package com.kopo.hanagift.controller;

import com.kopo.hanagift.dto.*;
import com.kopo.hanagift.service.FriendService;
import com.kopo.hanagift.service.StockNCurrencyService;
import com.kopo.hanagift.service.UserService;
import com.kopo.hanagift.service.WishListService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private FriendService friendService;
    @Autowired
    private StockNCurrencyService stockNCurrencyService;
    @Autowired
    private WishListService wishListService;

    @GetMapping("/myPage")
    public String myPage(Model model, HttpSession session){
        // 임시 로그인 상태
        session.setAttribute("userId", "joy98721");

        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/loginPage";  // loginPage는 JSP 파일의 URL
        }
        // read info
        Users user  = userService.findUserById(userId);
        UserPreferences userPreferences = userService.findUserPreference(userId);
//        List<Friend> friendList = friendService.findAllFriendsById(userId);
//        List<UserPreferences> friendPreference = userService.findFriendPreferences(userId);
        List<WishList> wishLists = wishListService.findUserWishList(userId);
        List<FriendList> friendList = friendService.findFriendList(userId);
        List<StockNCurrency> currencyList = stockNCurrencyService.findCurrencyAll();
        List<StockGift> stockGifts = userService.getStockGiftList(userId);

        model.addAttribute("userPreference", userPreferences);
        model.addAttribute("friendList", friendList);
//        model.addAttribute("friendPreference", friendPreference);
        model.addAttribute("user", user);
        model.addAttribute("activeMenu", "myPage");
        model.addAttribute("currencyList", currencyList);
        model.addAttribute("wishlist", wishLists);
        model.addAttribute("stockGifts",stockGifts);
        return "myPage";
    }
    @PostMapping("myPage/savePreferences")
    @ResponseBody
    public Map<String, Object> savePreferences(
            @RequestBody UserPreferences preferences,
            HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        String userId = (String) session.getAttribute("userId");
        System.out.println(preferences.getCountryId());

        UserPreferences userPreferences = userService.findUserPreference(userId);
        // 서비스 로직을 호출하여 저장 또는 업데이트 처리
        boolean success;
        if(userPreferences != null){
            success = userService.updateUserPreferences(userId, preferences);
        }
        else{
            success = userService.insertUserPreferences(userId, preferences);
        }

        response.put("success", success);


        return response;  // JSON 응답 반환
    }


    @PostMapping("/friendDetails")
    @ResponseBody
    public Map<String, Object> getFriendDetails(@RequestParam("userId") String userId) {
        Map<String, Object> response = new HashMap<>();
        System.out.println(userId);
        JoinedPreferences joinedPreferences = userService.findFriendJoinedPreferences(userId);
        List<WishList> wishLists = wishListService.findUserWishList(userId);
        System.out.println(joinedPreferences.getLogoImgURL());
        response.put("friendDetails", joinedPreferences);
        response.put("wishLists", wishLists);

        return response;
    }


    @PostMapping("/deleteFriend")
    @ResponseBody
    public Map<String, Object> deleteFriend(
            @RequestParam("friendId") String friendId,
            HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        try {
            // friendId를 기반으로 친구 삭제 처리
            String userId = (String) session.getAttribute("userId");
            boolean isDeleted = friendService.deleteFriendById(userId, friendId);

            if (isDeleted) {
                response.put("success", true);
            } else {
                response.put("success", false);
                response.put("message", "삭제할 친구를 찾지 못했습니다.");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "삭제 중 오류가 발생했습니다.");
        }

        return response;
    }

    @PostMapping("/addFriend")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> addFriend(@RequestBody Map<String, String> payload,
                                            HttpSession session) {
        String userId = (String) session.getAttribute("userId"); // 현재 로그인한 사용자 ID
        String friendName = payload.get("friendName");
        String phoneNumber = payload.get("phoneNumber");

        Map<String, Boolean> response = new HashMap<>();

        if (userId == null) {
            response.put("success", false);
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);  // 로그인 필요
        }

        boolean isAdded = friendService.addFriend(userId, friendName, phoneNumber);
        response.put("success", isAdded);

        if (isAdded) {
            return ResponseEntity.ok(response);  // 친구 추가 성공 시 true 반환
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);  // 친구를 찾을 수 없을 때 false 반환
        }
    }


    @GetMapping("/friendRequestList")
    @ResponseBody
    public List<Friend> getFriendRequests(HttpSession session) {
        // 현재 로그인한 사용자 ID 가져오기
        String userId = (String) session.getAttribute("userId");
        System.out.println(userId);
        // 친구 요청 목록 조회
        return friendService.getFriendRequests(userId);
    }

    @PostMapping("/acceptFriendRequest")
    public ResponseEntity<Map<String, Boolean>> approveFriendRequest(
            @RequestParam("id") String friendId,
            HttpSession session
    ) {
        String userId = (String) session.getAttribute("userId");

        // 세션에 사용자 ID가 없는 경우 401 응답
        if (userId == null) {
            Map<String, Boolean> response = new HashMap<>();
            response.put("approved", false);
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
        }

        // 친구 요청 승인 로직
        boolean isApproved = friendService.approveFriendRequest(userId, friendId);
        Map<String, Boolean> response = new HashMap<>();
        response.put("approved", isApproved);

        if (isApproved) {
            return ResponseEntity.ok(response);  // 성공 응답
        } else {
            return ResponseEntity.badRequest().body(response);  // 실패 응답
        }
    }

}
