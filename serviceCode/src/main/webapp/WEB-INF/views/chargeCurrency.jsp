<%--
  Created by IntelliJ IDEA.
  User: gimjuhwan
  Date: 8/22/24
  Time: 11:49 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>외화 충전하기</title>
    <jsp:include page="component/head.jsp" flush="false"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/charging.css" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>
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
        /* 드롭다운 버튼 스타일 */
        .custom-dropdown-button {
            border: 1px solid #009778 !important; /* 테두리 색상 */
            font-family: "HanaFont-CM"; /* 폰트 */
            font-size: 16px; /* 글씨 크기 */
            padding: 20px 25px;
            width: 200px; /* 버튼 너비 */
            text-align: left; /* 텍스트를 왼쪽 정렬 */
            display: flex;
            align-items: center;
            background-color: white; /* 배경색 */
            color: #009778;  /* 글자 색 */
        }


        .custom-dropdown-button:hover {
            background-color: #009778; /* hover 시 더 어두운 색상 */
            border-color: #009778;
            color:white;
        }

        .custom-dropdown-menu {
            width: 200px;  /* 드롭다운 너비 */
        }

        .dropdown-item img {
            width: 20px;
            margin-right: 10px;
        }

        .dropdown-item {
            font-family: "HanaFont-CM"; /* 원하는 폰트 설정 */
            font-size: 16px; /* 글씨 크기 설정 */
        }
    </style>
    <!--===============================================================================================-->
    <script src="${pageContext.request.contextPath}/resources/vendor/sweetalert/sweetalert.min.js"></script>
</head>
<body class="animsition">
<!-- Header -->
<jsp:include page="component/header.jsp" flush="false"/>
<!-- Friend tap -->
<jsp:include page="component/friend_tap.jsp" flush="false"/>

<form id="chargeForm" class="bg0 p-t-75 p-b-120" method="POST" action="${pageContext.request.contextPath}/chargeCurrency">
    <div class="container">
        <div class="row mt-4 mb-4">
            <div class="col-md-8">
                <div class="title-header">
                    <img
                            src="${pageContext.request.contextPath}/resources/images/hanamoney2.png"
                            alt="선물 아이콘"
                            class="gift-icon"
                    />
                    <div class="text-container">
                        <h3 class="mtext-111 cl14 mb-3">외화 충전하기</h3>
                        <p class="stext-113 cl6">
                            하나머니 환전지갑 서비스로 쉽게 외화를 충전해보세요!
                        </p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="btn-group">
                    <button type="button" class="btn dropdown-toggle custom-dropdown-button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" id="selected-country">
                        <span id="selected-flag" style="margin-right: 10px;"></span>국가 선택
                    </button>
                    <div class="dropdown-menu custom-dropdown-menu">
                        <c:forEach var="currency" items="${findAllCurrency}">
                            <a class="dropdown-item" href="#"
                               data-value="${currency.code}"
                               data-country-name="${currency.productName}"
                               data-flag-src="${pageContext.request.contextPath}${currency.logoImageURL}">
                                <img src="${pageContext.request.contextPath}${currency.logoImageURL}" alt="${currency.code}" style="width: 20px; margin-right: 10px;" />
                                    ${currency.productName}
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <script>
                // 드롭다운 항목 클릭 시 선택한 국가명과 국기 이미지를 버튼에 반영하고 페이지를 리로드
                document.querySelectorAll('.dropdown-item').forEach(function(item) {
                    item.addEventListener('click', function(e) {
                        e.preventDefault();  // 기본 링크 클릭 동작 방지
                        var countryName = this.getAttribute('data-country-name');
                        var flagSrc = this.getAttribute('data-flag-src');
                        var currencyCode = this.getAttribute('data-value');  // 선택한 외화 코드

                        // 버튼의 내용을 선택한 국가명으로 변경
                        document.getElementById('selected-country').innerHTML = '<img src="' + flagSrc + '" alt="' + countryName + '" style="width: 20px; margin-right: 10px;" />' + countryName;

                        // 페이지를 리로드하면서 선택된 code 파라미터를 GET 방식으로 전송
                        var url = '${pageContext.request.contextPath}/charge?code=' + currencyCode;
                        window.location.href = url;  // 해당 URL로 리다이렉트
                    });
                });
            </script>




        </div>
        <div class="row">
            <!-- 환율 그래프, 외화 계산 영역 -->
            <div class="col-lg-7 col-xl-6 m-b-50">
                <div class="bor10 p-lr-40 p-t-30 p-b-40 p-lr-15-sm">
                    <div class="wrap-table-shopping-cart">
                        <div>
                            <h3 class="mtext-109 cl2 p-b-30">
                                현재 환율 정보에요!
                            </h3>
                            <div>
                                <canvas id="exchangeRateChart"></canvas>
                                <script type="text/javascript">
                                    // JSP에서 전달된 데이터를 JavaScript로 그대로 전달
                                    const exchangeRatePeriodJson = '${exchangeRatePeriodJson}';  // 서버에서 전달된 JSON 문자열

                                    console.log(exchangeRatePeriodJson);  // 확인용

                                    // JSON 문자열을 JavaScript 객체로 변환
                                    const exchangeRatePeriod = JSON.parse(exchangeRatePeriodJson);

                                    console.log(exchangeRatePeriod);  // 변환된 객체 확인

                                    const ctx = document.getElementById("exchangeRateChart").getContext("2d");

                                    const labels = exchangeRatePeriod.map(item => item.exchangeDate); // 날짜 데이터를 라벨로 사용
                                    const exchangeRates = exchangeRatePeriod.map(item => item.exchangeRate); // 환율 데이터를 차트 데이터로 사용

                                    // 차트 데이터 설정
                                    const exchangeRateData = {
                                        labels: labels,
                                        datasets: [
                                            {
                                                label: "${selectedCurrency.code} to KRW",
                                                data: exchangeRates,
                                                borderColor: "rgba(75, 192, 192, 1)",
                                                backgroundColor: "rgba(75, 192, 192, 0.2)", // 투명도 적용
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
                                                    text: "${selectedCurrency.code} -> KRW 환율 트렌드",
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
                        <div>
                            <h3 class="mtext-109 cl2 p-b-30">
                                환율 계산기
                            </h3>
                            <!-- 환율 계산기 시작 -->
                            <div class="exchange-container">
                                <div class="currency-section">
                                    <div class="currency-input">
                                        <div class="input-container">
                                            <select
                                                    id="from-currency"
                                                    class="currency-select"
                                                    onchange="updateFlagAndLabel('from')"
                                            >
                                                <option
                                                        value="${latestRate.currencyCode}"
                                                        data-flag="united-states.png"
                                                        data-country="미국"
                                                        name="currencyCode"
                                                >
                                                    ${latestRate.currencyCode}
                                                </option>
                                                <!-- 다른 통화 옵션들 -->
                                            </select>
                                            <div
                                                    class="currency-label"
                                                    id="from-label"
                                            >
                                                <img
                                                        src="${pageContext.request.contextPath}${selectedCurrency.logoImageURL}"
                                                        alt="${selectedCurrency.productName}"
                                                        class="currency-flag"
                                                        id="from-flag"
                                                />
                                                <span id="from-country"
                                                >${selectedCurrency.productName}</span
                                                >
                                            </div>
                                        </div>
                                        <input
                                                type="number"
                                                id="from-amount"
                                                placeholder="금액"
                                                oninput="calculateExchange()"
                                        />
                                    </div>
                                </div>
                                <div class="currency-section">
                                    <div class="currency-input">
                                        <div class="input-container">
                                            <select
                                                    id="to-currency"
                                                    class="currency-select"
                                                    onchange="updateFlagAndLabel('to')"
                                            >
                                                <option
                                                        value="KRW"
                                                        data-flag="korea.png"
                                                        data-country="한국"
                                                >
                                                    KRW
                                                </option>
                                                <!-- 다른 통화 옵션들 -->
                                            </select>
                                            <div
                                                    class="currency-label"
                                                    id="to-label"
                                            >
                                                <img
                                                        src="${pageContext.request.contextPath}/resources/images/countries/korea.png"
                                                        alt="KRW"
                                                        class="currency-flag"
                                                        id="to-flag"
                                                />
                                                <span id="to-country"
                                                >한국</span
                                                >
                                            </div>
                                        </div>
                                        <input
                                                type="number"
                                                id="to-amount"
                                                placeholder="환전"
                                                readonly
                                        />
                                    </div>
                                </div>
                                <div class="exchange-rate" style="font-family: 'HanaFont-CM';">
                                    적용 환율: <span id="exchange-rate" style="font-weight: bold;">${latestRate.exchangeRate}</span>

                                    <!-- 변동 지표와 금액 및 퍼센트를 한 줄로 표시 -->
                                    <c:choose>
                                        <c:when test="${changeAmount > 0}">
            <span style="color: red; font-family: 'HanaFont-CM';">
                ▲ ${changeAmount} (+${changePercentage}%)
            </span>
                                        </c:when>
                                        <c:otherwise>
            <span style="color: blue; font-family: 'HanaFont-CM';">
                ▼ ${changeAmount} (${changePercentage}%)
            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <!-- 환율 계산기 끝 -->
                        </div>
                    </div>
                </div>
            </div>

            <!-- 외화 충전 영역 -->
            <div class="col-lg-7 col-xl-6 col-xl-5 m-lr-auto m-b-50">
                <div
                        class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm"
                >
                    <h4 class="mtext-109 cl2 p-b-30">외화 충전하기</h4>

                    <div class="flex-w flex-t bor12 p-b-13">
                        <div class="size-208">
        <span class="stext-110 cl2">
            현재 환율
        </span>
                        </div>

                        <div class="size-209">
        <span class="mtext-110 cl2">
            ${latestRate.exchangeRate}
        </span>

                            <!-- 변동 지표 표시 (상승/하락 표시) -->
                            <c:choose>
                                <c:when test="${changeAmount > 0}">
                <span style="color: red; ">
                    ▲ ${changeAmount} (+${changePercentage}%)
                </span>
                                </c:when>
                                <c:otherwise>
                <span style="color: blue; ">
                    ▼ ${changeAmount} (${changePercentage}%)
                </span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="flex-w flex-t bor12 p-t-15 p-b-30">
                        <div class="size-208 w-full-ssm">
                            <span class="stext-110 cl2"> 입력 </span>
                        </div>

                        <div
                                class="size-209 p-r-18 p-r-0-sm w-full-ssm"
                        >
                            <div class="p-t-15">
                                        <span class="stext-112 cl14">
                                            하나머니는 환전 수수료 100% 우대!
                                        </span>

                                <div
                                        class="rs1-select2 rs2-select2 bor8 bg0 m-b-12 m-t-9"
                                >
                                    <select class="js-select2" name="account" id="account-select">
                                        <option value="">계좌 선택</option>
                                        <option value="${account.accountNumber}"> ${account.accountName} - ${account.accountNumber}</option>
                                    </select>
                                    <div class="dropDownSelect2"></div>
                                </div>

                                <div class="bor8 bg0 m-b-12">
                                    <input
                                            class="stext-111 cl8 plh4 size-111 p-lr-15"
                                            type="number"
                                            id="usd-input"
                                            name="amount"
                                            placeholder="충전할 ${latestRate.currencyCode}를 입력하세요."
                                            oninput="calculateWon()"
                                    />
                                    <input type="hidden" name="currencyCode" value="${latestRate.currencyCode}">
                                    <input type="hidden" name="bankCode" value="${account.bankCode}">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="flex-w flex-t p-t-27 p-b-33">
                        <div class="size-208">
                                    <span class="mtext-101 cl2">
                                        충전 금액:
                                    </span>
                        </div>

                        <div class="size-209 p-t-1">
                            <input
                                    class="mtext-101 cl8 plh3 size-111 p-lr-15"
                                    type="text"
                                    id="won-output"
                                    name="wonAmount"
                                    placeholder="원"
                                    readonly
                            />
                        </div>
                    </div>

                    <button
                            class="flex-c-m stext-101 cl0 size-116 bg3 bor14 hov-btn3 p-lr-15 trans-04 pointer" id="chargeButton" type="button"
                    >
                        외화 충전하기
                    </button>
                </div>
            </div>
        </div>
    </div>
</form>
<div class="btn-back-to-top" id="myBtn">
            <span class="symbol-btn-back-to-top">
                <i class="zmdi zmdi-chevron-up"></i>
            </span>
</div>
<%--footer--%>
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
    var exchangeRate = ${latestRate.exchangeRate}; // 서버에서 전달된 환율 값
</script>





<script>
    $(".js-select2").each(function () {
        $(this).select2({
            minimumResultsForSearch: 20,
            dropdownParent: $(this).next(".dropDownSelect2"),
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


<script>

    $(document).ready(function() {
        $("#chargeButton").on("click", function () {
            var selectedAccount = $("#account-select").val(); // 선택한 계좌 번호
            var amount = $("#usd-input").val(); // 충전할 외화 금액
            var wonAmount = $("#won-output").val(); // 원화 금액
            console.log(selectedAccount, amount, wonAmount);
            if (!selectedAccount || !amount || !wonAmount) {
                swal("Error", "모든 필드를 입력해주세요.", "error");
                return;
            }
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
                            password: password
                        },
                        success: function(response) {
                            if (response.match) {
                                // 비밀번호가 일치하면 로딩 메시지를 3초 동안 표시
                                swal({
                                    title: "외화를 충전하는 중이에요",
                                    text: "잠시만 기다려주세요...",
                                    icon: "info",
                                    buttons: false, // 버튼 숨김
                                    closeOnClickOutside: false, // 외부 클릭 방지
                                    timer: 3000 // 3초 동안 로딩 화면 표시
                                }).then(() => {
                                    // 로딩이 끝난 후 실제 충전 요청을 전송
                                    $.ajax({
                                        url: '${pageContext.request.contextPath}/chargeCurrency', // 실제 충전 처리 URL
                                        type: 'POST',
                                        data: $('#chargeForm').serialize(),  // 폼 데이터를 서버에 전송
                                        success: function(response) {
                                            if (response.success) {  // 충전이 성공적으로 이루어졌는지 확인
                                                swal({
                                                    title: "충전 완료",
                                                    text: "외화 충전이 완료되었습니다.",
                                                    icon: "success",
                                                    buttons: {
                                                        confirm: "확인"
                                                    }
                                                }).then(() => {
                                                    // 충전 완료 후 페이지를 리로드하거나 다른 행동 수행
                                                    window.location.href = '${pageContext.request.contextPath}/currency-details?productCode=${selectedCurrency.code}&productId=${selectedCurrency.productID}';  // 성공 페이지로 이동
                                                });
                                            } else {
                                                swal("Error", "충전 중 오류가 발생했습니다.", "error");
                                            }
                                        },
                                        error: function() {
                                            // 서버 요청 중 오류가 발생한 경우
                                            swal("Error", "서버 오류가 발생했습니다. 다시 시도해주세요.", "error");
                                        }
                                    });
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



</script>





<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/charging.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/chart.js"></script>
</body>
</html>