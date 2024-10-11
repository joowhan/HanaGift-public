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

    // 나에게 요청을 보낸 친구
    @Select("select Friends.UserID friendId, Users.Name FriendName, Users.PhoneNumber phoneNumber from Friends join Users on Users.UserID=Friends.UserID " +
            "WHERE FriendID = #{userId} AND status = #{status}")
    List<Friend> findFriendsByStatus(@Param("userId") String userId, @Param("status") String status);

    @Update("UPDATE Friends set status = #{status} where UserID = #{friendId} and FriendID =#{userId}")
    int friendAprroved(@Param("userId") String userId, @Param("friendId") String friendId, @Param("status") String status);

    @Select("SELECT * FROM Friends WHERE UserID = #{friendId} and FriendID =#{userId}")
    Friend findFriend(@Param("userId") String userId, @Param("friendId") String friendId);

    @Select("select count(*) from Friends where Status='standby' and FriendID=#{userId}")
    int countRequestFriends(String userId);
    @Insert("INSERT INTO Friends ( UserID, FriendID, friendName, Date, Status, PhoneNumber) " +
            "VALUES ( #{userId}, #{friendId}, #{friendName}, now(), 'approved', #{phoneNumber})")
    void insertApprovedFriend(@Param("userId")String userId, @Param("friendId") String friendId,
                              @Param("friendName") String friendName, @Param("phoneNumber") String phoneNumber);
}
