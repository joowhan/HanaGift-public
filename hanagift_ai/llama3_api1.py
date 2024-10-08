from flask import Flask, request, jsonify
from flask_cors import CORS  # CORS 패키지 임포트
import os
import warnings
warnings.filterwarnings("ignore")

from langchain_community.document_loaders import PyMuPDFLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_community.embeddings import HuggingFaceEmbeddings
from langchain_community.vectorstores import Chroma
from langchain_community.chat_models import ChatOllama
from langchain_core.runnables import RunnablePassthrough
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate

# Flask 애플리케이션 생성
app = Flask(__name__)

# CORS 설정 (모든 도메인 허용)
CORS(app)  # 기본적으로 모든 도메인에서의 요청을 허용

# 벡터스토어와 모델 초기화 (서버가 시작될 때 한번만 로드)
def initialize_rag():
    # PDF 파일 로드
    loader = PyMuPDFLoader("hanamoney.pdf")
    pages = loader.load()

    # 문서를 청크로 분리
    text_splitter = RecursiveCharacterTextSplitter(
        chunk_size=500,
        chunk_overlap=50,
    )
    docs = text_splitter.split_documents(pages)

    # 임베딩 설정
    embeddings = HuggingFaceEmbeddings(
        model_name='BAAI/bge-m3',
        model_kwargs={'device': 'cpu'},
        encode_kwargs={'normalize_embeddings': True},
    )

    # 벡터 저장소 생성
    vectorstore_path = 'vectorstore'
    os.makedirs(vectorstore_path, exist_ok=True)
    vectorstore = Chroma.from_documents(docs, embeddings, persist_directory=vectorstore_path)
    vectorstore.persist()

    # ChatOllama 모델 초기화
    model = ChatOllama(model="llama3-ko", temperature=0)

    # Retriever 설정
    retriever = vectorstore.as_retriever(search_kwargs={'k': 3})

    # RAG Chain 설정
    template = '''친절한 챗봇으로서 상대방의 요청에 최대한 자세하고 친절하게 답하자. 모든 대답은 한국어(Korean)으로 대답해줘.:
    {context}

    Question: {question}
    '''
    prompt = ChatPromptTemplate.from_template(template)

    def format_docs(docs):
        return '\n\n'.join([d.page_content for d in docs])

    rag_chain = (
        {'context': retriever | format_docs, 'question': RunnablePassthrough()}
        | prompt
        | model
        | StrOutputParser()
    )
    return rag_chain

rag_chain = initialize_rag()

# 질문을 받아 답변을 리턴하는 API
@app.route('/ask', methods=['POST'])
def ask_model():
    data = request.json
    query = data.get('query')

    if not query:
        return jsonify({'error': 'No query provided'}), 400

    # Chain 실행
    answer = rag_chain.invoke(query)

    return jsonify({'query': query, 'answer': answer})

# 서버 실행
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
