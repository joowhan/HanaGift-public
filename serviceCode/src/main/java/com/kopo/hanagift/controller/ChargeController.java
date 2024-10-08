package com.kopo.hanagift.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kopo.hanagift.dto.BankAccounts;
import com.kopo.hanagift.dto.ExchangeRate;
import com.kopo.hanagift.dto.StockNCurrency;
import com.kopo.hanagift.service.BankService;
import com.kopo.hanagift.service.ChargeService;
import com.kopo.hanagift.service.ExchangeRateService;
import com.kopo.hanagift.service.StockNCurrencyService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ChargeController {

    @Autowired
    private StockNCurrencyService stockNCurrencyService;
    @Autowired
    private ExchangeRateService exchangeRateService;
    @Autowired
    private BankService bankService;
    @Autowired
    private ChargeService chargeService;

    @GetMapping("/charge")
    public String charge(
            @RequestParam(value = "code", defaultValue = "USD") String code,
            HttpSession session,
            Model model) throws JsonProcessingException {
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/loginPage";  // loginPage는 JSP 파일의 URL
        }
        System.out.println(code);
        List<StockNCurrency> findAllCurrency = stockNCurrencyService.findCurrencyAll();
        BankAccounts account = bankService.getAccountsByUserId(userId);
        Map<String, Object> rateInfo = exchangeRateService.findExchangeRateWithComparison(code);
        StockNCurrency selectedCurrency = stockNCurrencyService.findStockNCurrencyByCode(code);
        ExchangeRate latestRate = (ExchangeRate) rateInfo.get("latestRate");
        List<ExchangeRate> exchangeRatePeriod = exchangeRateService.findExchangeRatePeriod(code);
        double changeAmount1 = (double) rateInfo.get("changeAmount");
        double changePercentage1 = (double) rateInfo.get("changePercentage");

        double changeAmount = Double.parseDouble(String.format("%.2f", changeAmount1));
        double changePercentage = Double.parseDouble(String.format("%.2f", changePercentage1));

        model.addAttribute("activeMenu", "charge");
        model.addAttribute("account", account);
        model.addAttribute("latestRate", latestRate);
        model.addAttribute("findAllCurrency", findAllCurrency);
        model.addAttribute("changeAmount",changeAmount);
        model.addAttribute("changePercentage", changePercentage);
        model.addAttribute("selectedCurrency",selectedCurrency);
        // JSON 문자열로 직렬화
        ObjectMapper objectMapper = new ObjectMapper();
        String exchangeRatePeriodJson = objectMapper.writeValueAsString(exchangeRatePeriod);

        model.addAttribute("exchangeRatePeriodJson", exchangeRatePeriodJson);

        return "chargeCurrency";
    }
    @PostMapping("/chargeCurrency")
    public ResponseEntity<Map<String, Object>> chargeCurrency(
            @RequestParam("account") String account,    // 선택된 계좌
            @RequestParam("amount") double amount,      // 입력된 외화 금액
            @RequestParam("bankCode") String bankCode,
            @RequestParam("wonAmount") String wonAmount, // 계산된 원화 금액
            @RequestParam("currencyCode") String currencyCode, // 외화 코드 (USD, EUR 등)
            HttpSession session) {
        System.out.println(amount + account + wonAmount + currencyCode);
        String userId = (String) session.getAttribute("userId");
        Map<String, Object> response = new HashMap<>();
        //1. 선택한 계좌에서 잔액 조회
        //2. 계좌에서 계산된 원화만큼 인출
        //3. 하나머니 환전지갑에서 선택한 외화가 존재하는지 확인 후 존재하면 update, 존재하지 않으면 insert
        //4. 하나머니 거래 내역에 거래 내역 기록
        boolean success = chargeService.chargeForeignCurrency(userId, account,amount,wonAmount,currencyCode, bankCode);
        if(success){
            response.put("success", true);
        }
        else{
            response.put("success", false);
        }

        return ResponseEntity.ok(response);
    }

}
