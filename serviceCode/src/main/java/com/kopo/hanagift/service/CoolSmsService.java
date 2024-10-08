package com.kopo.hanagift.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import net.nurigo.sdk.message.model.Message;
import java.util.HashMap;

@Service
public class CoolSmsService {

    @Value("${coolsms.api.number}")
    private String fromPhoneNumber;

    public String getValidationCode() {
        String ran_str = "";
        for(int i=0; i<6; i++) {
            ran_str += (int)(Math.random()*10);
        }
        return ran_str;
    }

    public Message getMsgForm(String ran_str, String phone) {
        Message msg = new Message();

        msg.setFrom(fromPhoneNumber);
        msg.setTo(phone);
        msg.setText("[hanagift] 아래의 인증번호를 입력해주세요\n" + ran_str);

        return msg;
    }

    public Message sendGiftMessage(String name, String phone){
        Message msg = new Message();

        msg.setFrom(fromPhoneNumber);
        msg.setTo(phone);
        msg.setText("[하나Gift - 하나금융그룹 금융상품 선물 서비스]\n" +
                "안녕하세요 손님!\n" +
                name+"님이 보내신 금융상품선물이 도착했어요!\n" +
                "지금 선물함에서 확인해보세요!\n" +
                "https://www.hanagift.shop/giftBox");
        return msg;
    }
}
