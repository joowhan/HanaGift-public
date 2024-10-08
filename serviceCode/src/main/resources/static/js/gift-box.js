// 필터링 기능 구현
document.querySelectorAll(".dropdown-item").forEach(function (item) {
    item.addEventListener("click", function (event) {
        event.preventDefault();

        // 모든 필터링 항목을 비활성화
        document
            .querySelectorAll(".dropdown-item")
            .forEach(function (innerItem) {
                innerItem.classList.remove("active");
            });

        // 현재 선택된 필터 활성화
        this.classList.add("active");

        // 필터 기준 가져오기
        const filterValue = this.getAttribute("data-filter");

        // 모든 아이템 숨기기
        const parentTab = this.closest(".tab-pane");
        parentTab.querySelectorAll(".gift-item").forEach(function (giftItem) {
            giftItem.style.display = "none";
        });

        // 선택된 필터에 맞는 아이템만 보이기
        parentTab
            .querySelectorAll(`.gift-item.${filterValue}`)
            .forEach(function (filteredItem) {
                filteredItem.style.display = "flex";
            });

        // 필터 버튼의 텍스트를 변경
        this.closest(".dropdown").querySelector(".btn").textContent =
            this.textContent;
    });
});

// 초기화면에서 '전체' 필터가 적용되도록 설정
document.querySelectorAll(".tab-pane").forEach(function (tabPane) {
    tabPane.querySelector('.dropdown-item[data-filter="all"]').click();
});

// 탭 클릭 이벤트 리스너 추가
document.querySelectorAll(".nav-link").forEach(function (tabLink) {
    tabLink.addEventListener("click", function (event) {
        event.preventDefault();

        // 모든 탭 내용 숨기기
        document.querySelectorAll(".tab-pane").forEach(function (tabContent) {
            tabContent.classList.remove("show", "active");
        });

        // 선택된 탭 활성화
        const target = this.getAttribute("href");
        document.querySelector(target).classList.add("show", "active");

        // 모든 탭 버튼의 활성화 상태 초기화
        document.querySelectorAll(".nav-link").forEach(function (tabLink) {
            tabLink.classList.remove("active");
        });

        // 클릭된 탭 버튼 활성화
        this.classList.add("active");

        // 해당 탭의 첫 번째 필터를 선택하여 필터링 적용
        document
            .querySelector(target)
            .querySelector('.dropdown-item[data-filter="all"]')
            .click();
    });
});

// 초기 상태 설정: 받은 선물 탭을 기본으로 활성화
document.querySelector('.nav-link[href="#received"]').click();
