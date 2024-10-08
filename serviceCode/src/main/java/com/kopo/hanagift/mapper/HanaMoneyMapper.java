package com.kopo.hanagift.mapper;

import com.kopo.hanagift.dto.ForeignExchangeTransactions;
import com.kopo.hanagift.dto.ForeignWallet;
import com.kopo.hanagift.dto.HanaMoney;
import org.apache.ibatis.annotations.*;

@Mapper
public interface HanaMoneyMapper {

    @Select("SELECT * FROM ForeignWallet WHERE userID = #{userId} AND CurrencyCode = #{productCode}")
    ForeignWallet findCurrencyWalletById(@Param("userId") String userId, @Param("productCode") String productCode);

    @Select("SELECT * FROM HanaMoney WHERE userID  = #{userId}")
    HanaMoney findHanaMoney(String userId);

    @Select("select count(Password) " +
            "from HanaMoney " +
            "where UserID =  #{userID} and Password = #{password}") // 은행 계좌 ID?? 계좌번호가 더 적절해보임
    int checkPassword(@Param("userID") String userID, @Param("password") String password);

    @Update("UPDATE ForeignWallet SET balance = balance - #{amount} WHERE userID = #{userId} AND currencyCode = #{currencyCode} AND balance >= #{amount}")
    int deductBalance(@Param("userId") String userId, @Param("currencyCode") String currencyCode, @Param("amount") double amount);

    @Insert("INSERT INTO ForeignExchangeTransactions (transactionID, transactionType, amount, balanceAfter, currencyCode, userID) " +
            "VALUES (#{transaction.transactionID}, #{transaction.transactionType}, #{transaction.amount}, " +
            "#{transaction.balanceAfter}, #{transaction.currencyCode}, #{transaction.userID})")
    void insertTransaction(@Param("transaction") ForeignExchangeTransactions transaction);

    @Select("select * from ForeignWallet where CurrencyCode = #{currencyUnit} AND UserID = #{userId}")
    ForeignWallet findWalletByUserIdAndCurrencyUnit(@Param("currencyUnit") String currencyUnit, @Param("userId") String userId);

    @Update("UPDATE ForeignWallet SET Balance = #{balance} WHERE CurrencyCode = #{currencyUnit} AND UserID = #{userId}")
    void updateWalletBalance(@Param("currencyUnit") String currencyUnit, @Param("userId") String userId, @Param("balance") double balance);

    // 새로운 외화 지갑을 추가
    @Insert("INSERT INTO ForeignWallet (UserID, CurrencyCode, Balance) VALUES (#{userId}, #{currencyUnit}, #{balance})")
    void insertNewWallet(@Param("userId") String userId, @Param("currencyUnit") String currencyUnit, @Param("balance") double balance);



}
