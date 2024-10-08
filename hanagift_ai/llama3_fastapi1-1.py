from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
from langchain_chroma import Chroma
from langchain_huggingface import HuggingFaceEmbeddings
from langchain_community.chat_models import ChatOllama
from langchain_core.runnables import RunnablePassthrough
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate
from langchain.retrievers.multi_query import MultiQueryRetriever
import os
app = FastAPI()

# CORS 설정 추가
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# PDF 제목 리스트
pdf_titles = [
    "하나머니, 외화 선물하기",
    "소수점 주식 선물하기, 해외주식 선물하기"
]

# PDF 파일 경로 설정
pdf_files = {
    "하나머니, 외화 선물하기": "hanamoney.pdf",
    "소수점 주식 선물하기, 해외주식 선물하기": "stockGift.pdf"
}

# 벡터 저장소 경로 설정
vectorstore_paths = {
    "하나머니, 외화 선물하기": "vectorstore/hanamoney",
    "소수점 주식 선물하기, 해외주식 선물하기": "vectorstore/stockGift"
}

# 벡터 저장소를 미리 로드해서 캐싱해 둘 딕셔너리
vectorstores = {}

# 서버 시작 시 벡터 저장소를 모두 미리 로드
def load_all_vectorstores():
    embeddings = HuggingFaceEmbeddings(
        model_name='BAAI/bge-m3',
        model_kwargs={'device': 'cpu'},
        encode_kwargs={'normalize_embeddings': True}
    )
    
    for title, path in vectorstore_paths.items():
        if os.path.exists(path):
            print(f"Loading vectorstore for {title} from {path}")
            vectorstore = Chroma(persist_directory=path, embedding_function=embeddings)
            vectorstores[title] = vectorstore
        else:
            print(f"Vectorstore for {title} not found at {path}")

# 가장 유사한 PDF 선택
def select_pdf_by_title(input_title):
    tfidf_vectorizer = TfidfVectorizer()
    tfidf_matrix = tfidf_vectorizer.fit_transform([input_title] + pdf_titles)

    # 첫 번째 벡터(입력 제목)와 나머지 PDF 제목 간의 유사도 계산
    cosine_sim = cosine_similarity(tfidf_matrix[0:1], tfidf_matrix[1:])
    most_similar_index = cosine_sim.argmax()
    print("most similar: ", pdf_titles[most_similar_index])
    return pdf_titles[most_similar_index]

# 입력 데이터를 검증하기 위한 Pydantic 모델
class QueryRequest(BaseModel):
    title: str
    query: str

# 질문을 받아 답변을 리턴하는 API
@app.post('/ask')
async def ask_model(data: QueryRequest):
    title = data.title
    query = data.query

    if not title or not query:
        raise HTTPException(status_code=400, detail="Title or query is missing")

    # 제목을 기반으로 적합한 PDF 선택
    selected_pdf_title = select_pdf_by_title(title)

    # 미리 로드된 벡터 저장소에서 가져오기
    vectorstore = vectorstores.get(selected_pdf_title)
    if not vectorstore:
        raise HTTPException(status_code=500, detail="Failed to load vectorstore for the selected PDF")

    # MultiQueryRetriever를 사용하여 질문을 변형하고 검색 정확도 향상
    llm = ChatOllama(model="llama3-ko", temperature=0)
    
    # MultiQueryRetriever를 통해 여러 질문 생성 및 검색
    multi_query_retriever = MultiQueryRetriever.from_llm(
        retriever=vectorstore.as_retriever(search_kwargs={'k': 3}),
        llm=llm
    )
    
    # 변형된 질문들을 사용해 문서 검색
    related_docs = multi_query_retriever.invoke(query)

    # RAG Chain 설정
    template = '''친절한 챗봇으로서 상대방의 요청에 최대한 자세하고 친절하게 답하자. 모든 대답은 한국어(Korean)으로 대답해줘.:
    {context}

    Question: {question}
    '''
    prompt = ChatPromptTemplate.from_template(template)

    def format_docs(docs):
        return '\n\n'.join([d.page_content for d in docs])

    # 문서 검색 결과 포맷팅
    context = format_docs(related_docs)
    # 프롬프트를 사용하여 최종 입력 생성
    prompt_text = prompt.format(context=context, question=query)

    # LLM에게 프롬프트 전달 및 답변 생성
    answer = llm.invoke(prompt_text)
    # RAG Chain 연결 및 실행
    # rag_chain = (
    #     prompt.format(context=context, question=query)  # 개별 키워드 인자로 전달
    #     | llm
    #     | StrOutputParser()
    # )

    # 질문에 대한 답변 생성
    # answer = rag_chain.invoke(query)

    return {"query": query, "answer": answer.strip()}

# 서버 시작 시 모든 벡터 저장소를 로드
load_all_vectorstores()
