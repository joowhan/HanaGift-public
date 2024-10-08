
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="kr">
<head>
    <title>하나다움</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!--===============================================================================================-->
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/icons/favicon.png" />
    <!--===============================================================================================-->
    <link
            rel="stylesheet"
            type="text/css"
            href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.min.css"
    />
    <!-- =============================================================================================== -->
    <link
            rel="stylesheet"
            type="text/css"
            href="${pageContext.request.contextPath}/resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css"
    />
    <!--===============================================================================================-->
    <link
            rel="stylesheet"
            type="text/css"
            href="${pageContext.request.contextPath}/resources/fonts/iconic/css/material-design-iconic-font.min.css"
    />
    <!--===============================================================================================-->
    <link
            rel="stylesheet"
            type="text/css"
            href="${pageContext.request.contextPath}/resources/fonts/linearicons-v1.0.0/icon-font.min.css"
    />
    <!--===============================================================================================-->
    <link
            rel="stylesheet"
            type="text/css"
            href="${pageContext.request.contextPath}/resources/vendor/animate/animate.css"
    />
    <!--===============================================================================================-->
    <link
            rel="stylesheet"
            type="text/css"
            href="${pageContext.request.contextPath}/resources/vendor/css-hamburgers/hamburgers.min.css"
    />
    <!--===============================================================================================-->
    <link
            rel="stylesheet"
            type="text/css"
            href="${pageContext.request.contextPath}/resources/vendor/animsition/css/animsition.min.css"
    />
    <!--===============================================================================================-->
    <link
            rel="stylesheet"
            type="text/css"
            href="${pageContext.request.contextPath}/resources/vendor/select2/select2.min.css"
    />
    <!--===============================================================================================-->
    <link
            rel="stylesheet"
            type="text/css"
            href="${pageContext.request.contextPath}/resources/vendor/daterangepicker/daterangepicker.css"
    />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/vendor/slick/slick.css" />
    <!--===============================================================================================-->
    <link
            rel="stylesheet"
            type="text/css"
            href="${pageContext.request.contextPath}/resources/vendor/MagnificPopup/magnific-popup.css"
    />
    <!--===============================================================================================-->
    <link
            rel="stylesheet"
            type="text/css"
            href="${pageContext.request.contextPath}/resources/vendor/perfect-scrollbar/perfect-scrollbar.css"
    />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/util.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css" />
    <!--===============================================================================================-->
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
    />
    <link
            href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
            rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="animsition">
<!-- Header -->
<jsp:include page="component/header.jsp" flush="false"/>
<!-- Cart -->
<jsp:include page="component/friend_tap.jsp" flush="false"/>

<!-- Slider -->
<section class="section-slide">
    <div class="wrap-slick1">
        <div class="slick1">
            <div
                    class="item-slick1"
                    style="
                            background-image: url(https://www.hanafn.com:8002/upload/common/upeditor/10000103/20240228//20240228051145815.png);
                        "
            >
                <div class="container h-full">
                    <div
                            class="flex-col-l-m h-full p-t-100 p-b-30 respon5"
                    >
                        <div
                                class="layer-slick1 animated visible-false"
                                data-appear="fadeInDown"
                                data-delay="0"
                        >
                                    <span class="ltext-101 cl0 respon2">
                                        선물은 하나!
                                    </span>
                            <span class="ltext-101 cl1 respon2">
                                        하나Gift
                                    </span>
                        </div>

                        <div
                                class="layer-slick1 animated visible-false"
                                data-appear="fadeInUp"
                                data-delay="800"
                        >
                            <h2
                                    class="ltext-201 cl0 p-t-19 p-b-43 respon1"
                            >
                                쉽고 빠른 금융 상품 선물
                            </h2>
                        </div>

                        <div
                                class="layer-slick1 animated visible-false"
                                data-appear="zoomIn"
                                data-delay="1600"
                        >
                            <a
                                    href="/productPage"
                                    class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04"
                            >
                                선물하러 가기
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div
                    class="item-slick1"
                    style="background-image: url(${pageContext.request.contextPath}/resources/images/main_banner6.png)"
            >
                <div class="container h-full">
                    <div
                            class="flex-col-l-m h-full p-t-100 p-b-30 respon5"
                    >
                        <div
                                class="layer-slick1 animated visible-false"
                                data-appear="fadeInDown"
                                data-delay="0"
                        >
                                    <span class="ltext-101 cl2 respon2">
                                        친구가 해외로 여행간다면?
                                    </span>
                        </div>

                        <div
                                class="layer-slick1 animated visible-false"
                                data-appear="fadeInUp"
                                data-delay="800"
                        >
                            <h2
                                    class="ltext-201 cl14 p-t-19 p-b-43 respon1"
                            >
                                하나머니 외화 선물하기
                            </h2>
                        </div>

                        <div
                                class="layer-slick1 animated visible-false"
                                data-appear="zoomIn"
                                data-delay="1600"
                        >
                            <a
                                    href="/productPage?productType=foreigncurrency"
                                    class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04"
                            >
                                외화 선물하기
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div
                    class="item-slick1"
                    style="background-image: url(${pageContext.request.contextPath}/resources/images/main_banner4.png)"
            >
                <div class="container h-full">
                    <div
                            class="flex-col-l-m h-full p-t-100 p-b-30 respon5"
                    >
                        <div
                                class="layer-slick1 animated visible-false"
                                data-appear="fadeInDown"
                                data-delay="0"
                        >
                                    <span class="ltext-101 cl13 respon2">
                                        인기 있는 소수점 주식,
                                    </span>
                        </div>

                        <div
                                class="layer-slick1 animated visible-false"
                                data-appear="fadeInUp"
                                data-delay="800"
                        >
                            <h2
                                    class="ltext-201 cl15 p-t-19 p-b-43 respon1"
                            >
                                선물 받아 '온주' 만들기!
                            </h2>
                        </div>

                        <div
                                class="layer-slick1 animated visible-false"
                                data-appear="zoomIn"
                                data-delay="1600"
                        >
                            <a
                                    href="/productPage?productType=stock"
                                    class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04"
                            >
                                주식 선물하기
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Banner -->
<div class="sec-banner bg0 p-t-80 p-b-50">
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-xl-4 p-b-30 m-lr-auto">
                <!-- Block1 -->
                <div class="block1 wrap-pic-w">
                    <img
                            src="${pageContext.request.contextPath}/resources/images/main_banner1.png"
                            alt="IMG-BANNER"
                    />

                    <a
                            href="/productPage?productType=savings"
                            class="block1-txt ab-t-l s-full flex-col-l-sb p-lr-38 p-tb-34 trans-03 respon3"
                    >
                        <div class="block1-txt-child1 flex-col-l">
                                    <span
                                            class="block1-name ltext-102 trans-04 p-b-8"
                                    >
                                        적금 선물하기
                                    </span>

                            <span
                                    class="block1-info stext-102 trans-04"
                            >
                                        하나은행 적금
                                    </span>
                        </div>

                        <div class="block1-txt-child2 p-b-4 trans-05">
                            <div
                                    class="block1-link stext-101 cl0 trans-09"
                            >
                                선물하기
                            </div>
                        </div>
                    </a>
                </div>
            </div>

            <div class="col-md-6 col-xl-4 p-b-30 m-lr-auto">
                <!-- Block1 -->
                <div class="block1 wrap-pic-w">
                    <img
                            src="${pageContext.request.contextPath}/resources/images/main_banner2.png"
                            alt="IMG-BANNER"
                    />

                    <a
                            href="/productPage?productType=stock"
                            class="block1-txt ab-t-l s-full flex-col-l-sb p-lr-38 p-tb-34 trans-03 respon3"
                    >
                        <div class="block1-txt-child1 flex-col-l">
                                    <span
                                            class="block1-name ltext-102 trans-04 p-b-8"
                                    >
                                        주식 선물하기
                                    </span>

                            <span
                                    class="block1-info stext-102 trans-04"
                            >
                                        하나증권 소수점 주식
                                    </span>
                        </div>

                        <div class="block1-txt-child2 p-b-4 trans-05">
                            <div
                                    class="block1-link stext-101 cl0 trans-09"
                            >
                                선물하기
                            </div>
                        </div>
                    </a>
                </div>
            </div>

            <div class="col-md-6 col-xl-4 p-b-30 m-lr-auto">
                <!-- Block1 -->
                <div class="block1 wrap-pic-w">
                    <img
                            src="${pageContext.request.contextPath}/resources/images/main_banner3.png"
                            alt="IMG-BANNER"
                    />

                    <a
                            href="/productPage?productType=foreigncurrency"
                            class="block1-txt ab-t-l s-full flex-col-l-sb p-lr-38 p-tb-34 trans-03 respon3"
                    >
                        <div class="block1-txt-child1 flex-col-l">
                                    <span
                                            class="block1-name ltext-102 trans-04 p-b-8"
                                    >
                                        외화 선물하기
                                    </span>

                            <span
                                    class="block1-info stext-102 trans-04"
                            >
                                        하나머니 트래블로그
                                    </span>
                        </div>

                        <div class="block1-txt-child2 p-b-4 trans-05">
                            <div
                                    class="block1-link stext-101 cl0 trans-09"
                            >
                                선물하기
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Product -->
<jsp:include page="component/product.jsp" flush="false"/>

<!-- Footer -->
<jsp:include page="component/footer.jsp" flush="false"/>

<!-- Back to top -->
<div class="btn-back-to-top" id="myBtn">
            <span class="symbol-btn-back-to-top">
                <i class="zmdi zmdi-chevron-up"></i>
            </span>
</div>

<!-- Modal1 -->
<jsp:include page="modal/saving_detail.jsp" flush="false"/>

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
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/isotope/isotope.pkgd.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/sweetalert/sweetalert.min.js"></script>
<script>
    $(".js-addwish-b2").on("click", function (e) {
        e.preventDefault();
    });

    $(".js-addwish-b2").each(function () {
        var nameProduct = $(this)
            .parent()
            .parent()
            .find(".js-name-b2")
            .html();
        $(this).on("click", function () {
            swal(nameProduct, "is added to wishlist !", "success");

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
            swal(nameProduct, "is added to wishlist !", "success");

            $(this).addClass("js-addedwish-detail");
            $(this).off("click");
        });
    });

    /*---------------------------------------------*/

    $(".js-addcart-detail").each(function () {
        var nameProduct = $(this)
            .parent()
            .parent()
            .parent()
            .parent()
            .find(".js-name-detail")
            .html();
        $(this).on("click", function () {
            swal(nameProduct, "is added to cart !", "success");
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
</body>
</html>
