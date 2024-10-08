package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BankTransaction {
    private String transactionID;  // 거래 ID
    private String transactionType; // 거래 유형 (예: "GIFT")
    private double amount;         // 거래 금액
    private double balanceAfter;   // 거래 후 잔액
    private String date;             // 거래 날짜
    private String accountNumber;  // 계좌 번호
    private String bankCode;       // 은행 코드
}
