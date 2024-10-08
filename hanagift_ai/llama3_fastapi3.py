import os

# OpenMP 환경 변수 설정
os.environ["KMP_DUPLICATE_LIB_OK"] = "FALSE"

import faiss  # 가능한 빨리 로드
import numpy as np
import faiss
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from langchain_chroma import Chroma
from langchain_huggingface import HuggingFaceEmbeddings
from langchain_community.chat_models import ChatOllama
from langchain_core.runnables import RunnablePassthrough, RunnableMap
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate
from pydantic import BaseModel
import threading

app = FastAPI()

# CORS settings
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 필요한 도메인으로 변경 가능
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Global variables
pdf_titles = [
    "하나머니, 외화 선물하기",
    "소수점 주식 선물하기, 해외주식 선물하기"
]

pdf_files = {
    "하나머니, 외화 선물하기": "hanamoney.pdf",
    "소수점 주식 선물하기, 해외주식 선물하기": "stockGift.pdf"
}

vectorstore_paths = {
    "하나머니, 외화 선물하기": "vectorstore/hanamoney",
    "소수점 주식 선물하기, 해외주식 선물하기": "vectorstore/stockGift"
}

vectorstores = {}
faiss_index = None
embedding_dim = None
embeddings = None
faiss_lock = threading.Lock()  # FAISS 접근을 위한 락

@app.on_event("startup")
def load_resources():
    global faiss_index, embedding_dim, embeddings

    # FAISS의 OpenMP 스레드 수를 1로 제한
    faiss.omp_set_num_threads(1)

    # Embeddings 초기화
    embeddings = HuggingFaceEmbeddings(
        model_name='BAAI/bge-m3',
        model_kwargs={'device': 'cpu'},
        encode_kwargs={'normalize_embeddings': True}
    )

    # Vectorstores 로드
    for title, path in vectorstore_paths.items():
        if os.path.exists(path):
            print(f"Loading vectorstore for {title} from {path}")
            vectorstore = Chroma(persist_directory=path, embedding_function=embeddings)
            vectorstores[title] = vectorstore
        else:
            print(f"Vectorstore for {title} not found at {path}")

    # PDF 타이틀 임베딩
    title_embeddings = embeddings.embed_documents(pdf_titles)
    title_embeddings = np.array(title_embeddings).astype('float32')

    # 임베딩 차원 설정
    embedding_dim = title_embeddings.shape[1]

    # FAISS 인덱스 초기화
    faiss_index = faiss.IndexFlatIP(embedding_dim)

    # 코사인 유사성을 위한 정규화
    faiss.normalize_L2(title_embeddings)

    # FAISS 인덱스에 임베딩 추가
    faiss_index.add(title_embeddings)
    print(f"FAISS index initialized with {faiss_index.ntotal} titles.")

@app.on_event("shutdown")
def shutdown_event():
    global faiss_index
    if faiss_index is not None:
        faiss_index.reset()
        faiss_index = None
    # 추가적인 리소스 정리가 필요하다면 여기에 작성

def select_pdf_by_title(input_title):
    global faiss_index, embeddings

    if faiss_index is None or embeddings is None:
        raise ValueError("FAISS index or embeddings not initialized.")

    # 입력 타이틀 임베딩
    input_vector = embeddings.embed_query(input_title)
    input_vector = np.array(input_vector).astype('float32').reshape(1, -1)

    # 입력 벡터 정규화
    faiss.normalize_L2(input_vector)

    # FAISS 검색을 스레드 안전하게 수행
    with faiss_lock:
        D, I = faiss_index.search(input_vector, k=1)

    if I[0][0] == -1:
        raise ValueError("No similar PDF title found.")

    most_similar_index = I[0][0]
    if most_similar_index >= len(pdf_titles):
        raise ValueError("Invalid index retrieved from FAISS.")

    most_similar_title = pdf_titles[most_similar_index]
    print("Most similar PDF title:", most_similar_title)
    return most_similar_title

class QueryRequest(BaseModel):
    title: str
    query: str

@app.post('/ask')
async def ask_model(data: QueryRequest):
    title = data.title
    query = data.query

    if not title or not query:
        raise HTTPException(status_code=400, detail="Title or query is missing")

    try:
        selected_pdf_title = select_pdf_by_title(title)
    except ValueError as ve:
        raise HTTPException(status_code=500, detail=str(ve))

    vectorstore = vectorstores.get(selected_pdf_title)
    if not vectorstore:
        raise HTTPException(status_code=500, detail="Failed to load vectorstore for the selected PDF")

    retriever = vectorstore.as_retriever(search_kwargs={'k': 3})
    model = ChatOllama(model="llama3-ko", temperature=0)

    template = '''친절한 챗봇으로서 상대방의 요청에 최대한 자세하고 친절하게 답하자. 모든 대답은 한국어(Korean)으로 대답해줘.:
    {context}

    Question: {question}
    '''
    prompt = ChatPromptTemplate.from_template(template)

    def format_docs(docs):
        return '\n\n'.join([d.page_content for d in docs])

    # 수정된 부분: RunnableMap을 사용하여 입력을 적절히 매핑
    rag_chain = (
        RunnableMap({
            'context': retriever | format_docs,
            'question': RunnablePassthrough()
        })
        | prompt
        | model
        | StrOutputParser()
    )

    try:
        # query를 입력으로 전달
        answer = rag_chain.invoke(query)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error during model invocation: {str(e)}")

    return {"query": query, "answer": answer}