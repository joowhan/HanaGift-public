package com.kopo.hanagift;

import org.junit.jupiter.api.Test;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.JobParametersBuilder;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

@SpringBootTest
@ActiveProfiles("test")
public class StockOrderSchedulerTest {

    @Autowired
    private JobLauncher jobLauncher;

    @Autowired
    private Job updateStockPricesJob;

    @Autowired
    private Job processStockOrdersJob;

    @Test
    public void testRunUpdateStockPricesJob() throws Exception {
        JobParameters jobParameters = new JobParametersBuilder()
                .addLong("time", System.currentTimeMillis())
                .toJobParameters();

        jobLauncher.run(updateStockPricesJob, jobParameters);  // 주식 가격 업데이트 배치 실행
    }

    @Test
    public void testRunProcessStockOrdersJob() throws Exception {
        JobParameters jobParameters = new JobParametersBuilder()
                .addLong("time", System.currentTimeMillis())
                .toJobParameters();

        jobLauncher.run(processStockOrdersJob, jobParameters);  // 주식 주문 처리 배치 실행
    }
}
