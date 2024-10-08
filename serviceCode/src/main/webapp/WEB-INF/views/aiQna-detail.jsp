<%--
  Created by IntelliJ IDEA.
  User: gimjuhwan
  Date: 9/14/24
  Time: 1:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>AI Q&A</title>
    <jsp:include page="component/head.jsp" flush="false"/>
    <style>
        .title-header {
            display: flex;
            align-items: center; /* 이미지와 텍스트를 수직으로 중앙 정렬 */
        }

        .text-container {
            margin-left: 15px; /* 이미지와 텍스트 사이의 간격 설정 */
        }

        .title-header h3.mtext-111 {
            font-family: "HanaFont-CM"; /* 제목 폰트 적용 */
            margin-bottom: 0; /* 텍스트 간의 간격을 조정 */
        }

        .title-header p.stext-113 {
            font-family: "HanaFont-CM"; /* 설명글 폰트 적용 */
            margin-top: 5px; /* 제목과 설명 글 사이의 간격 설정 */
            margin-bottom: 0; /* 텍스트 간의 간격을 조정 */
        }

        .gift-icon {
            width: 60px; /* 이미지 크기 조정 */
            height: auto;
        }
        .reply-content {
            white-space: pre-wrap; /* 줄바꿈과 공백을 유지 */
        }
    </style>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/qna.css"/>
</head>
<body>
<!-- Header -->
<jsp:include page="component/header.jsp" flush="false"/>
<!-- Friend tap -->
<jsp:include page="component/friend_tap.jsp" flush="false"/>
<section class="bg0 p-t-75 p-b-120">
    <div class="container">
        <div class="row mt-4 mb-4">
            <div class="col-md-8">
                <div class="title-header">
                    <img
                            src="${pageContext.request.contextPath}/resources/images/1490514_list.png"
                            alt="선물 아이콘"
                            class="gift-icon"
                    />
                    <div class="text-container">
                        <h3 class="mtext-111 cl14 mb-3">AI Q&A</h3>
                        <p class="stext-113 cl6">
                            Llama3 AI에게 무엇이든 물어보세요!
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <div class="user-post">
                    <!-- 글 상단: 제목과 날짜 -->
                    <div class="post-header">
                        <h3 class="post-title">${post.title}</h3>
                        <div class="post-header-right">
                            <span class="post-date">${post.date}</span>
                            <c:if test="${canDelete}">
                                <button class="delete-btn" onclick="deletePost(${post.postId})">삭제</button>
                            </c:if>
                        </div>
                    </div>

                    <!-- 작성자 정보 -->
                    <div class="post-meta">
                        <div class="post-header-left">
                            <!-- 사용자 프로필 이미지 -->
                            <img src="${post.profileUrl}" alt="작성자 프로필" class="user-profile">
                            <span class="author-name">${post.userId}</span>
                        </div>
                    </div>

                    <!-- 구분선 -->
                    <hr class="post-divider">

                    <!-- 글 본문: 내용 -->
                    <div class="post-content">
                        <p id="post-content-text">${post.content}</p>
                    </div>
                </div>
            </div>
        </div>


        <!-- 관리자 답변 또는 답변 대기 중 메시지 -->
        <div class="row mt-5">
            <div class="col-12">
                <c:choose>

                    <c:when test="${post.responseStatus ne '대기 중'}">
                        <div class="admin-reply">
                            <div class="reply-header">
                                <div class="reply-header-left">
                                    <img src="${pageContext.request.contextPath}/resources/images/hanagift_profile.png"
                                         alt="프로필 이미지" class="admin-profile">
                                    <span class="admin-name">AI & 관리자</span>
                                </div>
                                <span class="reply-date">${adminReply.replyDate}</span>
                            </div>
                            <hr class="reply-divider">
                            <div class="reply-bubble">
                                <p class="reply-content">${adminReply.replyContent}</p>
                            </div>
                        </div>
                    </c:when>


                    <c:otherwise>
                        <c:choose>

                            <c:when test="${!fn:contains(authorities, 'ROLE_ADMIN')}">
                                <div class="no-reply text-center">
                                    <p>아직 답변이 없어요!</p>
                                    <div class="no-reply-images">
                                        <img src="${pageContext.request.contextPath}/resources/images/ollama2.png" alt="Meta 로고">
                                        <img src="${pageContext.request.contextPath}/resources/images/close.png" alt="X 표시" class="x-image">
                                        <img src="${pageContext.request.contextPath}/resources/images/hanagift.png" alt="하나기프트 로고">
                                    </div>
                                    <div class="wait-message">
                                        하나Gift AI와 관리자가 최고의 답변을 작성하고 있습니다. 조금 더 기다려주세요!
                                    </div>
                                </div>
                            </c:when>


                            <c:when test="${fn:contains(authorities, 'ROLE_ADMIN')}">
                                <div class="admin-reply-form">
                                    <!-- 답변 입력 폼을 말풍선 형태로 구성 -->
                                    <div class="reply-bubble">
                                        <form id="admin-reply-form" action="${pageContext.request.contextPath}/submitReply" method="POST">
                                            <textarea id="admin-reply-content" name="replyContent"
                                                      class="form-control admin-input" rows="5" placeholder="손님이 관리자님의 답변을 기다리고 있어요!">
                                                <c:if test="${not empty adminReply}">
                                                    <c:if test="${not empty adminReply.replyContent}">
                                                        <c:out value="${fn:trim(adminReply.replyContent)}" />
                                                    </c:if>
                                                </c:if>
                                            </textarea>
                                            <!-- 버튼들: 말풍선 안의 textarea 아래에 위치 -->
                                            <div class="action-buttons">
                                                <button type="button" id="request-ai-answer" class="btn ai-button">
                                                    <img src="${pageContext.request.contextPath}/resources/images/ollama2.png" alt="AI Icon" class="ai-icon" />
                                                    AI의 답변 받기
                                                </button>
                                                <button type="submit" id="submit-reply" class="btn submit-button">답변 전송</button>
                                            </div>
                                            <input type="hidden" name="postId" value="${post.postId}"/>
                                        </form>
                                    </div>
                                </div>
                            </c:when>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </div>
</section>


<%--footer--%>
<jsp:include page="component/footer.jsp" flush="false"/>

</body>
<script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/popper.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/select2/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/sweetalert/sweetalert.min.js"></script>
<script>
    $(".js-select2").each(function () {
        $(this).select2({
            minimumResultsForSearch: 20,
            dropdownParent: $(this).next(".dropDownSelect2"),
        });
    });
</script>
<script>
    $(document).ready(function() {
        // '답변 전송' 버튼 클릭 시 폼 제출을 처리
        $('#admin-reply-form').on('submit', function(e) {
            e.preventDefault(); // 기본 폼 제출 동작을 막음

            // JSON 형태로 데이터를 구성
            var postData = {
                postId: $('input[name="postId"]').val(),
                replyContent: $('#admin-reply-content').val()
            };

            // AJAX로 JSON 데이터를 전송
            $.ajax({
                type: "POST",
                url: $(this).attr('action'),
                contentType: "application/json", // JSON으로 전송
                data: JSON.stringify(postData), // 데이터를 JSON 문자열로 변환
                success: function(response) {
                    // SweetAlert 알림: 성공적으로 전송 후 페이지 새로고침
                    swal({
                        title: '성공',
                        text: '답변이 성공적으로 전송되었습니다!',
                        icon: 'success',
                        button: '확인'
                    }).then(function() {
                        // SweetAlert 확인 버튼을 누르면 페이지 새로고침
                        location.reload();
                    });
                },
                error: function(xhr, status, error) {
                    // SweetAlert 알림: 실패 시
                    swal({
                        title: '오류',
                        text: '답변 전송에 실패했습니다. 다시 시도해주세요.',
                        icon: 'error',
                        button: '확인'
                    });
                }
            });
        });
    });
</script>

<script>
    document.getElementById('request-ai-answer').addEventListener('click', function() {
        // 서버 렌더링된 ${post.title}과 ${post.content} 값을 그대로 JavaScript로 사용
        const title = '${post.title}';  // 서버에서 렌더링된 제목 사용
        const query = '${post.content}';  // 서버에서 렌더링된 본문 내용 사용

        // 제목이 제대로 들어왔는지 로그로 출력
        console.log("Title:", title);
        console.log("Query:", query);

        // 로딩 상태 표시
        swal({
            title: "답변을 생각하고 있어요...",
            text: "잠시만 기다려주세요.",
            buttons: false,  // 확인 버튼 숨김
            closeOnClickOutside: false,  // 외부 클릭으로 닫히지 않게 설정
            icon: "info"  // 로딩 중에는 정보 아이콘 표시
        });

        // Flask 서버로 POST 요청 보내기 (포트 5001)
        fetch('http://localhost:8000/ask', {  // Flask 서버 경로로 요청
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                title: title,  // 제목 전송
                query: query   // 본문 내용을 쿼리로 전송
            }),
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('네트워크 응답에 문제가 있습니다.');
                }
                return response.json();
            })
            .then(data => {
                // 로딩 상태 닫기
                swal.close();

                // AI 답변을 받아 textarea에 넣음
                document.getElementById('admin-reply-content').value = data.answer;

                // 성공 시 SweetAlert로 알림
                swal({
                    title: "성공",
                    text: "AI의 답변이 성공적으로 추가되었습니다.",
                    icon: "success",
                    button: "확인"
                });
            })
            .catch((error) => {
                console.error('Error:', error);

                // 로딩 상태 닫기
                swal.close();

                // 오류 발생 시 SweetAlert로 알림
                swal({
                    title: "오류",
                    text: "AI 답변을 가져오는 중 오류가 발생했습니다.",
                    icon: "error",
                    button: "확인"
                });
            });
    });
</script>

<script>
    function deletePost(postId) {
        swal({
            title: "정말로 삭제하시겠습니까?",
            text: "이 작업은 되돌릴 수 없습니다!",
            icon: "warning",
            buttons: true,
            dangerMode: true,
        }).then((willDelete) => {
            if (willDelete) {
                // 사용자가 삭제를 확인했을 때 서버로 요청 전송
                fetch('/posts/delete', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({ postId: postId })
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            swal("게시글이 성공적으로 삭제되었습니다.", {
                                icon: "success",
                            }).then(() => {
                                // 삭제 후 페이지 새로고침 또는 게시글 목록으로 이동
                                window.location.href = '/aiqna'; // 게시글 목록 페이지로 이동
                            });
                        } else {
                            swal("게시글 삭제에 실패하였습니다.", {
                                icon: "error",
                            });
                        }
                    })
                    .catch((error) => {
                        console.error('Error:', error);
                        swal("게시글 삭제 중 오류가 발생했습니다.", {
                            icon: "error",
                        });
                    });
            } else {
                swal("게시글 삭제가 취소되었습니다.");
            }
        });
    }

</script>





</html>
