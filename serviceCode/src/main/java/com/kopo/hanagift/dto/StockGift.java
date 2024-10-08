package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StockGift {
    private String productID;             // 상품 ID
    private String stockCode;             // 주식 코드
    private String productName;           // 상품 이름
    private double expectedStockQuantity;    // 예상 주식 수량
    private double stockQuantity;            // 실제 주식 수량
    private String logoImageURL;          // 로고 이미지 URL
    private String createdAt;      // 생성 시간 (주식 선물 받은 시간)
}
