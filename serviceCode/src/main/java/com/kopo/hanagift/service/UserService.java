package com.kopo.hanagift.service;

import com.kopo.hanagift.dto.*;
import com.kopo.hanagift.mapper.UserMapper;
import com.kopo.hanagift.utils.BirthDateExtractor;
import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.core.userdetails.UserDetails;
//import org.springframework.security.core.userdetails.UserDetailsService;
//import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

//import org.springframework.security.core.GrantedAuthority;
//import org.springframework.security.core.authority.SimpleGrantedAuthority;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    public Users findUserByPhone(String phoneNumber) {
        return userMapper.findByPhone(phoneNumber);
    }

    public Users findUserById(String userId) {
        Users user = userMapper.findById(userId);
        user.setBirthDate(BirthDateExtractor.extractBirthDateFromSSN(user.getSsn()));
        return user;
    }

    public UserPreferences findUserPreference(String userId){
        return userMapper.findPreferenceById(userId);
    }
    public List<UserPreferences> findFriendPreferences(String userId){
        return userMapper.findFriendPreference(userId);
    }

    public boolean updateUserPreferences(String userId, UserPreferences userPreferences){
        System.out.println(userId+userPreferences.getCountryId()+ userPreferences.getGiftType());
        int affectedRows = userMapper.updateUserPreferences(userId, userPreferences.getCountryId(), userPreferences.getGiftType());
        return affectedRows > 0;
    }

    public boolean insertUserPreferences(String userId, UserPreferences userPreferences){
        int affectedRows = userMapper.insertUserPreferences(userId,
                userPreferences.getCountryId(),
                userPreferences.getGiftType());
        return affectedRows > 0;
    }

    public JoinedPreferences findFriendJoinedPreferences(String userId){
        return userMapper.findJoinedPreferencesByUserId(userId);
    }

    //권한 조회
    public List<String> findAuthorities(String userId){
        return userMapper.getAuthoritiesByUserId(userId);
    }

//    public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
//        // MyBatis를 통해 사용자 정보 조회
//        Users user = userMapper.findById(userId);
//        if (user == null) {
//            throw new UsernameNotFoundException("사용자를 찾을 수 없습니다.");
//        }
//
//        // 권한 조회
//        List<String> authorities = userMapper.getAuthoritiesByUserId(userId);
//
//        // GrantedAuthority로 변환
//        List<GrantedAuthority> grantedAuthorities = authorities.stream()
//                .map(SimpleGrantedAuthority::new)
//                .collect(Collectors.toList());
//
//        // UserDetails 반환
//        return new org.springframework.security.core.userdetails.User(
//                user.getUserId(),
//                user.getPassword(),
//                grantedAuthorities
//        );
//    }

    public boolean signup(Users user){

        if(userMapper.findById(user.getUserId()) != null){
            return false;
        }
        int rows = userMapper.insertUser(user);
        return rows > 0;
    }

    public List<StockGift> getStockGiftList(String userId){
        return userMapper.getStockGiftList(userId);
    }

}
