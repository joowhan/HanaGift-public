package com.kopo.hanagift.service;

import com.kopo.hanagift.dto.Friend;
import com.kopo.hanagift.dto.FriendList;
import com.kopo.hanagift.dto.Users;
import com.kopo.hanagift.mapper.FriendMapper;
import com.kopo.hanagift.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
public class FriendService {

    @Autowired
    private FriendMapper friendMapper;
    @Autowired
    private UserMapper userMapper;

    public List<Friend> findAllFriendsById(String userId){
        return friendMapper.findFriends(userId);
    }


    public List<FriendList> findFriendList(String userId){
        return friendMapper.findFriendList(userId);
    }

    public boolean deleteFriendById(String userId, String friendId){
        int rows = friendMapper.deleteFriendById(userId, friendId);
        return rows>0;
    }

    public boolean addFriend(String userId, String name, String phone) {
        // 사용자 조회
        Users user = userMapper.findUserByNameAndPhone(name, phone);

        if (user != null) {
            // 친구 추가
            Friend friend = new Friend();
            friend.setUserId(userId);
            friend.setFriendId(user.getUserId());
            friend.setFriendName(user.getName());
            friend.setPhoneNumber(user.getPhoneNumber());
            friend.setStatus("standby");

            friendMapper.insertFriend(friend);
            return true;
        }

        // 사용자 존재하지 않음
        return false;
    }

    public List<Friend> getFriendRequests(String userId) {
        return friendMapper.findFriendsByStatus(userId, "standby");
    }

    @Transactional
    public boolean approveFriendRequest(String userId, String friendId) {

        // 요청이 존재하고 상태가 'approved'가 아닐 경우 처리
        int rows = friendMapper.friendAprroved(userId, friendId,"approved");  // 상태를 'approved'로 변경
        return rows>0;  // 실패시 false 반환
    }
}
