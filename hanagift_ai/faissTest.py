import faiss
import numpy as np

# 1. 데이터 생성
d = 64                           # 벡터의 차원
nb = 10000                       # 데이터베이스에 저장할 벡터의 개수
nq = 5                           # 검색할 쿼리 벡터의 개수

# 랜덤 벡터 생성 (데이터베이스 벡터)
np.random.seed(1234)             # 재현성을 위해 시드 설정
xb = np.random.random((nb, d)).astype('float32')
xb[:, 0] += np.arange(nb) / 1000.  # 일부 조작을 통해 유사성 추가

# 랜덤 쿼리 벡터 생성
xq = np.random.random((nq, d)).astype('float32')
xq[:, 0] += np.arange(nq) / 1000.

# 2. 인덱스 생성
index = faiss.IndexFlatL2(d)     # L2 거리 기반 인덱스 생성
print("Is index trained?", index.is_trained)  # Flat 인덱스는 항상 훈련됨

# 3. 벡터 추가
index.add(xb)                    # 인덱스에 데이터베이스 벡터 추가
print("Number of vectors in the index:", index.ntotal)

# 4. 검색
k = 4                            # 상위 k개의 유사한 벡터를 검색
D, I = index.search(xq, k)       # D: 거리, I: 인덱스
print("Distances:\n", D)
print("Indices:\n", I)

# 5. 결과 해석
for i in range(nq):
    print(f"\nQuery {i}:")
    for j in range(k):
        print(f"  Neighbor {j}: Index {I[i][j]}, Distance {D[i][j]:.4f}")
