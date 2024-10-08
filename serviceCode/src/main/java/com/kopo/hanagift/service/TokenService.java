package com.kopo.hanagift.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import org.json.JSONObject;
import reactor.core.publisher.Mono;

@Service
public class TokenService {
    @Value("${api.key}")
    private String appKey;

    @Value("${api.secret}")
    private String appSecret;
    private final WebClient webClient;
    private String currentToken;  // 발급된 토큰을 저장하는 변수
    private long tokenExpiryTime;  // 토큰 만료 시간을 저장하는 변수 (Unix timestamp)

    // WebClient를 주입받아 설정
    public TokenService(WebClient.Builder webClientBuilder) {
        this.webClient = webClientBuilder.baseUrl("https://openapi.koreainvestment.com:9443").build();
    }

    // 토큰을 발급받고 저장하는 메서드
    public void fetchAndStoreToken() {
        // 요청 JSON Body
        JSONObject requestBody = new JSONObject();
        requestBody.put("grant_type", "client_credentials");
        requestBody.put("appkey", appKey);
        requestBody.put("appsecret", appSecret);

        // WebClient를 통해 POST 요청으로 토큰 발급
        String response = this.webClient.post()
                .uri("/oauth2/tokenP")
                .header("content-type", "application/json")
                .bodyValue(requestBody.toString())  // 요청 본문 설정
                .retrieve()
                .bodyToMono(String.class)  // 응답을 Mono<String>으로 처리
                .block();  // 동기 방식으로 응답을 기다림

        // 응답에서 토큰 추출
        JSONObject jsonResponse = new JSONObject(response);
        String token = jsonResponse.getString("access_token");  // 응답에서 토큰 추출
        long expiresIn = jsonResponse.getLong("expires_in");    // 만료 시간 추출 (초 단위)

        // 토큰과 만료 시간 저장
        this.currentToken = token;
        this.tokenExpiryTime = System.currentTimeMillis() + (expiresIn * 1000);

        System.out.println("새로 발급된 토큰: " + currentToken);
    }

    // 현재 저장된 토큰 반환
    public String getCurrentToken() {
        // 만료 시간을 검사하여 토큰이 만료되었는지 확인
        if (System.currentTimeMillis() >= tokenExpiryTime) {
            System.out.println("토큰이 만료되었습니다. 새로 발급합니다.");
            fetchAndStoreToken();  // 토큰이 만료되었으면 다시 발급
        }
        return currentToken;
    }

    // 토큰 만료 여부 확인
    public boolean isTokenExpired() {
        return System.currentTimeMillis() >= tokenExpiryTime;
    }
}

