<%--
  Created by IntelliJ IDEA.
  User: gimjuhwan
  Date: 8/30/24
  Time: 7:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<!-- Review Modal -->
<div
        class="modal fade"
        id="reviewModal"
        tabindex="-1"
        role="dialog"
        aria-labelledby="reviewModalLabel"
        aria-hidden="true"
>
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5
                        class="modal-title"
                        id="reviewModalLabel"
                >
                    상품에 리뷰를 달아주세요!
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
                <form class="w-full" action="${pageContext.request.contextPath}/submitReview" method="post">
                    <div
                            class="flex-w flex-m p-t-50 p-b-23"
                    >
                                                    <span
                                                            class="stext-102 cl3 m-r-16"
                                                    >만족도</span
                                                    >
                        <span
                                class="wrap-rating fs-18 cl11 pointer"
                        >
                                                        <i
                                                                class="item-rating pointer zmdi zmdi-star-outline"
                                                        ></i>
                                                        <i
                                                                class="item-rating pointer zmdi zmdi-star-outline"
                                                        ></i>
                                                        <i
                                                                class="item-rating pointer zmdi zmdi-star-outline"
                                                        ></i>
                                                        <i
                                                                class="item-rating pointer zmdi zmdi-star-outline"
                                                        ></i>
                                                        <i
                                                                class="item-rating pointer zmdi zmdi-star-outline"
                                                        ></i>
                                                        <input
                                                                class="dis-none"
                                                                type="number"
                                                                name="stars"
                                                        />
                                                    </span>
                    </div>
                    <div class="row p-b-25">
                        <div class="col-12 p-b-5">
                            <label
                                    class="stext-102 cl3"
                                    for="review"
                            >해당 상품은 어떤가요?</label
                            >
                            <textarea
                                    class="size-110 bor8 stext-102 cl2 p-lr-20 p-tb-10"
                                    id="review"
                                    name="reviewText"
                            ></textarea>
                        </div>
                    </div>
                    <input type="hidden" name="productID" value="${savingProduct.productId}" />
                    <button
                            type="submit"
                            class="flex-c-m stext-101 cl0 size-112 bg7 bor11 hov-btn3 p-lr-15 trans-04 m-b-10"
                    >
                        리뷰 쓰기
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
