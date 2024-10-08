const ctx = document.getElementById("exchangeRateChart").getContext("2d");

// 예시 데이터
const exchangeRateData = {
    labels: [
        "2024.08.01",
        "2024.08.02",
        "2024.08.03",
        "2024.08.04",
        "2024.08.05",
        "2024.08.06",
        "2024.08.07",
        "2024.08.08",
    ],
    datasets: [
        {
            label: "USD to KRW",
            data: [1180, 1185, 1190, 1185, 1195, 1200, 1195, 1205], // 예시 환율 데이터
            borderColor: "rgba(75, 192, 192, 1)",
            backgroundColor: "rgba(75, 192, 192, 0.2)", // 투명도 적용
            fill: true, // 그래프 아래 영역 색칠
            tension: 0.1,
        },
    ],
};

const config = {
    type: "line",
    data: exchangeRateData,
    options: {
        responsive: true,
        plugins: {
            legend: {
                position: "top",
            },
            title: {
                display: true,
                text: "환율 트렌드 그래프",
            },
        },
        animation: {
            duration: 2000, // 애니메이션 지속 시간 (밀리초)
            easing: "easeInOutQuad", // 애니메이션 이징 함수
        },
        scales: {
            x: {
                title: {
                    display: true,
                    text: "Date",
                },
                grid: {
                    display: false, // 세로선 제거
                },
            },
            y: {
                title: {
                    display: true,
                    text: "Exchange Rate (KRW)",
                },
                grid: {
                    color: "rgba(200, 200, 200, 0.5)", // 가로선 색상 및 투명도
                },
            },
        },
    },
};

new Chart(ctx, config);
