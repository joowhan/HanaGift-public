package com.kopo.hanagift.batch;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import com.kopo.hanagift.dto.StockOrder;
import com.kopo.hanagift.service.StockPriceService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.batch.item.ItemProcessor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.concurrent.TimeUnit;

@Component
@Slf4j
public class ActualStockOrderProcessor implements ItemProcessor<StockOrder, StockOrder> {

    @Autowired
    private StockPriceService stockPriceService;

    private double exchangeRate; // 환율 값
    private Cache<String, Double> stockPriceCache = Caffeine.newBuilder()
            .expireAfterWrite(10, TimeUnit.MINUTES) // 10분 후 캐시 만료
            .maximumSize(100) // 캐시 항목 최대 100개
            .build();
    public void setExchangeRate(double exchangeRate) {
        this.exchangeRate = exchangeRate; // Step 시작 시 환율 설정
    }
    // 5틱을 더한 실제 주식 가격 계산
    @Override
    public StockOrder process(StockOrder order) throws Exception {
        String stockCode = order.getStockCode();

        // 현재 주식 가격 불러오기
        // Caffeine 캐시에서 주식 가격을 가져옴, 없으면 stockPriceService에서 불러옴
        double stockPrice = stockPriceCache.get(stockCode, key -> {
            // 캐시가 없을 경우 주식 가격 API를 호출하여 가져옴
            return stockPriceService.getStockPrice(key);
        });

        // 1틱 크기 설정 (예: 1틱 = 0.01 달러)
        double tickSize = 0.01;

        // 주식 가격에 5틱을 더함
        double stockPriceWithTicks = stockPrice + (5 * tickSize);

        // 실제 주문 수량 계산 (기존 로직 사용, 가격에 5틱 추가)
        double actualQuantity = calculateActualStockQuantity(order.getAmount(), stockPriceWithTicks, exchangeRate);
        log.info("주문 수량 계산 값: "+ actualQuantity);
        // 주문 수량 설정
        order.setStockQuantity(actualQuantity);

        return order;
    }

    private double calculateActualStockQuantity(double amount, double stockPrice, double exchangeRate) {
        double usableAmount = amount * 0.95;  // 매수 금액의 95% 사용
        double amountInBaseCurrency = usableAmount / exchangeRate;  // 환율 적용
        double stockQuantity = amountInBaseCurrency / stockPrice;  // 주가로 나눈 예상 수량 계산
        return truncateToSixDecimalPlaces(stockQuantity);
    }

    private double truncateToSixDecimalPlaces(double value) {
        return Math.floor(value * 1_000_000) / 1_000_000;
    }

}
