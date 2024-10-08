package com.kopo.hanagift.controller;

import com.kopo.hanagift.dto.Users;
import com.kopo.hanagift.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@Slf4j
public class LoginController {

    @Autowired
    private UserService userService;

    @GetMapping("/loginPage")
    public String loginPage() {
        return "signInUp";
    }

    @PostMapping("/custom-signup")
    @ResponseBody
    public Map<String, Object> signup(@RequestBody Users user) {
        Map<String, Object> response = new HashMap<>();
        // 전체 URL에서 '/resources/images/' 부분만 남기고 앞부분 제거
        // 로그로 user 객체 확인
        log.info("Received User Data: {}", user);
        log.info("User ID: {}", user.getUserId());
        log.info("Password: {}", user.getPassword());
        log.info("Phone Number: {}", user.getPhoneNumber());
        log.info("SSN: {}", user.getSsn());
        log.info("Email: {}", user.getEmail());
        log.info("Name: {}", user.getName());
        log.info("Profile URL: {}", user.getProfileUrl());

        String profileUrl = user.getProfileUrl().replace("http://localhost:8080", "");

        // 수정된 URL을 다시 user 객체에 설정
        user.setProfileUrl(profileUrl);
        try {

            // 서비스에서 회원가입 처리
            boolean result = userService.signup(user);

            if (result) {
                response.put("success", true);
                response.put("message", "회원가입이 완료되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "회원가입 실패");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        log.info("로그인 응답: " + response.values());
        return response;
    }

    @PostMapping("/login")
    @ResponseBody
    public Map<String, Object> login(@RequestBody Map<String, String> loginData, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        String userId = loginData.get("userId");
        String hashedPassword = loginData.get("password");

        Users user = userService.findUserById(userId);

        if (user != null && user.getPassword().equals(hashedPassword)) {
            // 로그인 성공 - 세션에 사용자 정보 저장
            session.setAttribute("userId", user.getUserId()); // "user"라는 이름으로 세션에 사용자 정보 저장
            response.put("success", true);
            response.put("message", "로그인 성공");
        } else {
            // 로그인 실패
            response.put("success", false);
            response.put("message", "아이디 또는 비밀번호가 일치하지 않습니다.");
        }

        return response;
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();  // 세션 무효화
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "로그아웃 성공");
        return "redirect:/loginPage";
    }



}
