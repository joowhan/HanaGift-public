package com.kopo.hanagift.batch;

import com.kopo.hanagift.mapper.StockNCurrencyMapper;
import com.kopo.hanagift.service.StockPriceService;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class StockPriceUpdater implements Tasklet {

    @Autowired
    private StockNCurrencyMapper stockNCurrencyMapper;

    @Autowired
    private StockPriceService stockPriceService;

    @Override
    public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
        // 1. 주식 코드 목록을 MyBatis로 조회
        List<String> stockCodes = stockNCurrencyMapper.findStockCodes();

        // 2. 주식 가격 API 호출 및 테이블 업데이트
        stockPriceService.updateStockPrices(stockCodes);
        return RepeatStatus.FINISHED;
    }
}