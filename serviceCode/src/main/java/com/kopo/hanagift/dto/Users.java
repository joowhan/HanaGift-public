package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Users {
    private String userId;
    private String password;
    private String phoneNumber;
    private String ssn;
    private String createDate;
    private String name;
    private String email;
    private String statusMessage;
    private String birthDate;
    private String profileUrl;
}
