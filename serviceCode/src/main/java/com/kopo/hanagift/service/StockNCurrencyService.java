package com.kopo.hanagift.service;

import com.kopo.hanagift.dto.StockNCurrency;
import com.kopo.hanagift.mapper.StockNCurrencyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StockNCurrencyService {
    @Autowired
    private StockNCurrencyMapper stockNCurrencyMapper;

    public String getStockCode(String productId){
        return stockNCurrencyMapper.productCode(productId);
    }

    public List<StockNCurrency> findCurrencyAll(){
        return stockNCurrencyMapper.findCurrencyAll();
    }

    public StockNCurrency findStockNCurrencyByCode(String code){
        return stockNCurrencyMapper.findStockNCurrencyByCode(code);
    }
}
