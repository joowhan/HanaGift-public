package com.kopo.hanagift.service;

import com.kopo.hanagift.dto.JoinedPreferences;
import com.kopo.hanagift.dto.WishList;
import com.kopo.hanagift.mapper.WishListMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WishListService {

    @Autowired
    private WishListMapper wishListMapper;

    public List<WishList> findUserWishList(String userId){
        return wishListMapper.findUserWishList(userId);
    }

}
