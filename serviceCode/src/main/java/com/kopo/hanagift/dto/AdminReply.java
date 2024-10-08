package com.kopo.hanagift.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminReply {
    private int replyId;
    private int postId;
    private String adminId;
    private String replyContent;
    private String replyDate; // String으로 날짜를 처리
}
