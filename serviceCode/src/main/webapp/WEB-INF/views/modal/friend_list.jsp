<%--
  Created by IntelliJ IDEA.
  User: gimjuhwan
  Date: 8/22/24
  Time: 10:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<section class="bg0 p-t-75 p-b-120">
    <div class="container">
        <div class="container">
            <!-- 친구 목록과 마이페이지를 함께 포함하는 섹션 -->
            <div class="row p-b-50 mt-5 mb-4">
                <!-- 텍스트와 아이콘 섹션 -->
                <div class="col-md-9 col-lg-8 offset-lg-2">
                    <div class="gift-header">
                        <img
                                src="${pageContext.request.contextPath}/resources/images/friend_list.png"
                                alt="선물 아이콘"
                                class="gift-icon1"
                        />
                        <div class="text-container">
                            <h3 class="mtext-111 cl14 mb-3">
                                내 친구 목록
                            </h3>
                            <p class="stext-113 cl6">
                                친구 맺기를 통해 쉽고 간편하게
                                선물해보세요!
                            </p>
                        </div>
                    </div>
                </div>

                <!-- 이미지 섹션 -->
                <div class="col-11 col-md-5 col-lg-4 m-lr-auto">
                    <div class="character-img">
                        <img
                                src="${pageContext.request.contextPath}/resources/images/hanacharacterAll.png"
                                alt="IMG"
                        />
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 col-lg-12 p-b-30">
                <div class="p-t-7 p-l-85 p-l-15-lg p-l-0-md">
                    <h3 class="mtext-111 cl2 p-b-16">친구 목록</h3>
                    <!-- 친구 목록 테이블 -->
                    <div class="container">
                        <!-- 친구 추가 버튼 -->
                        <div class="row justify-content-end">
                            <!-- 버튼을 오른쪽으로 정렬 -->
                            <div class="col-md-3">
                                <!-- col-md-12를 col-md-auto로 변경하여 버튼 크기에 맞게 조정 -->
                                <button
                                        class="btn add-friend-btn mb-4"
                                        data-toggle="modal"
                                        data-target="#addFriendModal"
                                >
                                    <img
                                            src="images/icons/plus.png"
                                            alt="친구 추가 아이콘"
                                            class="friend-icon"
                                    />
                                    친구 추가
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table
                                class="table table-borderless friend-table"
                                style="width: 100%"
                        >
                            <tbody id="friendTableBody">
                            <tr
                                    class="friend-row d-flex align-items-center border-bottom"
                            >
                                <td class="col-2 text-center">
                                    <img
                                            src="${pageContext.request.contextPath}/resources/images/profile.png"
                                            alt="Profile Image"
                                            class="img-fluid rounded-circle"
                                    />
                                </td>

                                <td class="col-4">
                                    <p class="m-0">John Doe</p>
                                    <p class="text-muted small m-0">
                                        Feeling good today!
                                    </p>
                                </td>
                                <td class="col-2 text-center">
                                    <button
                                            class="btn btn-sm btn-info"
                                    >
                                        상세보기
                                    </button>
                                </td>
                                <td class="col-2 text-center">
                                    <button
                                            class="btn btn-sm btn-danger"
                                    >
                                        삭제
                                    </button>
                                </td>
                                <td class="col-2 text-center">
                                    <i
                                            class="fa fa-star-o"
                                            style="cursor: pointer"
                                    ></i>
                                </td>
                            </tr>
                            <tr
                                    class="friend-row d-flex align-items-center border-bottom"
                            >
                                <td class="col-2 text-center">
                                    <img
                                            src="${pageContext.request.contextPath}/resources/images/profile.png"
                                            alt="Profile Image"
                                            class="img-fluid rounded-circle"
                                    />
                                </td>
                                <td class="col-4">
                                    <p class="m-0">Jane Smith</p>
                                    <p class="text-muted small m-0">
                                        Just chilling...
                                    </p>
                                </td>
                                <td class="col-2 text-center">
                                    <button
                                            class="btn btn-sm btn-info"
                                    >
                                        상세보기
                                    </button>
                                </td>
                                <td class="col-2 text-center">
                                    <button
                                            class="btn btn-sm btn-danger"
                                    >
                                        삭제
                                    </button>
                                </td>
                                <td class="col-2 text-center">
                                    <i
                                            class="fa fa-star-o"
                                            style="cursor: pointer"
                                    ></i>
                                </td>
                            </tr>
                            <tr
                                    class="friend-row d-flex align-items-center border-bottom"
                            >
                                <td class="col-2 text-center">
                                    <img
                                            src="${pageContext.request.contextPath}/resources/images/profile.png"
                                            alt="Profile Image"
                                            class="img-fluid rounded-circle"
                                    />
                                </td>
                                <td class="col-4">
                                    <p class="m-0">Jane Smith</p>
                                    <p class="text-muted small m-0">
                                        Just chilling...
                                    </p>
                                </td>
                                <td class="col-2 text-center">
                                    <button
                                            class="btn btn-sm btn-info"
                                    >
                                        상세보기
                                    </button>
                                </td>
                                <td class="col-2 text-center">
                                    <button
                                            class="btn btn-sm btn-danger"
                                    >
                                        삭제
                                    </button>
                                </td>
                                <td class="col-2 text-center">
                                    <i
                                            class="fa fa-star-o"
                                            style="cursor: pointer"
                                    ></i>
                                </td>
                            </tr>
                            <tr
                                    class="friend-row d-flex align-items-center border-bottom"
                            >
                                <td class="col-2 text-center">
                                    <img
                                            src="${pageContext.request.contextPath}/resources/images/profile.png"
                                            alt="Profile Image"
                                            class="img-fluid rounded-circle"
                                    />
                                </td>
                                <td class="col-4">
                                    <p class="m-0">Jane Smith</p>
                                    <p class="text-muted small m-0">
                                        Just chilling...
                                    </p>
                                </td>
                                <td class="col-2 text-center">
                                    <button
                                            class="btn btn-sm btn-info"
                                    >
                                        상세보기
                                    </button>
                                </td>
                                <td class="col-2 text-center">
                                    <button
                                            class="btn btn-sm btn-danger"
                                    >
                                        삭제
                                    </button>
                                </td>
                                <td class="col-2 text-center">
                                    <i
                                            class="fa fa-star-o"
                                            style="cursor: pointer"
                                    ></i>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>
