package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Reviews {
    private String reviewID;
    private String userID;
    private String productID;
    private String writtenDate;
    private String reviewText;
    private int stars;
}
