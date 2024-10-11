<%--
  Created by IntelliJ IDEA.
  User: gimjuhwan
  Date: 8/19/24
  Time: 5:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        .partner-section {
            padding-top: 40px; /* 전체 섹션 위쪽 여백 */
        }

        .partner-logo-wrapper {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-wrap: wrap;
            gap: 20px; /* 로고 간 간격 설정 */
        }

        .partner-logo {
            margin: 10px; /* 로고 주변에 여백 추가 */
        }

        .partner-logo img {
            max-width: 120px; /* 로고의 최대 너비 설정 */
            height: auto; /* 높이는 비율에 맞춰 자동 조절 */
            transition: transform 0.3s ease; /* 로고 호버 시 애니메이션을 부드럽게 설정 */
        }

        .partner-logo img:hover {
            transform: scale(1.1); /* 마우스 호버 시 로고 확대 효과 */
        }

    </style>
</head>
<body>
<footer class="bg3 p-t-75 p-b-32">
    <div class="container">
        <div class="row">
            <div class="col-sm-6 col-lg-3 p-b-50">
                <h4 class="stext-301 cl0 p-b-30">Categories</h4>

                <ul>
                    <li class="p-b-10">
                        <a
                                href="#"
                                class="stext-107 cl7 hov-cl1 trans-04"
                        >
                            선물하기
                        </a>
                    </li>

                    <li class="p-b-10">
                        <a
                                href="#"
                                class="stext-107 cl7 hov-cl1 trans-04"
                        >
                            서비스 소개
                        </a>
                    </li>

                    <li class="p-b-10">
                        <a
                                href="#"
                                class="stext-107 cl7 hov-cl1 trans-04"
                        >
                            선물함
                        </a>
                    </li>

                    <li class="p-b-10">
                        <a
                                href="#"
                                class="stext-107 cl7 hov-cl1 trans-04"
                        >
                            친구 찾기
                        </a>
                    </li>
                </ul>
            </div>

            <div class="col-sm-6 col-lg-3 p-b-50">
                <h4 class="stext-301 cl0 p-b-30">Help</h4>

                <ul>
                    <li class="p-b-10">
                        <a
                                href="#"
                                class="stext-107 cl7 hov-cl1 trans-04"
                        >
                            관리자에게 문의하기
                        </a>
                    </li>

                    <li class="p-b-10">
                        <a
                                href="#"
                                class="stext-107 cl7 hov-cl1 trans-04"
                        >
                            하나은행
                        </a>
                    </li>

                    <li class="p-b-10">
                        <a
                                href="#"
                                class="stext-107 cl7 hov-cl1 trans-04"
                        >
                            하나머니
                        </a>
                    </li>

                    <li class="p-b-10">
                        <a
                                href="#"
                                class="stext-107 cl7 hov-cl1 trans-04"
                        >
                            하나증권
                        </a>
                    </li>
                </ul>
            </div>

            <div class="col-sm-6 col-lg-3 p-b-50">
                <h4 class="stext-301 cl0 p-b-30">관리자에게 문의는..</h4>

                <p class="stext-107 cl7 size-201">
                    본 프로젝트는 하나금융TI 채용연계 프로젝트입니다. 상업적 목적이 아닙니다.
                    관리자 문의는 최신 생성형 모델 llama3에 기반한 정확한 답변을 제공합니다.
                    궁금한 점을 쉽고 빠르게 물어보세요!
                </p>

            </div>

            <div class="col-sm-6 col-lg-3 p-b-50">
                <h4 class="stext-301 cl0 p-b-30">이메일로 연락</h4>

                <form>
                    <div class="wrap-input1 w-full p-b-4">
                        <input
                                class="input1 bg-none plh1 stext-107 cl7"
                                type="text"
                                name="email"
                                placeholder="email@example.com"
                        />
                        <div class="focus-input1 trans-04"></div>
                    </div>

                    <div class="p-t-18">
                        <button
                                class="flex-c-m stext-101 cl0 size-103 bg1 bor1 hov-btn2 p-lr-15 trans-04"
                        >
                            해당 이메일로 관리자가 연락드립니다.
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <div class="partner-section">
            <div class="partner-logo-wrapper">
                <a href="#" class="partner-logo">
                    <img
                            src="${pageContext.request.contextPath}/resources/images/hanabank1.png"
                            alt="하나은행 아이콘"
                    />
                </a>

                <a href="#" class="partner-logo">
                    <img
                            src="${pageContext.request.contextPath}/resources/images/hanacard1.png"
                            alt="하나카드 아이콘"
                    />
                </a>

                <a href="#" class="partner-logo">
                    <img
                            src="${pageContext.request.contextPath}/resources/images/hanasecurities1.png"
                            alt="하나증권 아이콘"
                    />
                </a>
            </div>
        </div>

    </div>
</footer>
</body>
</html>
