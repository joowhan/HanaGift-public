package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FriendReq {
    private String userId;          // Users.UserID
    private String userName;        // Users.Name
    private String userPhoneNumber; // Users.PhoneNumber (별칭: UserPhone)
    private String friendId;        // FriendID
    private String friendName;      // friendName
    private String date;            // Date
    private String status;          // Status
    private String friendPhoneNumber; // Friends.PhoneNumber
}
