package com.kopo.hanagift;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class TomcatConfig {

    @Bean
    public WebServerFactoryCustomizer<TomcatServletWebServerFactory> tomcatCustomizer() {
        return factory -> factory.addContextCustomizers(context -> {
            context.getResources().setCacheMaxSize(100000); // 캐시 최대 크기를 설정 (단위: KB)
            context.getResources().setCachingAllowed(true); // 캐싱을 허용
            context.getResources().setCacheTtl(60000L); // 캐시 TTL (단위: milliseconds, 예: 1분)
        });
    }
}
