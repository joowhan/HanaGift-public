<%--
  Created by IntelliJ IDEA.
  User: gimjuhwan
  Date: 8/19/24
  Time: 5:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery-3.2.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendor/sweetalert/sweetalert.min.js"></script>
    <style>

    </style>
</head>
<body>
<header class="${headerClass}">
    <!-- Header desktop -->
    <div class="container-menu-desktop">
        <!-- Topbar -->
        <div class="top-bar">
            <div class="content-topbar flex-sb-m h-full container">
                <div class="left-top-bar">선물은 하나, 하나Gift</div>

                <div class="right-top-bar flex-w h-full">
                    <a href="myPage" class="flex-c-m trans-04 p-lr-25">
                        MyPage
                    </a>

                    <%
                        // 세션에서 userId를 확인하여 로그인 여부에 따라 링크 변경
                        String userId = (String) session.getAttribute("userId");
                        if (userId != null) {
                    %>
                    <a href="logout" class="flex-c-m trans-04 p-lr-25">Logout</a>
                    <%
                    } else {
                    %>
                    <a href="loginPage" class="flex-c-m trans-04 p-lr-25">Login</a>
                    <%
                        }
                    %>

                    <a href="https://www.kebhana.com/" class="flex-c-m trans-04 p-lr-25">
                        하나은행
                    </a>

                    <a href="https://www.hanacard.co.kr/" class="flex-c-m trans-04 p-lr-25">
                        하나카드
                    </a>
                </div>
            </div>
        </div>

        <div class="wrap-menu-desktop">
            <nav class="limiter-menu-desktop container">
                <!-- Logo desktop -->
                <a href="${pageContext.request.contextPath}/" class="logo">
                    <img
                            src="${pageContext.request.contextPath}/resources/images/icons/hanagift.svg"
                            alt="IMG-LOGO"
                    />
                </a>

                <!-- Menu desktop -->
                <div class="menu-desktop">
                    <ul class="main-menu">
                        <li class="<%= "home".equals(request.getAttribute("activeMenu")) ? "active-menu" : "" %>">
                            <a href="${pageContext.request.contextPath}/">Home</a>
                        </li>

                        <li class="<%= "gift".equals(request.getAttribute("activeMenu")) ? "active-menu" : "" %>">
                            <a href="${pageContext.request.contextPath}/productPage">선물하기</a>
                            <ul class="sub-menu">
                                <li>
                                    <a href="${pageContext.request.contextPath}/productPage">주식 선물하기</a>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/productPage">적금 선물하기</a>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/productPage">외화 선물하기</a>
                                </li>
                            </ul>
                        </li>

                        <li class="<%= "giftbox".equals(request.getAttribute("activeMenu")) ? "active-menu" : "" %>">
                            <a href="${pageContext.request.contextPath}/giftBox">선물함</a>
                        </li>

                        <li class="<%= "charge".equals(request.getAttribute("activeMenu")) ? "active-menu" : "" %>label1" data-label1="하나머니">
                            <a href="${pageContext.request.contextPath}/charge">외화 충전하기</a>
                        </li>

                        <li class="<%= "myPage".equals(request.getAttribute("activeMenu")) ? "active-menu" : "" %>">
                            <a href="${pageContext.request.contextPath}/myPage">마이페이지</a>
                        </li>

                        <li class="<%= "aiqna".equals(request.getAttribute("activeMenu")) ? "active-menu" : "" %>">
                            <a href="${pageContext.request.contextPath}/aiqna">AI Q&A</a>
                        </li>
                    </ul>

                </div>

                <!-- Icon header -->
                <div class="wrap-icon-header flex-w flex-r-m">
                    <div class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 js-show-modal-search">
                        <i class="zmdi zmdi-search"></i>
                    </div>

                    <div class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 icon-header-noti js-show-cart"
                            <c:if test="${not empty sessionScope.userId}">
                                data-notify="2"
                            </c:if>
                    >
                        <i class="zmdi zmdi-account-add"></i> <!-- 사람 추가 아이콘 -->
                    </div>

                    <a href="#" class="dis-block icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 icon-header-noti"
                            <c:if test="${not empty sessionScope.userId}">
                                data-notify="0"
                            </c:if>
                    >
                        <i class="zmdi zmdi-favorite-outline"></i>
                    </a>
                </div>

            </nav>
        </div>
    </div>

    <!-- Header Mobile -->
    <div class="wrap-header-mobile">
        <!-- Logo moblie -->
        <div class="logo-mobile">
            <a href="${pageContext.request.contextPath}/"
            ><img
                    src="${pageContext.request.contextPath}/resources/images/icons/hanagift_header_logo.png"
                    alt="IMG-LOGO"
            /></a>
        </div>

        <!-- Icon header -->
        <!-- Icon header -->
        <div class="wrap-icon-header flex-w flex-r-m m-r-15">
            <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 js-show-modal-search">
                <i class="zmdi zmdi-search"></i>
            </div>

            <div id="cartIcon" class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti js-show-cart">
                <i class="zmdi zmdi-shopping-cart"></i>
            </div>

            <a id="favoriteIcon" href="#" class="dis-block icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti">
                <i class="zmdi zmdi-favorite-outline"></i>
            </a>
        </div>

        <!-- 세션의 userId를 자바스크립트로 전달 -->
        <script type="text/javascript">
            var userId = '<%= session.getAttribute("userId") %>'; // userId 세션 값 전달

            // userId가 있는지 여부에 따라 동적으로 data-notify 속성 추가
            if (userId) {
                document.getElementById("cartIcon").setAttribute("data-notify", "2");
                document.getElementById("favoriteIcon").setAttribute("data-notify", "0");
            }
        </script>



        <!-- Button show menu -->
        <div class="btn-show-menu-mobile hamburger hamburger--squeeze">
                    <span class="hamburger-box">
                        <span class="hamburger-inner"></span>
                    </span>
        </div>
    </div>

    <!-- Menu Mobile -->
    <div class="menu-mobile">
        <ul class="topbar-mobile">
            <li>
                <div class="left-top-bar">선물은 하나, 하나Gift</div>
            </li>

            <li>
                <div class="right-top-bar flex-w h-full" style="height: 20px">
                    <a href="" class="flex-c-m p-lr-10 trans-04">
                        Login
                    </a>
                </div>
            </li>
        </ul>

        <ul class="main-menu-m">
            <li>
                <a href="${pageContext.request.contextPath}/">Home</a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/productPage">선물하기</a>
                <ul class="sub-menu-m">
                    <li><a href="${pageContext.request.contextPath}/productPage">적금 선물하기</a></li>
                    <li><a href="${pageContext.request.contextPath}/productPage">주식 선물하기</a></li>
                    <li><a href="${pageContext.request.contextPath}/productPage">외화 선물하기</a></li>
                </ul>
                <span class="arrow-main-menu-m">
                            <i class="fa fa-angle-right" aria-hidden="true"></i>
                        </span>
            </li>

            <li>
                <a
                        href="${pageContext.request.contextPath}/giftBox"
                        class="label1 rs1"
                        data-label1="hot"
                >선물함</a
                >
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/charge"
                   class="label1 rs1"
                   data-label1="하나머니"
                >외화 충전하기 </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/myPage">마이페이지</a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/myPage">AI Q&A</a>
            </li>
        </ul>
    </div>

    <!-- Modal Search -->
    <div
            class="modal-search-header flex-c-m trans-04 js-hide-modal-search"
    >
        <div class="container-search-header">
            <button
                    class="flex-c-m btn-hide-modal-search trans-04 js-hide-modal-search"
            >
                <img src="${pageContext.request.contextPath}/resources/images/icons/icon-close2.png" alt="CLOSE" />
            </button>

            <form class="wrap-search-header flex-w p-l-15">
                <button class="flex-c-m trans-04">
                    <i class="zmdi zmdi-search"></i>
                </button>
                <input
                        class="plh3"
                        type="text"
                        name="search"
                        placeholder="입력..."
                />
            </form>
        </div>
    </div>
</header>

<script>
    $(document).ready(function () {
        $('.js-show-cart').on('click', function () {
            console.log("hello");
            // AJAX로 서버에 친구 목록을 요청
            $.ajax({
                url: '/friendRequestList', // 컨트롤러에서 이 URL로 매핑
                method: 'GET',
                dataType: 'json',
                success: function (data) {
                    $('#friendRequestList').empty();  // 기존 목록 비우기

                    Object.values(data).forEach(function (friend) {
                        var $listItem = $('<li>', {class: 'friend-list-item'});
                        var $friendInfo = $('<div>', {class: 'friend-info'});

                        // friendName, phoneNumber 값을 각 p 요소에 삽입
                        $('<p>', {class: 'friend-name'}).text(friend.friendName).appendTo($friendInfo);
                        $('<p>', {class: 'friend-contact'}).text(friend.phoneNumber).appendTo($friendInfo);

                        var $buttons = $('<div>', {class: 'ft-friend-request-btn'});
                        $('<button>', {
                            class: 'btn ft-js-accept-request',
                            'data-id': friend.friendId
                        }).text('수락').appendTo($buttons);

                        $('<button>', {
                            class: 'btn ft-js-reject-request',
                            'data-id': friend.friendId
                        }).text('거절').appendTo($buttons);

                        // 최종적으로 각 부분을 하나의 li에 추가
                        $listItem.append($friendInfo).append($buttons);
                        $('#friendRequestList').append($listItem);
                    });
                },

                error: function (xhr, status, error) {
                    console.error('Error fetching friend requests:', error);
                }
            });
        });

        // "수락" 버튼 클릭 시 SweetAlert 모달 표시 (swal 방식)
        $(document).on('click', '.ft-js-accept-request', function () {
            var friendId = $(this).data('id');
            var $listItem = $(this).closest('.friend-list-item');
            swal({
                title: '친구 요청 수락',
                text: '이 친구 요청을 수락하시겠습니까?',
                icon: 'warning',
                buttons: {
                    cancel: {
                        text: "취소",
                        value: null,
                        visible: true,
                        className: 'btn btn-danger'.split(' '),  // 공백으로 구분된 클래스는 배열로 처리
                        closeModal: true,
                    },
                    confirm: {
                        text: "수락",
                        value: true,
                        visible: true,
                        className: 'btn btn-success'.split(' '),  // 마찬가지로 배열로 처리
                        closeModal: true
                    }
                }
            }).then((isConfirmed) => {
                if (isConfirmed) {
                    // 수락 로직 처리 (예: 서버에 수락 요청 보내기)
                    $.ajax({
                        url: '/acceptFriendRequest',  // 수락 처리할 URL
                        method: 'POST',
                        data: { id: friendId },
                        success: function (response) {
                            // 응답 데이터에 따라 성공 여부를 처리
                            if (response.approved) {
                                swal("수락 완료", "친구 요청을 수락했습니다.", "success");
                                $listItem.remove();
                            } else {
                                swal("수락 실패", "친구 요청 수락 중 오류가 발생했습니다.", "error");
                            }
                        },
                        error: function (xhr, status, error) {
                            swal("오류 발생", "친구 요청 수락 중 문제가 발생했습니다.", "error");
                        }
                    });
                }
            });
        });
    });







</script>


</body>
</html>
