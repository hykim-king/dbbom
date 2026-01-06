document.addEventListener("DOMContentLoaded", () => {

  // Lucide 아이콘 초기화
  if (typeof lucide !== "undefined") {
    lucide.createIcons();
  }

  // 메뉴 탭 클릭 이벤트
  const tabButtons = document.querySelectorAll(".tab-btn");
  tabButtons.forEach((button) => {
    button.addEventListener("click", () => {
      tabButtons.forEach((btn) =>
        btn.setAttribute("aria-selected", "false")
      );
      button.setAttribute("aria-selected", "true");
    });
  });

  // 일기 등록 버튼 이벤트
  document.getElementById("saveDiary").addEventListener("click", () => {
    const titleInput = document.querySelector(".diary-title");
    const contentInput = document.querySelector(".diary-content");
    const dateInput = document.querySelector(".diary-date");

    const title = titleInput.value.trim();
    const content = contentInput.value.trim();
    const date = dateInput.value;

    // 제목 검사
    if (title === "") {
      alert("제목을 입력해주세요");
      titleInput.focus();
      return;
    }

    // 내용 검사
    if (content === "") {
      alert("내용을 작성해주세요");
      contentInput.focus();
      return;
    }

    // 공개/비공개
    const visibility = document.querySelector(
      'input[name="visibility"]:checked'
    )?.value || "private";

    console.log({
      title,
      date,
      content,
      visibility,
    });

    alert("일기가 등록되었습니다!");

    // 입력값 초기화
    titleInput.value = "";
    contentInput.value = "";
    dateInput.value = "";

    document
      .querySelectorAll('input[name="visibility"]')
      .forEach((radio) => (radio.checked = false));


  });
});
