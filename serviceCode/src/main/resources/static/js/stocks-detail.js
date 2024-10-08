document.addEventListener("DOMContentLoaded", function () {
    var swiperLeft = new Swiper(".swiper-container-left", {
        loop: true,
        speed: 10000,
        autoplay: {
            delay: 0,
            disableOnInteraction: false,
        },
        slidesPerView: 1,
        centeredSlides: true,
        allowTouchMove: false,
    });

    var swiperRight = new Swiper(".swiper-container-right", {
        loop: true,
        speed: 10000,
        autoplay: {
            delay: 0,
            disableOnInteraction: false,
        },
        slidesPerView: 1,
        centeredSlides: true,
        allowTouchMove: false,
        reverseDirection: true,
    });
});
