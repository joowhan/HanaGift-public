package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Friend {
    private String userId;       // 사용자 ID
    private String friendId;     // 친구 ID
    private String friendName;
    private String status;       // 친구 상태
    private String phoneNumber;  // 친구 전화번호
}
