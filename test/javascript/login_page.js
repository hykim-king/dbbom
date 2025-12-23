document.getElementById("fullLoginForm").addEventListener("submit", function(e) {
    e.preventDefault();
    const id = e.target.querySelector('input[type="text"]').value;
    
    // 간단한 로그인 환영 메시지
    alert(`${id}님, 내면의 흔적에 오신 것을 환영합니다.`);
    location.href = "main.html"; // 로그인 후 메인으로 이동
});