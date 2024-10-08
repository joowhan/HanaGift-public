package com.kopo.hanagift.scheduler;

import com.kopo.hanagift.dto.Post;
import com.kopo.hanagift.mapper.QnAMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Service
@Slf4j
public class PostScheduler {

    private final QnAMapper qnaMapper;
    private final RestTemplate restTemplate;
    @Autowired
    public PostScheduler(QnAMapper qnaMapper) {
        this.qnaMapper = qnaMapper;
        this.restTemplate = new RestTemplate(); // RestTemplate 객체 생성
    }

    // 매 1시간마다 실행 (cron 표현식: 초 분 시 일 월 요일)
    // 매 1시간마다 실행 (cron 표현식: 초 분 시 일 월 요일)
    @Scheduled(cron = "0 0 * * * *")
    public void sendPendingPostsToFlask() {
        log.info("Post scheduler 시작");
        // '대기 중'인 게시글 조회
        List<Post> pendingPosts = qnaMapper.findPostsByResponseStatus("대기 중");
        log.info("대기 중인 게시글 수: {}", pendingPosts.size());

        for (Post post : pendingPosts) {
            try {
                // FastAPI 서버에 요청 보낼 데이터 준비
                String url = "http://localhost:8000/ask";

                HttpHeaders headers = new HttpHeaders();
                headers.setContentType(MediaType.APPLICATION_JSON);

                Map<String, String> request = new HashMap<>();
                request.put("title", post.getTitle());
                request.put("query", post.getContent());

                HttpEntity<Map<String, String>> entity = new HttpEntity<>(request, headers);

                // FastAPI 서버에 POST 요청
                ResponseEntity<Map> response = restTemplate.postForEntity(url, entity, Map.class);

                if (response.getStatusCode() == HttpStatus.OK) {
                    Map<String, String> responseBody = response.getBody();
                    String answer = responseBody.get("answer");

                    // Flask 서버로부터 받은 답변을 AdminReplies 테이블에 저장
                    qnaMapper.saveReply(answer, post.getPostId());

                    // Post 테이블의 responseStatus를 '답변 완료'로 업데이트
                    //                qnaMapper.updatePostStatus(post.getPostId());
                    log.info("Post ID {}에 대한 답변 저장 완료", post.getPostId());
                } else {
                    // 실패 시 로그 출력
                    log.error("FastAPI 응답 에러: {} for postId={}", response.getStatusCode(), post.getPostId());
                }

            } catch (HttpClientErrorException | HttpServerErrorException httpException) {
                log.error("HTTP 오류 발생: status={}, message={}", httpException.getStatusCode(), httpException.getMessage());
            } catch (Exception e) {
                // 오류 처리 (예: 로그 남기기 등)
                log.error("게시글 처리 중 예외 발생: postId={}, error={}", post.getPostId(), e.getMessage());
            }
        }
        log.info("Post scheduler 완료");
    }

}
