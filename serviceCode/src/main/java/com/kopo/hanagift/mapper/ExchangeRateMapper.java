package com.kopo.hanagift.mapper;

import com.kopo.hanagift.dto.ExchangeRate;
import com.kopo.hanagift.dto.StockNCurrency;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ExchangeRateMapper {
    @Select("SELECT * FROM exchangeRate WHERE currencyCode = #{code} ORDER BY insertedDate DESC LIMIT 2")
    List<ExchangeRate> findLatestTwoExchangeRates(String code);
    @Select("select * from exchangeRate where currencyCode =#{code} ORDER BY insertedDate DESC LIMIT 1")
    ExchangeRate findLatestExchangeRate(String code);

    @Select("SELECT * FROM (" +
            "  SELECT * " +
            "  FROM ExchangeRatePeriod " +
            "  WHERE currencyCode=#{code} " +
            "  ORDER BY exchangeDate DESC " +
            "  LIMIT 5" +
            ") AS recentRates " +
            "ORDER BY exchangeDate ASC")
    List<ExchangeRate> findExchangeRatePeriod(@Param("code") String code);
}