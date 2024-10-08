package com.kopo.hanagift.batch;

import org.springframework.batch.item.ItemReader;
import org.springframework.beans.factory.annotation.Autowired;
import com.kopo.hanagift.mapper.StockOrderMapper;
import com.kopo.hanagift.dto.StockOrder;

import java.util.List;

public class StockOrderReader implements ItemReader<StockOrder> {

    @Autowired
    private StockOrderMapper stockOrderMapper;

    private List<StockOrder> pendingOrders;
    private int nextOrderIndex = 0;

    @Override
    public StockOrder read() {
        if (pendingOrders == null) {
            // PENDING 상태의 주문을 MyBatis Mapper에서 가져옴
            pendingOrders = stockOrderMapper.findPendingOrders();
        }

        // 주문이 있으면 하나씩 반환, 없으면 null 반환하여 배치 종료
        StockOrder nextOrder = null;
        if (nextOrderIndex < pendingOrders.size()) {
            nextOrder = pendingOrders.get(nextOrderIndex);
            nextOrderIndex++;
        }

        return nextOrder;
    }
}

