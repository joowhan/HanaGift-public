<%--
  Created by IntelliJ IDEA.
  User: gimjuhwan
  Date: 8/19/24
  Time: 5:36 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>

<style>
    /* 카드 컨테이너 스타일 */
    .product-card {
        height: 250px; /* 고정된 카드 높이 */
        background-color: #fff;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        display: flex;
        flex-direction: column;
        justify-content: center;
        text-align: left;
        transition: transform 0.2s;
        overflow: hidden;
    }

    /* 카드 안의 이미지를 중앙에 배치 */
    .product-card img.country-img {
        align-self: center; /* 이미지 중앙 정렬 */
        width: 100px;
        height: auto;
        margin: 10px 0;
    }

    /* 카드 제목 고정 위치 (상단에 배치) */
    .card-title {
        position: absolute;
        top: 45px; /* 카드의 상단에서 40px 아래 */
        left: 20px;
        font-size: 1.2em;
        font-weight: bold;
        color: #333;
        margin: 0;
    }

    .card-description {
        position: absolute;
        top: 155px;
        left: 20px;
        margin-right: 20px;
    }

    /* 카드 hover 효과 */
    .product-card:hover {
        /* transform: translateY(-5px); */
    }

    /* 카드 제목 (상품명) 스타일 */
    .product-card h2 {
        font-size: 1.2em;
        font-weight: bold;
        color: #333;
        margin-bottom: 10px;
    }

    /* 금리와 기간 */
    .product-card .card-interest {
        font-size: 1.5em;
        font-weight: bold;
        color: #333;
        margin-bottom: 10px;
    }

    .product-card .card-duration {
        font-size: 1em;
        color: #666;
        margin-bottom: 10px;
    }

    /* 카드 이미지 스타일 */
    .product-card img {
        width: 50px;
        height: auto;
        margin-top: 20px;
    }

    /* 카드 라벨 (상품 타입) */
    .product-card .label {
        font-size: 0.9em;
        font-weight: bold;
        color: #6c757d;
        border: 1px solid #6c757d;
        border-radius: 12px;
        padding: 5px 10px;
        display: inline-block;
        margin-bottom: 10px;
    }

    /* "자세히 보기" 버튼 스타일 */
    .block2-btn {
        font-size: 1em;
        background-color: #f5f5f5;
        border-radius: 5px;
        padding: 10px;
        color: #333;
        text-align: center;
        text-decoration: none;
        transition: background-color 0.3s ease;
    }

    .block2-btn:hover {
        background-color: #eaeaea;
        text-decoration: none;
        color: #333;
    }

    /*!* 금리 스타일 *!*/
    /*.card-interest-test {*/
    /*    margin-top: 3px;*/
    /*    color: #333;*/
    /*    margin-bottom: 10px;*/
    /*}*/
    /* 금리 (고정된 위치) */
    .card-interest-test {
        position: absolute;
        top: 80px; /* 금리 위치 */
        left: 20px;
        font-size: 1em;
        font-weight: bold;
        color: #333;
    }

    .card-interest h3 {
        font-size: 2em;
        margin: 5px 0;
    }


    /* 칩 스타일 (고정된 위치) */
    .chip-container {
        position: absolute; /* 고정된 위치 */
        top: 15px; /* 카드의 상단에서 15px 아래 */
        left: 15px; /* 카드의 좌측에서 10px 오른쪽 */
        margin-bottom: 10px;
    }

    .chip {
        display: inline-block;
        padding: 2px 8px;
        font-size: 0.7em;
        font-weight: bold;
        color: white;
        background-color: #f5b041; /* 기본 배경색 (입출금 등) */
        border-radius: 12px;
    }

    /* 칩 색상 변경 (상품 유형별로 색상 변경) */
    .chip.savings {
        background-color: #3498db; /* 적금 */
    }

    .chip.deposit {
        background-color: #1abc9c; /* 입출금 */
    }

    .chip.stock {
        background-color: #e74c3c; /* 주식 */
    }

    .chip.foreigncurrency {
        background-color: #9b59b6; /* 외화 */
    }

    .chip.insurance {
        background-color: #f39c12; /* 보험 */
    }

    .chip.funds {
        background-color: #2ecc71; /* 펀드 */
    }

    .chip.etc {
        background-color: #3F3F3F; /* 기타 */
    }

</style>

<head>
    <title>Title</title>
</head>
<body>
<section class="bg0 p-t-23 p-b-140">
    <div class="container">
        <div class="p-b-10">
            <h3 class="ltext-103 cl5">선물 고르기</h3>
        </div>

        <div class="flex-w flex-sb-m p-b-52">
            <div class="flex-w flex-l-m filter-tope-group m-tb-10">
                <button
                        class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5 ${selectedProductType == 'all' ? 'how-active1' : ''}"
                        data-filter="*"
                >
                    모든 상품
                </button>

                <button
                        class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5 ${selectedProductType == 'savings' ? 'how-active1' : ''}"
                        data-filter=".savings"
                >
                    적금
                </button>

                <button
                        class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5 ${selectedProductType == 'stock' ? 'how-active1' : ''}"
                        data-filter=".stock"
                >
                    소수점 주식
                </button>
                <button
                        class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5 ${selectedProductType == 'foreigncurrency' ? 'how-active1' : ''}"
                        data-filter=".foreigncurrency"
                >
                    외화
                </button>

                <button
                        class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5 ${selectedProductType == 'insurance' ? 'how-active1' : ''}"
                        data-filter=".insurance"
                >
                    보험
                </button>

                <button
                        class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5 ${selectedProductType == 'funds' ? 'how-active1' : ''}"
                        data-filter=".funds"
                >
                    펀드
                </button>
            </div>

            <div class="flex-w flex-c-m m-tb-10">
                <div
                        class="flex-c-m stext-106 cl6 size-104 bor4 pointer hov-btn3 trans-04 m-r-8 m-tb-4 js-show-filter"
                >
                    <i
                            class="icon-filter cl2 m-r-6 fs-15 trans-04 zmdi zmdi-filter-list"
                    ></i>
                    <i
                            class="icon-close-filter cl2 m-r-6 fs-15 trans-04 zmdi zmdi-close dis-none"
                    ></i>
                    Filter
                </div>

                <div
                        class="flex-c-m stext-106 cl6 size-105 bor4 pointer hov-btn3 trans-04 m-tb-4 js-show-search"
                >
                    <i
                            class="icon-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-search"
                    ></i>
                    <i
                            class="icon-close-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-close dis-none"
                    ></i>
                    Search
                </div>
            </div>

            <!-- Search product -->
            <div class="dis-none panel-search w-full p-t-10 p-b-15">
                <div class="bor8 dis-flex p-l-15">
                    <button
                            class="size-113 flex-c-m fs-16 cl2 hov-cl1 trans-04"
                    >
                        <i class="zmdi zmdi-search"></i>
                    </button>

                    <input
                            class="mtext-107 cl2 size-114 plh2 p-r-15"
                            type="text"
                            name="search-product"
                            placeholder="Search"
                    />
                </div>
            </div>

            <!-- Filter -->
<%--            <div class="dis-none panel-filter w-full p-t-10">--%>
<%--                <div--%>
<%--                        class="wrap-filter flex-w bg6 w-full p-lr-40 p-t-27 p-lr-15-sm"--%>
<%--                >--%>
<%--                    <div class="filter-col1 p-r-15 p-b-27">--%>
<%--                        <div class="mtext-102 cl2 p-b-15">Sort By</div>--%>

<%--                        <ul>--%>
<%--                            <li class="p-b-6">--%>
<%--                                <a--%>
<%--                                        href="#"--%>
<%--                                        class="filter-link stext-106 trans-04"--%>
<%--                                >--%>
<%--                                    Default--%>
<%--                                </a>--%>
<%--                            </li>--%>

<%--                            <li class="p-b-6">--%>
<%--                                <a--%>
<%--                                        href="#"--%>
<%--                                        class="filter-link stext-106 trans-04"--%>
<%--                                >--%>
<%--                                    Popularity--%>
<%--                                </a>--%>
<%--                            </li>--%>

<%--                            <li class="p-b-6">--%>
<%--                                <a--%>
<%--                                        href="#"--%>
<%--                                        class="filter-link stext-106 trans-04"--%>
<%--                                >--%>
<%--                                    Average rating--%>
<%--                                </a>--%>
<%--                            </li>--%>

<%--                            <li class="p-b-6">--%>
<%--                                <a--%>
<%--                                        href="#"--%>
<%--                                        class="filter-link stext-106 trans-04 filter-link-active"--%>
<%--                                >--%>
<%--                                    Newness--%>
<%--                                </a>--%>
<%--                            </li>--%>

<%--                            <li class="p-b-6">--%>
<%--                                <a--%>
<%--                                        href="#"--%>
<%--                                        class="filter-link stext-106 trans-04"--%>
<%--                                >--%>
<%--                                    Price: Low to High--%>
<%--                                </a>--%>
<%--                            </li>--%>

<%--                            <li class="p-b-6">--%>
<%--                                <a--%>
<%--                                        href="#"--%>
<%--                                        class="filter-link stext-106 trans-04"--%>
<%--                                >--%>
<%--                                    Price: High to Low--%>
<%--                                </a>--%>
<%--                            </li>--%>
<%--                        </ul>--%>
<%--                    </div>--%>

<%--                    <div class="filter-col2 p-r-15 p-b-27">--%>
<%--                        <div class="mtext-102 cl2 p-b-15">Price</div>--%>

<%--                        <ul>--%>
<%--                            <li class="p-b-6">--%>
<%--                                <a--%>
<%--                                        href="#"--%>
<%--                                        class="filter-link stext-106 trans-04 filter-link-active"--%>
<%--                                >--%>
<%--                                    All--%>
<%--                                </a>--%>
<%--                            </li>--%>

<%--                            <li class="p-b-6">--%>
<%--                                <a--%>
<%--                                        href="#"--%>
<%--                                        class="filter-link stext-106 trans-04"--%>
<%--                                >--%>
<%--                                    $0.00 - $50.00--%>
<%--                                </a>--%>
<%--                            </li>--%>

<%--                            <li class="p-b-6">--%>
<%--                                <a--%>
<%--                                        href="#"--%>
<%--                                        class="filter-link stext-106 trans-04"--%>
<%--                                >--%>
<%--                                    $50.00 - $100.00--%>
<%--                                </a>--%>
<%--                            </li>--%>

<%--                            <li class="p-b-6">--%>
<%--                                <a--%>
<%--                                        href="#"--%>
<%--                                        class="filter-link stext-106 trans-04"--%>
<%--                                >--%>
<%--                                    $100.00 - $150.00--%>
<%--                                </a>--%>
<%--                            </li>--%>

<%--                            <li class="p-b-6">--%>
<%--                                <a--%>
<%--                                        href="#"--%>
<%--                                        class="filter-link stext-106 trans-04"--%>
<%--                                >--%>
<%--                                    $150.00 - $200.00--%>
<%--                                </a>--%>
<%--                            </li>--%>

<%--                            <li class="p-b-6">--%>
<%--                                <a--%>
<%--                                        href="#"--%>
<%--                                        class="filter-link stext-106 trans-04"--%>
<%--                                >--%>
<%--                                    $200.00+--%>
<%--                                </a>--%>
<%--                            </li>--%>
<%--                        </ul>--%>
<%--                    </div>--%>

<%--                    <div class="filter-col3 p-r-15 p-b-27">--%>
<%--                        <div class="mtext-102 cl2 p-b-15">Color</div>--%>

<%--                        <ul>--%>
<%--                            <li class="p-b-6">--%>
<%--                                        <span--%>
<%--                                                class="fs-15 lh-12 m-r-6"--%>
<%--                                                style="color: #222"--%>
<%--                                        >--%>
<%--                                            <i class="zmdi zmdi-circle"></i>--%>
<%--                                        </span>--%>

<%--                                <a--%>
<%--                                        href="#"--%>
<%--                                        class="filter-link stext-106 trans-04"--%>
<%--                                >--%>
<%--                                    Black--%>
<%--                                </a>--%>
<%--                            </li>--%>

<%--                            <li class="p-b-6">--%>
<%--                                        <span--%>
<%--                                                class="fs-15 lh-12 m-r-6"--%>
<%--                                                style="color: #4272d7"--%>
<%--                                        >--%>
<%--                                            <i class="zmdi zmdi-circle"></i>--%>
<%--                                        </span>--%>

<%--                                <a--%>
<%--                                        href="#"--%>
<%--                                        class="filter-link stext-106 trans-04 filter-link-active"--%>
<%--                                >--%>
<%--                                    Blue--%>
<%--                                </a>--%>
<%--                            </li>--%>

<%--                            <li class="p-b-6">--%>
<%--                                        <span--%>
<%--                                                class="fs-15 lh-12 m-r-6"--%>
<%--                                                style="color: #b3b3b3"--%>
<%--                                        >--%>
<%--                                            <i class="zmdi zmdi-circle"></i>--%>
<%--                                        </span>--%>

<%--                                <a--%>
<%--                                        href="#"--%>
<%--                                        class="filter-link stext-106 trans-04"--%>
<%--                                >--%>
<%--                                    Grey--%>
<%--                                </a>--%>
<%--                            </li>--%>

<%--                            <li class="p-b-6">--%>
<%--                                        <span--%>
<%--                                                class="fs-15 lh-12 m-r-6"--%>
<%--                                                style="color: #00ad5f"--%>
<%--                                        >--%>
<%--                                            <i class="zmdi zmdi-circle"></i>--%>
<%--                                        </span>--%>

<%--                                <a--%>
<%--                                        href="#"--%>
<%--                                        class="filter-link stext-106 trans-04"--%>
<%--                                >--%>
<%--                                    Green--%>
<%--                                </a>--%>
<%--                            </li>--%>

<%--                            <li class="p-b-6">--%>
<%--                                        <span--%>
<%--                                                class="fs-15 lh-12 m-r-6"--%>
<%--                                                style="color: #fa4251"--%>
<%--                                        >--%>
<%--                                            <i class="zmdi zmdi-circle"></i>--%>
<%--                                        </span>--%>

<%--                                <a--%>
<%--                                        href="#"--%>
<%--                                        class="filter-link stext-106 trans-04"--%>
<%--                                >--%>
<%--                                    Red--%>
<%--                                </a>--%>
<%--                            </li>--%>

<%--                            <li class="p-b-6">--%>
<%--                                        <span--%>
<%--                                                class="fs-15 lh-12 m-r-6"--%>
<%--                                                style="color: #aaa"--%>
<%--                                        >--%>
<%--                                            <i class="zmdi zmdi-circle-o"></i>--%>
<%--                                        </span>--%>

<%--                                <a--%>
<%--                                        href="#"--%>
<%--                                        class="filter-link stext-106 trans-04"--%>
<%--                                >--%>
<%--                                    White--%>
<%--                                </a>--%>
<%--                            </li>--%>
<%--                        </ul>--%>
<%--                    </div>--%>

<%--                    <div class="filter-col4 p-b-27">--%>
<%--                        <div class="mtext-102 cl2 p-b-15">Tags</div>--%>

<%--                        <div class="flex-w p-t-4 m-r--5">--%>
<%--                            <a--%>
<%--                                    href="#"--%>
<%--                                    class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5"--%>
<%--                            >--%>
<%--                                Fashion--%>
<%--                            </a>--%>

<%--                            <a--%>
<%--                                    href="#"--%>
<%--                                    class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5"--%>
<%--                            >--%>
<%--                                Lifestyle--%>
<%--                            </a>--%>

<%--                            <a--%>
<%--                                    href="#"--%>
<%--                                    class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5"--%>
<%--                            >--%>
<%--                                Denim--%>
<%--                            </a>--%>

<%--                            <a--%>
<%--                                    href="#"--%>
<%--                                    class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5"--%>
<%--                            >--%>
<%--                                Streetstyle--%>
<%--                            </a>--%>

<%--                            <a--%>
<%--                                    href="#"--%>
<%--                                    class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5"--%>
<%--                            >--%>
<%--                                Crafts--%>
<%--                            </a>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
        </div>

        <div class="row isotope-grid">
            <c:forEach var="savingProduct" items="${savingProducts}">
                <div class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item savings">
                    <div class="block2">
                        <div class="block2-pic hov-img0">
                            <div class="product-card">
                                <div class="chip-container">
                                    <span class="chip savings">적금</span>
                                </div>
                                <h2 class="card-title">${savingProduct.productName}</h2>
                                <!-- 금리 -->
                                <div class="card-interest-test">
                                    <span>금리(연)</span>
                                    <h3>${savingProduct.basicInterestRate}%</h3>
                                </div>
                                <p class="card-description">
                                        ${savingProduct.shortDescription}
                                </p>
                            </div>
                            <a href="/savings-detail?productId=${savingProduct.productId}" data-product-id="${savingProduct.productId}"
                               class="block2-btn flex-c-m stext-103 cl2 size-102 bg0 bor2 hov-btn1 p-lr-15 trans-04">
                                자세히 보기
                            </a>
                        </div>

                        <div class="block2-txt flex-w flex-t p-t-14">
                            <div class="block2-txt-child1 flex-col-l">
                                <a href="/savings-detail?productId=${savingProduct.productId}"
                                   class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
                                        ${savingProduct.productName}
                                </a>
                                <span class="stext-105 cl3">
                                    금리 ${savingProduct.basicInterestRate}%
                                </span>
                            </div>
                            <div class="block2-txt-child2 flex-r p-t-3">
                                <a href="#" class="btn-addwish-b2 dis-block pos-relative js-addwish-b2">
                                    <img class="icon-heart1 dis-block trans-04"
                                         src="${pageContext.request.contextPath}/resources/images/icons/icon-heart-01.png"
                                         alt="ICON"/>
                                    <img class="icon-heart2 dis-block trans-04 ab-t-l"
                                         src="${pageContext.request.contextPath}/resources/images/icons/icon-heart-02.png"
                                         alt="ICON"/>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>


            <c:forEach var="product" items="${products}">
                <!-- 기존 방식과 동일한 레이아웃 유지 -->
                <div class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item ${product.productType.toLowerCase()}">
                    <div class="block2">
                        <div class="block2-pic hov-img0">
                            <div class="product-card">
                                <div class="chip-container">
                                    <!-- <span class="chip ${product.productType.toLowerCase()}">${product.productType}</span> -->
                                    <c:choose>
                                        <c:when test="${product.productType eq 'Stock'}">
                                            <span class="chip ${product.productType.toLowerCase()}">주식</span>
                                        </c:when>
                                        <c:when test="${product.productType eq 'ForeignCurrency'}">
                                            <span class="chip ${product.productType.toLowerCase()}">외화</span>
                                        </c:when>
                                        <c:when test="${product.productType eq 'Insurance'}">
                                            <span class="chip ${product.productType.toLowerCase()}">보험</span>
                                        </c:when>
                                        <c:when test="${product.productType eq 'Fund'}">
                                            <span class="chip ${product.productType.toLowerCase()}">펀드</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="chip etc">기타</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <img src="${pageContext.request.contextPath}${product.logoImageURL}" alt="IMG-PRODUCT" class="country-img" />
                            </div>
                            <c:choose>
                                <c:when test="${product.productType == 'Stock'}">
                                    <a href="${pageContext.request.contextPath}/stocks-details?productId=${product.productID}" class="block2-btn flex-c-m stext-103 cl2 size-102 bg0 bor2 hov-btn1 p-lr-15 trans-04">
                                        바로 가기
                                    </a>
                                </c:when>
                                <c:when test="${product.productType == 'ForeignCurrency'}">
                                    <a href="${pageContext.request.contextPath}/currency-details?productCode=${product.code}&productId=${product.productID}" class="block2-btn flex-c-m stext-103 cl2 size-102 bg0 bor2 hov-btn1 p-lr-15 trans-04">
                                        바로 가기
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="#" class="block2-btn flex-c-m stext-103 cl2 size-102 bg0 bor2 hov-btn1 p-lr-15 trans-04">
                                        바로 가기
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="block2-txt flex-w flex-t p-t-14">
                            <div class="block2-txt-child1 flex-col-l">
                                <a href="#" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
                                        ${product.productName}
                                </a>
                                <span class="stext-105 cl3">
                                        ${product.productType}
                                </span>
                            </div>
                            <div class="block2-txt-child2 flex-r p-t-3">
                                <a href="#" class="btn-addwish-b2 dis-block pos-relative js-addwish-b2">
                                    <img class="icon-heart1 dis-block trans-04" src="${pageContext.request.contextPath}/resources/images/icons/icon-heart-01.png" alt="ICON" />
                                    <img class="icon-heart2 dis-block trans-04 ab-t-l" src="${pageContext.request.contextPath}/resources/images/icons/icon-heart-02.png" alt="ICON" />
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>


        </div>

        <!-- Load more -->
        <div class="flex-c-m flex-w w-full p-t-45">
            <a
                    href="#"
                    class="flex-c-m stext-101 cl5 size-103 bg2 bor1 hov-btn1 p-lr-15 trans-04"
            >
                Load More
            </a>
        </div>
    </div>
</section>
</body>
</html>