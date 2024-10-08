package com.kopo.hanagift.scheduler;

import com.kopo.hanagift.service.TokenService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class TokenScheduler {

    private final TokenService tokenService;

    public TokenScheduler(TokenService tokenService) {
        this.tokenService = tokenService;
    }

    // 매일 자정에 토큰을 갱신하는 스케줄러
    @Scheduled(cron = "0 0 0 * * ?")  // 매일 자정에 실행
    public void scheduleTokenRefresh() {
        System.out.println("스케줄러가 토큰 갱신을 시작합니다.");
        tokenService.fetchAndStoreToken();  // 토큰 갱신
    }
}
