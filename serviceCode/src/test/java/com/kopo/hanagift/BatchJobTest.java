package com.kopo.hanagift;

import org.junit.jupiter.api.Test;
import org.springframework.batch.core.BatchStatus;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobParametersBuilder;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@ActiveProfiles("test")
public class BatchJobTest {

    @Autowired
    private JobLauncher jobLauncher;

    @Autowired
    private Job stockPriceUpdateFlow;

    @Autowired
    private Job updateStockPricesJob;

    @Autowired
    private Job processStockOrdersJob;

    @Test
    public void testStockPriceUpdateFlowJob() throws Exception {
        JobExecution jobExecution = jobLauncher.run(stockPriceUpdateFlow, new JobParametersBuilder()
                .addLong("time", System.currentTimeMillis())
                .toJobParameters());

        assertEquals(BatchStatus.COMPLETED, jobExecution.getStatus(), "Stock price update flow should complete successfully");
    }

    @Test
    public void testUpdateStockPricesJob() throws Exception {
        JobExecution jobExecution = jobLauncher.run(updateStockPricesJob, new JobParametersBuilder()
                .addLong("time", System.currentTimeMillis())
                .toJobParameters());

        assertEquals(BatchStatus.COMPLETED, jobExecution.getStatus(), "Stock price update job should complete successfully");
    }

    @Test
    public void testProcessStockOrdersJob() throws Exception {
        JobExecution jobExecution = jobLauncher.run(processStockOrdersJob, new JobParametersBuilder()
                .addLong("time", System.currentTimeMillis())
                .toJobParameters());

        assertEquals(BatchStatus.COMPLETED, jobExecution.getStatus(), "Process stock orders job should complete successfully");
    }
}
