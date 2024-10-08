package com.kopo.hanagift.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kopo.hanagift.dto.*;
import com.kopo.hanagift.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.http.ResponseEntity;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class ProductController {

    @Autowired
    private ProductService productService;
    @Autowired
    private BankService bankService;
    @Autowired
    private SecuritiesService securitiesService;
    @Autowired
    private FriendService friendService;

    @Autowired
    private PasswordService passwordService;
    @Autowired
    private ReviewService reviewService;
    @Autowired
    private ExchangeRateService exchangeRateService;

    @Autowired
    private HanaMoneyService hanaMoneyService;

    @RequestMapping("/")
    public ModelAndView home(
            @RequestParam(value = "productType", defaultValue = "all") String productType,
            Model model,
            HttpSession session) {
        //login 구현 후 session은 수정할 것
        ModelAndView modelAndView = new ModelAndView("index");
        modelAndView.addObject("headerClass", "");
        modelAndView.addObject("activeMenu", "home");
        model.addAttribute("selectedProductType", productType);

        // StockNCurrency 테이블에서 모든 제품 데이터를 조회하여 모델에 추가
        List<StockNCurrency> products = productService.getAllProducts();
        List<SavingProduct> savingProducts = productService.getAllSavingProduct();
        model.addAttribute("products", products);
        model.addAttribute("savingProducts", savingProducts);
        System.out.println(products.size());
        return modelAndView;
    }

    @GetMapping("/productPage")
    public String productPage(Model model) {
        model.addAttribute("headerClass", "header-v4");  // 클래스 속성을 빈 문자열로 설정
        model.addAttribute("activeMenu", "gift");  // "선물하기" 메뉴를 활성화
        List<StockNCurrency> products = productService.getAllProducts();
        List<SavingProduct> savingProducts = productService.getAllSavingProduct();
        System.out.println(products.size());
        model.addAttribute("products", products);
        model.addAttribute("savingProducts", savingProducts);
        return "productPage";  // "productPage"는 /WEB-INF/views/productPage.jsp
    }

    @GetMapping("/savings-detail")
    public String savingsDetail(
            @RequestParam(value = "productId") String productId,
            Model model,
            HttpSession session){
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/loginPage";  // loginPage는 JSP 파일의 URL
        }
        BankAccounts accounts = bankService.getAccountsByUserId(userId);
        SavingProductDetail savingProductDetails = productService.getProductDetailsById(productId);
        SavingProduct savingProduct = productService.getSavingById(productId);
        List<Friend> friends = friendService.findAllFriendsById(userId);
        List<Reviews> reviews = reviewService.findAllReviewsById(productId);

        model.addAttribute("accounts", accounts);
        model.addAttribute("savingProduct", savingProduct);
        model.addAttribute("productDetails", savingProductDetails);
        model.addAttribute("friends", friends);
        model.addAttribute("reviews", reviews);


        return "savings-detail";
    }

    // 계좌 비밀번호 일치 여부 확인 -> 일반 은행계좌
    @PostMapping("/checkPassword")
    public ResponseEntity<Map<String, Boolean>> checkPassword(
//            @RequestParam(value ="accountNumber") String accountNumber,
            @RequestParam(value ="password")String password,
            HttpSession session) {
        System.out.println(password);
        String userId = (String)session.getAttribute("userId");
        Map<String, Boolean> response = new HashMap<>();
        boolean isPasswordValid = passwordService.checkPassword(userId, password); // 비밀번호 검증 로직
        response.put("match", isPasswordValid);
        //잔액 조회도 같이??
        return ResponseEntity.ok(response);
    }
    // 계좌 비밀번호 일치 여부 확인 ->  증권 계좌
    @PostMapping("/checkPassword/stock")
    public ResponseEntity<Map<String, Boolean>> checkStockPassword(
            @RequestBody Map<String, String> requestData,
            HttpSession session
    ){
        String password = requestData.get("password");
        String userId = (String) session.getAttribute("userId");
        Map<String, Boolean> response = new HashMap<>();
        boolean isPasswordValid = passwordService.checkStockPassword(userId, password);
        response.put("match", isPasswordValid);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/checkPassword/currency")
    public ResponseEntity<Map<String, Boolean>> checkCurrencyPassword(
            @RequestParam(value ="password")String password,
            HttpSession session){
        String userId = (String)session.getAttribute("userId");
        Map<String, Boolean> response = new HashMap<>();
        boolean isPasswordValid = passwordService.checkCurrencyPassword(userId, password);
        response.put("match", isPasswordValid);
        return ResponseEntity.ok(response);


    }


    // review insert
    @PostMapping("/submitReview")
    public String submitReview(
            HttpSession session,
            @RequestParam("productID") String productID,
            @RequestParam("reviewText") String reviewText,
            @RequestParam("stars") int stars,
            RedirectAttributes redirectAttributes) {
        Reviews review = new Reviews();
        review.setUserID((String) session.getAttribute("userId"));
        review.setProductID(productID);
        review.setReviewText(reviewText);
        review.setStars(stars);
        review.setWrittenDate(LocalDate.now().toString()); // 현재 날짜 설정

        // 리뷰 저장 로직
        reviewService.saveReview(review);

        // 리뷰 저장 후 리디렉션
        redirectAttributes.addFlashAttribute("message", "리뷰가 성공적으로 작성되었습니다!");
        return "redirect:/savings-detail?productId="+productID;
    }

    @GetMapping("/stocks-details")
    public String stockDetail(
            @RequestParam(value = "productId") String productId,
            Model model,
            HttpSession session
    ) throws JsonProcessingException {

        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/loginPage";  // loginPage는 JSP 파일의 URL
        }
        //증권 계좌 조회
        List<SecuritiesAccounts> accounts = securitiesService.getAccountsByUserId(userId);

        StockNCurrency stock = productService.getStockNCurrency(productId);
        List<Friend> friends = friendService.findAllFriendsById(userId);
        List<Reviews> reviews = reviewService.findAllReviewsById(productId);
        List<StockPrice> stockPriceList = securitiesService.getStockPriceByPeriod(stock.getCode());
        // JSON 문자열로 직렬화
        ObjectMapper objectMapper = new ObjectMapper();
        String stockPriceListJson = objectMapper.writeValueAsString(stockPriceList);
        model.addAttribute("stockPriceListJson", stockPriceListJson);
        model.addAttribute("stockPriceListJson", stockPriceListJson);
        model.addAttribute("stockPriceList", stockPriceList);
        model.addAttribute("accounts", accounts);
        model.addAttribute("stock", stock);
        model.addAttribute("friends", friends);
        model.addAttribute("reviews", reviews);


        return "stock-detail";
    }

    @GetMapping("/currency-details")
    public String currencyDetail(
            @RequestParam(value = "productCode") String productCode,
            @RequestParam(value = "productId") String productId,
            Model model,
            HttpSession session) throws JsonProcessingException {

        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/loginPage";  // loginPage는 JSP 파일의 URL
        }
        //유저 아이디 기반 외화 지갑 불러오기, 계정 불러오기
        ForeignWallet foreignWallet = hanaMoneyService.getCurrencyWalletById(userId, productCode);
        HanaMoney hanaMoney = hanaMoneyService.getHanaMoney(userId);
        List<Friend> friends = friendService.findAllFriendsById(userId);
        List<Reviews> reviews = reviewService.findAllReviewsById(productId);
        StockNCurrency currency = productService.getStockNCurrency(productId);
        List<ExchangeRate> exchangeRatePeriod = exchangeRateService.findExchangeRatePeriod(productCode);

        // JSON 문자열로 직렬화
        ObjectMapper objectMapper = new ObjectMapper();
        String exchangeRatePeriodJson = objectMapper.writeValueAsString(exchangeRatePeriod);

        model.addAttribute("exchangeRatePeriodJson", exchangeRatePeriodJson);
        model.addAttribute("currencyWallet", foreignWallet);
        model.addAttribute("hanaMoney", hanaMoney);
        model.addAttribute("friends", friends);
        model.addAttribute("reviews", reviews);
        model.addAttribute("product", currency);
        return "currency-detail";
    }

    @PostMapping("/wishlist/add")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addWishlist(@RequestParam("productName") String productName,
                                                           HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        System.out.println("add wishlist " + productName.trim());
        // 새로운 위시리스트 항목을 생성
        StockNCurrency stockNCurrency = productService.getProductByName(productName.trim());
        if (stockNCurrency == null) {
            response.put("status", "error");
            response.put("message", "상품을 찾을 수 없습니다.");
            return new ResponseEntity<>(response, HttpStatus.NOT_FOUND);
        }
        System.out.println(stockNCurrency.getProductName().trim());
        // 사용자 ID 가져오기
        String userId = (String) session.getAttribute("userId");
        if (userId == null || userId.isEmpty()) {
            response.put("status", "error");
            response.put("message", "사용자 정보를 찾을 수 없습니다.");
            return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
        }

        // 위시리스트 서비스 호출 (DB에 저장)
        try {
            productService.addWishlist(stockNCurrency, userId);
            response.put("status", "success");
            response.put("message", "위시리스트에 성공적으로 추가되었습니다!");
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "위시리스트 추가 중 오류가 발생했습니다.");
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
