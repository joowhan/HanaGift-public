package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ForeignWallet {
    private double balance;  // balance 필드
    private String userID;   // userID 필드
    private String currencyCode; // 외화 이름 -> 코드성 테이블에서 가져오기
}
