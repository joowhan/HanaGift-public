<%--
  Created by IntelliJ IDEA.
  User: gimjuhwan
  Date: 8/19/24
  Time: 8:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="kr">
<head>
    <title>Product</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <jsp:include page="component/head.jsp" flush="false"/>
    <!--===============================================================================================-->
</head>
<body class="animsition">
<!-- Header -->
<jsp:include page="component/header.jsp" flush="false"/>
<!-- Cart -->
<jsp:include page="component/friend_tap.jsp" flush="false"/>

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
    $(".js-addwish-b2, .js-addwish-detail").on("click", function (e) {
        e.preventDefault();
    });

    $(".js-addwish-b2").each(function () {
        var nameProduct = $(this)
            .parent()
            .parent()
            .find(".js-name-b2")
            .html();
         // productId를 데이터 속성에서 가져옴

        $(this).on("click", function () {
            swal(nameProduct, "위시리스트에 추가했어요!!", "success");

            // AJAX로 컨트롤러 호출
            $.ajax({
                url: "${pageContext.request.contextPath}/wishlist/add", // Controller URL
                method: "POST",
                data: {
                    // 서버로 전송할 데이터
                    productName: nameProduct
                },
                success: function(response) {
                    if (response.status === "success") {
                        swal(nameProduct, response.message, "success");
                    } else {
                        swal(nameProduct, response.message, "error");
                    }
                    console.log(response);
                },
                error: function(xhr, status, error) {
                    console.error("위시리스트 추가 중 오류 발생:", error);
                    swal(nameProduct, "서버 오류가 발생했습니다.", "error");
                }
            });


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
        // // productId를 데이터 속성에서 가져옴

        $(this).on("click", function () {
            swal(nameProduct, "위시리스트에 추가했어요!", "success");

            // AJAX로 컨트롤러 호출
            $.ajax({
                url: "${pageContext.request.contextPath}/wishlist/add", // Controller URL
                method: "POST",
                data: {
                    // 서버로 전송할 데이터
                    productName: nameProduct
                },
                success: function(response) {
                    if (response.status === "success") {
                        swal(nameProduct, response.message, "success");
                    } else {
                        swal(nameProduct, response.message, "error");
                    }
                    console.log(response);
                },
                error: function(xhr, status, error) {
                    console.error("위시리스트 추가 중 오류 발생:", error);
                    swal(nameProduct, "서버 오류가 발생했습니다.", "error");
                }
            });


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
