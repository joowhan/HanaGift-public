document.addEventListener("DOMContentLoaded", function () {
    // Sign Up 버튼 클릭 시
    document
        .getElementById("toggleSignIn")
        .addEventListener("click", function () {
            document.getElementById("sign-up-container").classList.add("hide");
            document
                .getElementById("sign-in-container")
                .classList.remove("hide");
            document
                .getElementById("toggleSignIn")
                .classList.add("active-signin");
            document
                .getElementById("toggleSignUp")
                .classList.remove("active-signup");
        });

    // Sign In 버튼 클릭 시
    document
        .getElementById("toggleSignUp")
        .addEventListener("click", function () {
            document.getElementById("sign-in-container").classList.add("hide");
            document
                .getElementById("sign-up-container")
                .classList.remove("hide");
            document
                .getElementById("toggleSignUp")
                .classList.add("active-signup");
            document
                .getElementById("toggleSignIn")
                .classList.remove("active-signin");
        });

    // 페이지 로드 시 기본적으로 Sign Up 폼만 보이도록 설정
    document.getElementById("sign-up-container").classList.remove("hide");
    document.getElementById("sign-in-container").classList.add("hide");
    document.getElementById("toggleSignUp").classList.add("active-signup");
});
