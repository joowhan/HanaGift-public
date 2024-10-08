package com.kopo.hanagift.mapper;

import com.kopo.hanagift.dto.BankAccounts;
import com.kopo.hanagift.dto.BankTransaction;
import com.kopo.hanagift.dto.InterestRate;
import com.kopo.hanagift.dto.Savings;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface BankMapper {
    @Select("SELECT AccountNumber, AccountName, UserID, Balance, BankCode, CodeDescription AS bankName " +
            "FROM BankAccounts b JOIN Codes c ON b.BankCode = c.CodeName " +
            "WHERE UserID = #{userId}")
    BankAccounts findAccountsByUserId(String userId);

    @Select("select count(Password) " +
            "from BankAccounts " +
            "where UserID =  #{userID} and Password = #{password}") // 은행 계좌 ID?? 계좌번호가 더 적절해보임
    int checkPassword(@Param("userID") String userID, @Param("password") String password);

    @Select("SELECT * FROM BankAccounts WHERE AccountNumber = #{accountNumber} AND BankCode = #{bankCode}")
    BankAccounts findAccount(@Param("accountNumber") String accountNumber, @Param("bankCode") String bankCode);

    @Update("UPDATE BankAccounts SET Balance = Balance - #{amount} WHERE AccountNumber = #{accountNumber} AND BankCode = #{bankCode}")
    int deductBalance(@Param("accountNumber") String accountNumber, @Param("bankCode") String bankCode, @Param("amount") double amount);

    @Insert("INSERT INTO BankTransactions (TransactionID, TransactionType, Amount, BalanceAfter, Date, AccountNumber, BankCode) " +
            "VALUES (#{transactionID}, #{transactionType}, #{amount}, #{balanceAfter}, now(), #{accountNumber}, #{bankCode})")
    int insertTransaction(BankTransaction transaction);

    @Update("UPDATE BankAccounts SET balance = balance + #{amount} WHERE accountNumber = #{accountNumber} AND bankCode = #{bankCode}")
    int addBalance(@Param("accountNumber") String accountNumber, @Param("bankCode") String bankCode, @Param("amount") double amount);

    @Select("select conditionName, preferentialInterestRate " +
            "from productConditions p join conditions c on p.conditionId = c.conditionId " +
            "where productId =#{productId}")
    List<InterestRate> findProductInterest(@Param("productId")String productId);

    // INSERT 쿼리
    @Insert("INSERT INTO db.Savings (AccountNumber, OpenDate, MaturityDate, PaymentDate, BaseRate, Amount, TotalAmount, SavingsCode) " +
            "VALUES (#{accountNumber}, now(),  DATE_ADD(NOW(), INTERVAL #{duration} MONTH), #{paymentDate}, #{baseRate}, #{amount}, #{amount}, 'HANA_S001')")
    int insertSavings(Savings savings);

    // UPDATE 쿼리 (계좌 번호를 기반으로 업데이트)

}
