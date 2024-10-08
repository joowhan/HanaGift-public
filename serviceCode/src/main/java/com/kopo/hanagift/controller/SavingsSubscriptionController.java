package com.kopo.hanagift.controller;

import com.kopo.hanagift.dto.*;
import com.kopo.hanagift.service.BankService;
import com.kopo.hanagift.service.ProductService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Slf4j
public class SavingsSubscriptionController {
    @Autowired
    ProductService productService;
    @Autowired
    BankService bankService;

    @PostMapping("/savings-subscription")
    public String savingsSubscription(@ModelAttribute Gift gift,
                                      HttpSession session,
                                      Model model){
        log.info(gift.getProductID());
        log.info(gift.getProductCategory());
        log.info(String.valueOf(gift.getAmount()));
        log.info(gift.getReceiverID());
        String userId = (String) session.getAttribute("userId");
        SavingProduct savingProduct = productService.getSavingById(gift.getProductID());
        SavingProductDetail savingProductDetail = productService.getProductDetailsById(gift.getProductID());
        BankAccounts bankAccounts = bankService.getAccountsByUserId(userId);

        model.addAttribute("savingProduct", savingProduct);
        model.addAttribute("savingProductDetail", savingProductDetail);
        model.addAttribute("bankAccount", bankAccounts);
        model.addAttribute("gift", gift);
        log.info(savingProduct.getProductName());
        System.out.println("ddd1"+savingProduct.getProductName());
        return "savingsSubscription";
    }

    @GetMapping("/savings-subscription")
    public String savingsSubscriptionTest(HttpSession session, Model model){
        System.out.println("test end point");
        Gift gift = new Gift();
        gift.setProductID("s001");
        session.setAttribute("userId", "joy9876");

        String userId = (String) session.getAttribute("userId");
        SavingProduct savingProduct = productService.getSavingById(gift.getProductID());
        SavingProductDetail savingProductDetail = productService.getProductDetailsById(gift.getProductID());
        BankAccounts bankAccounts = bankService.getAccountsByUserId(userId);
        List<InterestRate> productInterest = bankService.getProductInterestRate(gift.getProductID());

        model.addAttribute("savingProduct", savingProduct);
        model.addAttribute("savingProductDetail", savingProductDetail);
        model.addAttribute("bankAccount", bankAccounts);
        model.addAttribute("interestRate", productInterest);
        model.addAttribute("gift", gift);
        return "savingsSubscription";
    }

    @PostMapping("/complete-subscription")
    public ResponseEntity<Map<String, String>> completeSubscription(
            @RequestBody Savings savings,
            HttpSession session) {

        String userId = (String) session.getAttribute("userId");
        log.info("사용자 ID [{}]의 적금 가입 요청을 처리 중입니다.", userId);
        log.info("받은 적금 정보: {}", savings.getAccountNumber());


        // 적금 가입 로직 처리 (데이터베이스 저장)
        boolean isSuccess = bankService.completeSubscription(savings);

        Map<String, String> response = new HashMap<>();
        if (isSuccess) {
            response.put("status", "success");
            log.info("사용자 ID [{}]의 적금 가입이 성공적으로 완료되었습니다.", userId);
            return ResponseEntity.ok(response);
        } else {
            response.put("status", "failure");
            log.error("사용자 ID [{}]의 적금 가입에 실패하였습니다.", userId);
            return ResponseEntity.status(500).body(response);
        }
    }
}
