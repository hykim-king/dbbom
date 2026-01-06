// report.js

// 문서가 로딩된 후 버튼 이벤트 연결
document.addEventListener("DOMContentLoaded", () => {
  // [신고하기] 버튼 찾기 & 클릭 이벤트 연결
  const submitBtn = document.querySelector(".btn-submit");
  if (submitBtn) {
    submitBtn.addEventListener("click", submitReport);
  }

  // [닫기] 버튼 찾기 & 클릭 이벤트 연결
  const closeBtn = document.querySelector(".btn-close");
  if (closeBtn) {
    closeBtn.addEventListener("click", () => {
      window.close();
    });
  }
});

// 신고하기 실제 동작 함수
function submitReport() {
  // 라디오 버튼 선택값 가져오기
  const checkedInput = document.querySelector('input[name="reason"]:checked');

  // 선택된 것이 없으면 방어 코드
  if (!checkedInput) {
    alert("신고 사유를 선택해주세요.");
    return;
  }

  // 텍스트 내용 가져오기
  const reasonText = checkedInput.parentNode.textContent.trim();

  // 상세 내용 가져오기
  const detailText = document.querySelector(".textarea-box").value;

  // TODO: 서버 전송 로직 (AJAX 등)

  // 알림창 띄우기
  alert(`['${reasonText}'] 사유로 신고가 접수되었습니다.`);

  // 완료 후 창 닫기
  window.close();
}
