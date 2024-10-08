from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
import os
import numpy as np
import hashlib
import asyncio
import faiss
import redis
# from langchain_community.vectorstores import Chroma
from langchain_chroma import Chroma
# from langchain_community.embeddings import HuggingFaceEmbeddings
from langchain_huggingface import HuggingFaceEmbeddings
from langchain_community.chat_models import ChatOllama
from langchain_core.runnables import RunnablePassthrough
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate
from pydantic import BaseModel

app = FastAPI()

# CORS 설정 추가
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 모든 도메인 허용 (필요에 따라 변경 가능)
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Redis 클라이언트 초기화
redis_client = redis.Redis(host='localhost', port=6379, db=0)

# PDF 제목 리스트
pdf_titles = [
    "하나머니, 외화 선물하기",
    "소수점 주식 선물하기, 해외주식 선물하기"
]

# 글로벌 변수 초기화
embeddings = None
model = None
prompt = None
vectorstores = {}
retrievers = {}
faiss_index = None

# FastAPI 시작 시 실행되는 이벤트 핸들러
@app.on_event("startup")
async def startup_event():
    await load_all_resources()

# 서버 시작 시 모든 리소스 로드
async def load_all_resources():
    global embeddings, model, prompt, vectorstores, retrievers, faiss_index

    # 임베딩 모델 초기화
    embeddings = HuggingFaceEmbeddings(
        model_name='BAAI/bge-m3',
        model_kwargs={'device': 'cpu'},
        encode_kwargs={'normalize_embeddings': True}
    )

    # PDF 제목 임베딩 미리 계산 및 Faiss 인덱스 생성
    pdf_title_embeddings = []
    for title in pdf_titles:
        embedding = embeddings.embed_query(title)
        embedding = np.array(embedding, dtype='float32')
        # Normalize the embedding
        faiss.normalize_L2(embedding.reshape(1, -1))
        pdf_title_embeddings.append(embedding)

    pdf_title_embeddings = np.vstack(pdf_title_embeddings)
    faiss_index = build_faiss_index(pdf_title_embeddings)

    # 모델 초기화
    model = ChatOllama(model="llama3-ko", temperature=0)

    # 프롬프트 초기화
    template = '''친절한 챗봇으로서 상대방의 요청에 최대한 자세하고 친절하게 답하자. 모든 대답은 한국어(Korean)으로 대답해줘:
{context}

Question: {question}
'''
    prompt = ChatPromptTemplate.from_template(template)

    # 벡터스토어 및 retriever 로드
    load_vectorstores()

def build_faiss_index(embeddings):
    dimension = embeddings.shape[1]
    index = faiss.IndexHNSWFlat(dimension, 32)  # HNSW 인덱스 생성, M=32
    index.hnsw.efConstruction = 200
    index.hnsw.efSearch = 50  # 검색 시 탐색 깊이
    faiss.normalize_L2(embeddings)
    index.add(embeddings)
    print("Faiss index built.")
    return index

def load_vectorstores():
    global vectorstores, retrievers
    # 벡터 저장소 경로 설정
    vectorstore_paths = {
        "하나머니, 외화 선물하기": "vectorstore/hanamoney",
        "소수점 주식 선물하기, 해외주식 선물하기": "vectorstore/stockGift"
    }

    for title, path in vectorstore_paths.items():
        if os.path.exists(path):
            print(f"Loading vectorstore for {title} from {path}")
            vectorstore = Chroma(persist_directory=path, embedding_function=embeddings)
            vectorstores[title] = vectorstore
            retrievers[title] = vectorstore.as_retriever(search_kwargs={'k': 3})
        else:
            print(f"Vectorstore for {title} not found at {path}")

# 가장 유사한 PDF 선택 (Faiss 사용)
def select_pdf_by_title(input_title):
    input_embedding = embeddings.embed_query(input_title)
    input_embedding = np.array([input_embedding], dtype='float32')
    faiss.normalize_L2(input_embedding)

    # Faiss를 사용한 유사도 검색
    _, indices = faiss_index.search(input_embedding, k=1)
    most_similar_index = indices[0][0]
    if most_similar_index == -1:
        raise HTTPException(status_code=500, detail="No similar PDF found")
    most_similar_title = pdf_titles[most_similar_index]
    print("Most similar: ", most_similar_title)
    return most_similar_title

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

    # 질의 캐시 키 생성
    cache_key = f"query_cache:{hashlib.sha256(f'{title}:{query}'.encode()).hexdigest()}"

    # Redis에서 캐시 확인
    cached_answer = redis_client.get(cache_key)
    if cached_answer:
        return {"query": query, "answer": cached_answer.decode('utf-8')}

    # 제목을 기반으로 적합한 PDF 선택
    selected_pdf_title = select_pdf_by_title(title)

    # 미리 로드된 retriever 가져오기
    retriever = retrievers.get(selected_pdf_title)
    if not retriever:
        raise HTTPException(status_code=500, detail="Failed to load retriever for the selected PDF")

    # 질문에 대한 답변 생성
    answer = await generate_answer(retriever, query)

    # Redis에 결과 캐싱 (예: 10분 동안 캐싱)
    redis_client.setex(cache_key, 600, answer)

    return {"query": query, "answer": answer}

# 비동기적으로 답변 생성
async def generate_answer(retriever, query):
    loop = asyncio.get_event_loop()

    def format_docs(docs):
        return '\n\n'.join([d.page_content for d in docs])

    # RAG Chain 설정
    rag_chain = (
        {'context': retriever | format_docs, 'question': RunnablePassthrough()}
        | prompt
        | model
        | StrOutputParser()
    )

    # 비동기 호출로 변경
    answer = await loop.run_in_executor(None, rag_chain.invoke, query)
    return answer
