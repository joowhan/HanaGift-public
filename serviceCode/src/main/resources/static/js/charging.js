// // 서버에서 JSP로 전달된 데이터를 JSON 형식으로 변환하여 JavaScript로 전달
// const exchangeRatePeriodJson = '${exchangeRatePeriodJson}';  // Controller에서 JSON 직렬화된 데이터를 받음
//
// // JSON 문자열을 JavaScript 객체로 파싱
// const exchangeRatePeriod = JSON.parse(exchangeRatePeriodJson);
//
// console.log(exchangeRatePeriod);
//
// const ctx = document.getElementById("exchangeRateChart").getContext("2d");
//
// const labels = exchangeRatePeriod.map(item => item.exchangeDate);
// const exchangeRates = exchangeRatePeriod.map(item => item.exchangeRate);
//
// // 예시 데이터
// const exchangeRateData = {
//     labels: labels,
//     datasets: [
//         {
//             label: "USD to KRW",
//             data: exchangeRates, // 예시 환율 데이터
//             borderColor: "rgba(75, 192, 192, 1)",
//             backgroundColor: "rgba(75, 192, 192, 0.2)", // 투명도 적용
//             fill: true, // 그래프 아래 영역 색칠
//             tension: 0.1,
//         },
//     ],
// };
//
// const config = {
//     type: "line",
//     data: exchangeRateData,
//     options: {
//         responsive: true,
//         plugins: {
//             legend: {
//                 position: "top",
//             },
//             title: {
//                 display: true,
//                 text: "USD -> KRW 환율 트렌드 ",
//             },
//         },
//         animation: {
//             duration: 2000, // 애니메이션 지속 시간 (밀리초)
//             easing: "easeInOutQuad", // 애니메이션 이징 함수
//         },
//         scales: {
//             x: {
//                 title: {
//                     display: true,
//                     text: "날짜",
//                 },
//                 grid: {
//                     display: false, // 세로선 제거
//                 },
//             },
//             y: {
//                 title: {
//                     display: true,
//                     text: "환율 (KRW)",
//                 },
//                 grid: {
//                     color: "rgba(200, 200, 200, 0.5)", // 가로선 색상 및 투명도
//                 },
//             },
//         },
//     },
// };
//
// new Chart(ctx, config);

// 환율 계산기 동작
document
    .getElementById("amountFrom")
    .addEventListener("input", updateExchangeRate);
document
    .getElementById("currencyFrom")
    .addEventListener("change", updateExchangeRate);
document
    .getElementById("currencyTo")
    .addEventListener("change", updateExchangeRate);

function updateExchangeRate() {
    const amountFrom = parseFloat(document.getElementById("amountFrom").value);

    // 환율 정보를 페이지에서 받아온 값으로 사용
    document.getElementById("exchangeRate").textContent =
        exchangeRate.toFixed(2); // JSP에서 전달된 환율 사용
    document.getElementById("amountTo").value = (
        amountFrom * exchangeRate
    ).toFixed(2);
}

// 초기 계산
updateExchangeRate();

//원화 계산
function calculateWon() {
    const usdInput = document.getElementById("usd-input").value;
    const wonOutput = document.getElementById("won-output");

    // USD 값을 원화로 변환합니다.
    const wonValue = usdInput * exchangeRate;

    // 변환된 원화 값을 출력합니다.
    wonOutput.value = wonValue.toFixed(2) + " 원"; // 소수점 둘째 자리까지 표시합니다.
}

// 일반 환율 계산기 (USD -> KRW)
function calculateExchange() {
    const usdInput = document.getElementById("from-amount").value;
    const krwOutput = document.getElementById("to-amount");

    // USD 값을 KRW로 변환합니다.
    const krwValue = usdInput * exchangeRate;

    // 변환된 KRW 값을 출력합니다.
    krwOutput.value = krwValue.toFixed(2); // 소수점 둘째 자리까지 표시합니다.
}
//환율 계산기
