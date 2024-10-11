package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SavingsJoined {
    private String accountNumber;  // 계좌 번호
    private String openDate;       // 개설일
    private String maturityDate;   // 만기일
    private String paymentDate;    // 지급일
    private double baseRate;       // 기본 금리
    private double amount;         // 적금 금액
    private double totalAmount;    // 총 금액
    private String productName;    // 상품명
    private String imgUrl;         // 상품 이미지 URL
}
