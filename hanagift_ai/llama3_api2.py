from flask import Flask, request, jsonify
from flask_cors import CORS  # CORS 패키지 추가
import os
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
from langchain_community.vectorstores import Chroma
from langchain_community.embeddings import HuggingFaceEmbeddings
from langchain_community.chat_models import ChatOllama
from langchain_core.runnables import RunnablePassthrough
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate

app = Flask(__name__)
CORS(app)  # CORS 설정 추가

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

# 질문을 받아 답변을 리턴하는 API
@app.route('/ask', methods=['POST'])
def ask_model():
    data = request.json  # 받은 JSON 데이터를 확인합니다.

    try:
        data = request.json
        print("Received data:", data)
    except Exception as e:
        print("Error while parsing JSON data:", str(e))
        return jsonify({'error': 'Invalid JSON data'}), 400
    
    if not data:
        return jsonify({'error': 'No data received'}), 400  # 데이터를 받지 못한 경우

    title = data.get('title')
    query = data.get('query')

    if not title or not query:
        return jsonify({'error': 'Title or query is missing'}), 400

    # 제목을 기반으로 적합한 PDF 선택
    selected_pdf_title = select_pdf_by_title(title)

    # 미리 로드된 벡터 저장소에서 가져오기
    vectorstore = vectorstores.get(selected_pdf_title)
    if not vectorstore:
        return jsonify({'error': 'Failed to load vectorstore for the selected PDF'}), 500

    # RAG 모델 설정
    retriever = vectorstore.as_retriever(search_kwargs={'k': 3})
    model = ChatOllama(model="llama3-ko", temperature=0)

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

    # 질문에 대한 답변 생성
    answer = rag_chain.invoke(query)

    return jsonify({'query': query, 'answer': answer})

if __name__ == '__main__':
    # 서버 시작 시 모든 벡터 저장소를 로드
    load_all_vectorstores()
    app.run(host='0.0.0.0', port=5001)
