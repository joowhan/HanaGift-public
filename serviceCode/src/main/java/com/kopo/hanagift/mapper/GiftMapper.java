package com.kopo.hanagift.mapper;

import com.kopo.hanagift.dto.Gift;
import com.kopo.hanagift.dto.JoinedGift;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface GiftMapper {

    @Insert("INSERT INTO Gifts (GiftID, ProductID, SenderID, Date, Status, productCategory, ReceiverID, Amount, CurrencyUnit) " +
            "VALUES (#{giftID}, #{productID}, #{senderID}, now(), #{status}, #{productCategory}, #{receiverID}, #{amount}, #{currencyUnit})")
    void insertGift(Gift gift);

    @Select("""
            SELECT
                g.GiftID,
                g.ProductID,
                g.SenderID,
                g.Date,
                g.Status,
                g.productCategory,
                g.ReceiverID,
                g.Amount,
                g.CurrencyUnit,
                CASE
                    WHEN g.productCategory = '적립식예금' THEN sp.productName
                    WHEN g.productCategory = 'ForeignCurrency' THEN s.productName
                    WHEN g.productCategory = 'Stock' THEN s.productName
                    ELSE 'Unknown Product'
                END AS productName,
                sender.name AS senderName,
                receiver.name AS receiverName
            FROM Gifts g
                     LEFT JOIN Users receiver ON g.ReceiverID = receiver.userId
                     LEFT JOIN StockNCurrency s ON g.ProductID = s.ProductID AND g.productCategory IN ('Stock', 'ForeignCurrency')
                     LEFT JOIN SavingsProducts sp ON g.ProductID = sp.ProductID AND g.productCategory = '적립식예금'
                     LEFT JOIN Users sender ON g.SenderID = sender.userId
            WHERE g.ReceiverID = #{userId}
            ORDER BY g.Date desc
            """)
    List<JoinedGift> getReceivedGifts(@Param("userId") String userId);

    @Select("""
            SELECT
                g.GiftID,
                g.ProductID,
                g.SenderID,
                g.Date,
                g.Status,
                g.productCategory,
                g.ReceiverID,
                g.Amount,
                g.CurrencyUnit,
                CASE
                    WHEN g.productCategory = '적립식예금' THEN sp.productName
                    WHEN g.productCategory = 'ForeignCurrency' THEN s.productName
                    WHEN g.productCategory = 'Stock' THEN s.productName
                    ELSE 'Unknown Product'
                END AS productName,
                sender.name AS senderName,
                receiver.name AS receiverName
            FROM Gifts g
                     LEFT JOIN Users receiver ON g.ReceiverID = receiver.userId
                     LEFT JOIN StockNCurrency s ON g.ProductID = s.ProductID AND g.productCategory IN ('Stock', 'ForeignCurrency')
                     LEFT JOIN SavingsProducts sp ON g.ProductID = sp.ProductID AND g.productCategory = '적립식예금'
                     LEFT JOIN Users sender ON g.SenderID = sender.userId
            WHERE g.SenderID = #{userId}
            ORDER BY g.Date desc 
            """)
    List<JoinedGift> getSentGifts(@Param("userId") String userId);

    // 선물의 상태를 'RECEIVED'로 업데이트
    @Update("UPDATE Gifts " +
            "SET status = 'RECEIVED' " +
            "WHERE giftID = #{giftID} AND receiverID = #{receiverID}")
    void updateGiftStatusToReceived(@Param("giftID") String giftID, @Param("receiverID") String receiverID);

}
