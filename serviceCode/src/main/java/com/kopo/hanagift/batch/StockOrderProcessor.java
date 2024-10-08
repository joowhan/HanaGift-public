package com.kopo.hanagift.batch;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import org.springframework.batch.item.ItemProcessor;
import org.springframework.beans.factory.annotation.Autowired;
import com.kopo.hanagift.dto.StockOrder;
import com.kopo.hanagift.mapper.StockOrderMapper;
import com.kopo.hanagift.service.ExchangeRateService;
import com.kopo.hanagift.service.StockPriceService;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@Component
public class StockOrderProcessor implements ItemProcessor<StockOrder, StockOrder> {

    @Autowired
    private ExchangeRateService exchangeRateService;

    @Autowired
    private StockPriceService stockPriceService;

    @Autowired
    private StockOrderMapper stockOrderMapper;

    private double exchangeRate; // 환율은 배치 시작 시 한 번만 불러옴
//    private Map<String, Double> stockPriceCache = new HashMap<>(); // 주가 캐싱
    private Cache<String, Double> stockPriceCache = Caffeine.newBuilder()
        .expireAfterWrite(10, TimeUnit.MINUTES) // 10분 후 캐시 만료
        .maximumSize(100) // 캐시 항목 최대 100개
        .build();

    public void setExchangeRate(double exchangeRate) {
        this.exchangeRate = exchangeRate; // Step 시작 시 환율 설정
    }
    @Override
    public StockOrder process(StockOrder order) throws Exception {
        // 주식 코드에 따른 주가 캐싱 전략 적용
        String stockCode = order.getStockCode();

        // Caffeine 캐시에서 주식 가격을 가져옴, 없으면 stockPriceService에서 불러옴
        double stockPrice = stockPriceCache.get(stockCode, key -> {
            // 캐시가 없을 경우 주식 가격 API를 호출하여 가져옴
            return stockPriceService.getStockPrice(key);
        });

        // 소수점 주식 수량 계산
        double expectedQuantity = calculateExpectedStockQuantity(order.getAmount(), stockPrice, exchangeRate);

        // 예상 수량 업데이트
        order.setExpectedStockQuantity(expectedQuantity);

        return order;
    }

    //매수금액, 현재 주가, 환율
    /**
     * 소수점 이하 6자리까지 절삭하는 메서드.
     *
     * @param value 절삭할 값
     * @return 소수점 이하 6자리까지 절삭된 값
     */
    private double truncateToSixDecimalPlaces(double value) {
        return Math.floor(value * 1_000_000) / 1_000_000;
    }

    /**
     * 예상 주문 수량을 계산하는 메서드.
     *
     * @param amount        매수 금액 (원화 기준)
     * @param stockPrice    주식의 현재 가격 (달러 기준)
     * @param exchangeRate  환율 (원/달러)
     * @return              예상 주문 주식 수량 (소수점 이하 6자리까지 절삭)
     */
    private double calculateExpectedStockQuantity(double amount, double stockPrice, double exchangeRate) {
        // Step 1: 매수 금액에서 95%를 사용
        double usableAmount = amount * 0.95;

        // Step 2: 환율 적용하여 금액을 달러로 변환
        double amountInBaseCurrency = usableAmount / exchangeRate;

        // Step 3: 주식 가격으로 나눠 예상 주식 수량 계산
        double stockQuantity = amountInBaseCurrency / stockPrice;

        // Step 4: 소수점 이하 6자리로 절삭
        return truncateToSixDecimalPlaces(stockQuantity);
    }
}

