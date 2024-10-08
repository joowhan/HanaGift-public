package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SecuritiesTransaction {
    private String transactionID;
    private String transactionType;
    private double amount;
    private double balanceAfter;
    private String date;
    private String accountNumber;
    private String bankCode;
}
