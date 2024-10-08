<%--
  Created by IntelliJ IDEA.
  User: gimjuhwan
  Date: 8/23/24
  Time: 12:35 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="component/head.jsp" flush="false"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/friend.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css?after" />

</head>
<body>
    <jsp:include page="component/header.jsp" flush="false"/>
<%--    <jsp:include page="component/friend_tap.jsp" flush="false"/>--%>
    <section class="bg0 p-t-75 p-b-120">
        <div class="container">
            <div class="row mt-4 mb-4">
                <div class="col-md-8">
                    <div class="gift-header">
                        <img
                                src="${pageContext.request.contextPath}/resources/images/ch1.png"
                                alt="선물 아이콘"
                                class="gift-icon"
                        />
                        <div class="text-container">
                            <h3 class="mtext-111 cl14 mb-3">마이페이지</h3>
                            <p class="stext-113 cl6">
                                친구 맺기를 통해 쉽고 간편하게 선물해보세요!
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 내 계정 정보 -->
            <div class="row p-b-70">
                <div class="container mt-5">
                    <div class="row align-items-center">
                        <!-- 개인정보 및 프로필 이미지 영역 -->
                        <div class="col-md-6">
                            <!-- 너비를 8에서 6으로 줄임 -->
                            <div class="profile-info">
                                <div class="d-flex align-items-center">
                                    <!-- 프로필 이미지 -->
                                    <div class="profile-img-container mr-4">
                                        <img
                                                src="${pageContext.request.contextPath}${user.profileUrl}"
                                                alt="Profile Image"
                                                class="profile-img"
                                        />
                                    </div>
                                    <!-- 개인정보 -->
                                    <div>
                                        <div class="name-status-container">
                                            <h4 class="info-name" style="color: #2d3548">${user.name}</h4>
                                            <div class="status-section">
                                                <span>${user.statusMessage}</span>
                                                <i class="fa fa-pencil edit-status"></i>
                                            </div>
                                        </div>
                                        <div class="info-section">
                                            <strong>이메일:</strong>
                                            ${user.email}
                                        </div>
                                        <div class="info-section">
                                            <strong>생년월일:</strong>
                                            ${user.birthDate}
                                        </div>
                                        <div class="info-section">
                                            <strong>전화번호:</strong>
                                            ${user.phoneNumber}
                                        </div>
                                    </div>
                                </div>
                                <button
                                        class="btn btn-primary edit-btn mt-3"
                                        data-toggle="modal"
                                        data-target="#editProfileModal"
                                >
                                    <i class="fa fa-pencil"></i> 수정하기
                                </button>
                            </div>
                        </div>
                        <!-- 직사각형 버튼 영역 -->
                        <div class="col-md-6">
                            <div
                                    class="rectangular-buttons d-flex flex-wrap"
                            >
                                <div class="rectangular-button-wrapper">
                                    <div
                                            class="rectangular-button gift-button"
                                    >
                                        <img
                                                src="${pageContext.request.contextPath}/resources/images/giftbox.png"
                                                alt="Gift Icon"
                                        />
                                        <span>선물함</span>
                                    </div>
                                </div>
                                <div class="rectangular-button-wrapper">
                                    <div
                                            class="rectangular-button currency-button" id="stockGiftButton"
                                    >
                                        <img
                                                src="${pageContext.request.contextPath}/resources/images/chargeCurrency.png"
                                                alt="Foreign Currency Icon"
                                        />
                                        <span>선물 받은 소수점 주식</span>
                                    </div>
                                </div>
                                <div class="rectangular-button-wrapper">
                                    <!-- 친구 추가 버튼 -->
                                    <div class="rectangular-button-wrapper">
                                        <div class="rectangular-button friendAdd-button" id="openFriendAddModal">
                                            <img
                                                    src="${pageContext.request.contextPath}/resources/images/addFriend.png"
                                                    alt="Add Friend Icon"
                                            />
                                            <span>친구 추가</span>
                                        </div>
                                    </div>
                            </div>
                                <div class="rectangular-button-wrapper">
                                    <div class="rectangular-button wishlist-button" id="showWishCategoryModal">
                                        <img src="${pageContext.request.contextPath}/resources/images/wishGift.png" alt="Wishlist Icon" />
                                        <span>받고 싶은 선물</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 탭 메뉴 -->
            <div class="row">
                <div class="col-md-12">
                    <ul
                            class="nav nav-pills mb-3"
                            id="myTab"
                            role="tablist"
                    >
                        <li class="nav-item">
                            <a
                                    class="nav-link active"
                                    id="friends-tab"
                                    data-toggle="pill"
                                    href="#friends"
                                    role="tab"
                                    aria-controls="friends"
                                    aria-selected="true"
                            ><i class="fa fa-users mr-2"></i> 친구
                                목록</a
                            >
                        </li>
                        <li class="nav-item">
                            <a
                                    class="nav-link"
                                    id="wishlist-tab"
                                    data-toggle="pill"
                                    href="#wishlist"
                                    role="tab"
                                    aria-controls="wishlist"
                                    aria-selected="false"
                            ><i class="fa fa-heart mr-2"></i>
                                위시리스트</a
                            >
                        </li>
                        <li class="nav-item">
                            <a
                                    class="nav-link"
                                    id="products-tab"
                                    data-toggle="pill"
                                    href="#products"
                                    role="tab"
                                    aria-controls="products"
                                    aria-selected="false"
                            ><i class="fa fa-briefcase mr-2"></i> 나만의
                                상품</a
                            >
                        </li>
                    </ul>

                    <div class="tab-content p-t-30" id="myTabContent">
                        <div
                                class="tab-pane fade show active"
                                id="friends"
                                role="tabpanel"
                                aria-labelledby="friends-tab"
                        >
                            <!-- 친구 목록 테이블 -->
                            <!-- 친구 목록 테이블 -->
                            <div class="table-responsive">
                                <table class="table table-borderless friend-table" style="width: 100%;">
                                    <tbody id="friendTableBody">
                                    <c:forEach var="friend" items="${friendList}">
                                        <tr class="friend-row d-flex align-items-center border-bottom">
                                            <!-- 프로필 이미지 -->
                                            <td class="col-2 text-center">
                                                <img src="${pageContext.request.contextPath}${friend.friendProfileUrl}"
                                                     alt="Profile Image"
                                                     class="img-fluid profile-image"/>
                                            </td>

                                            <!-- 이름과 상태 메시지 -->
                                            <td class="col-4">
                                                <p class="m-0 friend-name">${friend.friendName}</p> <!-- 친구 이름 -->
                                                <p class="friend-status">
                                                    ${friend.friendStatusMessage}
                                                </p>
                                            </td>

                                            <!-- 상세보기 버튼 -->
                                            <td class="col-2 text-center">
                                                <button class="btn btn-sm btn-info btn-view-details"
                                                        data-friend-id="${friend.friendId}"
                                                        data-profile-url="${request.getContextPath()}${friend.friendProfileUrl}">
                                                    상세보기
                                                </button>
                                            </td>

                                            <!-- 삭제 버튼 -->
                                            <td class="col-2 text-center">
                                                <button class="btn btn-sm btn-danger btn-delete">삭제</button>
                                            </td>

                                            <!-- 즐겨찾기 아이콘 -->
                                            <td class="col-2 text-center">
                                                <i class="fa fa-star-o favorite-icon" style="cursor: pointer"></i>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <!-- 추가 친구 항목들 -->
                                    </tbody>
                                </table>
                            </div>

                        </div>
                        <div
                                class="tab-pane fade"
                                id="wishlist"
                                role="tabpanel"
                                aria-labelledby="wishlist-tab"
                        >
                            <div class="wishlist-container">
                                <c:forEach var="wishlist" items="${wishlist}">
                                    <div class="wishlist-item1">
                                        <div class="wishlist-icon">
                                            <!-- 각 아이템의 이미지 URL을 동적으로 설정 -->
                                            <img src="${pageContext.request.contextPath}${wishlist.productImgUrl}" alt="${wishlist.productName} 아이콘">
                                        </div>
                                        <div class="wishlist-info">
                                            <!-- 상품 이름을 동적으로 설정 -->
                                            <h5 class="wishlist-title">${wishlist.productName}</h5>

                                            <!-- 상품 카테고리 및 설명(금리 또는 빈 문자열) 동적 설정 -->
                                            <p class="wishlist-category">
                                                <c:choose>
                                                    <c:when test="${wishlist.productCategory == 'savings'}">
                                                        금리: ${wishlist.description}
                                                    </c:when>
                                                    <c:otherwise>
                                                        카테고리: ${wishlist.productCategory}
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                        <!-- 삭제 버튼 -->
                                        <button class="wishlist-delete-btn" data-product-id="${wishlist.productID}">삭제</button>
                                    </div>
                                </c:forEach>
                            </div>

                        </div>
                        <div
                                class="tab-pane fade"
                                id="products"
                                role="tabpanel"
                                aria-labelledby="products-tab"
                        >
                            <!-- 나만의 금융상품 내용 -->
                            <p>나만의 금융상품 내용이 여기에 표시됩니다.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

<%--    프로필 수정 모달--%>
    <div
            class="modal fade"
            id="editProfileModal"
            tabindex="-1"
            role="dialog"
            aria-labelledby="editProfileModalLabel"
            aria-hidden="true"
    >
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editProfileModalLabel">
                        프로필 수정
                    </h5>
                    <button
                            type="button"
                            class="close"
                            data-dismiss="modal"
                            aria-label="Close"
                    >
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="profileImage">프로필 이미지</label>
                            <input
                                    type="file"
                                    class="form-control-file"
                                    id="profileImage"
                            />
                            <!-- 이미지 미리보기 -->
                            <img
                                    id="imagePreview"
                                    src=""
                                    alt="미리보기"
                                    class="img-fluid mt-3"
                                    style="
                                        max-width: 100%;
                                        height: auto;
                                        display: none;
                                    "
                            />
                        </div>
                        <div class="form-group">
                            <label for="email">이메일</label>
                            <input
                                    type="email"
                                    class="form-control"
                                    id="email"
                                    value="honggildong@example.com"
                            />
                        </div>
                        <div class="form-group">
                            <label for="phoneNumber">전화번호</label>
                            <input
                                    type="text"
                                    class="form-control"
                                    id="phoneNumber"
                                    value="010-1234-5678"
                            />
                        </div>
                        <div class="form-group">
                            <label for="password">비밀번호</label>
                            <input
                                    type="password"
                                    class="form-control"
                                    id="password"
                                    placeholder="새 비밀번호 입력"
                            />
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button
                            type="button"
                            class="btn btn-secondary"
                            data-dismiss="modal"
                    >
                        닫기
                    </button>
                    <button type="button" class="btn btn-primary">
                        저장하기
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- 상세 보기 모달 -->
    <!-- 상세 보기 모달 -->
    <div id="userModal" class="modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- 프로필 이미지와 사용자 정보 섹션 -->
                    <div class="profile-section d-flex align-items-center mb-4">
                        <img id="modalProfileImage" src="" alt="Profile Image" class="img-fluid rounded-circle profile-image" />
                        <div class="ml-3">
                            <h4 id="modalUsername">사용자</h4>
                            <p id="modalStatus" class="status-message">상태 메세지</p>
                        </div>
                    </div>

                    <!-- 받고 싶은 선물 소제목 및 이미지 -->
                    <div class="d-flex align-items-center mb-2">
                        <img src="${pageContext.request.contextPath}/resources/images/ic_7958.png" alt="Gift Icon" class="mr-2" style="width: 30px; height: 30px;" />
                        <h5 class="mb-0 gift-title">받고 싶은 선물</h5>
                    </div>

                    <!-- 본문 설명 -->
                    <p class="mt-3 explanation-text">
                        <span class="username" id="modalUsernameGift"></span>님이 받고 싶은 선물은
                        <strong class="highlight gift-category"></strong>입니다.<br />
                    </p>
                    <div class="background1" id="modalGiftImageContainer"
                         style="background-image: url('${pageContext.request.contextPath}/resources/images/bg_utl_app.png'); background-size: cover; background-position: center; height: 300px; position: relative;">
                        <img id="modalGiftImage" src="" alt="Gift Image" class="gift-image my-3 layer-slick1 animated visible-false" />
                    </div>
                    <p class="mt-3 explanation-text">
                        현재 <strong class="highlight gift-category" id="modalTravelPlan"></strong> 여행을 계획 중이에요!
                    </p>

                    <!-- 여행 이미지 섹션 -->
                    <div class="travel-recommendations d-flex justify-content-around mt-4">
                        <div class="travel-image-container">
                            <a href="foreign-currency-page.html">
                                <img id="modalTravelImage" src="" alt="Travel Image" class="travel-image" />
                            </a>
                            <p class="text-center travel-text mt-2">
                                <a href="foreign-currency-page.html">외화 선물하기</a>
                            </p>
                        </div>
                    </div>

                    <!-- 위시리스트 제목 -->
                    <div class="d-flex align-items-center mb-2 mt-3">
                        <img src="${pageContext.request.contextPath}/resources/images/travellog_listbanner.png" alt="Gift Icon" class="mr-2" style="width: 30px; height: 30px;" />
                        <h5 class="mb-0 gift-title">위시리스트</h5>
                    </div>

                    <!-- 탭 메뉴 -->
                    <ul class="custom-nav-tabs mb-3" id="wishlisttab" role="tablist">
                        <li class="custom-nav-item">
                            <a class="custom-nav-link active" data-filter="savings" id="deposit-tab" role="tab" aria-controls="deposit" aria-selected="true">
                                적금
                            </a>
                        </li>
                        <li class="custom-nav-item">
                            <a class="custom-nav-link" data-filter="currency" id="foreignCurrency-tab" role="tab" aria-controls="foreignCurrency" aria-selected="false">
                                외화
                            </a>
                        </li>
                        <li class="custom-nav-item">
                            <a class="custom-nav-link" data-filter="stock" id="stocks-tab" role="tab" aria-controls="stock" aria-selected="false">
                                주식
                            </a>
                        </li>
                    </ul>

                    <!-- 위시리스트 항목 -->
                    <div class="wishlist-items" id="wishlistItems">
                        <!-- 항목은 JS로 동적 생성 -->
                    </div>
                </div>

                <div class="modal-footer">
                    <button class="gift-button">
                        <img src="/resources/images/icons/gift_1.png" alt="Gift Icon" class="gift-icon-modal" />
                        <span>선물하기</span>
                    </button>
                </div>
            </div>
        </div>
    </div>


    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">삭제 확인</h5>
                    <button
                            type="button"
                            class="close"
                            data-dismiss="modal"
                            aria-label="Close"
                    >
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>정말 삭제하시겠어요?</p>
                </div>
                <div class="modal-footer">
                    <button
                            type="button"
                            class="btn btn-secondary"
                            data-dismiss="modal"
                    >
                        취소
                    </button>
                    <button
                            type="button"
                            class="btn btn-danger"
                            id="confirmDelete"
                    >
                        삭제
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- 친구 추가 모달 -->
    <div class="friendAdd-modal" id="friendAddModal">
        <div class="friendAdd-modal-dialog">
            <div class="friendAdd-modal-content">
                <div class="friendAdd-modal-header">
                    <h5 class="modal-title">친구 추가</h5>
                    <button type="button" class="friendAdd-close" id="closeFriendAddModal">&times;</button>
                </div>
                <!-- 상단 안내 문구 -->
                <div class="friendAdd-info text-center mt-3">
                    <p>이름과 연락처로 쉽고 간편하게 친구를 추가해보세요!</p>
                </div>
                <div class="friendAdd-modal-body">
                    <form>
                        <div class="form-group">
                            <label for="newFriendName">이름</label>
                            <input type="text" class="form-control" id="newFriendName" name="newFriendName" placeholder="이름 입력">
                        </div>
                        <div class="form-group">
                            <label for="newFriendPhone">전화번호</label>
                            <input type="text" class="form-control" id="newFriendPhone" name="newFriendPhone" placeholder="전화번호 입력">
                        </div>
                        <p class="text-danger small text-center">하나원큐를 사용하는 친구만 추가할 수 있습니다</p>
                    </form>
                </div>
                <div class="friendAdd-modal-footer">
                    <button class="btn btn-secondary" id="closeFriendAddModalFooter">취소</button>
                    <button class="btn btn-success" id="addFriendButton">추가</button>
                </div>
            </div>
        </div>
    </div>


    <!-- 받고 싶은 선물 카테고리 모달 -->
    <div class="wish-category-modal" id="wishCategoryModal">
        <div class="wish-category-modal-dialog">
            <div class="wish-category-modal-content">
                <div class="wish-category-modal-header">
                    <h5 class="modal-title">선물 선택 & 여행 계획</h5>
                    <button type="button" class="wish-category-close" id="closeWishCategoryModal">&times;</button>
                </div>
                <div class="wish-category-modal-body">
                    <h5 class="mt-5 modal-sub-title">어떤 선물을 선호하세요?</h5>
                    <form id="wishCategoryForm">
                        <!-- 선물 카드 선택 영역 -->
                        <div class="wish-category-cards">
                            <!-- 주식 카드 -->
                            <div class="wish-category-card">
                                <input type="radio" id="categoryStock" name="giftCategory" value="stock" class="wish-category-radio">
                                <label for="categoryStock">
                                    <img src="${pageContext.request.contextPath}/resources/images/icons/userModal_ic01.png" alt="Stock Gift" />
                                    <p><strong>주식</strong></p>
                                    <p class="description">안정적인 주식 투자를 시작하세요.</p>
                                </label>
                            </div>

                            <!-- 외화 카드 -->
                            <div class="wish-category-card">
                                <input type="radio" id="categoryCurrency" name="giftCategory" value="currency" class="wish-category-radio">
                                <label for="categoryCurrency">
                                    <img src="${pageContext.request.contextPath}/resources/images/icons/f_currency.png" alt="Currency Gift" />
                                    <p><strong>외화</strong></p>
                                    <p class="description">다양한 외화로 자산을 관리하세요.</p>
                                </label>
                            </div>

                            <!-- 적금 카드 -->
                            <div class="wish-category-card">
                                <input type="radio" id="categorySavings" name="giftCategory" value="savings" class="wish-category-radio">
                                <label for="categorySavings">
                                    <img src="${pageContext.request.contextPath}/resources/images/icons/userModal_ic03.png" alt="Savings Gift" />
                                    <p><strong>적금</strong></p>
                                    <p class="description">안정적인 적금으로 미래를 준비하세요.</p>
                                </label>
                            </div>
                        </div>

                        <!-- 여행 계획 영역 -->
                        <h5 class="mt-5 modal-sub-title">여행 계획이 있나요?
                            <img src="${pageContext.request.contextPath}/resources/images/travelog.png" alt="Travelog" class="shake-animation" />
                        </h5>

                        <!-- 더 보기 버튼 -->
                        <div class="country-selection">
                            <!-- 기본적으로 두 줄까지만 보여주고, 나머지는 숨김 처리 -->
                                <c:forEach var="currency" items="${currencyList}">
                                    <div class="country-card">
                                        <input type="radio" id="country${currency.productID}" name="country" value="${currency.productID}" class="country-radio">
                                        <label for="country${currency.productID}">
                                            <img src="${pageContext.request.contextPath}${currency.logoImageURL}" alt="${currency.productName}">
                                            <p>${currency.productName}</p>
                                        </label>
                                    </div>
                                </c:forEach>


                            <!-- 더 보기 버튼 -->
<%--                            <button type="button" id="showMoreButton" class="btn btn-info">더 보기</button>--%>
                        </div>
                    </form>
                </div>
                <div class="wish-category-modal-footer">
                    <button class="btn btn-secondary" id="closeWishCategoryModalFooter">취소</button>
                    <button class="btn btn-success" id="selectWishCategoryButton">선택 완료</button>
                </div>
            </div>
        </div>
    </div>


<%--    선물 받은 주식 모달--%>
    <!-- 모달 구조 -->
    <div id="msStockGiftModal" class="ms-modal" style="display: none;">
        <div class="ms-modal-content">
            <div class="ms-modal-header">
                <span class="ms-close">&times;</span>
                <h2>내가 받은 소수점 주식</h2>
            </div>
            <div class="ms-modal-body">
                <p>&#8251; 실제 주문 수량은 미국 주식시장의 정규거래 시간에 맞춰 저녁 10시, <br> 예상 주식 수량은 외환 시장과 주식 시장 마감 이후인 저녁 6시에 공개돼요!</p>
                <p>&#8251; 자세한 내용은 <img src="${pageContext.request.contextPath}/resources/images/hanasecurities.png" alt="하나증권" class="ms-securities-logo"> 소수점 거래에서 확인해주세요.</p>

                <table class="ms-stock-table">
                    <thead>
                    <tr>
                        <th>받은 주식</th>
                        <th>받은 시간</th>
                        <th>예상 주문 수량</th>
                        <th>실제 주문 수량</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- stockgift 목록 출력 -->
                    <c:forEach var="stock" items="${stockGifts}">
                        <tr>
                            <td>
                                <img src="${pageContext.request.contextPath}${stock.logoImageURL}" alt="${stock.productName}" class="ms-stock-image" />
                                    ${stock.productName}
                            </td>
                            <td>${stock.createdAt}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${stock.expectedStockQuantity == 0.0}">
                                        저녁 6시에 공개!
                                    </c:when>
                                    <c:otherwise>
                                        ${stock.expectedStockQuantity}주
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${stock.stockQuantity == 0.0}">
                                        저녁 10시에 공개!
                                    </c:when>
                                    <c:otherwise>
                                        ${stock.stockQuantity}주
                                    </c:otherwise>
                                </c:choose>
                            </td>

                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>






    <script type="text/javascript">
        var contextPath = '${pageContext.request.contextPath}';  // JSP의 EL을 JavaScript 변수에 할당
    </script>


    <jsp:include page="component/footer.jsp" flush="false"/>
    <script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery-3.2.1.min.js"></script>
    <!--===============================================================================================-->
    <script src="${pageContext.request.contextPath}/resources/vendor/animsition/js/animsition.min.js"></script>
    <!--===============================================================================================-->
    <script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/popper.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
    <!--===============================================================================================-->
    <script src="${pageContext.request.contextPath}/resources/vendor/select2/select2.min.js"></script>
    <script>
        $(".js-select2").each(function () {
            $(this).select2({
                minimumResultsForSearch: 20,
                dropdownParent: $(this).next(".dropDownSelect2"),
            });
        });
    </script>
    <script>
        document.querySelectorAll(".fa-star-o").forEach((star) => {
            star.addEventListener("click", function () {
                this.classList.toggle("fa-star");
                this.classList.toggle("fa-star-o");
            });
        });
    </script>
    <!--===============================================================================================-->
    <script src="${pageContext.request.contextPath}/resources/vendor/MagnificPopup/jquery.magnific-popup.min.js"></script>
    <!--===============================================================================================-->
    <script src="${pageContext.request.contextPath}/resources/vendor/perfect-scrollbar/perfect-scrollbar.min.js"></script>
    <script>
        $(".js-pscroll").each(function () {
            $(this).css("position", "relative");
            $(this).css("overflow", "hidden");
            var ps = new PerfectScrollbar(this, {
                wheelSpeed: 1,
                scrollingThreshold: 1000,
                wheelPropagation: false,
            });

            $(window).on("resize", function () {
                ps.update();
            });
        });
    </script>
    <!--===============================================================================================-->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/friend.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/mypage.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendor/sweetalert/sweetalert.min.js"></script>
<%--    친구 삭제 --%>
    <script>
        $(document).ready(function () {
            // 삭제 버튼 클릭 시
            $(".btn-delete").on("click", function (e) {
                e.preventDefault();

                var currentButton = $(this);
                var friendId = currentButton.closest(".friend-row").find(".btn-view-details").data("friend-id");

                // SweetAlert 모달을 띄웁니다.
                swal({
                    title: "정말 삭제하시겠어요?",
                    text: "삭제하면 되돌릴 수 없습니다.",
                    icon: "warning",
                    buttons: {
                        cancel: "취소",
                        confirm: {
                            text: "삭제",
                            closeModal: false,
                        },
                    },
                }).then((willDelete) => {
                    if (willDelete) {
                        // Ajax를 사용하여 서버에 삭제 요청
                        $.ajax({
                            url: "/deleteFriend",  // 서버의 삭제 처리 URL
                            method: "POST",
                            data: { friendId: friendId },  // 삭제할 친구의 ID 전달
                            success: function (response) {
                                if (response.success) {
                                    // 삭제 성공 시 메시지를 띄우고 해당 행을 삭제
                                    swal("삭제되었습니다!", "선택한 친구가 목록에서 삭제되었습니다.", "success");
                                    currentButton.closest(".friend-row").remove();
                                } else {
                                    swal("실패", "친구를 삭제하지 못했습니다.", "error");
                                }
                            },
                            error: function () {
                                swal("실패", "삭제 중 오류가 발생했습니다.", "error");
                            }
                        });
                    }
                });
            });
        });

    </script>
    <script>
        $(document).ready(function () {
            $(".edit-status").on("click", function () {
                swal({
                    title: "상태 메시지 수정",
                    text: "새로운 상태 메시지를 입력하세요:",
                    content: {
                        element: "input",
                        attributes: {
                            placeholder: "새로운 상태 메시지",
                            type: "text",
                        },
                    },
                    buttons: {
                        cancel: "취소",
                        confirm: {
                            text: "저장",
                            closeModal: false,
                        },
                    },
                }).then((newStatus) => {
                    if (newStatus) {
                        $(".status-section span").text(newStatus);
                        swal(
                            "수정되었습니다!",
                            "상태 메시지가 변경되었습니다.",
                            "success"
                        );
                    }
                });
            });

        });

        //친구 추가 모달
        document.addEventListener("DOMContentLoaded", function() {
            const openModalButton = document.getElementById('openFriendAddModal');
            const closeModalButton = document.getElementById('closeFriendAddModal');
            const closeModalButtonFooter = document.getElementById('closeFriendAddModalFooter');
            const friendAddModal = document.getElementById('friendAddModal');

            // 친구 추가 모달 열기
            openModalButton.addEventListener('click', function() {
                friendAddModal.style.display = 'flex'; // 모달 보이게 설정
                document.getElementById('newFriendName').value = ''; // 이름 입력 필드 초기화
                document.getElementById('newFriendPhone').value = ''; // 전화번호 입력 필드 초기화
            });

            // 친구 추가 모달 닫기 (상단 닫기 버튼)
            closeModalButton.addEventListener('click', function() {
                friendAddModal.style.display = 'none'; // 모달 숨기기
            });

            // 친구 추가 모달 닫기 (푸터 취소 버튼)
            closeModalButtonFooter.addEventListener('click', function(event) {
                event.preventDefault(); // 기본 동작(폼 제출) 방지
                friendAddModal.style.display = 'none'; // 모달 숨기기
            });

            // 친구 추가 버튼 눌렀을 때 처리
            document.getElementById('addFriendButton').addEventListener('click', function(event) {
                event.preventDefault(); // 기본 동작(폼 제출) 방지
                const name = document.getElementById('newFriendName').value.trim();
                const phone = document.getElementById('newFriendPhone').value.trim();
                console.log(name, phone);
                if (name && phone) {
                    // AJAX로 이름과 전화번호를 서버로 전송
                    fetch('/addFriend', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({
                            friendName: name,
                            phoneNumber: phone
                        })
                    })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                // 성공 메시지 표시
                                swal({
                                    title: "친구 추가 성공!",
                                    text: `${name}님이 추가되었습니다.`,
                                    icon: "success",
                                    button: "확인",
                                });

                                // 모달 닫기
                                friendAddModal.style.display = 'none';
                            } else {
                                // 실패 메시지 표시 (예: 존재하지 않는 사용자)
                                swal({
                                    title: "오류!",
                                    text: data.message,
                                    icon: "error",
                                    button: "확인",
                                });
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            swal({
                                title: "오류!",
                                text: "서버 요청 중 문제가 발생했습니다.",
                                icon: "error",
                                button: "확인",
                            });
                        });
                } else {
                    // 이름 또는 전화번호가 비어 있으면 경고 메시지 표시
                    swal({
                        title: "오류!",
                        text: "이름과 전화번호를 모두 입력해주세요.",
                        icon: "error",
                        button: "확인",
                    });
                }
            });

            // 전화번호 입력 필드 자동 형식 지정
            document.getElementById('newFriendPhone').addEventListener('input', function(event) {
                let input = event.target.value;

                // 숫자만 남기기
                input = input.replace(/\D/g, '');

                // 000-0000-0000 형식으로 변경
                if (input.length <= 3) {
                    event.target.value = input;
                } else if (input.length <= 7) {
                    event.target.value = input.slice(0, 3) + '-' + input.slice(3);
                } else {
                    event.target.value = input.slice(0, 3) + '-' + input.slice(3, 7) + '-' + input.slice(7, 11);
                }
            });
        });


        // 받고 싶은 선물 선택
        // 받고 싶은 선물 선택
        document.addEventListener("DOMContentLoaded", function() {
            const closeWishCategoryModalButton = document.getElementById('closeWishCategoryModal');
            const closeWishCategoryModalFooter = document.getElementById('closeWishCategoryModalFooter');
            const wishCategoryModal = document.getElementById('wishCategoryModal');
            const selectWishCategoryButton = document.getElementById('selectWishCategoryButton');

            // 모달 열기
            document.getElementById('showWishCategoryModal').addEventListener('click', function() {
                wishCategoryModal.style.display = 'flex'; // 모달 보이기
            });

            // 모달 닫기
            closeWishCategoryModalButton.addEventListener('click', function() {
                wishCategoryModal.style.display = 'none'; // 모달 숨기기
            });

            closeWishCategoryModalFooter.addEventListener('click', function(event) {
                event.preventDefault();
                wishCategoryModal.style.display = 'none';
            });

            // 선택 완료 버튼 눌렀을 때 처리
            selectWishCategoryButton.addEventListener('click', function(event) {
                event.preventDefault();

                // 선택한 선물 카테고리 및 국가 선택 확인
                const selectedCategory = document.querySelector('input[name="giftCategory"]:checked');
                const selectedCountry = document.querySelector('input[name="country"]:checked');

                if (selectedCategory && selectedCountry) {
                    // 전송할 데이터 구성
                    const requestData = {
                        giftType: selectedCategory.value,  // 선물 카테고리
                        countryId: selectedCountry.value         // 선택한 나라
                    };
                    console.log(requestData);
                    // AJAX 요청으로 데이터 전송
                    fetch('/myPage/savePreferences', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(requestData) // 데이터를 JSON 문자열로 변환
                    })
                        .then(response => response.json())
                        .then(result => {
                            if (result.success) {
                                // 성공 메시지
                                swal({
                                    title: "선택 완료!",
                                    text: `선물이 저장되었습니다.`,
                                    icon: "success",
                                    button: "확인",
                                });

                                // 모달 닫기
                                wishCategoryModal.style.display = 'none';
                            } else {
                                // 오류 메시지
                                swal({
                                    title: "오류 발생!",
                                    text: "선택한 선물 정보를 저장할 수 없습니다.",
                                    icon: "error",
                                    button: "확인",
                                });
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            // 서버와의 통신 오류 처리
                            swal({
                                title: "서버 오류!",
                                text: "서버와의 통신 중 문제가 발생했습니다.",
                                icon: "error",
                                button: "확인",
                            });
                        });
                } else {
                    // 선택하지 않았을 때 오류 처리
                    swal({
                        title: "선택 오류",
                        text: "받고 싶은 선물과 여행 계획을 모두 선택해주세요.",
                        icon: "error",
                        button: "확인",
                    });
                }
            });
        });



        document.addEventListener("DOMContentLoaded", function() {
            const showMoreButton = document.getElementById("showMoreButton");
            const countryListContainer = document.getElementById("countryListContainer");

            // "더 보기" 버튼 클릭 이벤트 처리
            showMoreButton.addEventListener("click", function() {
                // 목록의 클래스 변경하여 전체 항목을 보여줌
                countryListContainer.classList.remove("country-list-limited");
                countryListContainer.classList.add("country-list-expanded");

                // "더 보기" 버튼을 숨김
                showMoreButton.style.display = "none";
            });
        });









        $('#editProfileModal').modal('hide');
        $('#editProfileModal').on('hidden.bs.modal', function () {
            $('.modal-backdrop').remove();  // 모달 닫힐 때 백드롭 제거
        });


    </script>



<%--받은 선물 확인--%>
<script>
    // 모달 열기와 닫기 기능
    document.getElementById('stockGiftButton').addEventListener('click', function() {
        document.getElementById('msStockGiftModal').style.display = 'block';
    });

    document.querySelector('.ms-close').addEventListener('click', function() {
        document.getElementById('msStockGiftModal').style.display = 'none';
    });

    window.addEventListener('click', function(event) {
        if (event.target === document.getElementById('msStockGiftModal')) {
            document.getElementById('msStockGiftModal').style.display = 'none';
        }
    });

</script>
</body>
</html>
