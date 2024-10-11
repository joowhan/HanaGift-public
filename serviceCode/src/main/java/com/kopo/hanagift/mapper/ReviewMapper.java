package com.kopo.hanagift.mapper;

import com.kopo.hanagift.dto.Reviews;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ReviewMapper {

    @Select("select ReviewID,Reviews.UserID,Reviews.ProductID,WrittenDate,Stars, ReviewText, Users.profileUrl from Reviews join Users on Users.UserID= Reviews.UserID " +
            "where ProductID= #{productId} " )
    List<Reviews> findAllReviewById(String productId);

    @Insert("INSERT INTO Reviews (ReviewID, UserID, ProductID, WrittenDate, ReviewText, Stars) " +
            "VALUES (#{reviewID}, #{userID}, #{productID}, now(), #{reviewText}, #{stars})")
    void insertReview(Reviews review);

}
