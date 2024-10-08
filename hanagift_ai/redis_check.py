import redis
import logging

# 로깅 설정
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

try:
    redis_client = redis.Redis(host='localhost', port=6379, db=0)
    redis_client.ping()
    logger.info("Redis 서버에 성공적으로 연결되었습니다.")
except redis.ConnectionError as e:
    logger.error(f"Redis 연결 실패: {e}")
    raise e
