package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserPreferences {
    private String userId;
    private int countryId;
    private String giftType;
    private String stockCode;
    private String currencyCode;
}
