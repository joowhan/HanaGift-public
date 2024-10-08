<%--
  Created by IntelliJ IDEA.
  User: gimjuhwan
  Date: 9/6/24
  Time: 6:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<!-- Modal Structure -->
<div id="userModal" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
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
                <!-- 프로필 이미지와 사용자 정보 섹션 -->
                <div
                        class="profile-section d-flex align-items-center mb-4"
                >
                    <img
                            src="${pageContext.request.contextPath}/resources/images/profile.png"
                            alt="Profile Image"
                            class="img-fluid rounded-circle profile-image"
                    />
                    <div class="ml-3">
                        <h4 id="modalUsername">김주환</h4>
                        <p id="modalStatus" class="status-message">
                            Feeling good today!
                        </p>
                    </div>
                </div>

                <!-- 추가 텍스트 섹션 -->
                <p class="mt-3 explanation-text">
                    <span class="username">John Doe</span>님이 받고 싶은
                    선물은
                    <strong class="highlight">주식</strong>입니다.<br />
                </p>
                <div class="background1"
                     style="background-image: url('${pageContext.request.contextPath}/resources/images/bg_utl_app.png'); background-size: cover; background-position: center; height: 300px; position: relative;">
                    <img
                            src="${pageContext.request.contextPath}/resources/images/icons/userModal_ic01.png"
                            alt="Gift Image"
                            class="gift-image my-3 layer-slick1 animated visible-false"
                            data-appear="fadeInUp"
                            data-delay="800"
                    />
                </div>

                <p class="mt-3 explanation-text">
                    현재 <span class="username">John Doe</span>님은
                    주식을 모아 온주를 만들고 있어요!
                </p>
                <!-- 그래프 섹션 -->
                <div class="chart-container">
                    <canvas
                            id="stockChart"
                            width="200"
                            height="200"
                    ></canvas>
                    <div class="chart-value" id="chartValue">0.3주</div>
                </div>
                <p class="mt-3 explanation-text">
                    <span class="username">John Doe</span>님은 현재 영국
                    여행을 계획 중이에요!
                </p>

                <!-- 여행 이미지 섹션 -->
                <div
                        class="travel-recommendations d-flex justify-content-around mt-4"
                >
                    <div class="travel-image-container">
                        <a href="foreign-currency-page.html">
                            <img
                                    src="${pageContext.request.contextPath}/resources/images/countries/spain.png"
                                    alt="Spain"
                                    class="travel-image"
                            />
                        </a>
                        <p class="text-center travel-text mt-2">
                            <a href="foreign-currency-page.html"
                            >외화 선물하기</a
                            >
                        </p>
                    </div>
                </div>

                <!-- 적금 추천 섹션 -->
                <!-- 적금 추천 섹션 -->
                <p class="mt-3 explanation-text">
                    <span class="username">John Doe</span>님에게 필요한
                    적금은 다음과 같습니다:
                </p>
                <div class="d-flex justify-content-around mt-3">
                    <a href="link_to_product_1" class="savings-card">
                        <div class="card-content">
                            <h5>하나원큐 적금</h5>
                            <p class="interest-rate">금리 3.0%</p>
                            <p class="description">
                                저축금액, 만기일, 중간이체 구간까지 내
                                맘대로 디자인하는 DIY 적금
                            </p>
                        </div>
                    </a>
                    <a href="link_to_product_2" class="savings-card">
                        <div class="card-content">
                            <h5>하나원큐 적금</h5>
                            <p class="interest-rate">금리 3.0%</p>
                            <p class="description">
                                저축금액, 만기일, 중간이체 구간까지 내
                                맘대로 디자인하는 DIY 적금
                            </p>
                        </div>
                    </a>
                </div>
            </div>
            <div class="modal-footer">
                <button class="gift-button">
                    <img
                            src="${pageContext.request.contextPath}/resources/images/icons/gift_1.png"
                            alt="Gift Icon"
                            class="gift-icon"
                    />
                    <span>선물하기</span>
                </button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
