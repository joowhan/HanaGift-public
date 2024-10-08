<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery-3.2.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendor/sweetalert/sweetalert.min.js"></script>
    <!-- External CSS File for Friend List -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/friend_tap.css">
</head>
<body>
<div class="wrap-header-cart js-panel-cart">
    <div class="header-cart flex-col-l p-l-25 p-r-25">
        <!-- 친구 목록 헤더 -->
        <div class="header-cart-title flex-w flex-sb-m p-b-8">
            <div class="gift-header">
                <img
                        src="${pageContext.request.contextPath}/resources/images/friend_list.png"
                        alt="친구 목록 아이콘"
                        class="gift-icon-tap"
                />
                <div class="text-container">
                    <h3 class="mtext-103 cl2">내 친구 요청</h3>
                </div>
            </div>
            <div class="fs-35 lh-10 cl2 p-lr-5 pointer hov-cl1 trans-04 js-hide-cart">
                <i class="zmdi zmdi-close"></i>
            </div>
        </div>

        <div class="header-cart-content flex-w js-pscroll" id="friendListContainer">
            <ul class="header-cart-wrapitem w-full" id="friendRequestList">
                <!-- 샘플 친구 요청 -->
            </ul>
        </div>

        <div class="w-full text-center">
            <!-- 추가 이미지 -->
            <img src="${pageContext.request.contextPath}/resources/images/hanacharacterAll.png" alt="캐릭터 이미지" class="friend-add-character-img mb-4">

            <!-- 친구 추가 버튼 -->
            <div class="header-cart-buttons flex-w w-full p-l-25 p-r-25"> <!-- 리스트와 동일한 패딩 값을 설정 -->
                <button class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 m-b-10 w-100" id="toggleFriendFormBtn" style="max-width: 450px; margin: 0 auto;"> <!-- 버튼 너비 제한 -->
                    친구 추가
                </button>
            </div>
        </div>

        <!-- 친구 추가 입력 영역 -->
        <div id="friendInputArea" style="display: none;">
            <form id="addFriendForm">
                <div class="form-group">
                    <label for="friendName">이름</label>
                    <input type="text" class="form-control" id="friendName" placeholder="친구 이름을 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="friendContact">연락처</label>
                    <input type="text" class="form-control" id="friendContact" placeholder="친구 연락처를 입력하세요" required>
                </div>
                <button type="button" class="btn btn-primary w-100" id="saveFriendBtn">저장하기</button>
            </form>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // 친구 추가 폼 표시/숨기기
        $('#toggleFriendFormBtn').on('click', function() {
            $('#friendInputArea').toggle(); // 클릭할 때마다 폼을 보이거나 숨김
        });

        // 친구 요청 수락
        $('.js-accept-request').on('click', function() {
            var name = $(this).data('name');
            var contact = $(this).data('contact');

            swal({
                title: name + "님의 요청을 수락하시겠습니까?",
                text: "연락처: " + contact,
                icon: "info",
                buttons: true,
            }).then((willAccept) => {
                if (willAccept) {
                    swal(name + "님과 친구가 되었습니다!", {
                        icon: "success",
                    });
                    $(this).closest('li').remove();
                }
            });
        });

        // 친구 추가 저장 버튼 클릭 시
        $('#saveFriendBtn').click(function() {
            var friendName = $('#friendName').val();
            var friendContact = $('#friendContact').val();

            if (friendName && friendContact) {
                // 친구 목록에 추가
                $('#friendRequestList').append(`
                    <li class="friend-list-item">
                        <div class="friend-info">
                            <p class="friend-name">${friendName} (${friendContact})</p>
                        </div>
                        <div class="friend-request-btn">
                            <button class="btn js-accept-request" data-name="${friendName}" data-contact="${friendContact}">
                                수락
                            </button>
                        </div>
                    </li>
                `);

                // 입력 폼을 비우고 숨기기
                $('#friendInputArea').hide();
                $('#addFriendForm')[0].reset();
            }
        });
    });
</script>
</body>
</html>
