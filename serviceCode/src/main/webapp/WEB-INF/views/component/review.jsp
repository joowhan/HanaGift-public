<%--
  Created by IntelliJ IDEA.
  User: gimjuhwan
  Date: 8/30/24
  Time: 7:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<!-- 리뷰 영역 -->
<div
        class="tab-pane fade"
        id="reviews"
        role="tabpanel"
>
    <div class="row">
        <div
                class="col-sm-10 col-md-8 col-lg-6 m-lr-auto"
        >
            <div class="p-b-30 m-lr-15-sm">
                <!-- Reviews List -->
                <c:forEach var="review" items="${reviews}">
                    <div class="review-item flex-w flex-t p-b-68">
                        <div class="wrap-pic-s size-109 bor0 of-hidden m-r-18 m-t-6">
                            <img src="${pageContext.request.contextPath}/resources/images/profile2.png" alt="AVATAR" />
                        </div>
                        <div class="size-207">
                            <div class="flex-w flex-sb-m p-b-17">
                                <div>
                                    <span class="mtext-107 cl2 p-r-20">${review.userID}</span>
                                    <span class="stext-102 cl6">${review.writtenDate}</span>
                                </div>
                                <span class="fs-18 cl11">
                                    <c:forEach begin="1" end="${review.stars}">
                                        <i class="zmdi zmdi-star"></i>
                                    </c:forEach>
                                    <c:forEach begin="1" end="${5 - review.stars}">
                                        <i class="zmdi zmdi-star-outline"></i>
                                    </c:forEach>
                                </span>
                            </div>
                            <p class="stext-102 cl6">
                                    ${review.reviewText}
                            </p>
                        </div>
                    </div>
                </c:forEach>
                <!-- Add Review Button -->
                <button
                        class="flex-c-m stext-101 cl0 size-112 bg7 bor11 hov-btn3 p-lr-15 trans-04 m-b-10"
                        data-toggle="modal"
                        data-target="#reviewModal"
                >
                    리뷰 추가하기
                </button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
