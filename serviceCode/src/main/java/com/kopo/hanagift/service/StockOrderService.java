package com.kopo.hanagift.service;

import com.kopo.hanagift.dto.Gift;
import com.kopo.hanagift.dto.StockOrder;
import com.kopo.hanagift.mapper.StockNCurrencyMapper;
import com.kopo.hanagift.mapper.StockOrderMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class StockOrderService {

    @Autowired
    private StockOrderMapper stockOrderMapper;
    @Autowired
    private StockNCurrencyMapper stockNCurrencyMapper;


    // 1시간마다 주식 주문을 처리하는 스케줄러 (주기적으로 실행)
//    @Scheduled(fixedRate = 3600000)  // 1시간마다 실행
    public void processPendingStockOrders() {
        // PENDING 상태의 주문 조회
        List<StockOrder> pendingOrders = stockOrderMapper.findPendingOrders();

        for (StockOrder order : pendingOrders) {
            // 주문 처리 로직 (실제 주식 구매 API 호출 등)
            executeOrder(order);

            // 주문 상태를 'EXECUTED'로 업데이트
            stockOrderMapper.updateOrderStatusToExecuted(order.getOrderID());

            // 주문 실행 내역 기록
//            stockOrderMapper.saveOrderExecution(order.getOrderID());
        }
    }


    private void executeOrder(StockOrder order) {
//        System.out.println("주문 처리: " + order.getStockName() + " (" + order.getStockCode() + "), 금액: " + order.getAmount());
        // 주식 거래 로직 구현 필요 (ex: 주식 API 호출)
    }
    public void saveStockOrder(Gift gift, String code, String userId){
        stockOrderMapper.saveStockOrder(gift, code, userId);
    }

    // productId로부터 해당하는 productCode를 가져오는 메서드
    public String getProductCode(String productId) {
        return stockNCurrencyMapper.productCode(productId);
    }

}

