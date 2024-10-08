package com.kopo.hanagift.mapper;

import com.kopo.hanagift.dto.Gift;
import com.kopo.hanagift.dto.StockOrder;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface StockOrderMapper {
    // 주식 주문 저장
    @Insert("INSERT INTO stockOrder (productID, StockCode, Amount, CurrencyUnit, ReceiverID, Status, CreatedAt, ExpectedStockQuantity) " +
            "VALUES ( #{gift.productID}, #{code}, #{gift.amount}, #{gift.currencyUnit}, #{userId}, 'PENDING', now(), 0)")
    void saveStockOrder(@Param("gift")  Gift gift, @Param("code") String code, @Param("userId") String userId);

    // PENDING 상태의 주문 목록 조회
    @Select("SELECT * FROM stockOrder WHERE Status = 'PENDING'")
    List<StockOrder> findPendingOrders();

    @Select("select * from stockOrder where Status='EXECUTED'")
    List<StockOrder> findExecutedOrders();

    // 주문 상태를 'EXECUTED'로 업데이트
    @Update("UPDATE stockOrder SET Status = 'EXECUTED' WHERE OrderID = #{OrderID}")
    void updateOrderStatusToExecuted(Long OrderID);

    //주문 상태를 'CONCLUSION'로 업데이트
    @Update("UPDATE stockOrder SET Status = 'CONCLUSION' WHERE OrderID = #{OrderID}")
    void updateOrderStatusToConclusion(Long orderID);


    // 주문 실행 내역 저장
    @Insert("INSERT INTO stockOrderExecution (OrderID) VALUES (#{OrderID})")
    void saveOrderExecution(Long OrderID);

    @Update("UPDATE stockOrder SET stockOrder.ExpectedStockQuantity = #{expectedStockQuantity} WHERE OrderID =#{orderId}")
    void updateExpectedStockQuantity(@Param("expectedStockQuantity") double expectedStockQuantity, @Param("orderId") Long orderId);


    @Update("UPDATE stockOrder SET stockOrder.StockQuantity = #{stockQuantity} WHERE OrderID = #{orderId} ")
    void updateStockQuantity(@Param("stockQuantity") double stockQuantity, @Param("orderId") Long orderId);

}
