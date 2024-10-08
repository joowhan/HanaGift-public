package com.kopo.hanagift;
import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

import com.kopo.hanagift.dto.Post;
import com.kopo.hanagift.mapper.QnAMapper;
import com.kopo.hanagift.scheduler.PostScheduler;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public class PostSchedulerTest {

    @Mock
    private QnAMapper qnaMapper;

    @Mock
    private RestTemplate restTemplate;

    @InjectMocks
    private PostScheduler postScheduler;

    @Test
    public void testSendPendingPostsToFlask() {
        // Mock 데이터 설정
        Post post = new Post();
        post.setPostId(1222);
        post.setTitle("테스트 제목");
        post.setContent("테스트 내용");

        when(qnaMapper.findPostsByResponseStatus("대기 중")).thenReturn(Arrays.asList(post));

        // FastAPI 응답 모킹
        Map<String, String> responseBody = new HashMap<>();
        responseBody.put("answer", "테스트 답변");
        ResponseEntity<Map> responseEntity = new ResponseEntity<>(responseBody, HttpStatus.OK);
        when(restTemplate.postForEntity(anyString(), any(HttpEntity.class), eq(Map.class))).thenReturn(responseEntity);

        // 메서드 실행
        postScheduler.sendPendingPostsToFlask();

        // 검증
        verify(qnaMapper, times(1)).saveReply("테스트 답변", 122);
        verify(qnaMapper, times(1)).updatePostStatus(122);
    }
}



