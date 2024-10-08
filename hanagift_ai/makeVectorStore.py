import os
from langchain_community.document_loaders import PyMuPDFLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_community.embeddings import HuggingFaceEmbeddings
from langchain_community.vectorstores import Chroma

# PDF 파일 경로 설정
pdf_files = {
    "hanamoney": "hanamoney.pdf",
    "stockGift": "stockGift.pdf"
}

# 벡터 저장소 생성 및 저장
def create_vectorstores():
    # 임베딩 모델 설정
    embeddings = HuggingFaceEmbeddings(
        model_name='BAAI/bge-m3',
        model_kwargs={'device': 'cpu'},
        encode_kwargs={'normalize_embeddings': True}
    )

    # 각 PDF 파일에 대해 벡터 저장소 생성
    for title, pdf_file in pdf_files.items():
        print(f"Processing PDF: {pdf_file}")

        # PDF 파일 로드
        loader = PyMuPDFLoader(pdf_file)
        pages = loader.load()

        # 텍스트를 청크로 분리
        text_splitter = RecursiveCharacterTextSplitter(chunk_size=500, chunk_overlap=50)
        docs = text_splitter.split_documents(pages)

        # 벡터 저장소 경로 설정
        vectorstore_path = f'vectorstore/{title.replace(" ", "_")}'
        os.makedirs(vectorstore_path, exist_ok=True)

        # 벡터 저장소 생성
        print(f"Creating vectorstore for {pdf_file}")
        vectorstore = Chroma.from_documents(docs, embeddings, persist_directory=vectorstore_path)
        vectorstore.persist()
        print(f"Vectorstore for {pdf_file} saved at {vectorstore_path}")

# 벡터 저장소 생성 함수 실행
if __name__ == "__main__":
    create_vectorstores()
