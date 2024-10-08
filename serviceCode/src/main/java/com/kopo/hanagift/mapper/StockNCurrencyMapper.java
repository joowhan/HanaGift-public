package com.kopo.hanagift.mapper;

import com.kopo.hanagift.dto.StockNCurrency;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface StockNCurrencyMapper {

    @Select("select Code from StockNCurrency where ProductID=#{productId}")
    String productCode(@Param("productId") String productId);

    @Select("select * from StockNCurrency where Category = 'Foreign Currency'")
    List<StockNCurrency> findCurrencyAll();

    @Select("select * from StockNCurrency where Code =#{code}")
    StockNCurrency findStockNCurrencyByCode(@Param("code") String code);

    @Select("SELECT Code FROM StockNCurrency WHERE Category = 'Stocks'")
    List<String> findStockCodes();


}
