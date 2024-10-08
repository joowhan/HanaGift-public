package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Gift {
    private String giftID;
    private String productID;
    private String senderID;
    private String date;
    private String status;
    private String productCategory;
    private String receiverID;
    private double amount;
    private String currencyUnit;
}
