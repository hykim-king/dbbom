const modal = document.getElementById("loginModal");
const openModalBtn = document.querySelector(".login");
const closeModalBtn = document.querySelector(".close-btn");

openModalBtn.addEventListener("click", (e) => {
  e.preventDefault();
  modal.style.display = "block";
  document.body.style.overflow = "hidden"; // 화면 깨짐 방지

  closeModalBtn.addEventListener("click", () => {
    modal.style.display = "none";
    document.body.style.overflow = "auto"; // 팝업창을 닫을 때 원래 페이지 스크롤 복원
  });

  window.addEventListener("click", (event) => {
    if (event.target === modal) {
      modal.style.display = "none";
      document.body.style.overflow = "auto"; // 팝업창이 아닌 부분을 클릭했을때 창이 닫히게 만듬듬
    }
  });

  document.getElementById("loginForm").addEventListener("submit", (e) => {
    e.preventDefault();
    alert("로그인 로직을 연결해 주세요!");
  });
});
