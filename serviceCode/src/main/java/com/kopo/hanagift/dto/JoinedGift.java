package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class JoinedGift {
    private String giftID;
    private String productID;
    private String senderID;
    private String date;
    private String status;
    private String productCategory;
    private String receiverID;
    private String productName;  // Product name (from either StockNCurrency or SavingsProducts)
    private String senderName;   // Name of the sender (from Users table)
    private String receiverName;
    private String amount;
    private String currencyUnit;
}
