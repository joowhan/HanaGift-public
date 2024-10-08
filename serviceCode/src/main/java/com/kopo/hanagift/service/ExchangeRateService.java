package com.kopo.hanagift.service;

import com.kopo.hanagift.dto.ExchangeRate;
import com.kopo.hanagift.mapper.ExchangeRateMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class ExchangeRateService {
    @Autowired
    private ExchangeRateMapper exchangeRateMapper;
    private final Deque<ExchangeRate> exchangeRateDeque = new LinkedList<>();
    // 현재 환율을 불러올 것
    public Map<String, Object> findExchangeRateWithComparison(String code) {
        // 최신 두 개의 환율 데이터를 가져옴
        List<ExchangeRate> rates = exchangeRateMapper.findLatestTwoExchangeRates(code);

        if (rates.size() < 2) {
            throw new IllegalStateException("환율 데이터가 충분하지 않습니다.");
        }

        // 가장 최신의 환율
        ExchangeRate latestRate = rates.get(0);
        // 바로 직전의 환율
        ExchangeRate previousRate = rates.get(1);

        // 증감 계산 (증가율 또는 감소율)
        double changeAmount = latestRate.getExchangeRate() - previousRate.getExchangeRate();
        double changePercentage = (changeAmount / previousRate.getExchangeRate()) * 100;

        // 결과를 Map 형태로 반환
        Map<String, Object> result = new HashMap<>();
        result.put("latestRate", latestRate);
        result.put("changeAmount", changeAmount);
        result.put("changePercentage", changePercentage);

        return result;
    }

    public List<ExchangeRate> findExchangeRatePeriod(String code){
        return exchangeRateMapper.findExchangeRatePeriod(code);
    }

    public double findLatestExchangeRate(String code){
        ExchangeRate exchangeRate = exchangeRateMapper.findLatestExchangeRate(code);
        return exchangeRate.getExchangeRate();
    }
}
