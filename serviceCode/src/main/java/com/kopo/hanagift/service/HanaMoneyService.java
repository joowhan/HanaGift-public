package com.kopo.hanagift.service;

import com.kopo.hanagift.dto.ForeignExchangeTransactions;
import com.kopo.hanagift.dto.ForeignWallet;
import com.kopo.hanagift.dto.HanaMoney;
import com.kopo.hanagift.mapper.HanaMoneyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
public class HanaMoneyService {

    @Autowired
    private HanaMoneyMapper hanaMoneyMapper;

    // 사용자 ID와 상품 ID를 기반으로 외화 지갑 정보를 가져오는 메서드
    public ForeignWallet getCurrencyWalletById(String userId, String productCode) {
        return hanaMoneyMapper.findCurrencyWalletById(userId, productCode);
    }
    public HanaMoney getHanaMoney(String userId){
        return hanaMoneyMapper.findHanaMoney(userId);
    }

    @Transactional
    public boolean processGiftTransaction(String userId, String productCode, double amount){
        // 1. 외화 지갑 정보 조회
        ForeignWallet wallet = hanaMoneyMapper.findCurrencyWalletById(userId, productCode);
        if (wallet == null || wallet.getBalance() < amount) {
            return false; // 잔액 부족 또는 지갑 없음
        }

        // 2. 잔액 차감
        int updatedRows = hanaMoneyMapper.deductBalance(userId, productCode, amount);
        if (updatedRows == 0) {
            return false; // 업데이트 실패
        }

        // 3. 거래 이력 기록
        ForeignExchangeTransactions transaction = new ForeignExchangeTransactions();
        transaction.setTransactionID(UUID.randomUUID().getMostSignificantBits() & Long.MAX_VALUE); // 고유한 거래 ID 생성
        transaction.setTransactionType("선물"); // 거래 유형 설정
        transaction.setAmount(amount);
        transaction.setCurrencyCode(productCode);
        transaction.setBalanceAfter(wallet.getBalance() - amount);
        transaction.setUserID(userId);

        hanaMoneyMapper.insertTransaction(transaction);
        return true;


    }

    @Transactional
    public boolean receivedGift(String userId, String currencyUnit, double receivedAmount){
        ForeignWallet existingWallet = hanaMoneyMapper.findWalletByUserIdAndCurrencyUnit(userId, currencyUnit);
        if (existingWallet != null) {
            // 지갑에 해당 외화가 이미 존재하면, 기존 잔액에 받은 금액을 더함
            double updatedBalance = existingWallet.getBalance() + receivedAmount;
            hanaMoneyMapper.updateWalletBalance(userId, currencyUnit, updatedBalance);
        } else {
            // 지갑에 해당 외화가 없으면 새롭게 지갑에 INSERT
            hanaMoneyMapper.insertNewWallet(userId, currencyUnit, receivedAmount);
        }
        return true;
    }
}
