package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ForeignWalletJoined {
    private double balance;
    private String currencyCode;
    private String productName;
    private String logoImageUrl;
}
