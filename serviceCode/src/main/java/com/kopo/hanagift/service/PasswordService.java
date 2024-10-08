package com.kopo.hanagift.service;

import com.kopo.hanagift.mapper.BankMapper;
import com.kopo.hanagift.mapper.HanaMoneyMapper;
import com.kopo.hanagift.mapper.SecuritiesMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PasswordService {

    @Autowired
    private BankMapper bankMapper;
    @Autowired
    private SecuritiesMapper securitiesMapper;
    @Autowired
    private HanaMoneyMapper hanaMoneyMapper;

    // accountNumber로 인증하려고 했으나, 제대로 받아오지 못해 userId로 변경
    public boolean checkPassword(String userId, String password) {
        int result = bankMapper.checkPassword(userId, password);
        return result > 0; // 1 이상이면 일치하는 비밀번호가 존재
    }
    public boolean checkStockPassword(String userId, String password){
        int result = securitiesMapper.checkPassword(userId, password);
        return result >0;
    }

    public boolean checkCurrencyPassword(String userId, String password){
        int result = hanaMoneyMapper.checkPassword(userId,password);
        return result >0;
    }
}
