package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class WishList {
    private String productID;
    private String userID;
    private String productName;
    private String productCategory;
    private String productImgUrl;
    private String description; //적금은 금리, 외화나 주식은 비어있음
}
