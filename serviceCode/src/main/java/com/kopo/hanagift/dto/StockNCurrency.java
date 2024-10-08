package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StockNCurrency {
    private int productID;
    private String productType; // 'Stock' or 'ForeignCurrency'
    private String category;
    private String productName;
    private String createdDate;
    private String logoImageURL;
    private String adminID;
    private String code;
}
