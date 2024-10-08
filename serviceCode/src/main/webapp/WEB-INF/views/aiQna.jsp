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
            <!-- 게시판 내용 -->
            <div class="col-12">
                <table class="table table-hover hana-font">
                    <thead class="thead-light">
                    <tr>
                        <th scope="col">번호</th>
                        <th scope="col">글 제목</th>
                        <th scope="col">작성자</th> <!-- 작성자 컬럼 추가 -->
                        <th scope="col">날짜</th>
                        <th scope="col">응답 상태</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="post" items="${posts}">
                        <tr>
                            <th scope="row">${post.number}</th>
                            <td>
                                <a href="/postDetail?postId=${post.postId}">
                                        ${post.title}
                                </a>
                            </td>
                            <!-- 작성자 정보 추가 -->
                            <td class="author-cell">
                                <img src="${post.profileUrl}" alt="작성자 로고" class="author-logo">
                                <span>${post.userId}</span>
                            </td>
                            <td>
                                ${post.date}
                            </td>
                            <td>
                                <span class="badge
                                    <c:choose>
                                        <c:when test="${post.responseStatus == '답변 완료'}">badge-completed</c:when>
                                        <c:otherwise>badge-waiting</c:otherwise>
                                    </c:choose>">
                                        ${post.responseStatus}
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <!-- 글쓰기 버튼과 내가 쓴 글 보기 버튼을 포함하는 영역 -->
                <div class="col-12 mb-3 d-flex justify-content-between">
                    <!-- 내가 쓴 글 보기 버튼 -->
                    <form method="get" action="${pageContext.request.contextPath}/aiqna">
                        <input type="hidden" name="myPosts" value="${!myPosts}"/>
                        <button type="submit" class="btn write-button btn-toggle">
                            <c:choose>
                                <c:when test="${myPosts}">
                                    전체 글 보기
                                </c:when>
                                <c:otherwise>
                                    내가 쓴 글 보기
                                </c:otherwise>
                            </c:choose>
                        </button>
                    </form>
                    <!-- 기존의 글쓰기 버튼 -->
                    <button type="button" class="btn write-button" data-toggle="modal" data-target="#writeModal">
                        AI와 관리자에게 물어보기
                    </button>
                </div>
            </div>

            <!-- 페이지네이션 -->
            <!-- 페이지네이션 -->
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center hana-font">
                    <!-- 이전 페이지 링크 -->
                    <li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>'">
                        <a class="page-link" href="${pageContext.request.contextPath}/aiqna?page=${currentPage - 1}"
                           tabindex="-1">이전</a>
                    </li>
                    <!-- 페이지 번호 링크 -->
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item <c:if test='${currentPage == i}'>active</c:if>'">
                            <a class="page-link" href="${pageContext.request.contextPath}/aiqna?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <!-- 다음 페이지 링크 -->
                    <li class="page-item <c:if test='${currentPage == totalPages}'>disabled</c:if>'">
                        <a class="page-link"
                           href="${pageContext.request.contextPath}/aiqna?page=${currentPage + 1}">다음</a>
                    </li>
                </ul>
            </nav>

        </div>
    </div>
</section>

<!-- 글쓰기 모달 -->
<div class="modal fade" id="writeModal" tabindex="-1" role="dialog" aria-labelledby="writeModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form id="writeForm">
                <div class="modal-header">
                    <!-- 이미지와 문구 추가 -->
                    <div class="w-100 text-center">
                        <img src="${pageContext.request.contextPath}/resources/images/ollama2.png" alt="Llama3 이미지"
                             class="modal-top-image">
                        <p class="modal-top-text">답변은 최신형 AI Llama3와 <br>하나Gift 관리자가 함께 고민합니다!</p>
                    </div>
                    <!-- 닫기 버튼 -->
                    <button type="button" class="close position-absolute" style="right: 15px;" data-dismiss="modal"
                            aria-label="닫기">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- 기존의 제목과 내용 입력 폼 -->
                    <div class="form-group">
                        <label for="postTitle">제목</label>
                        <input type="text" class="form-control" id="postTitle" name="title" placeholder="키워드 중심으로 제목을 달아주세요." required>
                    </div>
                    <div class="form-group">
                        <label for="postContent">어떤 점이 궁금하세요?</label>
                        <textarea class="form-control" id="postContent" name="content" rows="5" placeholder="하나Gift AI와 관리자가 함께 검토한 후 답변을 드릴 예정입니다." required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                    <button type="submit" class="btn write-button">작성하기</button>
                </div>
            </form>
        </div>
    </div>
</div>


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
    $(document).ready(function () {
        // 글쓰기 폼 제출 이벤트 핸들러
        $('#writeForm').submit(function (event) {
            event.preventDefault(); // 기본 폼 제출 방지

            // 폼 데이터 가져오기
            var formData = {
                title: $('#postTitle').val(),
                content: $('#postContent').val()
            };

            // AJAX로 서버에 데이터 전송
            $.ajax({
                type: 'POST',
                url: '${pageContext.request.contextPath}/writePost', // 서버의 글쓰기 처리 URL로 수정하세요
                data: JSON.stringify(formData),
                contentType: 'application/json; charset=utf-8',
                success: function (response) {
                    if (response.success) {
                        // 성공 메시지 표시
                        swal('성공!', '게시글이 등록되었습니다.', 'success').then(() => {
                            // 모달 닫기
                            $('#writeModal').modal('hide');
                            // 페이지 새로고침 또는 게시판 갱신
                            location.reload();
                        });
                    } else {
                        // 실패 메시지 표시
                        swal('실패!', '게시글 등록에 실패했습니다.', 'error');
                    }
                },
                error: function () {
                    swal('오류!', '서버와의 통신에 실패했습니다.', 'error');
                }
            });
        });
    });
</script>

</html>
