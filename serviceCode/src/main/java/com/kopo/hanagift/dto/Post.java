package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Post {
    private int postId;
    private String userId;
    private String profileUrl;
    private String title;
    private String content;
    private String date;
    private String responseStatus;
    private int number;
}
