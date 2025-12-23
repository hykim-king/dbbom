/* =========================
   닉네임 중복확인
========================= */
function checkNickname() {
  const nickname = document.getElementById("nickname").value.trim();
  const msg = document.getElementById("nicknameMsg");

  if (nickname === "") {
    msg.textContent = "닉네임을 입력해주세요.";
    msg.style.color = "red";
    return;
  }

  // (서버 없으므로 임시 처리)
  msg.textContent = "사용 가능한 닉네임입니다.";
  msg.style.color = "green";
}

/* =========================
   아이디 중복확인
========================= */
function checkUserId() {
  const userid = document.getElementById("userid").value.trim();
  const msg = document.getElementById("useridMsg");

  if (userid === "") {
    msg.textContent = "아이디를 입력해주세요.";
    msg.style.color = "red";
    return;
  }

  msg.textContent = "사용 가능한 아이디입니다.";
  msg.style.color = "green";
}

/* =========================
   비밀번호 일치 실시간 검사
========================= */
document.addEventListener("DOMContentLoaded", () => {
  const pwInput = document.getElementById("userpw");
  const pwConfirmInput = document.getElementById("userpw_confirm");
  const pwMsg = document.getElementById("pwMsg");

  if (!pwInput || !pwConfirmInput || !pwMsg) return;

  pwConfirmInput.addEventListener("input", () => {
    if (pwInput.value === "" || pwConfirmInput.value === "") {
      pwMsg.textContent = "";
      return;
    }

    if (pwInput.value === pwConfirmInput.value) {
      pwMsg.textContent = "비밀번호가 일치합니다.";
      pwMsg.style.color = "green";
    } else {
      pwMsg.textContent = "비밀번호가 일치하지 않습니다.";
      pwMsg.style.color = "red";
    }
  });
});

/* =========================
   가입하기 버튼 클릭
========================= */
function submitForm() {
  const nickname = document.getElementById("nickname").value.trim();
  const username = document.getElementById("username").value.trim();
  const userid = document.getElementById("userid").value.trim();
  const pw = document.getElementById("userpw").value.trim();
  const pwConfirm = document.getElementById("userpw_confirm").value.trim();
  const emailId = document.getElementById("email_id").value.trim();
  const emailDomain = document.getElementById("email_domain").value.trim();

  // 1️⃣ 빈 칸 검사
  if (
    !nickname ||
    !username ||
    !userid ||
    !pw ||
    !pwConfirm ||
    !emailId ||
    !emailDomain
  ) {
    alert("모든 칸을 작성해주세요.");
    return;
  }

  // 2️⃣ 비밀번호 불일치 검사
  if (pw !== pwConfirm) {
    alert("비밀번호가 일치하지 않습니다.");
    return;
  }

  // 3️⃣ 가입 완료
  alert("가입이 완료되었습니다.");
  window.location.href = "../html/login_page.html";
}
