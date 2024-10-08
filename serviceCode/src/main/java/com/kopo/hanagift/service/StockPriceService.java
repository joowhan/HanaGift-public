package com.kopo.hanagift.service;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kopo.hanagift.dto.StockPrice;
import com.kopo.hanagift.mapper.StockPriceMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.ClientResponse;
import reactor.core.publisher.Mono;

import java.util.List;
@Slf4j
@Service
public class StockPriceService {

    private final WebClient webClient;
    private final TokenService tokenService;
    private final StockPriceMapper stockPriceMapper;
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Value("${api.key}")
    private String appKey;

    @Value("${api.secret}")
    private String appSecret;

    @Value("${api.token}")
    private String tempToken;

    // WebClient 설정 (Bean으로 주입 가능)

    @Autowired
    public StockPriceService(WebClient.Builder webClientBuilder, TokenService tokenService, StockPriceMapper stockPriceMapper) {
        this.webClient = webClientBuilder.baseUrl("https://openapi.koreainvestment.com:9443/uapi/overseas-price/v1/quotations/price").build();
        this.tokenService = tokenService;
        this.stockPriceMapper = stockPriceMapper;
    }

    // 주식 가격 조회
    // 주식 가격 조회 및 저장
    public void updateStockPrices(List<String> stockCodes) {
        String token = tokenService.getCurrentToken();
//        String token = tempToken;
        if (token == null || token.isEmpty()) {
            tokenService.fetchAndStoreToken();
            token = tokenService.getCurrentToken();
        }

        // 각 주식 코드에 대해 API 호출
        for (String stockCode : stockCodes) {
            try {
                String response = this.webClient.get()
                        .uri(uriBuilder -> uriBuilder
                                .queryParam("AUTH", "")
                                .queryParam("EXCD", "NAS")      // 거래소 코드 (예시로 NASDAQ 사용)
                                .queryParam("SYMB", stockCode)  // 주식 코드
                                .build())
                        .header("content-type", "application/json")
                        .header("authorization", "Bearer " + token)
                        .header("appkey", appKey)
                        .header("appsecret", appSecret)
                        .header("tr_id", "HHDFS00000300")
                        .retrieve()
                        .bodyToMono(String.class)
                        .block();

                // 응답을 파싱해 StockPrices 테이블에 저장 (예시로 JSON 파싱을 추가해야 함)
                // 파싱된 데이터가 아래와 같은 형태라고 가정합니다.
                StockPrice stockPrice = parseResponse(stockCode,response);
                stockPriceMapper.saveStockPrice(stockPrice);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    private StockPrice parseResponse(String stockCode, String response) {
        try {
            // 응답 JSON을 파싱하여 JsonNode로 변환
            JsonNode rootNode = objectMapper.readTree(response);
            JsonNode outputNode = rootNode.path("output");  // output 필드 접근

            // 각 필드 값을 가져오기
//            String stockCode = outputNode.path("rsym").asText();  // 실시간 조회종목코드 (rsym)
            String basePriceStr = outputNode.path("base").asText();  // 전일 종가 (base)
            String lastPriceStr = outputNode.path("last").asText();  // 현재가 (last)
            String diffStr = outputNode.path("diff").asText();  // 가격 변동폭 (diff)
            String rateStr = outputNode.path("rate").asText();  // 등락률 (rate)
            String volumeStr = outputNode.path("pvol").asText();  // 전일 거래량 (pvol)
            String tradeVolumeStr = outputNode.path("tvol").asText();  // 당일 거래량 (tvol)
            String tradeAmountStr = outputNode.path("tamt").asText();  // 당일 거래 금액 (tamt)
            String sign = outputNode.path("sign").asText();  // 대비 기호 (sign)

            // 문자열로 된 숫자 값을 실제 숫자로 변환
            double basePrice = Double.parseDouble(basePriceStr);  // 전일 종가
            double lastPrice = Double.parseDouble(lastPriceStr);  // 현재가
            double diff = Double.parseDouble(diffStr);  // 가격 변동폭
            double rate = Double.parseDouble(rateStr);  // 등락률
            long volume = Long.parseLong(volumeStr);  // 전일 거래량
            long tradeVolume = Long.parseLong(tradeVolumeStr);  // 당일 거래량
            long tradeAmount = Long.parseLong(tradeAmountStr);  // 당일 거래 금액


            // 로그 출력
            log.info("Stock Code: {}", stockCode);
            log.info("Base Price: {}", basePrice);
            log.info("Last Price: {}", lastPrice);
            log.info("Diff: {}", diff);
            log.info("Rate: {}", rate);
            log.info("Volume: {}", volume);
            log.info("Trade Volume: {}", tradeVolume);
            log.info("Trade Amount: {}", tradeAmount);
            log.info("Sign: {}", sign);

            StockPrice stockPrice = new StockPrice();
            // StockPrice 객체를 생성하여 반환
            // Setter 메서드를 통해 각 필드 값 설정
            stockPrice.setCode(stockCode);
            stockPrice.setBasePrice(basePrice);
            stockPrice.setLastPrice(lastPrice);
            stockPrice.setDiff(diff);
            stockPrice.setRate(rate);
            stockPrice.setVolume(volume);
            stockPrice.setTradeVolume(tradeVolume);
            stockPrice.setTradeAmount(tradeAmount);
            stockPrice.setSign(sign);

            // 객체 반환
            return stockPrice;

        } catch (Exception e) {
            e.printStackTrace();
            return null;  // 에러 발생 시 null 반환
        }
    }

    public double getStockPrice(String code){
        return stockPriceMapper.findStockPrice(code);
    }
}
