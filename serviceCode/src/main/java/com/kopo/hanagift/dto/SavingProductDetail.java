package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SavingProductDetail {
    private int detailId;             // DetailID
    private String productId;         // ProductID
    private String detailedDescription; // DetailedDescription
    private double preferentialRate;  // PreferentialRate
    private int minDuration;          // MinDuration
    private int maxDuration;          // MaxDuration
    private String depositLimit;      // DepositLimit
    private String joinEligibility;   // JoinEligibility
    private String pdfLink;           // PDFLink
    private String createdDate;         // CreatedDate
}
