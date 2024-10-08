package com.kopo.hanagift.mapper;

import com.kopo.hanagift.dto.*;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ProductMapper {
    @Select("SELECT * FROM StockNCurrency")
    List<StockNCurrency> findAll();
    @Select("SELECT * FROM SavingsProducts")
    List<SavingProduct> findAllSavingProduct();

    @Select("SELECT * FROM SavingsProductDetails WHERE ProductID = #{productId}")
    SavingProductDetail findProductDetailsById(String productId);

    @Select("SELECT * FROM SavingsProducts WHERE ProductID = #{productId}")
    SavingProduct findSavingById(String productId);

    @Select("select * from StockNCurrency WHERE ProductID=#{productId}")
    StockNCurrency findStockNCurrency(String productId);

    @Select("select * from StockNCurrency WHERE ProductName=#{productName} ")
    StockNCurrency getProductByName(@Param("productName")String productName);

    @Insert("INSERT INTO WishList (productID, userID, productName, productCategory, productImgUrl, description) " +
            "VALUES (#{productID}, #{userID}, #{productName}, #{productCategory}, #{productImgUrl}, #{description})")
    void addWishlist(WishList wishList);
}
