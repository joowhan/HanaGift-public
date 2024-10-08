<%--
  Created by IntelliJ IDEA.
  User: gimjuhwan
  Date: 8/21/24
  Time: 10:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="component/head.jsp" flush="false"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/util.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/friend.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/gift-box.css" />
</head>
<body>

<!-- Header -->
<jsp:include page="component/header.jsp" flush="false"/>
<!-- Friend tap -->
<%--<jsp:include page="component/friend_tap.jsp" flush="false"/>--%>

<section class="bg0 p-t-75 p-b-120">
    <div class="container">
        <div class="row mt-4 mb-4">
            <div class="col-md-8">
                <div class="gift-header">
                    <img
                            src="${pageContext.request.contextPath}/resources/images/gift.png"
                            alt="선물 아이콘"
                            class="gift-icon"
                    />
                    <div class="text-container">
                        <h3 class="mtext-111 cl14 mb-3">선물함</h3>
                        <p class="stext-113 cl6">
                            내가 받은 선물 확인하기
                        </p>
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
                                id="received-tab"
                                data-toggle="pill"
                                href="#received"
                                role="tab"
                                aria-controls="received"
                                aria-selected="true"
                        >
                            <i class="fa fa-gift mr-2"></i> 받은 선물
                        </a>
                    </li>
                    <li class="nav-item">
                        <a
                                class="nav-link"
                                id="sent-tab"
                                data-toggle="pill"
                                href="#sent"
                                role="tab"
                                aria-controls="sent"
                                aria-selected="false"
                        >
                            <i class="fa fa-paper-plane mr-2"></i> 보낸
                            선물
                        </a>
                    </li>
                </ul>
                <div class="tab-content p-t-30" id="myTabContent">
                    <!-- 받은 선물 목록 -->
                    <!-- 받은 선물 목록 -->
                    <div class="tab-pane fade show active gift-category" id="received" role="tabpanel" aria-labelledby="received-tab">
                        <!-- 필터링 탭 -->
                        <div class="dropdown mb-3">
                            <button class="btn btn-secondary dropdown-toggle" type="button" id="filterDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                전체
                            </button>
                            <div class="dropdown-menu" aria-labelledby="filterDropdown">
                                <a class="dropdown-item active" href="#" data-filter="all">전체</a>
                                <a class="dropdown-item" href="#" data-filter="savings">적금</a>
                                <a class="dropdown-item" href="#" data-filter="stocks">주식</a>
                                <a class="dropdown-item" href="#" data-filter="foreign">외화</a>
                            </div>
                        </div>
                        <!-- 받은 선물 아이템 목록 -->
                        <c:forEach var="gift" items="${receivedGifts}">
                            <c:choose>
                                <c:when test="${gift.productCategory == '적금' || gift.productCategory == '적립식예금'}">
                                    <div class="gift-item all savings">
                                        <img src="${pageContext.request.contextPath}/resources/images/icons/savings.png" alt="적금 아이콘" class="mr-3" />
                                        <div class="gift-details">
                                            <span class="gift-type"><strong>${gift.productCategory}</strong></span>
                                            <span class="gift-info">상품 이름: ${gift.productName}</span>
                                            <span class="gift-info">보낸 사람: ${gift.senderName}</span>
                                            <span class="gift-amount">보낸 금액: ${gift.amount} ${gift.currencyUnit}</span>
                                            <span class="gift-info">날짜: ${gift.date}</span>
                                        </div>
                                        <c:choose>
                                            <c:when test="${gift.status == 'SENT'}">
                                                <button class="btn btn-outline-primary ml-auto js-receive-gift"
                                                        data-gift-id="${gift.giftID}"
                                                        data-product-id="${gift.productID}"
                                                        data-product-name="${gift.productName}"
                                                        data-amount="${gift.amount}"
                                                        data-currency-unit="${gift.currencyUnit}"
                                                        data-sender-id="${gift.senderID}"
                                                        data-product-type="${gift.productCategory}"
                                                        style="z-index: 9999">
                                                    선물 받기
                                                </button>
                                            </c:when>
                                            <c:when test="${gift.status == 'RECEIVED'}">
                                                <span class="badge badge-success ml-auto">선물 받기 완료</span>
                                            </c:when>
                                            <c:when test="${gift.status == 'FAIL'}">
                                                <span class="badge badge-danger ml-auto">만료됨</span>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </c:when>
                                <c:when test="${gift.productCategory == 'Stock'}">
                                    <div class="gift-item all stocks">
                                        <img src="${pageContext.request.contextPath}/resources/images/icons/stocks1.png" alt="주식 아이콘" class="mr-3" />
                                        <div class="gift-details">
                                            <span class="gift-type"><strong>주식</strong></span>
                                            <span class="gift-info">상품 이름: ${gift.productName}</span>
                                            <span class="gift-info">보낸 사람: ${gift.senderName}</span>
                                            <span class="gift-amount">보낸 금액: ${gift.amount} ${gift.currencyUnit}</span>
                                            <span class="gift-info">날짜: ${gift.date}</span>
                                        </div>
                                        <c:choose>
                                            <c:when test="${gift.status == 'SENT'}">
                                                <button class="btn btn-outline-primary ml-auto js-receive-gift"
                                                        data-gift-id="${gift.giftID}"
                                                        data-product-id="${gift.productID}"
                                                        data-product-name="${gift.productName}"
                                                        data-amount="${gift.amount}"
                                                        data-currency-unit="${gift.currencyUnit}"
                                                        data-sender-id="${gift.senderID}"
                                                        data-product-type="${gift.productCategory}"
                                                        style="z-index: 9999">
                                                    선물 받기
                                                </button>
                                            </c:when>
                                            <c:when test="${gift.status == 'RECEIVED'}">
                                                <span class="badge badge-success ml-auto">선물 받기 완료</span>
                                            </c:when>
                                            <c:when test="${gift.status == 'FAIL'}">
                                                <span class="badge badge-danger ml-auto">만료됨</span>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </c:when>
                                <c:when test="${gift.productCategory == 'ForeignCurrency'}">
                                    <div class="gift-item all foreign">
                                        <img src="${pageContext.request.contextPath}/resources/images/icons/f_currency.png" alt="외화 아이콘" class="mr-3" />
                                        <div class="gift-details">
                                            <span class="gift-type"><strong>외화</strong></span>
                                            <span class="gift-info">상품 이름: ${gift.productName}</span>
                                            <span class="gift-info">보낸 사람: ${gift.senderName}</span>
                                            <span class="gift-amount">보낸 금액: ${gift.amount} ${gift.currencyUnit}</span>
                                            <span class="gift-info">날짜: ${gift.date}</span>
                                        </div>
                                        <c:choose>
                                            <c:when test="${gift.status == 'SENT'}">
                                                <button class="btn btn-outline-primary ml-auto js-receive-gift"
                                                        data-gift-id="${gift.giftID}"
                                                        data-product-id="${gift.productID}"
                                                        data-product-name="${gift.productName}"
                                                        data-amount="${gift.amount}"
                                                        data-currency-unit="${gift.currencyUnit}"
                                                        data-sender-id="${gift.senderID}"
                                                        data-product-type="${gift.productCategory}"
                                                        style="z-index: 9999">
                                                    선물 받기
                                                </button>
                                            </c:when>

                                            <c:when test="${gift.status == 'RECEIVED'}">
                                                <span class="badge badge-success ml-auto">선물 받기 완료</span>
                                            </c:when>
                                            <c:when test="${gift.status == 'FAIL'}">
                                                <span class="badge badge-danger ml-auto">만료됨</span>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </div>

                    <!-- 보낸 선물 목록 -->
                    <div class="tab-pane fade gift-category" id="sent" role="tabpanel" aria-labelledby="sent-tab">
                        <!-- 필터링 탭 -->
                        <div class="dropdown mb-3">
                            <button class="btn btn-secondary dropdown-toggle" type="button" id="filterSentDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                전체
                            </button>
                            <div class="dropdown-menu" aria-labelledby="filterSentDropdown">
                                <a class="dropdown-item active" href="#" data-filter="all">전체</a>
                                <a class="dropdown-item" href="#" data-filter="savings">적금</a>
                                <a class="dropdown-item" href="#" data-filter="stocks">주식</a>
                                <a class="dropdown-item" href="#" data-filter="foreign">외화</a>
                            </div>
                        </div>

                        <!-- 보낸 선물 아이템 목록 -->
                        <c:forEach var="gift" items="${sentGifts}">
                            <c:choose>
                                <c:when test="${gift.productCategory == '적금' || gift.productCategory == '적립식예금'}">
                                    <div class="gift-item all savings">
                                        <img src="${pageContext.request.contextPath}/resources/images/icons/savings.png" alt="적금 아이콘" class="mr-3" />
                                        <div class="gift-details">
                                            <span class="gift-type"><strong>${gift.productCategory}</strong></span>
                                            <span class="gift-info">상품 이름: ${gift.productName}</span>
                                            <span class="gift-info">받는 사람: ${gift.receiverName}</span>
                                            <span class="gift-amount">보낸 금액: ${gift.amount} ${gift.currencyUnit}</span>
                                            <span class="gift-info">날짜: ${gift.date}</span>
                                        </div>
                                        <c:choose>
                                            <c:when test="${gift.status == 'SENT'}">
                                                <span class="badge badge-warning ml-auto">받기 대기중</span>
                                            </c:when>
                                            <c:when test="${gift.status == 'RECEIVED'}">
                                                <span class="badge badge-success ml-auto">받기 완료</span>
                                            </c:when>
                                            <c:when test="${gift.status == 'FAIL'}">
                                                <span class="badge badge-danger ml-auto">취소됨</span>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </c:when>
                                <c:when test="${gift.productCategory == 'Stock'}">
                                    <div class="gift-item all stocks">
                                        <img src="${pageContext.request.contextPath}/resources/images/icons/stocks1.png" alt="주식 아이콘" class="mr-3" />
                                        <div class="gift-details">
                                            <span class="gift-type"><strong>주식</strong></span>
                                            <span class="gift-info">상품 이름: ${gift.productName}</span>
                                            <span class="gift-info">받는 사람: ${gift.receiverName}</span>
                                            <span class="gift-amount">보낸 금액: ${gift.amount} ${gift.currencyUnit}</span>
                                            <span class="gift-info">날짜: ${gift.date}</span>
                                        </div>
                                        <c:choose>
                                            <c:when test="${gift.status == 'SENT'}">
                                                <span class="badge badge-warning ml-auto">받기 대기중</span>
                                            </c:when>
                                            <c:when test="${gift.status == 'RECEIVED'}">
                                                <span class="badge badge-success ml-auto">받기 완료</span>
                                            </c:when>
                                            <c:when test="${gift.status == 'FAIL'}">
                                                <span class="badge badge-danger ml-auto">취소됨</span>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </c:when>
                                <c:when test="${gift.productCategory == 'ForeignCurrency'}">
                                    <div class="gift-item all foreign">
                                        <img src="${pageContext.request.contextPath}/resources/images/icons/f_currency.png" alt="외화 아이콘" class="mr-3" />
                                        <div class="gift-details">
                                            <span class="gift-type"><strong>외화</strong></span>
                                            <span class="gift-info">상품 이름: ${gift.productName}</span>
                                            <span class="gift-info">받는 사람: ${gift.receiverName}</span>
                                            <span class="gift-amount">보낸 금액: ${gift.amount} ${gift.currencyUnit}</span>
                                        </div>
                                        <c:choose>
                                            <c:when test="${gift.status == 'SENT'}">
                                                <span class="badge badge-warning ml-auto">받기 대기중</span>
                                            </c:when>
                                            <c:when test="${gift.status == 'RECEIVED'}">
                                                <span class="badge badge-success ml-auto">받기 완료</span>
                                            </c:when>
                                            <c:when test="${gift.status == 'FAIL'}">
                                                <span class="badge badge-danger ml-auto">취소됨</span>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </div>

                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="modal/user_detail.jsp" flush="false"/>
<jsp:include page="modal/delete.jsp" flush="false"/>
<%--footer--%>
<jsp:include page="component/footer.jsp" flush="false"/>

div class="btn-back-to-top" id="myBtn">
<span class="symbol-btn-back-to-top">
                <i class="zmdi zmdi-chevron-up"></i>
            </span>
</div>

<!--===============================================================================================-->
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
<script src="${pageContext.request.contextPath}/resources/vendor/sweetalert/sweetalert.min.js"></script>
<script>
    $(document).ready(function() {
        console.log("ready 함수 실행됨");

        // 클릭 이벤트 바인딩
        $(document).on("click", ".js-receive-gift", function(event) {
            event.preventDefault();  // 기본 동작 막기
            console.log("클릭 이벤트 발생");

            // 데이터를 추출합니다.
            var gift = {
                giftID: $(this).data("gift-id"),
                productID: $(this).data("product-id"),
                amount: $(this).data("amount"),
                currencyUnit: $(this).data("currency-unit"),
                senderID: $(this).data("sender-name"),
                productCategory: $(this).data("product-type"),
                receiverID: $(this).data("receiver-id")  // 필요한 경우 추가
            };
            var productName = $(this).data("product-name");
            console.log("선물 데이터: ", gift);
            var giftMsg="선물을 받았습니다!";
            if(gift.productCategory==='Stock'){
                giftMsg = "선물을 받았습니다! 예상 소수점 주문 수량을 마이페이지에서 확인하세요!";
            }
            // SweetAlert 작동
            swal({
                title: productName,
                text: "선물을 받으시겠어요?",
                icon: "warning",
                buttons: ["취소", "예"],
                dangerMode: true,
            }).then((willReceive) => {
                if (willReceive) {
                    $.ajax({
                        type: "POST",
                        url: `${pageContext.request.contextPath}/receiveGift`,
                        contentType: "application/json",  // 데이터를 JSON 형식으로 보냅니다.
                        data: JSON.stringify(gift),  // JSON 형식으로 변환하여 전송합니다.
                        success: function(response) {
                            if (response.success) {
                                swal("성공!", giftMsg, "success").then(() => {
                                    // 선물 카테고리가 '적립식예금'인 경우 폼을 제출하여 이동
                                    if (gift.productCategory === '적립식예금') {
                                        // 폼을 생성하여 데이터 전송
                                        var form = $('<form></form>');
                                        form.attr('method', 'post');
                                        form.attr('action', `${pageContext.request.contextPath}/savings-subscription`);

                                        // gift 객체의 정보를 폼에 추가
                                        $.each(gift, function(key, value) {
                                            var input = $('<input>').attr({
                                                type: 'hidden',
                                                name: key,
                                                value: value
                                            });
                                            form.append(input);
                                        });

                                        // 폼을 body에 추가하고 제출하여 페이지 전환
                                        $('body').append(form);
                                        form.submit();
                                    } else {
                                        // 적립식 예금이 아닌 경우 페이지 리로드
                                        location.reload();
                                    }
                                });
                            } else {
                                swal("실패!", "선물을 받을 수 없습니다.", "error");
                            }
                        },
                        error: function() {
                            swal("오류!", "서버와의 통신에 실패했습니다.", "error");
                        }
                    });
                }
            });
        });
    });











</script>
<script src="${pageContext.request.contextPath}/resources/js/gift-box.js"></script>
</body>
</html>
