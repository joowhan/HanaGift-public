package com.kopo.hanagift.service;

import com.kopo.hanagift.dto.AdminReply;
import com.kopo.hanagift.dto.Post;
import com.kopo.hanagift.mapper.QnAMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import java.util.List;

@Service
public class QnAService {
    @Autowired
    private QnAMapper qnAMapper;

    public List<Post> findAllPost(){
        return qnAMapper.findAllPost();
    }
    // 전체 게시글 수를 반환하는 메서드
    public int countPosts() {
        return qnAMapper.countPosts();
    }
    public int countPostsByUser(String userId) {
        return qnAMapper.countPostsByUser(userId);
    }
    // 특정 페이지의 게시글을 반환하는 메서드
    public List<Post> findPostsByPage(int offset, int limit) {
        return qnAMapper.findPostsByPage(offset, limit);
    }
    public List<Post> findPostsByUser(String userId, int offset, int limit) {
        return qnAMapper.findPostsByUser(userId, offset, limit);
    }

    public Post findPostById(int postId) {
        return qnAMapper.findPostById(postId);
    }

    public AdminReply findAdminReplyByPostId(int postId) {
        return qnAMapper.findAdminReplyByPostId(postId);
    }

    public void writePost(Post post, String userId) throws Exception {
        if (post.getTitle() == null || post.getContent() == null) {
            throw new Exception("제목과 내용은 필수 입력 사항입니다.");
        }
        post.setUserId(userId);
        qnAMapper.insertPost(post);
    }
    // 게시글 삭제 로직
    public void deletePost(int postId) throws Exception {
        qnAMapper.deletePost(postId);
    }

    //답변 저장
    public boolean saveReplyAndUpdatePost(int postId, String replyContent) {
        // INSERT INTO AdminReplies
        if(qnAMapper.findAdminReplyByPostId(postId) != null){
            //update
            qnAMapper.updateAdminReply(replyContent,postId);
        }
        else{
            // INSERT INTO AdminReplies
            int rowsInserted = qnAMapper.saveReply(replyContent, postId);
            // INSERT 실패 (영향받은 행이 0일 경우)
            if (rowsInserted == 0) {
                // 트랜잭션 롤백
                TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                return false;
            }
        }


        // UPDATE Post
        int rowsUpdated = qnAMapper.updatePostStatus(postId);

        // UPDATE 실패 (영향받은 행이 0일 경우)
        if (rowsUpdated == 0) {
            // 트랜잭션 롤백
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return false;
        }

        // 둘 다 성공한 경우 true 반환
        return true;
    }
}
