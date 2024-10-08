package com.kopo.hanagift.mapper;

import com.kopo.hanagift.dto.JoinedPreferences;
import com.kopo.hanagift.dto.WishList;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface WishListMapper {
    @Select("select * from WishList where userID = #{userId}")
    List<WishList> findUserWishList(@Param("userId") String userId);
}
