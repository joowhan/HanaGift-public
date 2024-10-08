import os
import warnings
warnings.filterwarnings("ignore")

from langchain_community.document_loaders import PyMuPDFLoader

# PyMuPDFLoader 을 이용해 PDF 파일 로드
# loader = PyMuPDFLoader("law.pdf")
loader = PyMuPDFLoader("hanamoney.pdf")
pages = loader.load()

from langchain.text_splitter import RecursiveCharacterTextSplitter

# 문서를 문장으로 분리
## 청크 크기 500, 각 청크의 50자씩 겹치도록 청크를 나눈다
text_splitter = RecursiveCharacterTextSplitter(
    chunk_size=500,
    chunk_overlap=50,
)
docs = text_splitter.split_documents(pages)

#from langchain.embeddings import HuggingFaceEmbeddings
from langchain_community.embeddings import HuggingFaceEmbeddings
# 문장을 임베딩으로 변환하고 벡터 저장소에 저장
embeddings = HuggingFaceEmbeddings(
    model_name='BAAI/bge-m3',
    model_kwargs={'device':'cpu'},
    #model_kwargs={'device':'cuda'},
    encode_kwargs={'normalize_embeddings':True},
)

# 벡터 저장소 생성
from langchain_community.vectorstores import Chroma
vectorstore = Chroma.from_documents(docs, embeddings)


# 벡터 저장소 경로 설정
## 현재 경로에 'vectorstore' 경로 생성
vectorstore_path = 'vectorstore'
os.makedirs(vectorstore_path, exist_ok=True)

# 벡터 저장소 생성 및 저장
vectorstore = Chroma.from_documents(docs, embeddings, persist_directory=vectorstore_path)
# 벡터스토어 데이터를 디스크에 저장
vectorstore.persist()
print("Vectorstore created and persisted")


from langchain_community.chat_models import ChatOllama

# Ollama 를 이용해 로컬에서 LLM 실행
model = ChatOllama(model="llama3-ko", temperature=0)

retriever = vectorstore.as_retriever(search_kwargs={'k': 3})


from langchain_core.runnables import RunnablePassthrough
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate


# Prompt 템플릿 생성
template = '''친절한 챗봇으로서 상대방의 요청에 최대한 자세하고 친절하게 답하자. 모든 대답은 한국어(Korean)으로 대>답해줘.":
{context}

Question: {question}
'''

prompt = ChatPromptTemplate.from_template(template)

def format_docs(docs):
    return '\n\n'.join([d.page_content for d in docs])

# RAG Chain 연결
rag_chain = (
    {'context': retriever | format_docs, 'question': RunnablePassthrough()}
    | prompt
    | model
    | StrOutputParser()
)

# Chain 실행
query = "하나머니에서 하루에 최대 선물 가능한 금액에 대해 알려 줘"
answer = rag_chain.invoke(query)

print("Query:", query)
print("Answer:", answer)