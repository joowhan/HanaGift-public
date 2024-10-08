package com.kopo.hanagift.scheduler;

import lombok.extern.slf4j.Slf4j;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.JobParametersBuilder;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class StockOrderScheduler {

    @Autowired
    private JobLauncher jobLauncher;

    @Autowired
    private Job updateStockPricesJob;  // 주식 가격 업데이트 배치 작업

    @Autowired
    @Qualifier("processStockOrdersJob")
    private Job processStockOrdersJob;  // 주식 주문 처리 배치 작업

    @Autowired
    private Job stockPriceUpdateFlow;

    // 매일 오후 6시에 주식 가격을 업데이트
    @Scheduled(cron = "0 0 18 * * ?")  // 오후 6시에 실행
    public void runUpdateStockPricesJob() {
        log.info("Stock Order 예상 주문 수량 scheduler 시작");
        try {
            JobParameters params = new JobParametersBuilder()
                    .addLong("time", System.currentTimeMillis())  // 유니크한 파라미터 추가
                    .toJobParameters();

            jobLauncher.run(updateStockPricesJob, params);  // 주식 가격 업데이트 작업 실행
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 매일 오후 6시 30분에 주식 주문을 처리
    @Scheduled(cron = "0 30 18 * * ?")  // 오후 6시 30분에 실행
    public void runProcessStockOrdersJob() {
        try {
            JobParameters params = new JobParametersBuilder()
                    .addLong("time", System.currentTimeMillis())  // 유니크한 파라미터 추가
                    .toJobParameters();

            jobLauncher.run(processStockOrdersJob, params);  // 주식 주문 처리 작업 실행
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 미국 주식 시장이 열리는 저녁 10시 30분에 주문 처리
    @Scheduled(cron = "0 30 22 * * ?")  // 저녁 10시 30분에 실행
    public void runStockPriceUpdateFlow() {
        log.info("주식 가격 업데이트와 주문 수량 계산 scheduler 시작");
        try {
            JobParameters params = new JobParametersBuilder()
                    .addLong("time", System.currentTimeMillis())
                    .toJobParameters();

            jobLauncher.run(stockPriceUpdateFlow, params);  // 주식 가격 업데이트 및 주문 수량 계산 JobFlow 실행
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
