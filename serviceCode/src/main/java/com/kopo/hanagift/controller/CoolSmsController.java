package com.kopo.hanagift.controller;

import com.kopo.hanagift.service.CoolSmsService;
import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import net.nurigo.sdk.message.model.Message;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/sms")
@Slf4j
public class CoolSmsController {
    @Autowired
    private CoolSmsService coolSmsService;
    @Value("${coolsms.api.key}")
    private String apiKey;

    @Value("${coolsms.api.secret}")
    private String apiSecret;

    @Value("${coolsms.api.number}")
    private String fromPhoneNumber;
    final DefaultMessageService messageService;

    @Autowired
    public CoolSmsController(CoolSmsService coolSmsService,
                             @Value("${coolsms.api.key}") String apiKey,
                             @Value("${coolsms.api.secret}") String apiSecret,
                             @Value("${coolsms.api.number}") String fromPhoneNumber) {
        this.coolSmsService = coolSmsService;
        this.messageService = NurigoApp.INSTANCE.initialize(apiKey, apiSecret, "https://api.coolsms.co.kr");
        this.fromPhoneNumber = fromPhoneNumber;
    }

    @PostMapping("/validation")
    public SingleMessageSentResponse sendSms(@RequestParam("phone") String phone, HttpSession session) {
        String cleanPhone = phone.replace("-", "");
        String ran_str = coolSmsService.getValidationCode();
        Message msg = coolSmsService.getMsgForm(ran_str, cleanPhone);
        session.setAttribute("phoneValidation", ran_str);
        return this.messageService.sendOne(new SingleMessageSendingRequest(msg));
    }

    @PostMapping("/sendGiftMsg")
    public SingleMessageSentResponse sendGiftMsg(@RequestBody Map<String, String> requestData) {
        String phone = requestData.get("phone");
        String name = requestData.get("name");
        String cleanPhone = phone.replace("-", "");
        Message msg = coolSmsService.sendGiftMessage(name,cleanPhone);
        log.info("Received phone: " + phone);
        log.info("Received name: " + name);
        return this.messageService.sendOne(new SingleMessageSendingRequest(msg));
    }

    @PostMapping("/verify-code")
    public Map<String, Object> verifyCode(@RequestBody Map<String, String> payload, HttpSession session) {
        String inputCode = payload.get("code");
        String sessionCode = (String) session.getAttribute("phoneValidation");

        Map<String, Object> response = new HashMap<>();
        if (inputCode != null && inputCode.equals(sessionCode)) {
            response.put("success", true);
        } else {
            response.put("success", false);
        }
        return response;
    }

}
