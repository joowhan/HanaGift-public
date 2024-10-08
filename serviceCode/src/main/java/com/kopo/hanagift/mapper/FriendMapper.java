package com.kopo.hanagift.mapper;

import com.kopo.hanagift.dto.Friend;
import com.kopo.hanagift.dto.FriendList;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface FriendMapper {
    @Select("select UserID, FriendID, friendName, Status, PhoneNumber " +
            "from  Friends " +
            "where Status='Approved' AND UserID=#{userId}")
    List<Friend> findFriends(String userId);

    @Select("SELECT " +
            "    f.userId AS userId, " +
            "    f.friendId AS friendId, " +
            "    u.name AS friendName, " +
            "    u.statusMessage AS friendStatusMessage, " +
            "    u.phoneNumber AS friendPhoneNumber, " +
            "    u.profileUrl AS friendProfileUrl " +
            "FROM " +
            "    Friends f " +
            "        JOIN " +
            "    Users u " +
            "    ON " +
            "        f.friendId = u.userId " +
            "WHERE " +
            "    f.userId = #{userId} ")
    List<FriendList> findFriendList(@Param("userId") String userId);

    @Delete("DELETE FROM Friends WHERE friendId = #{friendId} AND userId = #{userId}")
    int deleteFriendById(@Param("userId") String userId, @Param("friendId") String friendId);

    // 친구 추가
    @Insert("INSERT INTO Friends ( UserID, FriendID, friendName, Date, Status, PhoneNumber) " +
            "VALUES ( #{userId}, #{friendId}, #{friendName}, now(), 'standby', #{phoneNumber})")
    void insertFriend(Friend friend);

    @Select("SELECT friendId, friendName, phoneNumber " +
            "FROM Friends " +
            "WHERE userId = #{userId} AND status = #{status}")
    List<Friend> findFriendsByStatus(@Param("userId") String userId, @Param("status") String status);
    @Update("UPDATE Friends set status = #{status} where UserID = #{userId} and FriendID =#{friendId}")
    int friendAprroved(@Param("userId") String userId, @Param("friendId") String friendId, @Param("status") String status);
}
