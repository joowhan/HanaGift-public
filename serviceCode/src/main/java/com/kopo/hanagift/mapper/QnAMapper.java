package com.kopo.hanagift.mapper;

import com.kopo.hanagift.dto.AdminReply;
import com.kopo.hanagift.dto.Post;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface QnAMapper {
    @Select("SELECT * FROM Post ORDER BY Date desc")
    List<Post> findAllPost();
    // 전체 게시글 수를 세는 메서드
    @Select("SELECT COUNT(*) FROM Post")
    int countPosts();

    @Select("SELECT COUNT(*) FROM Post WHERE userId = #{userId}")
    int countPostsByUser(@Param("userId") String userId);
    // 페이지별로 게시글을 가져오는 메서드
    // 페이지별로 게시글을 가져오는 메서드 (JOIN 추가)
    @Select("SELECT p.postId, p.userId, u.profileUrl, p.title, p.content, p.date, p.responseStatus " +
            "FROM Post p " +
            "JOIN Users u ON p.userId = u.userId " +
            "ORDER BY p.date DESC " +
            "LIMIT #{limit} OFFSET #{offset}")
    List<Post> findPostsByPage(@Param("offset") int offset, @Param("limit") int limit);

    @Select("SELECT p.postId, p.userId, u.profileUrl, p.title, p.content, p.date, p.responseStatus " +
            "FROM Post p " +
            "JOIN Users u ON p.userId = u.userId " +
            "WHERE p.userId = #{userId} " +
            "ORDER BY p.date DESC " +
            "LIMIT #{limit} OFFSET #{offset}")
    List<Post> findPostsByUser(@Param("userId") String userId, @Param("offset") int offset, @Param("limit") int limit);

    @Select("SELECT p.postId, p.userId, u.profileUrl, p.title, p.content, p.date, p.responseStatus " +
            "FROM Post p " +
            "JOIN Users u ON p.userId = u.userId " +
            "WHERE p.postId = #{postId}")
    Post findPostById(@Param("postId") int postId);

    @Select("SELECT * FROM AdminReplies WHERE postId = #{postId}")
    AdminReply findAdminReplyByPostId(@Param("postId") int postId);

    @Insert("INSERT INTO Post (userId, title, content, date, number) " +
            "VALUES (#{userId}, #{title}, #{content}, NOW(), 0)")
    void insertPost(Post post);
    @Delete("DELETE FROM Post WHERE postId = #{postId}")
    void deletePost(int postId);

    @Insert("INSERT INTO AdminReplies(postId, adminId, replyContent, replyDate) " +
            "VALUES (#{postId},'adminhanagift', #{replyContent}, now())")
    int saveReply(@Param("replyContent") String replyContent,@Param("postId") int postId);

    @Update("UPDATE Post SET responseStatus = '답변 완료' WHERE postId = #{postId}")
    int updatePostStatus(@Param("postId") int postId);
    @Update("UPDATE AdminReplies set replyContent = #{replyContent} where postId=#{postId}")
    int updateAdminReply(@Param("replyContent") String replyContent,@Param("postId") int postId);
    @Select("SELECT * FROM Post WHERE responseStatus = #{responseStatus}")
    List<Post> findPostsByResponseStatus(@Param("responseStatus") String responseStatus);

}
