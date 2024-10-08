package com.kopo.hanagift.controller;

import com.kopo.hanagift.dto.*;
import com.kopo.hanagift.service.*;
import com.kopo.hanagift.service.StockNCurrencyService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Slf4j
@Controller
public class GiftController {

    @Autowired
    private BankService bankService;

    @Autowired
    private UserService userService;

    @Autowired
    private GiftService giftService;

    @Autowired
    private SecuritiesService securitiesService;

    @Autowired
    private HanaMoneyService hanaMoneyService;

    @Autowired
    private StockNCurrencyService stockNCurrencyService;
    @Autowired
    private StockOrderService stockOrderService;

    @PostMapping("/sendGift")
    public String sendGift(
            @RequestParam("account") String account,
            @RequestParam("amount") String amountVal,
            @RequestParam(value = "recipientName", required = false) String recipientName,
            @RequestParam(value = "recipientPhone", required = false) String recipientPhone,
            @RequestParam(value = "selectedFriendId", required = false) String selectedFriendId,
            @RequestParam(value = "selectedFriendName", required = false) String selectedFriendName,
            @RequestParam(value = "currencyUnit", defaultValue = "won") String currencyUnit,
            @RequestParam(value = "productId") String productId,
            @RequestParam(value = "productType") String productType,
            @RequestParam(value = "bankCode") String bankCode,
            Model model,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        String[] accountDetails = account.split(" ");
        String accountNumber = accountDetails[accountDetails.length-1];
        double amount = Double.parseDouble(amountVal.replace(",", ""));
        // 문자열의 앞뒤 공백을 제거
        if (recipientName != null) {
            recipientName = recipientName.trim();
            recipientName = recipientName.replace(",","");
        }
        if (recipientPhone != null) {
            recipientPhone = recipientPhone.trim();
            recipientPhone = recipientPhone.replace(",","");
        }
        System.out.println("Account: " + accountNumber);
        System.out.println("Amount: " + amount);
        System.out.println("code: " + bankCode);
        System.out.println("Recipient Name: " + recipientName);
        System.out.println("Recipient Phone: " + recipientPhone);
        System.out.println("Selected Friend ID: " + selectedFriendId);
        System.out.println("Selected Friend Name: " + selectedFriendName);

        //계좌에서 돈 차감
        System.out.println("선택한 계좌: "+account);
        boolean success = bankService.processGiftTransaction(accountNumber, bankCode, amount);

        if (success) {
            String receiverID;
            if (selectedFriendId != null && !selectedFriendId.trim().isEmpty() &&
                    selectedFriendName != null && !selectedFriendName.trim().isEmpty()) {
                // 친구를 선택한 경우
                receiverID = selectedFriendId;
                log.info("친구 사용자: "+receiverID);
            } else if (recipientPhone != null && recipientName != null) {
                // 연락처로 보낸 경우, 전화번호로 사용자 조회
                Users recipientUser = userService.findUserByPhone(recipientPhone);
                log.info("연락처로 보낸 사용자: "+recipientUser.getName());
                if (recipientUser != null) {
                    receiverID = recipientUser.getUserId();
                } else {
                    // 사용자 정보를 찾을 수 없는 경우 처리
                    redirectAttributes.addFlashAttribute("error", "해당 연락처를 가진 사용자를 찾을 수 없습니다.");
                    return "redirect:/errorPage"; // 에러 페이지로 리디렉션
                }
            } else {
                // 잘못된 입력 처리
                redirectAttributes.addFlashAttribute("error", "수신자 정보를 입력하세요.");
                return "redirect:/errorPage"; // 에러 페이지로 리디렉션
            }
            String senderID = (String) session.getAttribute("userId"); // 실제 응용에서는 로그인한 사용자의 ID를 사용

            giftService.saveGift(productId, senderID, productType, receiverID, amount, currencyUnit);
            redirectAttributes.addFlashAttribute("message", "선물이 성공적으로 전송되었습니다!");
        } else {
            redirectAttributes.addFlashAttribute("error", "선물 전송에 실패했습니다. 잔액을 확인하세요.");
        }


        return "redirect:/giftBox";
    }

    @PostMapping("/sendGift/stock")
    public String sendStockGift(
            @RequestParam("account") String account,
            @RequestParam("amount") String amountVal,
            @RequestParam(value = "recipientName", required = false) String recipientName,
            @RequestParam(value = "recipientPhone", required = false) String recipientPhone,
            @RequestParam(value = "selectedFriendId", required = false) String selectedFriendId,
            @RequestParam(value = "selectedFriendName", required = false) String selectedFriendName,
            @RequestParam(value = "currencyUnit", defaultValue = "won") String currencyUnit,
            @RequestParam(value = "productId") String productId,
            @RequestParam(value = "productType") String productType,
            Model model,
            HttpSession session,
            RedirectAttributes redirectAttributes
    ) throws JSONException {
        double amount = Double.parseDouble(amountVal.replace(",", ""));
        if (recipientName != null) {
            recipientName = recipientName.trim();
            recipientName = recipientName.replace(",","");
        }
        if (recipientPhone != null) {
            recipientPhone = recipientPhone.trim();
            recipientPhone = recipientPhone.replace(",","");
        }

        System.out.println("Account: " + account);
        System.out.println("Amount: " + amount);
        System.out.println("Recipient Name: " + recipientName);
        System.out.println("Recipient Phone: " + recipientPhone);
        System.out.println("Selected Friend ID: " + selectedFriendId);
        System.out.println("Selected Friend Name: " + selectedFriendName);
        System.out.println(productId);
        JSONObject accountJson = new JSONObject(account);
        String accountNumber = accountJson.getString("accountNumber");
        String bankCode = accountJson.getString("bankCode");
        boolean success = securitiesService.processGiftTransaction(accountNumber, bankCode, amount);
        if (success) {
            String receiverID;

            if (selectedFriendId != null && !selectedFriendId.trim().isEmpty() &&
                    selectedFriendName != null && !selectedFriendName.trim().isEmpty()) {
                // 친구를 선택한 경우
                receiverID = selectedFriendId;
            } else if (recipientPhone != null && recipientName != null) {
                // 연락처로 보낸 경우, 전화번호로 사용자 조회
                Users recipientUser = userService.findUserByPhone(recipientPhone);
                if (recipientUser != null) {
                    receiverID = recipientUser.getUserId();
                } else {
                    // 사용자 정보를 찾을 수 없는 경우 처리
                    redirectAttributes.addFlashAttribute("error", "해당 연락처를 가진 사용자를 찾을 수 없습니다.");
                    return "redirect:/errorPage"; // 에러 페이지로 리디렉션
                }
            } else {
                // 잘못된 입력 처리
                redirectAttributes.addFlashAttribute("error", "수신자 정보를 입력하세요.");
                return "redirect:/errorPage"; // 에러 페이지로 리디렉션
            }

            String senderID = (String) session.getAttribute("userId"); // 실제 응용에서는 로그인한 사용자의 ID를 사용

            giftService.saveGift(productId, senderID, productType, receiverID, amount, currencyUnit);
            redirectAttributes.addFlashAttribute("message", "선물이 성공적으로 전송되었습니다!");
        } else {
            redirectAttributes.addFlashAttribute("error", "선물 전송에 실패했습니다. 잔액을 확인하세요.");
        }



        return "redirect:/giftBox";
    }



    @PostMapping("sendGift/currency")
    public String sendCurrencyGift(
            @RequestParam("amount") String amountVal,
            @RequestParam("balance") String balance,
            @RequestParam(value = "recipientName", required = false) String recipientName,
            @RequestParam(value = "recipientPhone", required = false) String recipientPhone,
            @RequestParam(value = "selectedFriendId", required = false) String selectedFriendId,
            @RequestParam(value = "selectedFriendName", required = false) String selectedFriendName,
            @RequestParam(value = "productCode") String productCode,

            @RequestParam(value = "productId") String productId,
            @RequestParam(value = "productType") String productType,
            Model model,
            HttpSession session,
            RedirectAttributes redirectAttributes
    ){
        double amount = Double.parseDouble(amountVal.replace(",", ""));
        if (recipientName != null) {
            recipientName = recipientName.trim();
            recipientName = recipientName.replace(",","");
        }
        if (recipientPhone != null) {
            recipientPhone = recipientPhone.trim();
            recipientPhone = recipientPhone.replace(",","");
        }

        System.out.println("Amount: " + amount);
        System.out.println("Recipient Name: " + recipientName);
        System.out.println("Recipient Phone: " + recipientPhone);
        System.out.println("Selected Friend ID: " + selectedFriendId);
        System.out.println("Selected Friend Name: " + selectedFriendName);
        System.out.println(productCode);

        String userId = (String) session.getAttribute("userId");

        boolean success = hanaMoneyService.processGiftTransaction(userId, productCode, amount);
        if (success) {
            String receiverID;

            if (selectedFriendId != null && !selectedFriendId.trim().isEmpty() &&
                    selectedFriendName != null && !selectedFriendName.trim().isEmpty()) {
                // 친구를 선택한 경우
                receiverID = selectedFriendId;
            } else if (recipientPhone != null && recipientName != null) {
                // 연락처로 보낸 경우, 전화번호로 사용자 조회
                Users recipientUser = userService.findUserByPhone(recipientPhone);
                if (recipientUser != null) {
                    receiverID = recipientUser.getUserId();
                } else {
                    // 사용자 정보를 찾을 수 없는 경우 처리
                    redirectAttributes.addFlashAttribute("error", "해당 연락처를 가진 사용자를 찾을 수 없습니다.");
                    return "redirect:/errorPage"; // 에러 페이지로 리디렉션
                }
            } else {
                // 잘못된 입력 처리
                redirectAttributes.addFlashAttribute("error", "수신자 정보를 입력하세요.");
                return "redirect:/errorPage"; // 에러 페이지로 리디렉션
            }

            String senderID = (String) session.getAttribute("userId"); // 실제 응용에서는 로그인한 사용자의 ID를 사용

            giftService.saveGift(productId, senderID, productType, receiverID, amount, productCode);
            redirectAttributes.addFlashAttribute("message", "선물이 성공적으로 전송되었습니다!");
        } else {
            redirectAttributes.addFlashAttribute("error", "선물 전송에 실패했습니다. 잔액을 확인하세요.");
        }
        return "redirect:/giftBox";
    }
    @GetMapping("/giftBox")
    public String giftBox(Model model, HttpSession session ) {
        // 받은 선물과 보낸 선물 리스트 가져오기
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/loginPage";  // loginPage는 JSP 파일의 URL
        }
        List<JoinedGift> receivedGifts = giftService.getReceivedGifts(userId);
        List<JoinedGift> sentGifts = giftService.getSentGifts(userId);
        System.out.println(receivedGifts.size()  + " "+ sentGifts.size());
        model.addAttribute("receivedGifts", receivedGifts);
        model.addAttribute("sentGifts", sentGifts);
        model.addAttribute("activeMenu", "giftbox");  // "선물하기" 메뉴를 활성화

        return "giftBox";
    }

    @PostMapping("/receiveGift")
    public ResponseEntity<Map<String, Boolean>> receiveGift(  @RequestBody Gift gift,
                                                              HttpSession session) {
        // 받은 Gift 객체를 처리하는 로직을 작

        System.out.println("선물 받기 요청: " + gift.getProductID());
        System.out.println("보낸 사람: " + gift.getSenderID());
        System.out.println("보낸 금액: " + gift.getAmount() + " " + gift.getCurrencyUnit());
        System.out.println(gift.getProductCategory());
        Map<String, Boolean> response = new HashMap<>();
        // 예시: 상태를 업데이트하고 처리 완료 응답 반환
        String userId = (String) session.getAttribute("userId");
        if (gift != null) {
            // 여기서 데이터베이스를 업데이트하는 로직을 넣습니다.
            // gift의 상태를 "RECEIVED"로 업데이트.
            giftService.updateGiftStatusToReceived(gift.getGiftID(), userId);
            //적금 -> 테이블에 업데이트, 거래내역 기록 -> 적금 테이블에 기록
            if("적립식예금".equals(gift.getProductCategory())){
                BankAccounts bankAccounts = bankService.getAccountsByUserId(userId);

                if (bankAccounts == null) {
                    response.put("success", false);
                    return ResponseEntity.status(400).body(response); // 계좌가 없으면 실패
                }

                boolean success = bankService.processDepositTransaction(bankAccounts.getAccountNumber(), bankAccounts.getBalance(), bankAccounts.getBankCode(), gift.getAmount());


            }
            //외화 -> 테이블에 업데이트, 거래내역 기록 -> 외화 지갑에 바로 업데이트
            if("ForeignCurrency".equals(gift.getProductCategory())){
                hanaMoneyService.receivedGift(userId,gift.getCurrencyUnit(),gift.getAmount());
            }
            //주식 -> 테이블에 업데이트, 거래내역 기록 -> 주식 일괄 주문 테이블에 insert -> 내 계좌, 주식 코드, 종목명, 날짜, 금액,
            if("Stock".equals(gift.getProductCategory())){
                // 주식 코드 불러오기
                String code = stockOrderService.getProductCode(gift.getProductID());
                // 주문 테이블에 insert
                stockOrderService.saveStockOrder(gift, code, userId);
                // 증권 계좌 업데이트(예수금, 출금가능금액)
                List<SecuritiesAccounts> securitiesAccountsList= securitiesService.getAccountsByUserId(userId);
                // 종합매매 계좌만 된다고 가정
                SecuritiesAccounts securitiesAccounts = securitiesAccountsList.get(0);
                securitiesService.addBalance(securitiesAccounts.getAccountNumber(), securitiesAccounts.getBankCode(),gift.getAmount());



            }
            response.put("success", true);
            return ResponseEntity.ok(response);
        } else {
            response.put("success", false);
            return ResponseEntity.status(400).body(response);
        }
    }
}
