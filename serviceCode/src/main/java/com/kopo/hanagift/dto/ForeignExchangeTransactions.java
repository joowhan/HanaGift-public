package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ForeignExchangeTransactions {
    private Long transactionID; // 거래 ID
    private String transactionType; // 거래 유형 (예: 송금 등)
    private Double amount; // 거래 금액
    private Double balanceAfter; // 거래 후 잔액
    private String currencyCode; // 화폐 코드 (예: USD, KRW 등)
    private String userID; // 사용자 ID
}
