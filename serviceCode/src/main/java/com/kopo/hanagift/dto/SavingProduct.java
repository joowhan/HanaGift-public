package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SavingProduct {
    private String productId;            // 테이블의 ProductID에 해당
    private String productName;          // 테이블의 ProductName에 해당
    private String productType;          // 테이블의 ProductType에 해당
    private double basicInterestRate;    // 테이블의 BasicInterestRate에 해당
    private double maxAmount;            // 테이블의 MaxAmount에 해당
    private String adminId;              // 테이블의 AdminID에 해당
    private String shortDescription;     // 테이블의 ShortDescription에 해당
    private String createdDate;          // 테이블의 CreatedDate에 해당 (DATETIME이므로 String으로 처리, 포맷에 따라 Date로 변경 가능)
    private String imgUrl;
}
