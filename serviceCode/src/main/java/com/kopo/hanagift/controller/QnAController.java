package com.kopo.hanagift.controller;

import com.kopo.hanagift.dto.AdminReply;
import com.kopo.hanagift.dto.Post;
import com.kopo.hanagift.service.QnAService;
import com.kopo.hanagift.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class QnAController {
    @Autowired
    private QnAService qnAService;
    @Autowired
    private UserService userService;

    @GetMapping("/aiqna")
    public String charge(
            Model model,
            HttpSession session,
            @RequestParam(value = "myPosts", defaultValue = "false") boolean myPosts,
            @RequestParam(value = "page", defaultValue = "1") int page){

        int postsPerPage = 20; // 페이지당 게시글 수
        session.setAttribute("userId", "joy9876");
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/loginPage";  // loginPage는 JSP 파일의 URL
        }
        // myPosts가 true이고 로그인이 되어 있지 않으면 myPosts를 false로 설정
        if (myPosts && userId == null) {
            myPosts = false;
        }

        int totalPosts;
        if (myPosts) {
            // 사용자가 작성한 게시글 수 가져오기
            totalPosts = qnAService.countPostsByUser(userId);
        } else {
            // 전체 게시글 수 가져오기
            totalPosts = qnAService.countPosts();
        }

        // 전체 페이지 수를 계산합니다.
        int totalPages = (int) Math.ceil((double) totalPosts / postsPerPage);

        // 현재 페이지가 유효한 범위 내에 있는지 확인합니다.
        if (page < 1) {
            page = 1;
        } else if (page > totalPages) {
            page = totalPages;
        }

        // 오프셋 계산
        int offset = (page - 1) * postsPerPage;

        List<Post> posts;
        if (myPosts) {
            // 사용자가 작성한 게시글 가져오기
            posts = qnAService.findPostsByUser(userId, offset, postsPerPage);
        } else {
            // 전체 게시글 가져오기
            posts = qnAService.findPostsByPage(offset, postsPerPage);
        }
        // 게시글 번호를 계산합니다.
        int startNumber = totalPosts - offset;
        for (Post post : posts) {
            post.setNumber(startNumber--);
        }

        model.addAttribute("activeMenu", "aiqna");
        model.addAttribute("posts", posts);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("myPosts", myPosts);
        return "aiQna";
    }
    @GetMapping("/postDetail")
    public String postDetail(
            Model model,
            @RequestParam(value = "postId") int postId,
            HttpSession session){
        // 게시글 정보를 가져옵니다.
        Post post = qnAService.findPostById(postId);
        //추후 제거 관리자 임의 지정
//        session.setAttribute("userId", "joy9876");

        // 관리자의 답변을 가져옵니다.
        AdminReply adminReply = qnAService.findAdminReplyByPostId(postId);

        // 현재 로그인한 사용자 ID를 세션에서 가져옴
        String loggedInUserId = (String) session.getAttribute("userId");
        // 로그인한 사용자와 글쓴이가 같은지 비교
        boolean canDelete = loggedInUserId != null && loggedInUserId.equals(post.getUserId());
        //권한 확인
        List<String> authorities = userService.findAuthorities(loggedInUserId);
        if(adminReply != null)
            adminReply.setReplyContent(adminReply.getReplyContent().trim());

        model.addAttribute("post", post);
        model.addAttribute("adminReply", adminReply);
        model.addAttribute("canDelete", canDelete); // 삭제 가능 여부를 뷰로 전달
        model.addAttribute("authorities", authorities);
        return "aiQna-detail";
    }
    @PostMapping("/writePost")
    public ResponseEntity<Map<String, Boolean>> writePost(
            @RequestBody Post post,
            HttpSession session) {
        Map<String, Boolean> response = new HashMap<>();
        String userId = (String) session.getAttribute("userId");
        System.out.println("writePost" + post.getContent() + post.getTitle());
        if (userId == null) {
            System.out.println("writePost: User is not logged in.");
            response.put("success", false);
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
        }
        try {
            // 서비스 계층에 게시글 작성 로직 위임
            qnAService.writePost(post, userId);
            // 성공 시, "success": true 반환
            response.put("success", true);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            // 예외 발생 시 예외 메시지와 스택 트레이스 출력 (서버 로그에서 확인)
            System.err.println("Error in writePost: " + e.getMessage());
            e.printStackTrace();  // 스택 트레이스 출력
            // 실패 시, "success": false 반환
            response.put("success", false);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @PostMapping("/posts/delete")
    public ResponseEntity<Map<String, Boolean>> deletePost(
            @RequestBody Map<String, Integer> request,
            HttpSession session) {
        int postId = request.get("postId");
        Map<String, Boolean> response = new HashMap<>();

        // 현재 로그인한 사용자 ID
        String loggedInUserId = (String) session.getAttribute("userId");

        try {
            // 삭제하려는 게시글 정보 가져오기
            Post post = qnAService.findPostById(postId);

            // 로그인한 사용자와 글 작성자 비교
            if (loggedInUserId == null || !loggedInUserId.equals(post.getUserId())) {
                // 삭제 권한이 없는 경우
                response.put("success", false);
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
            }

            // 게시글 삭제 로직 실행
            qnAService.deletePost(postId);

            // 삭제 성공
            response.put("success", true);
            return ResponseEntity.ok(response);

        } catch (Exception e) {
            // 예외 처리: 삭제 실패 시
            response.put("success", false);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    @PostMapping("/submitReply")
    public ResponseEntity<Map<String, Boolean>> submitReply(@RequestBody AdminReply adminReply) {
        Map<String, Boolean> response = new HashMap<>();
        try {
            // postId와 replyContent로 처리 로직 구현
            int postId = adminReply.getPostId();
            String replyContent = adminReply.getReplyContent();
            System.out.println(postId + " " +replyContent);

             qnAService.saveReplyAndUpdatePost(postId, replyContent);

            // 성공 시 응답 설정
            // 성공 시 응답 설정
            response.put("success", true);
            return ResponseEntity.ok(response); // 200 OK와 함께 성공 여부 전송
        } catch (Exception e) {
            // 실패 시 응답 설정
            response.put("success", false);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response); // 500 오류와 함께 실패 여부 전송
        }
    }
}
