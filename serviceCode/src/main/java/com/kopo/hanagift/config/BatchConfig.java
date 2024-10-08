package com.kopo.hanagift.config;
import com.kopo.hanagift.batch.*;
import com.kopo.hanagift.dto.StockOrder;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.batch.core.job.builder.JobBuilder;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.PlatformTransactionManager;

@Configuration
@EnableBatchProcessing
public class BatchConfig {
    //미국 주식 시장이 열리는 저녁 10시 30분에 실시간 체결 시세를 불러온 다음 5틱을 높인 후 주가 체결
    @Bean
    public Job stockPriceUpdateFlow(JobRepository jobRepository,
                                    @Qualifier("updateStockPricesStep") Step updateStockPricesStep,
                                    @Qualifier("calculateActualStockOrdersStep") Step calculateActualStockOrdersStep) {
        return new JobBuilder("stockPriceUpdateFlow", jobRepository)
                .start(updateStockPricesStep)
                .next(calculateActualStockOrdersStep)  // 첫 번째 Step 이후 다음 Step 실행
                .build();
    }
    // 실제 주가 계산 Job
    @Bean
    public Job calculateActualStockOrdersJob(JobRepository jobRepository,
                                             @Qualifier("calculateActualStockOrdersStep") Step calculateActualStockOrdersStep) {
        return new JobBuilder("calculateActualStockOrdersJob", jobRepository)
                .start(calculateActualStockOrdersStep)
                .build();
    }
    // 실제 주가 계산 Step
    @Bean
    public Step calculateActualStockOrdersStep(JobRepository jobRepository,
                                               PlatformTransactionManager transactionManager,
                                               ActualStockOrderProcessor actualStockOrderProcessor,
                                               ActualStockOrderStepListener actualStockOrderStepListener) {
        return new StepBuilder("calculateActualStockOrdersStep", jobRepository)
                .<StockOrder, StockOrder>chunk(10)
                .reader(actualStockOrderReader())
                .processor(actualStockOrderProcessor)
                .writer(actualStockOrderWriter()) // 수정 예정
                .listener(actualStockOrderStepListener)
                .transactionManager(transactionManager)
                .build();
    }


    // 실시간 체결가 업데이트
    @Bean
    public Job updateStockPricesJob(JobRepository jobRepository,
                                    @Qualifier("updateStockPricesStep") Step updateStockPricesStep) {
        return new JobBuilder("updateStockPricesJob", jobRepository)
                .start(updateStockPricesStep)
                .build();
    }

    @Bean
    public Step updateStockPricesStep(JobRepository jobRepository,
                                      PlatformTransactionManager transactionManager,
                                      StockPriceUpdater stockPriceUpdater) {
        return new StepBuilder("updateStockPricesStep", jobRepository)
                .tasklet(stockPriceUpdater)
                .transactionManager(transactionManager)
                .build();
    }

    @Bean
    public Job processStockOrdersJob(JobRepository jobRepository,
                                     @Qualifier("processStockOrdersStep") Step processStockOrdersStep) {
        return new JobBuilder("processStockOrdersJob", jobRepository)
                .start(processStockOrdersStep)
                .build();
    }

    @Bean
    public Step processStockOrdersStep(JobRepository jobRepository,
                                       PlatformTransactionManager transactionManager,
                                       StockOrderProcessor stockOrderProcessor,
                                       StockOrderStepListener stockOrderStepListener) {
        return new StepBuilder("processStockOrdersStep", jobRepository)
                .<StockOrder, StockOrder>chunk(10)
                .reader(stockOrderReader())
                .processor(stockOrderProcessor)
                .writer(stockOrderWriter())
                .listener(stockOrderStepListener)
                .transactionManager(transactionManager)
                .build();
    }

    // Reader, Writer 빈 설정
    @Bean
    public StockOrderReader stockOrderReader() {
        return new StockOrderReader();
    }

    @Bean
    public StockOrderWriter stockOrderWriter() {
        return new StockOrderWriter();
    }

    @Bean
    public ActualStockOrderReader actualStockOrderReader() {
        return new ActualStockOrderReader();
    }

    @Bean
    public ActualStockOrderWriter actualStockOrderWriter() {
        return new ActualStockOrderWriter();
    }


}