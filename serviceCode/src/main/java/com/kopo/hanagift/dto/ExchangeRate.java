package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ExchangeRate {
    private int id;                   // 자동 증가 ID
    private String exchangeDate;       // 날짜 (String으로 저장)
    private double buyCash;            // 현찰 사실 때
    private double sellCash;           // 현찰 파실 때
    private double sendRemit;          // 송금 보낼 때
    private double receiveRemit;       // 송금 받을 때
    private double buyForeignCheck;    // 외화수표 파실 때
    private double exchangeRate;       // 매매 기준율
    private double previousComparison; // 직전 대비
    private double rateGap;            // 환가율
    private double usdConversionRate;  // 미화 환산율
    private String currencyCode;       // 통화 코드
    private String insertedDate;       // 삽입된 날짜 (String으로 저장)
}
