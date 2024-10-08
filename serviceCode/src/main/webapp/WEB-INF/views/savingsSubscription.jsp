<%--
  Created by IntelliJ IDEA.
  User: gimjuhwan
  Date: 9/19/24
  Time: 2:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>적금 가입</title>
    <jsp:include page="component/head.jsp" flush="false"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/savingsSubscription.css" />
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
</head>
<body>
    <jsp:include page="component/header.jsp" flush="false"/>
    <section class="bg0 p-t-75 p-b-120">
        <div class="container">
            <div class="row mt-4 mb-4">
                <div class="col-md-8">
                    <div class="title-header">
                        <img
                                src="${pageContext.request.contextPath}/resources/images/chargeCurrency.png"
                                alt="선물 아이콘"
                                class="gift-icon"
                        />
                        <div class="text-container">
                            <h3 class="mtext-111 cl14 mb-3">하나원큐 적금 가입</h3>
                            <p class="stext-113 cl6">
                                받은 선물의 적금을 하나Gift에서 바로 가입하세요!
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="container">
                    <div class="container my-5">
                        <div class="wizard">
                            <ul class="nav nav-tabs justify-content-center" id="myTab" role="tablist">
                                <!-- Step 1: 가입 안내 -->
                                <li class="nav-item" role="presentation" data-bs-toggle="tooltip" data-bs-placement="top" title="Step 1">
                                    <a class="nav-link active" href="#step1" id="step1-tab" data-bs-toggle="tab" role="tab" aria-controls="step1" aria-selected="true">
                                        1. 가입 안내
                                    </a>
                                </li>
                                <!-- Step 2: 상품 중요사항 -->
                                <li class="nav-item" role="presentation" data-bs-toggle="tooltip" data-bs-placement="top" title="Step 2">
                                    <a class="nav-link" href="#step2" id="step2-tab" data-bs-toggle="tab" role="tab" aria-controls="step2" aria-selected="false">
                                        2. 상품 중요사항
                                    </a>
                                </li>
                                <!-- Step 3: 약관 동의 -->
                                <li class="nav-item" role="presentation" data-bs-toggle="tooltip" data-bs-placement="top" title="Step 3">
                                    <a class="nav-link" href="#step3" id="step3-tab" data-bs-toggle="tab" role="tab" aria-controls="step3" aria-selected="false">
                                        3. 약관 동의
                                    </a>
                                </li>
                                <!-- Step 4: 선물정보 확인 -->
                                <li class="nav-item" role="presentation" data-bs-toggle="tooltip" data-bs-placement="top" title="Step 4">
                                    <a class="nav-link" href="#step4" id="step4-tab" data-bs-toggle="tab" role="tab" aria-controls="step4" aria-selected="false">
                                        4. 선물정보 확인
                                    </a>
                                </li>
                                <!-- Step 5: 입금 계좌 선택 -->
<%--                                <li class="nav-item" role="presentation" data-bs-toggle="tooltip" data-bs-placement="top" title="Step 5">--%>
<%--                                    <a class="nav-link" href="#step5" id="step5-tab" data-bs-toggle="tab" role="tab" aria-controls="step5" aria-selected="false">--%>
<%--                                        5. 입금 계좌 선택--%>
<%--                                    </a>--%>
<%--                                </li>--%>
                                <!-- 최종 단계: 가입 성공 -->
                                <li class="nav-item" role="presentation" data-bs-toggle="tooltip" data-bs-placement="top" title="Success">
                                    <a class="nav-link" href="#success" id="success-tab" data-bs-toggle="tab" role="tab" aria-controls="success" aria-selected="false">
                                        가입 성공
                                    </a>
                                </li>
                            </ul>
                            <div class="tab-content" id="myTabContent">
                                <!-- Step 1: 가입 안내 -->
                                <div class="tab-pane fade show active" role="tabpanel" id="step1" aria-labelledby="step1-tab">


                                    <!-- 가입 안내 섹션 시작 -->
                                    <div class="d-flex justify-content-between align-items-start" style="gap: 20px;">
                                        <!-- 적금 정보 카드 -->
                                        <div class="saving-subscription-card">
                                            <div class="icon-text-wrapper d-flex justify-content-center align-items-center">
                                                <!-- 이자율 -->
                                                <div class="icon-section text-center">
                                                    <img src="${pageContext.request.contextPath}/resources/images/charging.gif" alt="이자율 아이콘" class="icon-large">
                                                    <div class="icon-text">
                                                        <p class="text-black">기본 금리</p>
                                                        <p class="text-green">${savingProduct.basicInterestRate}%</p>
                                                    </div>
                                                </div>

                                                <!-- 저축 한도 -->
                                                <div class="icon-section text-center">
                                                    <img src="${pageContext.request.contextPath}/resources/images/cost.gif" alt="저축 한도 아이콘" class="icon-large">
                                                    <div class="icon-text">
                                                        <p class="text-black">저축 한도</p>
                                                        <p class="text-green">${savingProductDetail.depositLimit}</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <h4 class="subscription-name">${savingProduct.productName}</h4>
                                            <p class="subscription-short-description">${savingProduct.shortDescription}</p>


                                            <p class="subscription-detail-title">상세 설명</p>
                                            <p class="subscription-detail-description">
                                                ${savingProductDetail.detailedDescription}
                                            </p>
                                        </div>

                                        <!-- 상품 설명서 영역 -->
                                        <div class="product-guide text-center">
                                            <h5>안전한 상품가입을 위해 상품 설명서를 먼저 확인해주세요.</h5>
                                            <div class="product-guide-section">
                                                <p>상품가입이 완료되면, 계약서와 함께 설명서를 전달드려요.</p>
                                                <div class="product-guide-info">
                                                    <span>${savingProduct.productName}</span>
                                                    <a href="${pageContext.request.contextPath}${savingProductDetail.pdfLink}" target="_blank" class="btn-guide">설명서 보기</a> <!-- PDF 파일 열기 -->
                                                </div>
                                            </div>

                                            <!-- 가입 기간 테이블 -->
                                            <table class="info-table">
                                                <thead>
                                                <tr>
                                                    <th>가입 기간</th>
                                                    <th>${savingProductDetail.minDuration} ~ ${savingProductDetail.maxDuration} 개월</th>
                                                </tr>
                                                </thead>
                                            </table>

                                            <!-- 우대 금리 소제목 -->
<%--                                            <p class="premium-rate-title">우대 금리</p>--%>

                                            <!-- 우대 금리 테이블 -->
                                            <table class="info-table">
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

                                    <div class="d-flex justify-content-end">
                                        <a class="btn btn-info next">다음 단계 <i class="fas fa-angle-right"></i></a>
                                    </div>
                                </div>
                                <!-- Step 2: 상품 중요사항 -->
                                <div class="tab-pane fade" role="tabpanel" id="step2" aria-labelledby="step2-tab">
                                    <h3 class="page-title">상품 중요사항을 충분히 읽고 확인해주세요.</h3>
                                    <p class="page-subtitle">금융소비자보호법 제19조 제1항에서 규정하고 있는 상품 중요사항입니다.</p>

                                    <!-- 가입 기간과 예상 금리 -->
                                    <div class="product-info-section card-box">
                                        <h4 class="section-title">가입 기간</h4>
                                        <p>${savingProductDetail.minDuration} ~ ${savingProductDetail.maxDuration} 개월</p>

                                        <div class="product-rate-table">
                                            <table class="info-table light-font-table">
                                                <thead>
                                                <tr>
                                                    <th>가입 기간</th>
                                                    <th>${savingProductDetail.minDuration}개월 기준</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <tr>
                                                    <td>예상 적용 금리 (세전)</td>
                                                    <td>연 ${savingProduct.basicInterestRate}%</td>
                                                </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <!-- 예금 해지 시 불이익 -->
                                    <div class="product-info-section card-box mt-4">
                                        <h4 class="section-title">예금 해지 시 불이익</h4>
                                        <p>만기 전 예금 해지 시 중도해지이자율이 적용됩니다.</p>

                                        <table class="info-table light-font-table">
                                            <thead>
                                            <tr>
                                                <th>기간</th>
                                                <th>중도해지금리</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <td>1개월 미만</td>
                                                <td>연 0.10%</td>
                                            </tr>
                                            <tr>
                                                <td>1개월 이상 ~ 3개월 미만</td>
                                                <td>연 0.15%</td>
                                            </tr>
                                            <tr>
                                                <td>3개월 이상 ~ 6개월 미만</td>
                                                <td>연 0.20%</td>
                                            </tr>
                                            <tr>
                                                <td>6개월 이상</td>
                                                <td>가입 시점에 적용된 기본금리 × 차등율 × 경과율</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>

                                    <!-- 체크박스 -->
                                    <div class="form-check mt-4">
                                        <input type="checkbox" class="form-check-input" id="check1">
                                        <label class="form-check-label" for="check1">가입 기간과 예상 적용 금리를 확인했습니다.</label>
                                    </div>
                                    <div class="form-check">
                                        <input type="checkbox" class="form-check-input" id="check2">
                                        <label class="form-check-label" for="check2">예금 해지 시 불이익을 확인했습니다.</label>
                                    </div>

                                    <!-- 이전/다음 단계 버튼 -->
                                    <div class="d-flex justify-content-between">
                                        <a class="btn btn-secondary previous"><i class="fas fa-angle-left"></i> 이전 단계</a>
                                        <a class="btn btn-info next">다음 단계 <i class="fas fa-angle-right"></i></a>
                                    </div>
                                </div>

                                <!-- Step 3: 약관 동의 -->
                                <div class="tab-pane fade" role="tabpanel" id="step3" aria-labelledby="step3-tab">
                                    <h3 class="page-title">약관에 동의해 주세요</h3>

                                    <!-- 약관 동의 섹션 -->
                                    <div class="terms-container">
                                        <!-- 필수 약관 -->
                                        <div class="terms-group">
                                            <div class="terms-header">
                                                <label class="terms-label" style="color: #0b0b0b">
                                                    <input type="checkbox" class="custom-checkbox"> 전체 동의
                                                </label>
                                                <a href="#" class="terms-view-link"><i class="fas fa-chevron-right"></i></a>
                                            </div>
                                            <div class="terms-item">
                                                <label class="terms-label">
                                                    <input type="checkbox" class="custom-checkbox"> [필수] 예금거래기본약관
                                                </label>
                                                <a href="#" class="terms-view-link"><i class="fas fa-chevron-right"></i></a>
                                            </div>
                                            <div class="terms-item">
                                                <label class="terms-label">
                                                    <input type="checkbox" class="custom-checkbox"> [필수] 적립식예금약관
                                                </label>
                                                <a href="#" class="terms-view-link"><i class="fas fa-chevron-right"></i></a>
                                            </div>
                                            <div class="terms-item">
                                                <label class="terms-label">
                                                    <input type="checkbox" class="custom-checkbox"> [필수] ${savingProduct.productName} 특약
                                                </label>
                                                <a href="#" class="terms-view-link"><i class="fas fa-chevron-right"></i></a>
                                            </div>
                                            <div class="terms-item">
                                                <label class="terms-label">
                                                    <input type="checkbox" class="custom-checkbox"> [필수] 비과세종합저축특약
                                                </label>
                                                <a href="#" class="terms-view-link"><i class="fas fa-chevron-right"></i></a>
                                            </div>
                                        </div>

                                        <!-- 선택 약관 -->
                                        <div class="terms-group">
                                            <div class="terms-header">
                                                <label class="terms-label" style="color: #0b0b0b">
                                                    <input type="checkbox" class="custom-checkbox"> [선택] 전체 동의
                                                </label>
                                                <a href="#" class="terms-view-link"><i class="fas fa-chevron-right"></i></a>
                                            </div>
                                            <div class="terms-item">
                                                <label class="terms-label">
                                                    <input type="checkbox" class="custom-checkbox"> [선택] 개인(신용)정보 수집·이용·제공 동의서
                                                </label>
                                                <a href="#" class="terms-view-link"><i class="fas fa-chevron-right"></i></a>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 이전/다음 단계 버튼 -->
                                    <div class="d-flex justify-content-between mt-4">
                                        <a class="btn btn-secondary previous"><i class="fas fa-angle-left"></i> 이전 단계</a>
                                        <a class="btn btn-info next" id="nextBtn" disabled>다음 단계 <i class="fas fa-angle-right"></i></a>
                                    </div>
                                </div>


                                <!-- Step 4: 선물정보 및 계좌 선택 -->
                                <div class="tab-pane fade" role="tabpanel" id="step4" aria-labelledby="step4-tab">
                                    <h3 class="page-title">선물 정보 확인 및 계좌 선택</h3>
                                    <form id="subscriptionForm" action="${pageContext.request.contextPath}/complete-subscription" method="post">
                                        <div class="row">
                                            <!-- 왼쪽 섹션: 받은 적금 정보 및 선택한 정보 -->
                                            <div class="col-md-6">
                                                <div class="card mb-4 shadow-sm">
                                                    <div class="card-body">
                                                        <!-- 적금 상품 이름을 크게 표시 -->
                                                        <h3 class="product-name">${savingProduct.productName}</h3>

                                                        <div class="form-group">
                                                            <label class="form-label">선물받은 금액</label>
                                                            <p class="gift-amount">${gift.amount}원</p>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="form-label">이율</label>
                                                            <p class="interest-rate">${savingProduct.basicInterestRate}%</p>
                                                        </div>
                                                    </div>
                                                    <!-- 아이콘 위치 변경 -->
                                                    <img src="${pageContext.request.contextPath}${savingProduct.imgUrl}" alt="적금 아이콘" class="icon-img-new">
                                                </div>
                                            </div>

                                            <!-- 오른쪽 섹션: 기간 선택 및 계좌 선택 -->
                                            <div class="col-md-6">
                                                <div class="card mb-4 shadow-sm">
                                                    <div class="card-header bg-transparent border-0">
                                                        <h5 class="card-title">기간 및 계좌 선택</h5>
                                                    </div>
                                                    <div class="card-body">
                                                        <!-- 기간 선택 -->
                                                        <div class="form-group">
                                                            <label class="form-label">기간 선택</label>
                                                            <div class="btn-group mb-3 d-flex justify-content-between" role="group" aria-label="Duration Selection">
                                                                <button type="button" class="btn btn-outline-success duration-btn" data-duration="6">6개월</button>
                                                                <button type="button" class="btn btn-outline-success duration-btn" data-duration="12">12개월</button>
                                                                <button type="button" class="btn btn-outline-success duration-btn" id="customDurationBtn">직접 입력</button>
                                                            </div>
                                                            <div class="form-group" id="customDurationGroup" style="display: none;">
                                                                <label for="customDurationField" class="form-label">직접 입력 (개월)</label>
                                                                <input type="number" class="form-control" name="customDuration" id="customDurationField" min="1" placeholder="개월 수를 입력하세요">
                                                            </div>
                                                        </div>

                                                        <!-- 계좌 선택 -->
                                                        <div class="form-group">
                                                            <label class="form-label">입금 계좌 선택</label>
                                                            <div class="dropdown custom-dropdown">
                                                                <button class="btn btn-outline-primary dropdown-toggle w-100 d-flex align-items-center" type="button" id="accountDropdownButton" data-bs-toggle="dropdown" aria-expanded="false">
                                                                    <img id="accountIcon" src="#" alt="Bank Icon" class="bank-icon" style="width: 25px; height: 25px; margin-right: 10px; display: none;">
                                                                    <span id="accountText">계좌를 선택하세요</span>
                                                                </button>
                                                                <ul class="dropdown-menu w-100" aria-labelledby="accountDropdownButton">
                                                                    <li>
                                                                        <a class="dropdown-item account-item" href="#" data-value="hana" data-icon="${pageContext.request.contextPath}/resources/images/hana.png" data-account-number="${bankAccount.accountNumber}">
                                                                            <img src="${pageContext.request.contextPath}/resources/images/hana.png" alt="Hana Icon" class="bank-icon" style="width: 25px; height: 25px; margin-right: 10px;">
                                                                            ${bankAccount.accountName} ${bankAccount.accountNumber}
                                                                        </a>
                                                                        <!-- 추가 계좌가 있다면 동일한 방식으로 추가 -->
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </div>

                                                        <!-- 자동이체일 입력 -->
                                                        <div class="form-group">
                                                            <label for="transferDayField" class="form-label">매월 자동이체일 입력 (1~28일)</label>
                                                            <input type="number" class="form-control" name="transferDay" id="transferDayField" min="1" max="28" required placeholder="자동이체일을 입력하세요">
                                                        </div>

                                                        <!-- 계좌 비밀번호 입력 (숨김 필드) -->
                                                        <input type="hidden" name="password" id="passwordField">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- 이전/제출 버튼 -->
                                        <div class="d-flex justify-content-between mt-4">
                                            <a class="btn btn-secondary previous"><i class="fas fa-angle-left"></i> 이전 단계</a>
                                            <button type="submit" class="btn btn-info" id="nextBtn1" disabled>적금 가입 <i class="fas fa-angle-right"></i></button>
                                        </div>
                                    </form>
                                </div>




                                <!-- 최종 단계: 가입 성공 -->
                                <div class="tab-pane fade" role="tabpanel" id="success" aria-labelledby="success-tab">
                                    <h3 class="page-title">적금 가입 성공</h3>
                                    <div class="success-image-container">
                                        <img src="${pageContext.request.contextPath}/resources/images/savings_complete.png" alt="가입 성공 이미지" class="success-image">
                                        <div class="success-message">
                                            적금 가입에 성공했어요!
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-center mt-4">
                                        <a class="btn btn-custom" href="${pageContext.request.contextPath}/">홈으로 이동</a>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>
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
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.min.js"></script>
<script>
    $(".js-select2").each(function () {
        $(this).select2({
            minimumResultsForSearch: 20,
            dropdownParent: $(this).next(".dropDownSelect2"),
        });
    });
</script>
<script>
    const check1 = document.getElementById('check1');
    const check2 = document.getElementById('check2');
    const nextBtn = document.getElementById('nextBtn');

    function checkValidation() {
        if (check1.checked && check2.checked) {
            nextBtn.disabled = false;
        } else {
            nextBtn.disabled = true;
        }
    }

    check1.addEventListener('change', checkValidation);
    check2.addEventListener('change', checkValidation);
</script>

<script>
    $(document).ready(function () {
        // Tooltip 활성화
        var tooltipTriggerList = [].slice.call(
            document.querySelectorAll('[data-bs-toggle="tooltip"]')
        );
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });

        // 탭 전환 함수
        function switchTab(direction) {
            const currentTab = $(".nav-tabs .nav-link.active");
            let newTab;

            if (direction === 'next') {
                newTab = currentTab.parent().next("li").find("a");
            } else if (direction === 'previous') {
                newTab = currentTab.parent().prev("li").find("a");
            }

            if (newTab.length) {
                const tab = new bootstrap.Tab(newTab[0]);
                tab.show();
            }
        }

        // 다음 버튼 클릭 이벤트
        $(".next").click(function () {
            const currentStep = $(".nav-tabs .nav-link.active").attr("href");

            // 각 단계에서 필요한 유효성 검사 및 데이터 수집 로직을 추가할 수 있습니다.
            // 예: if (currentStep === "#step1") { /* 유효성 검사 */ }
            if ($(this).attr("id") === "nextBtn1") {
                e.preventDefault(); // 기본 동작 방지
                return; // 다른 동작 수행 안 함
            }
            // 다음 탭으로 전환
            switchTab('next');
        });

        // 이전 버튼 클릭 이벤트
        $(".previous").click(function () {
            // 이전 탭으로 전환
            switchTab('previous');
        });

        // 최종 제출 단계에서 서버로 데이터 전송


    });
</script>

<script>
    $(document).ready(function() {
        // '전체 동의' 체크박스 클릭 시
        $('.terms-group .terms-header .custom-checkbox').change(function() {
            var isChecked = $(this).is(':checked');
            var $termsGroup = $(this).closest('.terms-group');
            $termsGroup.find('.terms-item .custom-checkbox').prop('checked', isChecked);
            toggleNextButton();
        });

        // 하위 체크박스 클릭 시 '전체 동의' 체크박스 상태 업데이트
        $('.terms-group .terms-item .custom-checkbox').change(function() {
            var $termsGroup = $(this).closest('.terms-group');
            var total = $termsGroup.find('.terms-item .custom-checkbox').length;
            var checked = $termsGroup.find('.terms-item .custom-checkbox:checked').length;
            $termsGroup.find('.terms-header .custom-checkbox').prop('checked', total === checked);
            toggleNextButton();
        });

        // 다음 단계 버튼 활성화 여부 결정 함수
        function toggleNextButton() {
            // 모든 필수 체크박스가 체크되었는지 확인
            var allRequiredChecked = true;
            $('.terms-group').first().find('.terms-item .custom-checkbox').each(function() {
                if (!$(this).is(':checked')) {
                    allRequiredChecked = false;
                    return false; // 루프 중단
                }
            });

            // 다음 버튼 활성화 여부 설정
            $('#nextBtn').prop('disabled', !allRequiredChecked);
        }

        // 초기 상태 설정
        toggleNextButton();
    });
</script>

<%--step 4--%>
<script>
    $(document).ready(function() {
        // 선택된 정보를 저장할 객체
        const selectedInfo = {
            duration: null,
            account: {
                name: null,
                icon: null,
                accountNumber: null
            },
            transferDay: null
        };

        // 기간 버튼 클릭 이벤트
        $('.duration-btn').click(function() {
            $('.duration-btn').removeClass('selected');
            $(this).addClass('selected');

            const duration = $(this).data('duration');
            selectedInfo.duration = duration ? `${duration}개월` : null;

            if ($(this).attr('id') === 'customDurationBtn') {
                $('#customDurationGroup').show();
                selectedInfo.duration = null;
            } else {
                $('#customDurationGroup').hide();
                $('#customDurationField').val('');
            }

            checkNextButton();
        });

        // 커스텀 기간 입력 이벤트
        $('#customDurationField').on('input', function() {
            const customDuration = $(this).val();
            if (customDuration && customDuration > 0) {
                selectedInfo.duration = `${customDuration}개월`;
            } else {
                selectedInfo.duration = null;
            }
            checkNextButton();
        });

        // 계좌 선택 이벤트
        $('.account-item').click(function (e) {
            e.preventDefault();
            var selectedAccountText = $(this).text().trim();
            var selectedAccountIcon = $(this).data('icon');
            var selectedAccountNumber = $(this).data('account-number');

            $('#accountText').text(selectedAccountText);
            $('#accountIcon').attr('src', selectedAccountIcon).show();

            selectedInfo.account = {
                name: selectedAccountText,
                icon: selectedAccountIcon,
                accountNumber: selectedAccountNumber
            };

            checkNextButton();
        });

        // 자동이체일 입력 이벤트
        $('#transferDayField').on('input', function() {
            const transferDay = $(this).val();
            if (transferDay >= 1 && transferDay <= 28) {
                selectedInfo.transferDay = transferDay; // 숫자만 저장
            } else {
                selectedInfo.transferDay = null;
            }
            checkNextButton();
        });

        // 다음 버튼 활성화 체크
        function checkNextButton() {
            if (selectedInfo.duration && selectedInfo.account.name && selectedInfo.transferDay) {
                $('#nextBtn1').prop('disabled', false);
            } else {
                $('#nextBtn1').prop('disabled', true);
            }
        }

        // 폼 제출 이벤트
        $('#subscriptionForm').submit(function(e) {
            e.preventDefault();

            swal({
                title: "계좌 비밀번호 입력",
                text: "적금을 가입하려면 계좌 비밀번호를 입력하세요.",
                content: {
                    element: "input",
                    attributes: {
                        type: "password",
                        placeholder: "비밀번호를 입력하세요",
                        required: true,
                        minLength: 4
                    },
                },
                buttons: {
                    cancel: "취소",
                    confirm: {
                        text: "확인",
                        closeModal: false
                    }
                },
                closeOnClickOutside: false,
                closeOnEsc: false
            })
                .then((password) => {
                    if (!password) {
                        swal.close();
                        return;
                    }

                    $.ajax({
                        type: "POST",
                        url: "${pageContext.request.contextPath}/checkPassword",
                        contentType: "application/x-www-form-urlencoded",
                        data: { password: password },
                        success: function(response) {
                            if (response.match) {
                                $('#passwordField').val(password);
                                submitSubscription();
                            } else {
                                swal("오류!", "비밀번호가 일치하지 않습니다. 다시 시도하세요.", "error");
                            }
                        },
                        error: function() {
                            swal("오류!", "비밀번호 검증 중 문제가 발생했습니다. 다시 시도하세요.", "error");
                        }
                    });
                });
        });

        // 적금 가입 데이터를 수집하고 서버로 전송하는 함수
        function submitSubscription() {
            const durationMonths = getDurationMonths(selectedInfo.duration);
            const giftAmountStr = $(".gift-amount").text().replace('원', '').trim();
            const interestRateStr = $(".interest-rate").text().replace('%', '').trim();

            const amount = parseFloat(giftAmountStr);
            const baseRate = parseFloat(interestRateStr);

            var savingsData = {
                accountNumber: selectedInfo.account.accountNumber,
                duration: durationMonths,
                paymentDate: selectedInfo.transferDay, // 숫자만 전달
                baseRate: baseRate,
                amount: amount,
            };

            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/complete-subscription",
                contentType: "application/json",
                data: JSON.stringify(savingsData),
                success: function(response) {
                    if (response.status === "success") {
                        swal({
                            title: "성공!",
                            text: "적금 가입이 완료되었습니다.",
                            icon: "success",
                            button: "확인"
                        }).then(() => {
                            // 확인 버튼을 누르면 다음 스텝으로 이동
                            const successTab = $(".nav-tabs .nav-link[href='#success']");
                            const tab = new bootstrap.Tab(successTab[0]);
                            tab.show();
                        });
                    } else {
                        swal("오류!", "적금 가입에 실패했습니다. 다시 시도하세요.", "error");
                    }
                },
                error: function() {
                    swal("오류!", "적금 가입 중 문제가 발생했습니다.", "error");
                }
            });
        }

        // 선택한 기간을 숫자로 변환하는 함수
        function getDurationMonths(durationStr) {
            return parseInt(durationStr.replace('개월', ''));
        }
    });
</script>


</html>
