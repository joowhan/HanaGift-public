<%--
  Created by IntelliJ IDEA.
  User: gimjuhwan
  Date: 8/19/24
  Time: 8:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="wrap-modal1 js-modal1 p-t-60 p-b-20">
    <div class="overlay-modal1 js-hide-modal1"></div>

    <div class="container">
        <div class="bg0 p-t-60 p-b-30 p-lr-15-lg how-pos3-parent">
            <button class="how-pos3 hov3 trans-04 js-hide-modal1">
                <img src="${pageContext.request.contextPath}/resources/images/icons/icon-close.png" alt="CLOSE" />
            </button>

            <div class="row">
                <div class="col-md-6 col-lg-7 p-b-30">
                    <div class="p-l-25 p-r-30 p-lr-0-lg">
                        <div class="wrap-slick3 flex-sb flex-w">
                            <div class="wrap-slick3-dots"></div>
                            <div
                                    class="wrap-slick3-arrows flex-sb-m flex-w"
                            >
                                <div class="summary-container">
                                    <h2>(내맘) 적금</h2>
                                    <div class="characters">
                                        <div
                                                class="character character1"
                                        ></div>
                                    </div>
                                    <div class="icon-container">
                                        <div class="icon-item">
                                            <img
                                                    src="${pageContext.request.contextPath}/resources/images/icons/lightbulb.png"
                                                    alt="Icon 1"
                                            />
                                            <p>특징</p>
                                            <span
                                            >기간도 금액도
                                                        <br />자유롭게</span
                                            >
                                        </div>
                                        <div class="icon-item">
                                            <img
                                                    src="${pageContext.request.contextPath}/resources/images/icons/7-days.png"
                                                    alt="Icon 2"
                                            />
                                            <p>기간</p>
                                            <span
                                            >6개월 ~ 60개월<br />(월
                                                        ,일단위 지정)</span
                                            >
                                        </div>
                                        <div class="icon-item">
                                            <img
                                                    src="${pageContext.request.contextPath}/resources/images/icons/piggy-bank.png"
                                                    alt="Icon 3"
                                            />
                                            <p>가입금액(원단위)</p>
                                            <span
                                            >1천원 이상<br />1천만원
                                                        이하</span
                                            >
                                        </div>
                                        <div class="icon-item">
                                            <img
                                                    src="${pageContext.request.contextPath}/resources/images/icons/interest-rate.png"
                                                    alt="Icon 4"
                                            />
                                            <p>
                                                60개월 기준(정액적립식)
                                            </p>
                                            <span
                                            >기본 연 3.10%<br />최고
                                                        연 3.60%</span
                                            >
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-lg-5 p-b-30">
                    <div class="p-r-50 p-t-5 p-lr-0-lg">
                        <h4 class="mtext-105 cl2 js-name-detail p-b-14">
                            (내맘) 적금
                        </h4>

                        <span class="mtext-106 cl2">
                                    자유적립식, 정액적립식
                                </span>

                        <p class="stext-102 cl3 p-t-23">
                            저축금액, 만기일, 자동이체 구간까지 내맘대로
                            디자인하는 DIY 적금
                        </p>

                        <!--  -->
                        <div class="p-t-33">
                            <div class="flex-w flex-r-m p-b-10">
                                <div
                                        class="size-203 flex-c-m respon6 font-light"
                                >
                                    출금 계좌
                                </div>

                                <div class="size-204 respon6-next">
                                    <div class="rs1-select2 bor8 bg0">
                                        <select
                                                class="js-select2"
                                                name="time"
                                        >
                                            <option>계좌 선택</option>
                                            <option>
                                                하나 입출금
                                                통장(저축예금)
                                                910-910203-22007
                                            </option>
                                        </select>
                                        <div
                                                class="dropDownSelect2"
                                        ></div>
                                    </div>
                                </div>
                            </div>

                            <div class="flex-w flex-r-m p-b-10">
                                <div
                                        class="size-203 flex-c-m respon6 font-light"
                                >
                                    금액
                                </div>

                                <div class="size-204 respon6-next">
                                    <div class="rs1-select2 bor8 bg0">
                                        <select
                                                class="js-select2"
                                                name="time"
                                        >
                                            <option>금액 선택</option>
                                            <option>1,000원</option>
                                            <option>10,000원</option>
                                            <option>20,000원</option>
                                            <option>30,000원</option>
                                        </select>
                                        <div
                                                class="dropDownSelect2"
                                        ></div>
                                    </div>
                                </div>
                            </div>

                            <!-- Color 선택 밑에 친구 선택 추가 -->

                            <div class="flex-w flex-r-m p-b-10">
                                <div
                                        class="size-203 flex-c-m respon6 font-light"
                                >
                                    친구
                                </div>

                                <div
                                        class="size-204 respon6-next"
                                        id="friendSelectionContainer"
                                >
                                    <button
                                            data-toggle="modal"
                                            data-target="#friendModal"
                                            id="selectFriendButton"
                                    >
                                        친구 선택
                                    </button>
                                    <button id="giftByContactButton">
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
                                                class="form-control"
                                                placeholder="이름(실명) 입력"
                                        />
                                        <input
                                                type="text"
                                                id="recipientPhone"
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
                            <!-- Modal -->
                            <div
                                    class="modal fade"
                                    id="friendModal"
                                    tabindex="-1"
                                    role="dialog"
                                    aria-labelledby="friendModalLabel"
                                    aria-hidden="true"
                            >
                                <div
                                        class="modal-dialog modal-dialog-centered"
                                        role="document"
                                >
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5
                                                    class="modal-title"
                                                    id="friendModalLabel"
                                            >
                                                친구를 선택해주세요!
                                            </h5>
                                            <button
                                                    type="button"
                                                    class="close"
                                                    data-dismiss="modal"
                                                    aria-label="Close"
                                            >
                                                        <span aria-hidden="true"
                                                        >&times;</span
                                                        >
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <input
                                                    type="text"
                                                    id="friendSearchInput"
                                                    class="form-control"
                                                    placeholder="Search for friends..."
                                            />
                                            <div
                                                    class="friend-list mt-3"
                                            >
                                                <!-- 예시 친구 목록 -->
                                                <div
                                                        class="friend-item"
                                                        data-friend-name="John Doe"
                                                        data-friend-status="Online"
                                                >
                                                    <img
                                                            src="/images/profile.png"
                                                            alt="Friend 1"
                                                            class="friend-avatar"
                                                    />
                                                    <div
                                                            class="friend-info"
                                                    >
                                                        <p
                                                                class="friend-name"
                                                        >
                                                            김현석
                                                        </p>
                                                        <span
                                                                class="status-indicator online"
                                                        >Online</span
                                                        >
                                                    </div>
                                                </div>
                                                <div
                                                        class="friend-item"
                                                        data-friend-name="Jane Smith"
                                                        data-friend-status="Offline"
                                                >
                                                    <img
                                                            src="/images/profile.png"
                                                            alt="Friend 2"
                                                            class="friend-avatar"
                                                    />
                                                    <div
                                                            class="friend-info"
                                                    >
                                                        <p
                                                                class="friend-name"
                                                        >
                                                            양진안
                                                        </p>
                                                        <span
                                                                class="status-indicator offline"
                                                        >Offline</span
                                                        >
                                                    </div>
                                                </div>
                                                <!-- 추가 친구 목록 -->
                                                <div
                                                        class="friend-item"
                                                        data-friend-name="김정우"
                                                        data-friend-status="Online"
                                                >
                                                    <img
                                                            src="${pageContext.request.contextPath}/resources/images/profile.png"
                                                            alt="Friend 3"
                                                            class="friend-avatar"
                                                    />
                                                    <div
                                                            class="friend-info"
                                                    >
                                                        <p
                                                                class="friend-name"
                                                        >
                                                            김정우
                                                        </p>
                                                        <span
                                                                class="status-indicator online"
                                                        >Online</span
                                                        >
                                                    </div>
                                                </div>
                                                <div
                                                        class="friend-item"
                                                        data-friend-name="Charlie Green"
                                                        data-friend-status="Offline"
                                                >
                                                    <img
                                                            src="/images/profile.png"
                                                            alt="Friend 4"
                                                            class="friend-avatar"
                                                    />
                                                    <div
                                                            class="friend-info"
                                                    >
                                                        <p
                                                                class="friend-name"
                                                        >
                                                            최현욱
                                                        </p>
                                                        <span
                                                                class="status-indicator offline"
                                                        >Offline</span
                                                        >
                                                    </div>
                                                </div>
                                                <!-- 더 많은 친구 목록을 추가 -->
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button
                                                    type="button"
                                                    class="btn btn-secondary"
                                                    data-dismiss="modal"
                                            >
                                                닫기
                                            </button>
                                            <button
                                                    type="button"
                                                    class="btn btn-primary"
                                                    id="selectFriendBtn"
                                            >
                                                선택
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="flex-w flex-r-m p-b-10">
                                <div
                                        class="size-204 flex-w flex-m respon6-next"
                                >
                                    <button
                                            class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04 js-addcart-detail"
                                    >
                                        선물하기
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!--  -->
                        <div
                                class="flex-w flex-m p-l-100 p-t-40 respon7"
                        >
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
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
