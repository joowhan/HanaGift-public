package com.kopo.hanagift.batch;

import com.kopo.hanagift.service.ExchangeRateService;
import org.springframework.batch.core.StepExecution;
import org.springframework.batch.core.StepExecutionListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ActualStockOrderStepListener implements StepExecutionListener {
    @Autowired
    private ExchangeRateService exchangeRateService;

    @Autowired
    private ActualStockOrderProcessor ActualstockOrderProcessor;
    @Override
    public void beforeStep(StepExecution stepExecution) {
        // 배치 시작 전에 환율을 한 번만 호출
        double exchangeRate = exchangeRateService.findLatestExchangeRate("USD");
        ActualstockOrderProcessor.setExchangeRate(exchangeRate); // Processor에 환율 설정
    }
}
