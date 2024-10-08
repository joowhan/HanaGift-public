package com.kopo.hanagift.service;

import com.kopo.hanagift.dto.*;
import com.kopo.hanagift.mapper.ProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ProductService {

    @Autowired
    private ProductMapper productMapper;

    public List<StockNCurrency> getAllProducts() {
        return productMapper.findAll();
    }
    public List<SavingProduct> getAllSavingProduct(){
        return productMapper.findAllSavingProduct();
    }
    public SavingProductDetail getProductDetailsById(String productId) {
        return productMapper.findProductDetailsById(productId);
    }
    public SavingProduct getSavingById(String productId){
        return productMapper.findSavingById(productId);
    }


    public StockNCurrency getStockNCurrency(String productId){
        return productMapper.findStockNCurrency(productId);
    }

    public StockNCurrency getProductByName(String name){
        return productMapper.getProductByName(name);
    }

    public void addWishlist(StockNCurrency stockNCurrency, String userId){
        WishList wishList = new WishList();
        wishList.setProductID(String.valueOf(stockNCurrency.getProductID()));
        wishList.setUserID(userId);
        wishList.setProductName(stockNCurrency.getProductName());
        String category = stockNCurrency.getCategory();
        if(category.equals("Stocks")){
            category = "stock";
        }
        else if(category.equals("Foreign Currency")){
            category="currency";
        }
        wishList.setProductCategory(category);
        wishList.setProductImgUrl(stockNCurrency.getLogoImageURL());
        productMapper.addWishlist(wishList);
    }

}
