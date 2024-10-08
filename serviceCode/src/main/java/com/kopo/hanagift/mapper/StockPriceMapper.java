package com.kopo.hanagift.mapper;

import com.kopo.hanagift.dto.StockPrice;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface StockPriceMapper {

    // 주식 가격 정보 저장
    @Insert("INSERT INTO StockPrices (Code, BasePrice, LastPrice, Diff, Rate, Volume, TradeVolume, TradeAmount, Sign, UpdatedAt) " +
            "VALUES (#{stockPrice.code}, #{stockPrice.basePrice}, #{stockPrice.lastPrice}, #{stockPrice.diff}, #{stockPrice.rate}, " +
            "#{stockPrice.volume}, #{stockPrice.tradeVolume}, #{stockPrice.tradeAmount}, #{stockPrice.sign}, now())")
    void saveStockPrice(@Param("stockPrice") StockPrice stockPrice);
    @Select("select LastPrice from StockPrices WHERE Code =#{code} ORDER BY UpdatedAt DESC LIMIT 1")
    double findStockPrice(@Param("code") String code);
}
