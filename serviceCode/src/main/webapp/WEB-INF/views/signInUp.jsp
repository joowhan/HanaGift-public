<%--
  Created by IntelliJ IDEA.
  User: gimjuhwan
  Date: 9/22/24
  Time: 10:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>로그인</title>
    <jsp:include page="component/head.jsp" flush="false"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/signInUp.css" />
    <style>
        .title-header {
            display: flex;
            align-items: center; /* 이미지와 텍스트를 수직으로 중앙 정렬 */
        }

        .text-container {
            margin-left: 15px; /* 이미지와 텍스트 사이의 간격 설정 */
        }

        .title-header h3.mtext-111 {
            font-family: "HanaFont-CM"; /* 제목 폰트 적용 */
            margin-bottom: 0; /* 텍스트 간의 간격을 조정 */
        }

        .title-header p.stext-113 {
            font-family: "HanaFont-CM"; /* 설명글 폰트 적용 */
            margin-top: 5px; /* 제목과 설명 글 사이의 간격 설정 */
            margin-bottom: 0; /* 텍스트 간의 간격을 조정 */
        }

        .gift-icon {
            width: 60px; /* 이미지 크기 조정 */
            height: auto;
        }
    </style>
</head>
<body>
<jsp:include page="component/header.jsp" flush="false"/>
<section class="signup-login-section bg0 p-t-75 p-b-120">
    <div class="container">
        <!-- 제목 영역 복원 -->
        <div class="row mt-4 mb-4">
            <div class="col-md-8">
                <div class="title-header">
                    <img src="${pageContext.request.contextPath}/resources/images/signInUp.png" alt="선물 아이콘" class="gift-icon" />
                    <div class="text-container ml-3">
                        <h3 class="mtext-111 cl14 mb-3">로그인 및 회원가입</h3>
                        <p class="stext-113 cl6">선물은 하나에서, 하나Gift로 마음을 전해보세요.</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="row justify-content-center align-items-center">
            <!-- Form Section -->
            <div class="col-md-8">
                <div class="form-container custom-form-container">
                    <div class="form-header">
                        <h2 id="form-title" class="form-title">로그인</h2>
                    </div>
                    <form id="signup-form">
                        <!-- 회원가입 폼 -->
                        <div id="signup-content" class="row hidden">
                            <div class="col-md-6">
                                <div class="form-group custom-form-group">
                                    <label for="name" class="form-label">이름 <span class="required">*</span></label>
                                    <input type="text" id="name" name="name" class="form-input" placeholder="실명을 입력해주세요." required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group custom-form-group">
                                    <label for="userId" class="form-label">ID <span class="required">*</span></label>
                                    <input type="text" id="userId" name="userId" class="form-input" placeholder="ID" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group custom-form-group d-flex">
                                    <div class="flex-grow-1">
                                        <label for="phone" class="form-label">전화번호 <span class="required">*</span></label>
                                        <input type="text" id="phone" name="phone" class="form-input" placeholder="000-0000-0000" required>
                                    </div>
                                    <button type="button" class="btn btn-secondary verify-btn">인증 요청</button>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group custom-form-group d-flex">
                                    <div class="flex-grow-1">
                                        <label for="verification-code" class="form-label">인증 코드 <span class="required">*</span></label>
                                        <input type="text" id="verification-code" name="verificationCode" class="form-input" placeholder="코드를 입력해주세요." required>
                                    </div>
                                    <button type="button" class="btn btn-secondary verify-btn" id="validate-code">인증 완료</button>
                                    <span id="verification-status" class="ml-2"></span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group custom-form-group">
                                    <label for="password" class="form-label">비밀번호 <span class="required">*</span></label>
                                    <input type="password" id="password" name="password" class="form-input" placeholder="비밀번호를 입력해주세요." required>
                                    <div id="password-check" class="text-danger"></div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group custom-form-group">
                                    <label for="confirm-password" class="form-label">비밀번호 확인 <span class="required">*</span></label>
                                    <input type="password" id="confirm-password" name="confirmPassword" class="form-input" placeholder="비밀번호를 다시 입력해주세요." required>
                                    <div id="confirm-password-check" class="text-danger"></div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group custom-form-group">
                                    <label for="email" class="form-label">이메일 <span class="required">*</span></label>
                                    <input type="email" id="email" name="email" class="form-input" placeholder="이메일을 입력해주세요." required>
                                </div>
                            </div>
                            <!-- 주민등록번호 필드 -->
                            <div class="col-md-6">
                                <div class="form-group custom-form-group">
                                    <label for="ssn-front" class="form-label">주민등록번호 <span class="required">*</span></label>
                                    <div class="d-flex align-items-center">
                                        <input type="text" id="ssn-front" name="ssnFront" class="form-input" maxlength="6" placeholder="앞 6자리" required>
                                        <span class="mx-2">-</span>
                                        <div class="ssn-back-container">
                                            <input type="password" id="ssn-back" name="ssnBack" class="form-input ssn-back-input" maxlength="1" placeholder="1" required>
                                            <div class="ssn-back-mask">******</div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- 프로필 이미지 선택 -->
                            <div class="col-12" id="profile-image-selection">
                                <h4>프로필 이미지 선택</h4>
                                <div class="profile-image-container d-flex justify-content-between">
                                    <img src="${pageContext.request.contextPath}/resources/images/mo_list1.png" alt="Profile 1" class="profile-img" id="profile1">
                                    <img src="${pageContext.request.contextPath}/resources/images/profile2.png" alt="Profile 2" class="profile-img" id="profile2">
                                    <img src="${pageContext.request.contextPath}/resources/images/1490514_list.png" alt="Profile 3" class="profile-img" id="profile3">
                                    <img src="${pageContext.request.contextPath}/resources/images/1496221_thum.png" alt="Profile 4" class="profile-img" id="profile4">
                                    <img src="${pageContext.request.contextPath}/resources/images/1496609_list-thumbnail.png" alt="Profile 5" class="profile-img" id="profile5">
                                </div>
                                <input type="hidden" id="selected-profile" name="selectedProfile" value="">
                            </div>

                            <div class="col-12">
                                <div class="checkbox-group custom-checkbox-group">
                                    <input type="checkbox" id="terms" name="terms" required>
                                    <label for="terms" class="form-label">하나Gift의 서비스 약관과 개인정보 사용에 동의합니다.</label>
                                </div>
                            </div>
                        </div>

                        <!-- 로그인 폼 -->
                        <div id="login-content">
                            <div class="form-group custom-form-group">
                                <label for="login-id" class="form-label">ID</label>
                                <input type="text" id="login-id" name="loginId" class="form-input" placeholder="ID를 입력하세요." required>
                            </div>
                            <div class="form-group custom-form-group">
                                <label for="login-password" class="form-label">비밀번호</label>
                                <input type="password" id="login-password" name="loginPassword" class="form-input" placeholder="비밀번호를 입력해주세요." required>
                            </div>
                        </div>

                        <!-- 회원가입과 로그인 버튼 -->
                        <div class="button-group d-flex justify-content-between">
                            <button type="submit" class="btn custom-btn btn-signup hidden" id="signup-btn">회원가입하기</button>
                            <button type="submit" class="btn custom-btn btn-login" id="login-btn">로그인하기</button>
                        </div>
                    </form>

                    <div class="form-footer text-center mt-3">
                        <a href="#" id="toggle-login" class="toggle-link hidden">로그인하기</a>
                        <a href="#" id="toggle-signup" class="toggle-link">회원가입하기</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>



<!-- 스크립트: 폼 전환 및 버튼 상태 변경 -->



<jsp:include page="component/footer.jsp" flush="false"/>
</body>
<script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/popper.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/select2/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/sweetalert/sweetalert.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.min.js"></script>
<script>
    // 비밀번호 유효성 검사
    document.getElementById("signup-form").addEventListener("submit", function (e) {
        const password = document.getElementById("password").value;
        const confirmPassword = document.getElementById("confirm-password").value;
        const passwordRegex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*]).{8,16}$/;

        if (!passwordRegex.test(password)) {
            alert("비밀번호는 8~16자 사이, 숫자, 영문, 특수문자를 포함해야 합니다.");
            e.preventDefault();
            return;
        }

        if (password !== confirmPassword) {
            alert("비밀번호가 일치하지 않습니다.");
            e.preventDefault();
        }
    });

    // 프로필 이미지 선택
    // 프로필 이미지 선택
    document.addEventListener("DOMContentLoaded", function() {
        const profileImages = document.querySelectorAll(".profile-img");
        const selectedProfileInput = document.getElementById("selected-profile");

        profileImages.forEach(function(img) {
            img.addEventListener("click", function() {
                // 모든 이미지에서 선택 해제
                profileImages.forEach(function(i) {
                    i.classList.remove("selected-profile");
                });

                // 클릭한 이미지에 선택 클래스 추가
                this.classList.add("selected-profile");

                // 선택한 이미지 URL을 히든 필드에 저장
                selectedProfileInput.value = this.src;
            });
        });
    });



    // 회원가입과 로그인 폼 전환
    document.getElementById("toggle-signup").addEventListener("click", function (e) {
        e.preventDefault();
        document.getElementById("form-title").textContent = "회원가입";
        document.getElementById("login-content").classList.add("hidden");
        document.getElementById("signup-content").classList.remove("hidden");
        document.getElementById("toggle-signup").classList.add("hidden");
        document.getElementById("toggle-login").classList.remove("hidden");
        document.getElementById("login-btn").classList.add("hidden");
        document.getElementById("signup-btn").classList.remove("hidden");
        document.getElementById("profile-image-selection").classList.remove("hidden");
    });

    document.getElementById("toggle-login").addEventListener("click", function (e) {
        e.preventDefault();
        document.getElementById("form-title").textContent = "로그인";
        document.getElementById("signup-content").classList.add("hidden");
        document.getElementById("login-content").classList.remove("hidden");
        document.getElementById("toggle-login").classList.add("hidden");
        document.getElementById("toggle-signup").classList.remove("hidden");
        document.getElementById("signup-btn").classList.add("hidden");
        document.getElementById("login-btn").classList.remove("hidden");
        document.getElementById("profile-image-selection").classList.add("hidden");
    });

    // 주민등록번호 뒷자리는 1자리 입력만 허용하고 나머지는 마스킹 처리
    // 주민등록번호 뒷자리는 1자리 입력만 허용하고 나머지는 마스킹 처리
    document.getElementById('ssn-back').addEventListener('input', function () {
        var ssnBackInput = document.getElementById('ssn-back');
        if (ssnBackInput.value.length > 1) {
            ssnBackInput.value = ssnBackInput.value[0]; // 첫 번째 문자만 남기기
        }
    });
</script>

<%--문자 인증 API--%>
<script>
    document.querySelector('.verify-btn').addEventListener('click', function() {
        // 전화번호 입력 필드에서 값을 가져옵니다.
        var phone = document.getElementById('phone').value;

        if (phone) {
            // AJAX로 POST 요청을 보냅니다.
            $.ajax({
                type: 'POST',
                url: '/api/sms/validation', // 컨트롤러 URL
                data: { phone: phone }, // 전달할 데이터
                success: function(response) {
                    alert('인증번호가 전송되었습니다.');
                    console.log(response); // 성공적인 응답 처리
                },
                error: function(xhr, status, error) {
                    alert('인증번호 전송에 실패했습니다.');
                    console.error(error); // 에러 처리
                }
            });
        } else {
            alert('전화번호를 입력해주세요.');
        }
    });
    // 인증 코드 확인
    document.getElementById("validate-code").addEventListener("click", function () {
        const verificationCode = document.getElementById("verification-code").value;

        fetch('${pageContext.request.contextPath}/api/sms/verify-code', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ code: verificationCode })
        })
            .then(response => response.json())
            .then(data => {
                const verificationStatus = document.getElementById("verification-status");
                if (data.success) {
                    verificationStatus.textContent = '인증 성공';
                    verificationStatus.style.color = 'green';
                } else {
                    verificationStatus.textContent = '인증 실패';
                    verificationStatus.style.color = 'red';
                }
            })
            .catch(error => console.error('Error:', error));
    });

</script>

<script>
    // 비밀번호 검증용 정규표현식: 8~16자, 최소 1개의 영문자, 숫자, 특수문자 포함
    const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,16}$/;

    document.getElementById("password").addEventListener("input", function() {
        const password = this.value;
        const passwordCheck = document.getElementById("password-check");

        // 정규표현식으로 비밀번호 검증
        if (!passwordRegex.test(password)) {
            passwordCheck.textContent = "비밀번호는 8~16자의 영문자, 숫자, 특수문자 조합이어야 합니다.";
        } else {
            passwordCheck.textContent = "사용 가능한 비밀번호입니다.";
            passwordCheck.classList.remove("text-danger");
            passwordCheck.classList.add("text-success");
        }
    });

    // 비밀번호 일치 여부 확인
    document.getElementById("confirm-password").addEventListener("input", function() {
        const password = document.getElementById("password").value;
        const confirmPassword = this.value;
        const confirmPasswordCheck = document.getElementById("confirm-password-check");

        if (password !== confirmPassword) {
            confirmPasswordCheck.textContent = "비밀번호가 일치하지 않습니다.";
            confirmPasswordCheck.classList.add("text-danger");
        } else {
            confirmPasswordCheck.textContent = "비밀번호가 일치합니다.";
            confirmPasswordCheck.classList.remove("text-danger");
            confirmPasswordCheck.classList.add("text-success");
        }
    });
</script>

<%--회원가입--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
<script>
    document.getElementById("signup-btn").addEventListener("click", function(e) {
        e.preventDefault();

        // 비밀번호를 SHA-256으로 암호화
        var password = document.getElementById("password").value;
        var hashedPassword = CryptoJS.SHA256(password).toString();

        // 다른 필드 값 가져오기
        var userId = document.getElementById("userId").value;
        var phoneNumber = document.getElementById("phone").value;
        var ssnFront = document.getElementById("ssn-front").value;
        var ssnBack = document.getElementById("ssn-back").value;
        var email = document.getElementById("email").value;
        var name = document.getElementById("name").value;
        var profileUrl = "";
        var selectedProfile = document.querySelector('.profile-img.selected');
        if (selectedProfile) {
            profileUrl = selectedProfile.src;  // 선택된 이미지의 URL
        } else {
            // 선택된 이미지가 없으면 기본값 설정 또는 경고 메시지
            profileUrl = "/resources/images/default-profile.png"; // 기본 프로필 이미지 경로
        }

        var ssn = ssnFront + "-" + ssnBack + "******";  // 주민등록번호 완성

        // 회원가입 데이터 객체 생성
        var userData = {
            userId: userId,
            password: hashedPassword, // 암호화된 비밀번호
            phoneNumber: phoneNumber,
            ssn: ssn,
            email: email,
            name: name,
            profileUrl: profileUrl
        };
        console.log(userData);
        // AJAX 요청으로 서버로 데이터 전송
        fetch('${pageContext.request.contextPath}/custom-signup', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(userData)
        }).then(response => response.json())
            .then(data => {
                if (data.success) {
                    swal({
                        title: "회원가입 성공!",
                        text: "회원가입이 완료되었습니다.",
                        icon: "success",
                        button: "확인"
                    }).then(() => {
                        // 성공 후 리다이렉션 처리 등을 여기에 추가 가능
                        window.location.href = "/loginPage";
                    });
                } else {
                    swal({
                        title: "회원가입 실패",
                        text: "회원가입 실패: " + data.message,
                        icon: "error",
                        button: "확인"
                    });
                }
            }).catch(error => {
            swal({
                title: "오류 발생",
                text: "서버와의 통신 중 오류가 발생했습니다.",
                icon: "error",
                button: "확인"
            });
            console.error('Error:', error);
        });

    });

    // 프로필 이미지 선택 처리
    document.querySelectorAll('.profile-img').forEach(img => {
        img.addEventListener('click', function() {
            document.querySelectorAll('.profile-img').forEach(i => i.classList.remove('selected'));
            this.classList.add('selected');
        });
    });
</script>

<%--로그인--%>
<script>
    document.getElementById("login-btn").addEventListener("click", function(e) {
        e.preventDefault();

        // 로그인 데이터 가져오기
        var loginId = document.getElementById("login-id").value;
        var loginPassword = document.getElementById("login-password").value;

        // 비밀번호를 SHA-256으로 암호화
        var hashedLoginPassword = CryptoJS.SHA256(loginPassword).toString();

        var loginData = {
            userId: loginId,
            password: hashedLoginPassword
        };

        console.log("로그인 데이터:", loginData);

        // AJAX 요청으로 로그인 데이터 전송
        fetch('${pageContext.request.contextPath}/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(loginData)
        }).then(response => response.json())
            .then(data => {
                if (data.success) {
                    swal({
                        title: "로그인 성공!",
                        text: "로그인이 완료되었습니다.",
                        icon: "success",
                        button: "확인"
                    }).then(() => {
                        window.location.href = "${pageContext.request.contextPath}/"; // 성공 후 리다이렉션
                    });
                } else {
                    swal({
                        title: "로그인 실패",
                        text: "로그인 실패: " + data.message,
                        icon: "error",
                        button: "확인"
                    });
                }
            }).catch(error => {
            swal({
                title: "오류 발생",
                text: "서버와의 통신 중 오류가 발생했습니다.",
                icon: "error",
                button: "확인"
            });
            console.error('Error:', error);
        });
    });

</script>
</html>
