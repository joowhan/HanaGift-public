package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class JoinedPreferences {
    private String userId;
    private int countryId;
    private String countryName;
    private String giftType;
    private String stockCode;
    private String currencyCode;
    private String logoImgURL;
}
