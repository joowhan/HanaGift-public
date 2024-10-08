package com.kopo.hanagift.service;

import com.kopo.hanagift.dto.SecuritiesAccounts;
import com.kopo.hanagift.dto.SecuritiesTransaction;
import com.kopo.hanagift.dto.StockPrice;
import com.kopo.hanagift.mapper.SecuritiesMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
public class SecuritiesService {

    @Autowired
    private SecuritiesMapper securitiesMapper;

    public List<SecuritiesAccounts> getAccountsByUserId(String userId){
        return securitiesMapper.getAccountsByUserId(userId);
    }

    @Transactional
    public boolean processGiftTransaction(String accountNumber, String bankCode, double amount) {
        // 1. 계좌 정보 조회
        SecuritiesAccounts account = securitiesMapper.findAccount(accountNumber, bankCode);
        if (account == null || account.getWithdrawalLimit() < amount) {
            return false; // 잔액 부족 또는 계좌 없음
        }

        // 2. 잔액 차감
        int updatedRows = securitiesMapper.deductBalance(accountNumber, bankCode, amount);
        if (updatedRows == 0) {
            return false; // 업데이트 실패
        }

        // 3. 거래 이력 기록
        SecuritiesTransaction transaction = new SecuritiesTransaction();
        transaction.setTransactionID(UUID.randomUUID().toString());
        transaction.setTransactionType("출금"); // 거래 유형 설정
        transaction.setAmount(amount);
        transaction.setBankCode(bankCode);
        transaction.setBalanceAfter(account.getDeposit() - amount);
        transaction.setAccountNumber(accountNumber);

        securitiesMapper.insertTransaction(transaction);
        return true;
    }

    public boolean addBalance(String accountNumber,String bankCode, double amount){
        int rows = securitiesMapper.addBalance(accountNumber,bankCode,amount);
        return rows>0;
    }


    public List<StockPrice> getStockPriceByPeriod(String code){
        return securitiesMapper.getStockPriceByPeriod(code);
    }

}
