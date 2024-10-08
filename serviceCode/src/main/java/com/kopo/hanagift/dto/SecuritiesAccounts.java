package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SecuritiesAccounts {
    private String accountNumber;
    private String password;
    private int deposit;
    private int withdrawalLimit;
    private String date;
    private String userId;
    private String bankCode;
}
