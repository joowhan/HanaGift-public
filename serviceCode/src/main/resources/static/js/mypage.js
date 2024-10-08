document.addEventListener("DOMContentLoaded", function () {
    // 수정하기 버튼 클릭 이벤트
    const editButton = document.querySelector(".edit-btn");

    if (editButton) {
        editButton.addEventListener("click", function () {
            // Bootstrap의 모달을 띄우는 코드
            $("#editProfileModal").modal("show");
        });
    }

    // 파일 선택 시 이미지 미리보기 업데이트
    const profileImageInput = document.querySelector("#profileImage");
    const imagePreviewElement = document.querySelector("#imagePreview");
    const profileImageElement = document.querySelector(
        ".profile-container .profile-img img"
    );

    if (profileImageInput) {
        profileImageInput.addEventListener("change", function () {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();

                reader.onload = function (e) {
                    // 미리보기 이미지에 파일 데이터 설정
                    imagePreviewElement.src = e.target.result;
                    imagePreviewElement.style.display = "block"; // 이미지 표시
                };

                reader.readAsDataURL(file);
            }
        });
    }

    // 모달에서 저장하기 버튼 클릭 시 프로필 정보 변경
    const saveButton = document.querySelector("#editProfileModal .btn-primary");
    const emailInput = document.querySelector("#email");
    const phoneNumberInput = document.querySelector("#phoneNumber");
    const emailElement = document.querySelector(".info-section strong + span");
    const phoneNumberElement = document.querySelector(
        ".info-section strong + span + span"
    );

    if (saveButton) {
        saveButton.addEventListener("click", function () {
            // 프로필 이미지 업데이트
            if (profileImageInput.files.length > 0) {
                const file = profileImageInput.files[0];
                const reader = new FileReader();

                reader.onload = function (e) {
                    profileImageElement.src = e.target.result;
                };

                reader.readAsDataURL(file);
            }

            // 이메일 업데이트
            if (emailInput && emailInput.value) {
                emailElement.textContent = emailInput.value;
            }

            // 전화번호 업데이트
            if (phoneNumberInput && phoneNumberInput.value) {
                phoneNumberElement.textContent = phoneNumberInput.value;
            }

            // 모달 닫기
            $("#editProfileModal").modal("hide");
        });
    }
});



