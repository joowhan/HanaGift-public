package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StockOrder {
    private Long OrderID;            // 주문 ID (Primary Key)
    private String HanaMoneyID;      // 선물 ID (GiftID)
    private String StockCode;      // 주식 종목 코드
    private double Amount;           // 주문 금액
    private String CurrencyUnit;     // 통화 단위 (예: KRW)
    private String ReceiverID;       // 주식을 받은 사람의 ID
    private String Status;           // 주문 상태 (PENDING 또는 EXECUTED)
    private String CreatedAt;     // 주문 생성 시각
    private Double expectedStockQuantity;  // 예상 주식 수량
    private Double stockQuantity; // 주식 수량
}
