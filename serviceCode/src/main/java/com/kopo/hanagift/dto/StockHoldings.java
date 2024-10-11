package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StockHoldings {
    private double quantity;
    private String stockCode;
    private String productName;
    private String logoImageUrl;
}
