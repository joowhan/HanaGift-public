package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class FriendList {
    private String userId;           // 사용자 ID (친구를 추가한 사람)
    private String friendId;         // 친구 ID
    private String friendName;       // 친구 이름
    private String friendStatusMessage; // 친구 상태 메시지
    private String friendPhoneNumber;   // 친구 전화번호
    private String friendProfileUrl;
}
