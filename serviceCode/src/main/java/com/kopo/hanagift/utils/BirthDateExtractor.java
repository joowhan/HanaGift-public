package com.kopo.hanagift.utils;

public class BirthDateExtractor {
    public static String extractBirthDateFromSSN(String ssn) {
        // 주민등록번호의 앞 6자리 (생년월일)와 뒤 첫 번째 자리 (성별 구분)를 추출
        String birthPart = ssn.substring(0, 6);
        char centuryIndicator = ssn.charAt(7);

        // 연도 계산 (성별 구분자의 첫 자리로 세기를 구분)
        String yearPrefix = (centuryIndicator == '1' || centuryIndicator == '2') ? "19" : "20";
        String year = yearPrefix + birthPart.substring(0, 2);

        // 월과 일 추출
        String month = birthPart.substring(2, 4);
        String day = birthPart.substring(4, 6);

        // 최종적으로 "yyyy년 M월 d일" 형식으로 반환
        return String.format("%s년 %d월 %d일", year, Integer.parseInt(month), Integer.parseInt(day));
    }
}
