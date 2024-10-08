package com.kopo.hanagift.mapper;

import com.kopo.hanagift.dto.*;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface UserMapper {
    @Select("SELECT * FROM Users WHERE phoneNumber = #{phoneNumber}")
    Users findByPhone(String phoneNumber);

    @Select("SELECT * FROM Users WHERE userId = #{userId}")
    Users findById(String userId);

    @Select("select * from UserPreferences where userID=#{userId}")
    UserPreferences findPreferenceById(@Param("userId") String userId);

    @Select("SELECT up.userID, up.countryId, up.giftType, up.stockCode, up.currencyCode " +
            "FROM Friends f " +
            "         JOIN UserPreferences up " +
            "              ON f.friendId = up.userId " +
            "WHERE f.userId = #{userId}")
    List<UserPreferences> findFriendPreference(@Param("userId") String userId);

    @Update("UPDATE UserPreferences " +
            "SET countryID = #{countryId}, giftType = #{giftType} " +
            "WHERE userID = #{userId}")
    int updateUserPreferences(@Param("userId") String userId,
                              @Param("countryId") int countryId,
                              @Param("giftType") String giftType);

    @Insert("INSERT INTO UserPreferences (userID, countryID, giftType) " +
            "VALUES (#{userId}, #{countryId}, #{giftType})")
    int insertUserPreferences(@Param("userId") String userId,
                              @Param("countryId") int countryId,
                              @Param("giftType") String giftType);

    @Select("SELECT up.userID, up.countryId, up.giftType, up.stockCode, up.currencyCode, s.ProductName AS countryName, s.LogoImageURL AS logoImgURL " +
            "FROM Users f " +
            "JOIN UserPreferences up ON f.UserID = up.userId " +
            "JOIN StockNCurrency s ON up.countryID = s.ProductID " +
            "WHERE f.userId = #{userId}")
    JoinedPreferences findJoinedPreferencesByUserId(@Param("userId") String userId);


    @Select("SELECT * FROM Users WHERE name = #{name} AND phoneNumber = #{phone}")
    Users findUserByNameAndPhone(@Param("name") String name, @Param("phone") String phone);

    @Select("select authority from authorities where userId=#{userId}")
    List<String> getAuthoritiesByUserId(@Param("userId") String userId);


    // 새로운 유저 추가 메서드
    @Insert("INSERT INTO Users (userId, password, phoneNumber, ssn, createdDate, name, email, statusMessage, profileUrl) " +
            "VALUES (#{userId}, #{password}, #{phoneNumber}, #{ssn}, now(), #{name}, #{email}, '하나 기프트 서비스 첫 가입!', #{profileUrl})")
    int insertUser(Users user);


    @Select("select o.productID, StockCode, ProductName, ExpectedStockQuantity, StockQuantity,LogoImageURL, o.CreatedAt from stockOrder o JOIN StockNCurrency s on s.ProductID = o.productID where ReceiverID=#{userId}")
    List<StockGift> getStockGiftList(@Param("userId") String userId);
}
