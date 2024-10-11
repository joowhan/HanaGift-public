<%--
  Created by IntelliJ IDEA.
  User: gimjuhwan
  Date: 8/30/24
  Time: 6:36 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">
<head>
    <title>상품 상세</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!--===============================================================================================-->
    <jsp:include page="component/head.jsp" flush="false"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/review.css" />
    <!-- Bootstrap CSS -->
    <link
            href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
            rel="stylesheet"
    />
    <!-- jQuery, Popper.js, Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <style>
        .accordion-content {
            font-family: "HanaFont-Light", sans-serif;
            background-color:white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .info-table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 16px;
            color: #333;
        }

        .info-table th, .info-table td {
            padding: 12px 15px;
            text-align: left;
            border: 1px solid #ddd;
        }

        .info-table th {
            background-color: #008485;
            color: #ffffff;
            font-weight: bold;
        }

        .info-table tr:nth-child(even) {
            background-color: #f3f3f3; /* 짝수 행 배경색 변경으로 가독성 향상 */
        }

        .info-table tr:hover {
            background-color: #f1f1f1; /* 마우스를 올렸을 때의 강조 효과 */
        }

        .preferential-rate {
            font-size: 1rem;
            margin: 20px 0;
            color: #444;
        }

    </style>
    <style>
        #selectFriendButton,
        #cancelFriendSelectionButton,
        #giftByContactButton {
            border: 1px solid #008485 !important;
            background-color: white !important;
            color : #008485 !important;
            margin-left : 2% !important;
            margin-right : 0 !important;
            flex : 1;
        }

        #selectFriendButton,
        #cancelFriendSelectionButton {
            width: 40% !important;
        }
        #giftByContactButton {
            width : 54% !important;
        }
        #leftBox {
            border: 1px solid #dddddd !important;
            border-radius: 10px;
        }
        #submitButton {
            margin-top: 20px;
            width: 70%;
            height: 40px;
            border-radius: 40px;
            background-color: #008485 !important;
            color : white !important;
        }


        .custom-input-container {
            position: relative;
            display: flex;
            align-items: center;
            border: 1px solid #ccc; /* 테두리 추가 */
            border-radius: 4px; /* 모서리 둥글게 */
            padding: 10px; /* 내부 여백 추가 */
        }

        .custom-input {
            width: 100%;
            /*padding: 5px 50px 10px 15px; !* Padding을 조정하여 오른쪽에 여백을 확보 *!*/
            padding-right: 30px;
            border: none; /* 추가적인 테두리 제거 */
            outline: none; /* 선택 시 기본 테두리 제거 */
            font-size: 16px;
            color: #333;
            background-color: transparent; /* 배경 투명으로 설정 */
            text-align: right;
        }

        .custom-input::placeholder {
            color: #aaa; /* Placeholder 색상 변경 */
        }

        .currency-label {
            position: absolute;
            right: 15px; /* 오른쪽에 위치 */
            font-size: 16px;
            color: #333;
        }

        .accordion-content {
            font-family: "HanaFont-Light", sans-serif;
            font-size: 16px;
            line-height: 1.6;
            color: #333;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .accordion-content p {
            margin-bottom: 15px;
        }

        .accordion-content h4 {
            font-size: 1.2rem;
            color: #009778;
            margin-top: 20px;
            margin-bottom: 10px;
        }

        .gift-instructions ol,
        .receive-instructions ol {
            list-style-type: decimal;
            margin-left: 20px;
            margin-bottom: 15px;
        }

        .gift-instructions .note {
            color: #d9534f; /* 경고 메시지를 강조하기 위해 빨간색 사용 */
            font-size: 0.9rem;
            margin-top: 10px;
        }
        .product-info-section {
            text-align: center;
            background-color: #f9f9f9;  /* 배경색을 연하게 설정하여 구분 */
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin: 20px auto;
            max-width: 600px;
            font-family: Arial, sans-serif;
        }

        .product-info-title {
            font-size: 1.25rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }

        .product-info-desc {
            font-size: 1rem;
            color: #666;
            margin-bottom: 20px;
        }

        .product-info-box {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: #ffffff;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 10px 15px;
            max-width: 500px;
            margin: 0 auto;
        }

        .product-name {
            font-size: 1rem;
            font-weight: bold;
            color: #333;
        }

        .view-guide-btn {
            text-decoration: none;
            color: #ffffff;
            background-color: #009778;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .view-guide-btn:hover {
            background-color: #007f65;
            transform: translateY(-2px);
        }

    </style>
    <!--===============================================================================================-->
</head>
<body class="animsition">
<!-- Header -->
<jsp:include page="component/header.jsp" flush="false"/>
<!-- Cart -->
<jsp:include page="component/friend_tap.jsp" flush="false"/>

<!-- breadcrumb -->
<section class="bg0 p-t-100 p-b-60">
    <div class="container">
        <div class="bread-crumb flex-w p-r-15 p-t-30 p-lr-0-lg">
            <a href="#" class="stext-109 cl8 hov-cl1 trans-04">
                Home
                <i
                        class="fa fa-angle-right m-l-9 m-r-10"
                        aria-hidden="true"
                ></i>
            </a>

            <a href="#" class="stext-109 cl8 hov-cl1 trans-04">
                적금 선물하기
                <i
                        class="fa fa-angle-right m-l-9 m-r-10"
                        aria-hidden="true"
                ></i>
            </a>

            <span class="stext-109 cl4"> ${savingProduct.productName} </span>
        </div>
    </div>
</section>
<!-- Product Detail -->
<section class="sec-product-detail bg0 p-b-60">
    <div class="container">
        <div class="row">
            <!-- 이미지 부분 -->
            <div class="col-md-6 col-lg-7 p-b-30">
                <div class="p-l-30 p-r-30 p-t-40 p-b-25 p-lr-15-lg" id="leftBox">
                    <h4 class="mtext-105 cl2 js-name-detail p-b-14">
                        ${savingProduct.productName}
                    </h4>

                    <span class="mtext-106 cl2">
                                기본 금리: ${savingProduct.basicInterestRate}%
                            </span>

                    <p class="stext-102 cl3 p-t-23">
                        ${savingProduct.shortDescription}
                    </p>
                    <div class="summary-container p-t-20">
                        <div class="icon-container">
                            <div class="icon-item">
                                <img
                                        src="${pageContext.request.contextPath}/resources/images/saving-feature.png"
                                        alt="Icon 1"
                                />
                                <p>특징</p>
                                <span
                                >기간도 금액도 <br />자유롭게</span
                                >
                            </div>
                            <div class="icon-item">
                                <img
                                        src="${pageContext.request.contextPath}/resources/images/saving-duration.png"
                                        alt="Icon 2"
                                />
                                <p>기간</p>
                                <span
                                >${productDetails.minDuration}개월 ~ ${productDetails.maxDuration}개월<br />(월 ,일단위
                                            지정)</span
                                >
                            </div>
                            <div class="icon-item">
                                <img
                                        src="${pageContext.request.contextPath}/resources/images/saving-deposit.png"
                                        alt="Icon 3"
                                />
                                <p>가입금액(원단위)</p>
                                <span>${productDetails.depositLimit}</span>
                            </div>
                            <div class="icon-item">
                                <img
                                        src="${pageContext.request.contextPath}/resources/images/saving-preferentialInterestRate.png"
                                        alt="Icon 4"
                                />
                                <p>우대금리</p>
                                <span>최대 연 ${productDetails.preferentialRate}%</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-lg-5 p-b-30">
                <div class="p-r-50 p-t-5 p-lr-0-lg">

                    <form action="${pageContext.request.contextPath}/sendGift" method="post" id="giftForm">
                        <!--  -->
                        <div class="p-t-33">
                            <div class="flex-w flex-r-m p-b-10">
                                <div class="w-100 flex-l-m font-light p-b-2">
                                    출금 계좌
                                </div>

                                <div class="w-100">
                                    <div class="rs1-select2 bor8 bg0">
                                        <select
                                                class="js-select2"
                                                name="account"
                                        >
                                            <option>계좌 선택</option>
                                            <option>
                                                ${accounts.accountName} ${accounts.accountNumber}
                                            </option>
                                        </select>
                                        <div class="dropDownSelect2"></div>
                                    </div>
                                </div>
                            </div>

                            <div class="flex-w flex-r-m p-b-10">
                                <div class="w-100 flex-l-m font-light p-b-2">
                                    금액
                                </div>

                                <div class="w-100">
                                    <div class="custom-input-container">
                                        <input
                                                type="text"
                                                class="custom-input js-amount-input"
                                                name="amount"
                                                placeholder="금액 입력"
                                        />
                                        <span class="currency-label">원</span>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" name="recipientName" id="hiddenRecipientName" />
                            <input type="hidden" name="recipientPhone" id="hiddenRecipientPhone" />
                            <input type="hidden" name="selectedFriendId" id="hiddenSelectedFriendId" />
                            <input type="hidden" name="selectedFriendName" id="hiddenSelectedFriendName" />
                            <input type="hidden" name="bankCode" value="${accounts.bankCode}">
                            <!-- 보내는 상품 정보 -->
                            <input type="hidden" name="productId" value="${savingProduct.productId}" />
                            <input type="hidden" name="productType" value="${savingProduct.productType}" />
                            <!-- Color 선택 밑에 친구 선택 추가 -->

                            <div class="flex-w flex-r-m p-b-10">
                                <div class="w-100 flex-l-m font-light p-b-2">
                                    친구
                                </div>

                                <div
                                        class="w-100"
                                        id="friendSelectionContainer"
                                >
                                    <button
                                            data-toggle="modal"
                                            data-target="#friendModal"
                                            id="selectFriendButton"
                                            type="button"
                                            class="selectButton"
                                    >
                                        친구 선택
                                    </button>
                                    <button id="giftByContactButton" type="button" class="selectButton">
                                        연락처로 선물하기
                                    </button>
                                    <div
                                            id="selectedFriendDisplay"
                                            class="selected-friend"
                                            style="display: none"
                                    >
                                        <img
                                                id="selectedFriendAvatar"
                                                src=""
                                                alt="Selected Friend"
                                                class="selected-friend-img"
                                        />
                                        <span
                                                id="selectedFriendName"
                                        ></span>
                                        <button
                                                id="cancelFriendSelectionButton"
                                                type="button"
                                        >
                                            취소
                                        </button>
                                    </div>
                                </div>

                                <!-- 연락처 입력 필드 -->
                            </div>
                            <div
                                    class="flex-w flex-r-m p-b-10"
                                    id="contactInputFields"
                                    style="display: none"
                            >
                                <div class="size-204 respon6-next">
                                    <div class="rs1-select2 bg0">
                                        <input
                                                type="text"
                                                id="recipientName"
                                                name="recipientName"
                                                class="form-control"
                                                placeholder="이름(실명) 입력"
                                        />
                                        <input
                                                type="text"
                                                id="recipientPhone"
                                                name="recipientPhone"
                                                class="form-control"
                                                placeholder="전화번호 입력"
                                        />
                                    </div>
                                    <button
                                            id="cancelContactInputButton"
                                            class="btn btn-secondary mt-2"
                                    >
                                        취소
                                    </button>
                                </div>
                            </div>
                            <!-- Modal -->

                            <jsp:include page="modal/select_friend.jsp" flush="false"/>
                            <div class="flex-w flex-r-m p-b-10">
                                <div
                                        class="flex-w flex-m w-100 flex-c-m"
                                >
                                    <button
                                            type="button" id="submitButton" class="flex-c-m stext-101 hov-btn1 trans-04 js-addcart-detail"
                                    >
                                        선물하기
                                    </button>

                                </div>
                            </div>
                        </div>

                        <!--  -->
                        <div class="flex-w flex-c-m p-t-15 respon7">
                            <div class="flex-m bor9 p-r-10 m-r-11">
                                <a
                                        href="#"
                                        class="fs-14 cl3 hov-cl1 trans-04 lh-10 p-lr-5 p-tb-2 js-addwish-detail tooltip100"
                                        data-tooltip="Add to Wishlist"
                                >
                                    <i class="zmdi zmdi-favorite"></i>
                                </a>
                            </div>

                            <a
                                    href="#"
                                    class="fs-14 cl3 hov-cl1 trans-04 lh-10 p-lr-5 p-tb-2 m-r-8 tooltip100"
                                    data-tooltip="Facebook"
                            >
                                <i class="fa fa-facebook"></i>
                            </a>

                            <a
                                    href="#"
                                    class="fs-14 cl3 hov-cl1 trans-04 lh-10 p-lr-5 p-tb-2 m-r-8 tooltip100"
                                    data-tooltip="Twitter"
                            >
                                <i class="fa fa-twitter"></i>
                            </a>

                            <a
                                    href="#"
                                    class="fs-14 cl3 hov-cl1 trans-04 lh-10 p-lr-5 p-tb-2 m-r-8 tooltip100"
                                    data-tooltip="Google Plus"
                            >
                                <i class="fa fa-google-plus"></i>
                            </a>
                        </div>
                    </form>
                </div>

            </div>
        </div>

        <div class="bor10 m-t-50 p-t-43 p-b-40">
            <!-- Tab01 -->
            <div class="tab01">
                <!-- Nav tabs -->
                <ul class="nav nav-tabs" role="tablist">
                    <li class="nav-item p-b-10">
                        <a
                                class="nav-link active"
                                data-toggle="tab"
                                href="#description"
                                role="tab"
                        >상품 설명</a
                        >
                    </li>

                    <li class="nav-item p-b-10">
                        <a
                                class="nav-link"
                                data-toggle="tab"
                                href="#information"
                                role="tab"
                        >부가 정보(상담)</a
                        >
                    </li>

                    <li class="nav-item p-b-10">
                        <a
                                class="nav-link"
                                data-toggle="tab"
                                href="#reviews"
                                role="tab"
                        >사용자 리뷰</a
                        >
                    </li>
                </ul>

                <!-- Tab panes -->
                <div class="tab-content p-t-43">
                    <!-- - -->
                    <div
                            class="tab-pane fade show active"
                            id="description"
                            role="tabpanel"
                    >
                        <div class="how-pos2 p-lr-15-md">
                            <div class="description">
                                <div class="accordion">
                                    <div class="accordion-item">
                                        <div class="accordion-header">
                                            선물하기, 선물받기
                                            <img
                                                    src="${pageContext.request.contextPath}/resources/images/icons/down.png"
                                                    alt="Down"
                                                    class="toggle-icon"
                                            />
                                        </div>
                                        <div class="accordion-content">
                                            <p><strong>상품유형:</strong> ${savingProduct.productType}</p>
                                            <p><strong>가입 대상:</strong> 실명의 개인(1인 3계좌)</p>
                                            <p><strong>저축 방법:</strong> 자유 적립식</p>

                                            <div class="gift-instructions">
                                                <h4>선물하는 방법</h4>
                                                <ol>
                                                    <li>1. 받는 사람의 이름과 연락처를 입력하거나, 친구맺기를 한 친구를 선택하세요!</li>
                                                    <li>2. 선물 금액을 입력하세요.</li>
                                                    <li>3. 선물을 보내면, 문자로 선물 받는 사람에게 알림이 가요!</li>
                                                </ol>
                                                <p class="note">※ 이때 선물 받는 사람의 실명과 전화번호를 정확하게 입력해야 선물을 받을 수 있어요.</p>
                                            </div>

                                            <div class="receive-instructions">
                                                <h4>선물 받는 방법</h4>
                                                <ol>
                                                    <li>1. 하나 Gift에 접속해요.</li>
                                                    <li>2. 선물함에서 선물 받기를 누르면 바로 적금을 가입할 수 있어요.</li>
                                                </ol>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <div class="accordion-header">
                                            저축한도
                                            <img
                                                    src="${pageContext.request.contextPath}/resources/images/icons/down.png"
                                                    alt="Down"
                                                    class="toggle-icon"
                                            />
                                        </div>
                                        <div class="accordion-content">
                                            <strong>저축한도:</strong>
                                            월 최대 500만원
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <div class="accordion-header">
                                            상세설명
                                            <img
                                                    src="${pageContext.request.contextPath}/resources/images/icons/down.png"
                                                    alt="Down"
                                                    class="toggle-icon"
                                            />
                                        </div>
                                        <div class="accordion-content">
                                            <strong>상세설명:</strong>
                                            ${productDetails.detailedDescription}
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <div class="accordion-header">
                                            우대금리
                                            <img
                                                    src="${pageContext.request.contextPath}/resources/images/icons/down.png"
                                                    alt="Down"
                                                    class="toggle-icon"
                                            />
                                        </div>
                                        <div class="accordion-content">
                                            <table class="info-table">
                                                <thead>
                                                <tr>
                                                    <th>가입 기간</th>
                                                    <th>${productDetails.minDuration} ~ ${productDetails.maxDuration} 개월</th>
                                                </tr>
                                                </thead>
                                            </table>

                                            <p class="preferential-rate">
                                                <strong>우대금리:</strong> 조건 충족 시 최대 연 ${productDetails.preferentialRate}% 추가 금리 혜택
                                            </p>

                                            <table class="info-table">
                                                <thead>
                                                <tr>
                                                    <th>조건</th>
                                                    <th>우대 금리</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <!-- 반복적으로 데이터를 출력 -->
                                                <c:forEach var="rate" items="${interestRate}">
                                                    <tr>
                                                        <td>${rate.conditionName}</td>
                                                        <td>연 ${rate.preferentialInterestRate}%</td>
                                                    </tr>
                                                </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>

                                    </div>
                                    <c:if test="${not empty productDetails.pdfLink}">
                                        <div class="accordion-item">
                                            <div class="accordion-header">
                                                상품 설명서
                                                <img
                                                        src="${pageContext.request.contextPath}/resources/images/icons/down.png"
                                                        alt="Down"
                                                        class="toggle-icon"
                                                />
                                            </div>
                                            <div class="accordion-content">
                                                <h3 class="product-info-title">안전한 상품가입을 위해 상품 설명서를 먼저 확인해 주세요.</h3>
                                                <p class="product-info-desc">상품가입이 완료되면, 계약서와 함께 설명서를 전달드려요.</p>

                                                <div class="product-info-box">
                                                    <span class="product-name">${savingProduct.productName}</span>
                                                    <a href="${pageContext.request.contextPath}${productDetails.pdfLink}" target="_blank" class="view-guide-btn">설명서 보기</a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>

                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 세부 사항 부가 정보 -->
                    <div
                            class="tab-pane fade"
                            id="information"
                            role="tabpanel"
                    >
                        <div class="row">
                            <div
                                    class="col-sm-10 col-md-8 col-lg-6 m-lr-auto"
                            >
                                <ul class="p-lr-28 p-lr-15-sm">
                                    <li class="flex-w flex-t p-b-7">
                                                <span class="stext-102 cl3 size-205">
                                                    선물하기
                                                </span>

                                        <span
                                                class="stext-102 cl6 size-206"
                                        >
                                                    하나금융그룹 금융상품 선물하기
                                                </span>
                                    </li>

                                    <li class="flex-w flex-t p-b-7">
                                                <span
                                                        class="stext-102 cl3 size-205"
                                                >
                                                    상담(문의)
                                                </span>

                                        <span
                                                class="stext-102 cl6 size-206"
                                        >
                                                    02-1234-1234
                                                </span>
                                    </li>

                                    <li class="flex-w flex-t p-b-7">
                                                <span
                                                        class="stext-102 cl3 size-205"
                                                >
                                                    수령자
                                                </span>

                                        <span
                                                class="stext-102 cl6 size-206"
                                        >
                                                    내국인, 국내 거주자만 수령할 수 있어요!
                                                </span>
                                    </li>

                                    <li class="flex-w flex-t p-b-7">
                                                <span
                                                        class="stext-102 cl3 size-205"
                                                >
                                                    증여세
                                                </span>

                                        <span
                                                class="stext-102 cl6 size-206"
                                        >
                                                    일부 금액 이상으로 선물하면 증여세가 있을 수 있어요!
                                                </span>
                                    </li>

                                    <li class="flex-w flex-t p-b-7">
                                                <span
                                                        class="stext-102 cl3 size-205"
                                                >
                                                    궁금한 점
                                                </span>

                                        <span
                                                class="stext-102 cl6 size-206"
                                        >
                                                    궁금한 점은 관리자 또는 'AI 하나다움'에게 질문해주세요!
                                                </span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- 리뷰 영역 -->
                    <jsp:include page="component/review.jsp" flush="false"/>
                    <%-- 리뷰 모달 --%>
                    <jsp:include page="modal/review.jsp" flush="false"/>
                </div>
            </div>
        </div>
    </div>

    <!--하단 -->
    <div class="bg6 flex-c-m flex-w size-302 m-t-73 p-tb-15">


        <span class="stext-107 cl6 p-lr-25">
                    선물의 패러다임을 바꾸다, 하나 Gift
                </span>
    </div>
</section>

<!-- Footer -->
<jsp:include page="component/footer.jsp" flush="false"/>

<!-- Back to top -->
<div class="btn-back-to-top" id="myBtn">
            <span class="symbol-btn-back-to-top">
                <i class="zmdi zmdi-chevron-up"></i>
            </span>
</div>


<!--===============================================================================================-->
<!-- jQuery, Popper.js, Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/endor/bootstrap/js/popper.js"></script>
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
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/daterangepicker/moment.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/slick/slick.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/slick-custom.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/parallax100/parallax100.js"></script>
<script>
    $(".parallax100").parallax100();
</script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/MagnificPopup/jquery.magnific-popup.min.js"></script>
<script>
    $(".gallery-lb").each(function () {
        // the containers for all your galleries
        $(this).magnificPopup({
            delegate: "a", // the selector for gallery item
            type: "image",
            gallery: {
                enabled: true,
            },
            mainClass: "mfp-fade",
        });
    });
</script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/isotope/isotope.pkgd.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/sweetalert/sweetalert.min.js"></script>

<%--금액에서 , 붙이기 --%>
<script>
    $(document).ready(function () {
        // 금액 입력 필드에 대한 이벤트 리스너 추가
        $(".js-amount-input").on("input", function (event) {
            var input = $(this).val();

            // 숫자 외의 문자 제거
            input = input.replace(/[^0-9]/g, "");

            // 천 단위마다 콤마 추가
            var formatted = new Intl.NumberFormat().format(input);

            // 다시 입력 필드에 표시
            $(this).val(formatted);

            // 입력값을 정수로 변환하여 500,000 제한 적용
            var numericValue = parseInt(input.replace(/,/g, ""), 10);
            if (numericValue > 500000) {
                alert("50만 원 이하의 금액만 입력할 수 있습니다.");
                $(this).val("");
            }
        });
    });

</script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const recipientPhoneInput = document.getElementById("recipientPhone");

        // 입력할 때마다 전화번호를 자동으로 포맷하는 함수
        recipientPhoneInput.addEventListener("input", function(event) {
            let input = event.target.value;

            // 숫자만 남기기 (숫자 이외의 문자 제거)
            input = input.replace(/\D/g, '');

            // 최대 11자리까지만 허용 (010-0000-0000 형식)
            if (input.length > 11) {
                input = input.slice(0, 11);
            }

            // 전화번호 형식으로 변환 (000-0000-0000)
            if (input.length > 3 && input.length <= 7) {
                input = input.slice(0, 3) + '-' + input.slice(3);
            } else if (input.length > 7) {
                input = input.slice(0, 3) + '-' + input.slice(3, 7) + '-' + input.slice(7);
            }

            // 변환된 값을 입력 필드에 설정
            event.target.value = input;
        });
    });


</script>
<script>
    $(document).ready(function() {
        // 친구 선택 버튼 클릭 시
        $('#selectFriendButton').on('click', function() {
            $('#friendSelectionContainer').show();
            $('#contactInputFields').hide();
        });

        // 연락처로 선물하기 버튼 클릭 시
        $('#giftByContactButton').on('click', function() {
            $('#contactInputFields').show();
            $('#friendSelectionContainer').hide();
        });

        // 친구 선택 취소 버튼 클릭 시
        $('#cancelFriendSelectionButton').on('click', function() {
            $('#selectedFriendDisplay').hide();
            $('#selectedFriendId').val('');
            $('#selectedFriendName').text('');
            $('#selectedFriendAvatar').attr('src', '');
        });

        // 연락처 입력 취소 버튼 클릭 시
        $('#cancelContactInputButton').on('click', function() {
            $('#contactInputFields').hide();
            $('#recipientName').val('');
            $('#recipientPhone').val('');
        });

        // 친구 선택 후 '선택' 버튼 클릭 시
        $('#selectFriendBtn').on('click', function() {
            var selectedFriend = $('.friend-item.selected'); // 선택된 친구 항목
            var friendId = selectedFriend.data('friend-id');
            var friendName = selectedFriend.data('friend-name');

            $('#hiddenSelectedFriendId').val(friendId); // 숨겨진 필드에 설정
            $('#hiddenSelectedFriendName').val(friendName); // 숨겨진 필드에 설정

            $('#selectedFriendDisplay').show();
            $('#selectedFriendName').text(friendName);
            $('#friendModal').modal('hide');
        });
    });
</script>
<script>
    $(".js-addwish-b2, .js-addwish-detail").on("click", function (e) {
        e.preventDefault();
    });

    $(".js-addwish-b2").each(function () {
        var nameProduct = $(this)
            .parent()
            .parent()
            .find(".js-name-b2")
            .html();
        $(this).on("click", function () {
            swal(
                nameProduct,
                "나의 위시리스트에 추가했어요!",
                "success"
            );

            $(this).addClass("js-addedwish-b2");
            $(this).off("click");
        });
    });

    $(".js-addwish-detail").each(function () {
        var nameProduct = $(this)
            .parent()
            .parent()
            .parent()
            .find(".js-name-detail")
            .html();

        $(this).on("click", function () {
            swal(
                nameProduct,
                "나의 위시리스트에 추가했어요!",
                "success"
            );

            $(this).addClass("js-addedwish-detail");
            $(this).off("click");
        });
    });

    /*---------------------------------------------*/

    $(document).ready(function() {
        $(".js-addcart-detail").each(function () {
            var nameProduct = $(this)
                .closest('.p-r-50') // 가장 가까운 부모 요소를 정확히 찾기 위해 수정
                .find(".js-name-detail")
                .html();

            $(this).on("click", function () {
                // 첫 번째 알림창: 비밀번호 입력 요청
                swal({
                    title: "비밀번호 입력",
                    text: "비밀번호를 입력하세요:",
                    content: {
                        element: "input",
                        attributes: {
                            placeholder: "비밀번호 입력",
                            type: "password"
                        },
                    },
                    buttons: {
                        cancel: "취소",
                        confirm: "확인"
                    }
                }).then((password) => {
                    if (password) {
                        // 비밀번호를 입력한 경우, 서버로 비밀번호 전송 및 확인 요청
                        $.ajax({
                            url: '${pageContext.request.contextPath}/checkPassword', // 비밀번호 확인 URL
                            type: 'POST',
                            data: {
                                <%--accountNumber: ${accounts.accountNumber},--%>
                                password: password

                            },
                            success: function(response) {
                                if (response.match) {
                                    // 비밀번호가 일치하면 성공 메시지를 표시하고 폼을 제출
                                    swal({
                                        title: nameProduct,
                                        text: "비밀번호가 확인되었습니다. 선물을 보냈어요!",
                                        icon: "success",
                                        buttons: {
                                            confirm: "확인"
                                        }
                                    }).then(() => {
                                        $('#giftForm').submit(); // 폼 제출
                                    });
                                } else {
                                    // 비밀번호가 일치하지 않으면 에러 메시지 표시
                                    swal("Error", "비밀번호가 일치하지 않습니다.", "error");
                                }
                            },
                            error: function() {
                                // 서버 요청 중 오류가 발생한 경우
                                swal("Error", "서버 오류가 발생했습니다. 다시 시도해주세요.", "error");
                            }
                        });
                    }
                });
            });
        });
    });

</script>
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
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
</body>
</html>
