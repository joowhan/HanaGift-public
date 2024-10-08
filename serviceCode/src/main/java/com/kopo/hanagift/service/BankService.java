package com.kopo.hanagift.service;

import com.kopo.hanagift.dto.BankAccounts;
import com.kopo.hanagift.dto.BankTransaction;
import com.kopo.hanagift.dto.InterestRate;
import com.kopo.hanagift.dto.Savings;
import com.kopo.hanagift.mapper.BankMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Service
public class BankService {
    @Autowired
    private BankMapper bankMapper;

    public BankAccounts getAccountsByUserId(String userId) {
        return bankMapper.findAccountsByUserId(userId);
    }

    @Transactional
    public boolean processGiftTransaction(String accountNumber, String bankCode, double amount){
        // 계좌 정보 조회
        BankAccounts account = bankMapper.findAccount(accountNumber, bankCode);
        if (account == null || account.getBalance() < amount) {
            return false; // 잔액 부족 또는 계좌 없음
        }

        // 잔액 차감
        int updatedRows = bankMapper.deductBalance(accountNumber, bankCode, amount);
        if (updatedRows == 0) {
            return false; // 업데이트 실패
        }

        // 거래 이력 기록
        BankTransaction transaction = new BankTransaction();
        transaction.setTransactionID(UUID.randomUUID().toString());
        transaction.setTransactionType("");
        transaction.setAmount(amount);
        transaction.setBankCode(bankCode);
        transaction.setTransactionType("출금");
        transaction.setBalanceAfter(account.getBalance() - amount);
        transaction.setAccountNumber(accountNumber);

        bankMapper.insertTransaction(transaction);
        return true;
    }

    @Transactional
    public boolean processDepositTransaction(String accountNumber, double balance, String bankCode, double amount) {


        // 2. 잔액 추가 (적금 선물 받기)
        int updatedRows = bankMapper.addBalance(accountNumber, bankCode, amount);
        if (updatedRows == 0) {
            return false; // 업데이트 실패
        }

        // 3. 거래 내역 기록
        BankTransaction transaction = new BankTransaction();
        transaction.setTransactionID(UUID.randomUUID().toString());
        transaction.setTransactionType("입금"); // 선물 입금
        transaction.setAmount(amount);
        transaction.setBankCode(bankCode);
        transaction.setBalanceAfter(balance + amount); // 추가된 잔액
        transaction.setAccountNumber(accountNumber);

        // 거래 내역을 DB에 저장
        bankMapper.insertTransaction(transaction);

        return true;
    }

    public List<InterestRate> getProductInterestRate(String productId){
        return bankMapper.findProductInterest(productId);
    }

    public boolean completeSubscription(Savings savings){
        int rows = bankMapper.insertSavings(savings);
        return rows >0;
    }



}
