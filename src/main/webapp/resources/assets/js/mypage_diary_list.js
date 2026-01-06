document.addEventListener("DOMContentLoaded", () => {

  // 1️⃣ 가짜 일기 데이터
  const diaryData = {
    "2025-11-01": [
      {
        title: "마음이 복잡했던 하루",
        type: "명언일기",
        content: "오늘은 마음이 조금 복잡했다."
      },
      {
        title: "따뜻했던 순간",
        type: "감사일기",
        content: "따뜻한 커피 한 잔에 감사했다."
      }
    ],
    "2025-11-03": [
      {
        title: "나를 돌아보다",
        type: "성찰일기",
        content: "평범하지만 소중한 하루."
      }
    ]
  };

  // 2️⃣ 일기 타입 색상
  const diaryTypeColor = {
    "명언일기": "purple",
    "성찰일기": "blue",
    "감사일기": "yellow",
    "행운일기": "green"
  };

  // 3️⃣ 달력 DOM 가져오기
  const calendar = document.getElementById("calendar");

  if (!calendar) {
    console.error("❌ calendar 요소 없음");
    return;
  }

  // 4️⃣ 달력 생성
  for (let day = 1; day <= 30; day++) {
    const dateStr = `2025-11-${String(day).padStart(2, "0")}`;
    const div = document.createElement("div");
    div.className = "day";
    div.textContent = day;

    if (diaryData[dateStr]) {
      div.classList.add("has-diary");
    }

    div.addEventListener("click", () => selectDate(dateStr, div));
    calendar.appendChild(div);
  }

  // 5️⃣ 날짜 선택 함수
  function selectDate(date, element) {
    document.querySelectorAll(".day")
      .forEach(d => d.classList.remove("active"));

    element.classList.add("active");

    document.getElementById("selectedDate").textContent = date;

    const list = document.getElementById("diaryTypeList");
    list.innerHTML = "";

    diaryData[date]?.forEach(diary => {
      const li = document.createElement("li");
      li.textContent = diary.title;

      const colorClass = diaryTypeColor[diary.type];
      if (colorClass) {
        li.classList.add(`diary-${colorClass}`);
      }

      li.addEventListener("click", () => {
        document.getElementById("diaryContent").textContent = diary.content;
      });

      list.appendChild(li);
    });
  }

});
