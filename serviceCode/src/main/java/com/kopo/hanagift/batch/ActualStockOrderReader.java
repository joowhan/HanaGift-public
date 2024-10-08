package com.kopo.hanagift.batch;

import com.kopo.hanagift.dto.StockOrder;
import com.kopo.hanagift.mapper.StockOrderMapper;
import org.springframework.batch.item.ItemReader;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class ActualStockOrderReader implements ItemReader<StockOrder> {
    @Autowired
    private StockOrderMapper stockOrderMapper;
    private List<StockOrder> executedOrders;
    private int nextOrderIndex = 0;
    @Override
    public StockOrder read(){
        if (executedOrders == null) {
            // EXECUTED 상태의 주문을 MyBatis Mapper에서 가져옴
            executedOrders = stockOrderMapper.findExecutedOrders();
        }

        StockOrder nextOrder = null;
        if (nextOrderIndex < executedOrders.size()) {
            nextOrder = executedOrders.get(nextOrderIndex);
            nextOrderIndex++;
        }

        return nextOrder;
    }
}
