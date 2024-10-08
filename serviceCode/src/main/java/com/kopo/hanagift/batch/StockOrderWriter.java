package com.kopo.hanagift.batch;

import org.springframework.batch.item.Chunk;
import org.springframework.batch.item.ItemWriter;
import org.springframework.beans.factory.annotation.Autowired;
import com.kopo.hanagift.dto.StockOrder;
import com.kopo.hanagift.mapper.StockOrderMapper;

import java.util.List;

public class StockOrderWriter implements ItemWriter<StockOrder> {

    @Autowired
    private StockOrderMapper stockOrderMapper;

    @Override
    public void write(Chunk<? extends StockOrder> chunk) throws Exception {
        // 각 주문에 대해 실행 내역 저장
        for (StockOrder order : chunk.getItems()) {
            stockOrderMapper.updateOrderStatusToExecuted(order.getOrderID());
            stockOrderMapper.updateExpectedStockQuantity(order.getExpectedStockQuantity(),order.getOrderID());
        }
    }
}

