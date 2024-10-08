package com.kopo.hanagift.mapper;

import com.kopo.hanagift.dto.SecuritiesAccounts;
import com.kopo.hanagift.dto.SecuritiesTransaction;
import com.kopo.hanagift.dto.StockPrice;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface SecuritiesMapper {
    @Select("SELECT * FROM SecuritiesAccounts WHERE UserID = #{userId}")
    List<SecuritiesAccounts> getAccountsByUserId(@Param("userId") String userId);

    @Select("SELECT * FROM SecuritiesAccounts WHERE UserID = #{userId}")
    SecuritiesAccounts getOneAccountByUserId(@Param("userId") String userId);

    @Update("UPDATE SecuritiesAccounts SET Deposit = Deposit - #{amount} WHERE AccountNumber = #{accountNumber} AND UserID = #{userId} AND Deposit >= #{amount}")
    int updateAccountBalance(@Param("accountNumber") String accountNumber, @Param("userId") String userId, @Param("amount") int amount);

    @Select("select count(Password) " +
            "from SecuritiesAccounts " +
            "where UserID =  #{userID} and Password = #{password}") // 은행 계좌 ID?? 계좌번호가 더 적절해보임
    int checkPassword(@Param("userID") String userID, @Param("password") String password);

    @Select("SELECT * FROM SecuritiesAccounts WHERE accountNumber = #{accountNumber} AND bankCode = #{bankCode}")
    SecuritiesAccounts findAccount(@Param("accountNumber") String accountNumber, @Param("bankCode") String bankCode);

    @Update("UPDATE SecuritiesAccounts " +
            "SET Deposit = Deposit - #{amount}, WithdrawalLimit = WithdrawalLimit - #{amount} " +
            "WHERE accountNumber = #{accountNumber} " +
            "AND bankCode = #{bankCode} " +
            "AND Deposit >= #{amount} " +
            "AND WithdrawalLimit >= #{amount}")
    int deductBalance(@Param("accountNumber") String accountNumber,
                      @Param("bankCode") String bankCode,
                      @Param("amount") double amount);

    @Update("UPDATE SecuritiesAccounts " +
            "SET Deposit = Deposit + #{amount}, WithdrawalLimit = WithdrawalLimit + #{amount} " +
            "WHERE accountNumber = #{accountNumber} " +
            "AND bankCode = #{bankCode} " +
            "AND Deposit >= #{amount} " +
            "AND WithdrawalLimit >= #{amount}")
    int addBalance(@Param("accountNumber") String accountNumber,
                      @Param("bankCode") String bankCode,
                      @Param("amount") double amount);

    @Insert("INSERT INTO SecuritiesTransactions (TransactionID, TransactionType, Amount, BalanceAfter, Date, AccountNumber, BankCode) " +
            "VALUES (#{transactionID}, #{transactionType}, #{amount}, #{balanceAfter}, now(), #{accountNumber}, #{bankCode})")
    int insertTransaction(SecuritiesTransaction securitiesTransaction);




    // 특정 계좌와 주식코드에 해당하는 보유 주식이 존재하는지 확인
    @Select("SELECT COUNT(*) > 0 FROM StockHoldings WHERE AccountNumber = #{accountNumber} AND StockCode = #{stockCode}")
    boolean existsByAccountNumberAndStockCode(@Param("accountNumber") String accountNumber, @Param("stockCode") String stockCode);

    // 존재하는 경우 수량과 금액을 업데이트 (기존 값에 더함)
    @Update("UPDATE StockHoldings " +
            "SET Quantity = Quantity + #{quantity}, Principal = Principal + #{amount} " +
            "WHERE AccountNumber = #{accountNumber} AND StockCode = #{stockCode}")
    void updateStockHoldings(@Param("quantity") double quantity,
                             @Param("amount") double amount,
                             @Param("accountNumber") String accountNumber,
                             @Param("stockCode") String stockCode);

    // 존재하지 않는 경우 새로운 보유 주식 추가
    @Insert("INSERT INTO StockHoldings (AccountNumber, StockCode, Quantity, Principal, EntryDate) " +
            "VALUES (#{accountNumber}, #{stockCode}, #{quantity}, #{amount}, NOW())")
    void insertStockHoldings(@Param("accountNumber") String accountNumber,
                             @Param("stockCode") String stockCode,
                             @Param("quantity") double quantity,
                             @Param("amount") double amount);

    @Select("SELECT sp1.Code, " +
            "       sp1.LastPrice, " +
            "       sp1.BasePrice, " +
            "       sp1.Diff, " +
            "       sp1.Rate, " +
            "       sp1.Volume, " +
            "       sp1.TradeVolume, " +
            "       sp1.TradeAmount, " +
            "       sp1.Sign, " +
            "       sp1.UpdatedAt " +
            "FROM db.StockPrices sp1 " +
            "         INNER JOIN ( " +
            "    SELECT Code, DATE(UpdatedAt) AS TradeDate, MAX(UpdatedAt) AS LastUpdatedAt " +
            "    FROM db.StockPrices " +
            "    GROUP BY Code, DATE(UpdatedAt) " +
            ") sp2 ON sp1.Code = sp2.Code " +
            "    AND sp1.UpdatedAt = sp2.LastUpdatedAt " +
            "WHERE sp1.Code = #{code} " +
            "  AND DATE(sp1.UpdatedAt) >= DATE_SUB(CURDATE(), INTERVAL 5 DAY) " +
            "ORDER BY sp1.UpdatedAt ")
    List<StockPrice> getStockPriceByPeriod(@Param("code") String code);
}
