package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StockPrice {
    private String code;            // 주식 코드 (Primary Key)
    private double basePrice;       // 전일 종가
    private double lastPrice;       // 현재가
    private double diff;            // 가격 변동폭
    private double rate;            // 등락률 (전일 대비 퍼센트)
    private long volume;            // 전일 거래량
    private long tradeVolume;       // 당일 거래량
    private long tradeAmount;       // 당일 거래 금액
    private String sign;            // 대비기호 (1: 상승, 2: 하락, 3: 보합)
    private String updatedAt;    // 업데이트 시간
}
