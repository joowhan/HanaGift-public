package com.kopo.hanagift.batch;

import com.kopo.hanagift.dto.SecuritiesAccounts;
import com.kopo.hanagift.dto.StockOrder;
import com.kopo.hanagift.mapper.SecuritiesMapper;
import com.kopo.hanagift.mapper.StockOrderMapper;
import org.springframework.batch.item.Chunk;
import org.springframework.batch.item.ItemWriter;
import org.springframework.beans.factory.annotation.Autowired;

public class ActualStockOrderWriter implements ItemWriter<StockOrder> {

    @Autowired
    private StockOrderMapper stockOrderMapper;
    @Autowired
    private SecuritiesMapper securitiesMapper;

    @Override
    public void write(Chunk<? extends StockOrder> chunk) throws Exception{
        for (StockOrder order : chunk.getItems()) {
            stockOrderMapper.saveOrderExecution(order.getOrderID());
            stockOrderMapper.updateOrderStatusToConclusion(order.getOrderID());
            //주문 내역에 기록
            stockOrderMapper.updateStockQuantity(order.getStockQuantity(), order.getOrderID());
            //개인 증권에 소수점 배분
            // 2. 계좌 정보 조회
            SecuritiesAccounts account = securitiesMapper.getOneAccountByUserId(order.getReceiverID());

            // 3. 해당 계좌의 보유 주식 정보 업데이트
            if (securitiesMapper.existsByAccountNumberAndStockCode(account.getAccountNumber(), order.getStockCode())) {
                // 이미 존재하는 경우: 수량 및 금액을 업데이트 (기존 값에 더함)
                securitiesMapper.updateStockHoldings(
                        order.getStockQuantity(),   // 추가할 주식 수량
                        order.getAmount(),          // 추가할 금액
                        account.getAccountNumber(),  // 계좌번호
                        order.getStockCode()        // 주식 코드
                );
            } else {
                // 존재하지 않는 경우: 새로운 보유 주식 추가
                securitiesMapper.insertStockHoldings(
                        account.getAccountNumber(),  // 계좌번호
                        order.getStockCode(),        // 주식 코드
                        order.getStockQuantity(),    // 주식 수량
                        order.getAmount()            // 금액
                );
            }
        }
    }
}
