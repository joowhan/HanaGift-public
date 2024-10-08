package com.kopo.hanagift.service;

import com.kopo.hanagift.dto.*;
import com.kopo.hanagift.mapper.BankMapper;
import com.kopo.hanagift.mapper.HanaMoneyMapper;
import com.kopo.hanagift.utils.WonExtractor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
public class ChargeService {
    @Autowired
    private BankMapper bankMapper;

    @Autowired
    private HanaMoneyMapper hanaMoneyMapper;

    @Transactional
    public boolean chargeForeignCurrency(String userId, String accountNumber,
                                         double amount, String wonAmount1,
                                         String currencyCode, String bankCode) {

        double wonAmount = WonExtractor.parseWonAmount(wonAmount1);
        // 1. 선택한 계좌에서 잔액 조회
        BankAccounts account = bankMapper.findAccount(accountNumber, bankCode);
        if (account.getBalance() < wonAmount) {
            throw new IllegalArgumentException("잔액이 부족합니다.");
        }

        // 2. 계좌에서 계산된 원화만큼 인출
        double newBalance = account.getBalance() - wonAmount;
        bankMapper.deductBalance(accountNumber, bankCode, amount);

        // 3. 거래 내역 기록
        BankTransaction bankTransaction = new BankTransaction();

        bankTransaction.setTransactionID(UUID.randomUUID().toString());
        bankTransaction.setTransactionType("WITHDRAW");
        bankTransaction.setAmount(wonAmount);
        bankTransaction.setBalanceAfter(newBalance);
        bankTransaction.setAccountNumber(accountNumber);
        bankTransaction.setBankCode(bankCode);

        bankMapper.insertTransaction(bankTransaction);

        // 4. 하나머니 환전지갑에서 선택한 외화가 존재하는지 확인
        ForeignWallet foreignWallet = hanaMoneyMapper.findCurrencyWalletById(userId, currencyCode);
        if (foreignWallet == null) {
            // 지갑이 없으면 새로운 지갑 생성
            hanaMoneyMapper.insertNewWallet(userId,currencyCode,amount);
            foreignWallet = hanaMoneyMapper.findCurrencyWalletById(userId, currencyCode);
        } else {
            // 지갑이 있으면 잔액 업데이트
            System.out.println("지갑이 존재한다고 나옴");
            double updatedBalance = foreignWallet.getBalance() + amount;
            hanaMoneyMapper.updateWalletBalance(userId, currencyCode, updatedBalance);
        }

        // 5. 하나머니 거래 내역 기록
        ForeignExchangeTransactions foreignTransaction = new ForeignExchangeTransactions();
        foreignTransaction.setTransactionID(UUID.randomUUID().getMostSignificantBits() & Long.MAX_VALUE);
        foreignTransaction.setTransactionType("CHARGE");
        foreignTransaction.setAmount(amount);
        foreignTransaction.setBalanceAfter(foreignWallet.getBalance() + amount);
        foreignTransaction.setCurrencyCode(currencyCode);
        foreignTransaction.setUserID(userId);
        System.out.println("wow" + foreignTransaction.getTransactionID());
        hanaMoneyMapper.insertTransaction(foreignTransaction);

        return true;
    }

}
