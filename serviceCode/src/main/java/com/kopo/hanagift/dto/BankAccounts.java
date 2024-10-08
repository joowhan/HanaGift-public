package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BankAccounts {
    private String accountNumber;  // 계좌 번호
    private String accountName;    // 계좌 명
    private String userId;         // 사용자 ID
    private double balance;
    private String bankCode;
    private String bankName;       // 은행 코드
}