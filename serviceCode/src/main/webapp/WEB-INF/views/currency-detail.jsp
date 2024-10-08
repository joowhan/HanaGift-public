<%--
  Created by IntelliJ IDEA.
  User: gimjuhwan
  Date: 9/3/24
  Time: 12:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<style>
    .currencyImage {
        width: 70px !important;
        height: 70px !important;
        position: static !important;
        margin-top: 11px;
        margin-right: 15px;
    }
    #exchangeRateChart {
        width: 95% !important;
        height: 300px !important;
    }
    #currency-amount {
        padding: 18px;
        margin-bottom: 0 !important;
        height: calc(1.5em + .75rem + 2px) !important;
        border: none !important;
        border-radius: 2px;
    }
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
    #chargeButton {
        border: 1px solid #008485 !important;
        background-color: white !important;
        color : #008485 !important;
        margin-right : 0 !important;
        flex : 1;
        border-radius: 40px;
        margin-left: 5%;
        font-size: 0.7em;
        width: 100px;
    }
    #submitButton {
        margin-top: 20px;
        width: 70%;
        height: 40px;
        border-radius: 40px;
        background-color: #008485 !important;
        color : white !important;
    }
</style>
<head>
    <title>하나Gift</title>
    <jsp:include page="component/head.jsp" flush="false"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/currency-detail.css" />
    <link
            href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
            rel="stylesheet"
    />
    <!-- jQuery, Popper.js, Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>
</head>
<body>
<jsp:include page="component/header.jsp" flush="false"/>
<jsp:include page="component/friend_tap.jsp" flush="false"/>
<c:if test="${currencyWallet == null || currencyWallet.balance == 0}">
    <script>
        $(document).ready(function() {
            swal({
                title: "보유한 외화가 없어요!",
                text: "외화 충전하기 페이지로 이동하시겠습니까?",
                icon: "warning",
                buttons: ["취소", "외화 충전하기"],
                dangerMode: true,
            }).then((willCharge) => {
                if (willCharge) {
                    window.location.href = "${pageContext.request.contextPath}/charge"; // 외화 충전 페이지 URL
                }
            });
        });
    </script>
</c:if>
<!-- breadcrumb -->
<section class="bg0 p-t-100 p-b-60">
    <div class="container">
        <div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
            <a href="index.html" class="stext-109 cl8 hov-cl1 trans-04">
                Home
                <i
                        class="fa fa-angle-right m-l-9 m-r-10"
                        aria-hidden="true"
                ></i>
            </a>

            <a href="product.html" class="stext-109 cl8 hov-cl1 trans-04">
                외화 선물하기
                <i
                        class="fa fa-angle-right m-l-9 m-r-10"
                        aria-hidden="true"
                ></i>
            </a>

            <span class="stext-109 cl4"> ${product.productName} </span>
        </div>
    </div>
</section>
<!-- Product Detail -->
<section class="sec-product-detail bg0 p-t-65 p-b-60">
    <div class="container">
        <div class="row">
            <!-- 이미지 부분 -->
            <div class="col-md-6 col-lg-7 p-b-30">
                <div class="p-l-30 p-r-30 p-t-40 p-b-25 p-lr-15-lg" id="leftBox">
                    <div class="flex-w">
                        <div>
                            <img
                                    src="${pageContext.request.contextPath}${product.logoImageURL}"
                                    alt="currency img"
                                    class="currencyImage"
                            />
                        </div>
                        <div>
                            <h4 class="mtext-105 cl2 js-name-detail p-b-8">
                                [${product.code}] 선물하기
                            </h4>
                            <p class="stext-102 cl3 p-b-2">
                                환율 100% 우대하는 하나머니로 쉽고 간편하게 외화를 선물하세요!
                            </p>
                        </div>
                    </div>

                    <!-- 그래프 자리 -->
                    <div class="summary-container">
                        <div class="w-100">
                            <div class="w-100">
                                <canvas id="exchangeRateChart" height="300"></canvas>
                                <script type="text/javascript">
                                    // JSP에서 전달된 데이터를 JavaScript로 그대로 전달
                                    const exchangeRatePeriodJson = '${exchangeRatePeriodJson}';  // 서버에서 전달된 JSON 문자열
                                    console.log(exchangeRatePeriodJson);  // 확인용

                                    // JSON 문자열을 JavaScript 객체로 변환
                                    const exchangeRatePeriod = JSON.parse(exchangeRatePeriodJson);

                                    console.log(exchangeRatePeriod); // 변환된 객체 확인

                                    const ctx = document.getElementById("exchangeRateChart").getContext("2d");

                                    const labels = exchangeRatePeriod.map(item => item.exchangeDate); // 날짜 데이터를 라벨로 사용
                                    const exchangeRates = exchangeRatePeriod.map(item => item.exchangeRate); // 종가를 차트 데이터로 사용

                                    // 차트 데이터 설정
                                    const exchangeRateData = {
                                        labels: labels,
                                        datasets: [
                                            {
                                                label: "${product.code} to KRW",
                                                data: exchangeRates,
                                                borderColor: "rgba(00, 84, 85, 1)",
                                                backgroundColor: "rgba(00, 84, 85, 0.2)", // 투명도 적용
                                                fill: true,
                                                tension: 0.1,
                                            },
                                        ],
                                    };

                                    // 차트 설정
                                    const config = {
                                        type: "line",
                                        data: exchangeRateData,
                                        options: {
                                            responsive: true,
                                            plugins: {
                                                legend: {
                                                    position: "top",
                                                },
                                                title: {
                                                    display: true,
                                                    ext: "${product.code} -> KRW 환율 트렌드",
                                                },
                                            },
                                            animation: {
                                                duration: 2000,
                                                easing: "easeInOutQuad",
                                            },
                                            scales: {
                                                x: {
                                                    title: {
                                                        display: true,
                                                        text: "날짜",
                                                    },
                                                    grid: {
                                                        display: false, // 세로선 제거
                                                    },
                                                },
                                                y: {
                                                    title: {
                                                        display: true,
                                                        text: "환율 (KRW)",
                                                    },
                                                    grid: {
                                                        color: "rgba(200, 200, 200, 0.5)", // 가로선 색상 및 투명도
                                                    },
                                                },
                                            },
                                        },
                                    };
                                    // 차트 초기화
                                    new Chart(ctx, config);
                                </script>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <div class="col-md-6 col-lg-5 p-b-30">
                <div class="p-r-50 p-t-5 p-lr-0-lg">
                    <form action="${pageContext.request.contextPath}/sendGift/currency" method="post" id="CurrencyGiftForm">
                        <!--  -->
                        <div class="p-t-33">
                            <div class="flex-w flex-r-m p-b-10">
                                <div class="w-100 flex-l-m font-light p-b-2">
                                    보유 외화
                                    <div>
                                        <a href="${pageContext.request.contextPath}/charge">
                                            <button type="button" id="chargeButton">
                                                <i class="fa fa-plus-circle"></i> 외화 충전하러 가기
                                            </button>
                                        </a>
                                    </div>
                                </div>

                                <div class="w-100">
                                    <div class="rs1-select2 bor8 bg0">
                                        <select
                                                class="js-select2"
                                                name="balance"
                                        >
                                            <option>외화 선택</option>
                                            <option>
                                                보유 ${currencyWallet.currencyCode}: ${currencyWallet.balance}
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
                                    <div class="rs1-select2 bor8 bg0 d-flex align-items-center">
                                        <input type="text" class="form-control js-amount-input" name="amount" id="currency-amount" placeholder="금액 입력"/>
                                        <span class="currency-label m-l-5 m-r-5">${currencyWallet.currencyCode}</span>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" name="recipientName" id="hiddenRecipientName" />
                            <input type="hidden" name="recipientPhone" id="hiddenRecipientPhone" />
                            <input type="hidden" name="selectedFriendId" id="hiddenSelectedFriendId" />
                            <input type="hidden" name="selectedFriendName" id="hiddenSelectedFriendName" />
                            <!-- Color 선택 밑에 친구 선택 추가 -->
                            <input type="hidden" name="productCode" value="${currencyWallet.currencyCode}"/>
                            <input type="hidden" name="productType" value="${product.productType}" />
                            <input type="hidden" name="productId" value="${product.productID}" />
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
                                    <button type="button" id="giftByContactButton" class="selectButton">
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
                                            type="button"
                                    >
                                        취소
                                    </button>
                                </div>
                            </div>
                            <!-- Modal -->
                            <!-- Modal -->
                            <jsp:include page="modal/select_friend.jsp" flush="false"/>

                            <div class="flex-w flex-r-m p-b-10">
                                <div
                                        class="size-204 flex-w flex-m respon6-next"
                                >
                                    <button
                                            type="button" id="submitButton" class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04 js-addcart-detail"
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
                                            선물하기, 선물 받기
                                            <img
                                                    src="${pageContext.request.contextPath}/resources/images/icons/down.png"
                                                    alt="Down"
                                                    class="toggle-icon"
                                            />
                                        </div>
                                        <div class="accordion-content">
                                            <strong>선물하기, 선물 받기</strong><br>
                                            보유한 외화를 친구에게 선물할 수 있어요.<br>
                                            - 이때 외화를 충전한 후 충전한 외화를 친구에게 선물할 수 있어요. 이때 현찰매도율을 적용해요!<br>
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <div class="accordion-header">
                                            제약 사항
                                            <img
                                                    src="${pageContext.request.contextPath}/resources/images/icons/down.png"
                                                    alt="Down"
                                                    class="toggle-icon"
                                            />
                                        </div>
                                        <div class="accordion-content">
                                            <strong>조건: </strong><br>
                                            - 선물하기는 일 통화별 환전 건당 최소 거래 단위 이상 ~ 미화 환산 500 불 상당액 이하 선물이 가능해요!

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
                                            <strong>상세설명:</strong><br>
                                            - 친구에게 선물을 하면 문자로 알림을 보내요.<br>
                                            - 30일 내로 받지 않으면 자동으로 반환됩니다.<br>
                                            - 선물 받는 손님은 하나은행 및 하나Gift 가입 고객으로, 가입되어 있지 않다면 가입 후 선물을 받으실 수 있습니다.
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <div class="accordion-header">
                                            주의 사항
                                            <img
                                                    src="${pageContext.request.contextPath}/resources/images/icons/down.png"
                                                    alt="Down"
                                                    class="toggle-icon"
                                            />
                                        </div>
                                        <div class="accordion-content">
                                            <strong>꼭 확인하세요!</strong>
                                            - 손님은 수령인의 정보를 정확히 입력하여야 하며, 해당 정보를 잘못 입력함으로 인한 문제에 대하여 은
                                            행은 책임을 지지 않습니다.
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- - -->
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

<jsp:include page="component/footer.jsp" flush="false"/>
</body>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
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
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/isotope/isotope.pkgd.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/sweetalert/sweetalert.min.js"></script>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

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
            $('#hiddenSelectedFriendId').val(''); // ID 초기화
            $('#hiddenSelectedFriendName').val(''); // Name 초기화
            $('#selectedFriendName').text('');
            $('#selectedFriendAvatar').attr('src', '');
        });

        // 연락처 입력 취소 버튼 클릭 시
        $('#cancelContactInputButton').on('click', function() {
            $('#contactInputFields').hide();
            $('#hiddenRecipientName').val(''); // 이름 초기화
            $('#hiddenRecipientPhone').val(''); // 전화번호 초기화
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
                            url: '${pageContext.request.contextPath}/checkPassword/currency', // 비밀번호 확인 URL
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
                                        $('#CurrencyGiftForm').submit(); // 폼 제출
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
<script src="${pageContext.request.contextPath}/resources/js/currency-detail.js"></script>
</html>
