package com.kopo.hanagift.utils;

public class WonExtractor {
    public static double parseWonAmount(String wonAmount) {
        // "원"을 제거하고 양 끝 공백을 제거한 후, 숫자만 남기기
        String cleanAmount = wonAmount.replace("원", "").trim();

        // 숫자만 남은 문자열을 double로 변환
        double amount = Double.parseDouble(cleanAmount.replace(",", ""));

        return amount;
    }
}
