document.addEventListener("DOMContentLoaded", function () {
    const modal = document.getElementById("userModal");
    const closeModalButton = modal.querySelector(".close");
    const friendRows = document.querySelectorAll(".friend-row");
    const tabs = document.querySelectorAll('.custom-nav-link');  // 탭 메뉴
    const wishlistContainer = document.getElementById("wishlistItems");

    friendRows.forEach((row) => {
        const detailButton = row.querySelector(".btn-view-details");

        detailButton.addEventListener("click", function () {
            const friendId = detailButton.getAttribute("data-friend-id");
            const profileUrl = detailButton.getAttribute("data-profile-url");

            // 프로필 이미지 설정
            document.getElementById("modalProfileImage").src = profileUrl;

            // AJAX 요청으로 친구의 상세 데이터 가져오기
            fetch(`/friendDetails`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams({userId: friendId})
            })
                .then(response => response.json())
                .then(data => {
                    const friendDetails = data.friendDetails;
                    const wishLists = data.wishLists || [];

                    // friendDetails가 null이면 swal로 알림 표시
                    if (!friendDetails) {
                        swal({
                            title: "사용자의 선물 정보가 없습니다",
                            text: "사용자가 받고 싶은 선물이 아직 없습니다.",
                            icon: "info",
                            buttons: {
                                confirm: {
                                    text: "확인",
                                    closeModal: true,
                                },
                            },
                        });
                        return;  // 함수를 종료하고 모달 표시 안함
                    }
                    // 프로필 정보 업데이트 (사용자 이름과 상태 메시지)
                    // 친구 이름과 상태 메시지를 해당 행에서 가져오기
                    const friendName = row.querySelector(".friend-name").textContent;
                    const friendStatusMessage = row.querySelector(".friend-status").textContent;
                    document.getElementById("modalUsername").textContent = friendName;  // 친구 이름 설정
                    document.getElementById("modalStatus").textContent = friendStatusMessage;  // 상태 메시지
                    // 받고 싶은 선물 타입을 외화, 주식, 적금으로 변환하여 표시
                    const giftTypeMapping = {
                        "currency": "외화",
                        "stock": "주식",
                        "savings": "적금"
                    };
                    const giftType = giftTypeMapping[friendDetails.giftType] || friendDetails.giftType;

                    // 받고 싶은 선물 정보 업데이트
                    document.getElementById("modalUsernameGift").textContent = friendDetails.userId;
                    document.querySelector(".gift-category").textContent = giftType;

                    // giftType에 따라 이미지 경로 설정
                    const giftImageElement = document.getElementById("modalGiftImage");
                    let giftImageUrl = "";

                    switch (friendDetails.giftType) {
                        case "currency":
                            giftImageUrl = `${contextPath}/resources/images/icons/f_currency.png`;
                            break;
                        case "stock":
                            giftImageUrl = `${contextPath}/resources/images/icons/userModal_ic01.png`;
                            break;
                        case "savings":
                            giftImageUrl = `${contextPath}/resources/images/icons/savings.png`;
                            break;
                        default:
                            giftImageUrl = `${contextPath}/resources/images/icons/userModal_ic02.png`;  // 기본 이미지 설정
                    }
                    giftImageElement.src = giftImageUrl;

                    // 여행 정보 업데이트
                    document.getElementById("modalTravelPlan").textContent = friendDetails.countryName || "정보 없음";
                    document.getElementById("modalTravelImage").src = contextPath + (friendDetails.logoImgURL || "/resources/images/default-travel.png");  // 여행 이미지

                    // 위시리스트 항목 업데이트
                    wishlistContainer.innerHTML = '';  // 기존 항목 지우기

                    wishLists.forEach(item => {
                        const wishlistItem = document.createElement("div");
                        wishlistItem.classList.add("wishlist-item");
                        wishlistItem.setAttribute("data-category", item.productCategory);  // 카테고리 설정

                        wishlistItem.innerHTML = `
                        <div class="tag">${item.productCategory}</div>
                        <img src="${contextPath}${item.productImgUrl}" alt="${item.productName}" class="wishlist-image">
                        <h5>${item.productName}</h5>
                        ${item.description ? `<p class="interest-rate">${item.description}</p>` : ''}
                    `;
                        wishlistContainer.appendChild(wishlistItem);
                    });

                    // 처음에는 적금 카테고리만 표시
                    filterWishList("savings");

                    // 모달 표시
                    modal.classList.add("show");
                    modal.style.display = "block";
                })
                .catch(error => {
                    console.error("Error fetching friend details:", error);
                });
        });
    });

    // 탭 메뉴 클릭 시 필터링
    tabs.forEach(tab => {
        tab.addEventListener('click', function () {
            const filter = this.getAttribute('data-filter');  // 현재 클릭한 탭의 필터 값

            // 모든 탭에서 active 클래스 제거 후, 클릭된 탭에만 active 추가
            tabs.forEach(t => t.classList.remove('active'));
            this.classList.add('active');

            // 위시리스트 필터링
            filterWishList(filter);
        });
    });

    // 위시리스트 필터링 함수
    function filterWishList(filter) {
        const wishlistItems = wishlistContainer.querySelectorAll('.wishlist-item');
        wishlistItems.forEach(item => {
            const category = item.getAttribute('data-category');
            if (category === filter) {
                item.style.display = 'block';  // 필터와 일치하는 항목만 표시
            } else {
                item.style.display = 'none';  // 필터와 일치하지 않는 항목 숨기기
            }
        });
    }

    // 모달 닫기 버튼 및 외부 클릭 시 모달 닫기
    closeModalButton.addEventListener("click", function () {
        modal.classList.remove("show");
        modal.style.display = "none";
    });

    window.addEventListener("click", function (event) {
        if (event.target === modal) {
            modal.classList.remove("show");
            modal.style.display = "none";
        }
    });
});
