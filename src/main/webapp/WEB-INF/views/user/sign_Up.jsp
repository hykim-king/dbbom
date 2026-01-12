<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>회원가입</title>

  <!-- (board_reg.jsp 방식) jQuery 로드 -->
  <script src="<%=request.getContextPath()%>/resources/assets/js/cmn/jquery.js"></script>

  <style>
    .wrap { width: 520px; margin: 30px auto; padding: 20px; border: 1px solid #ddd; }
    .row { margin-bottom: 12px; }
    label { display:block; margin-bottom: 6px; font-weight: 600; }
    input, textarea { width: 100%; padding: 10px; box-sizing: border-box; }
    .btns { display:flex; gap:10px; margin-top: 16px; }
    button { padding: 10px 14px; cursor:pointer; }
    .hint { font-size: 12px; color: #666; margin-top: 4px; }
  </style>

  <script>
    // 간단 빈값 체크
    function isEmpty(v){
      return v === null || v === undefined || (String(v).trim().length === 0);
    }

    // 최소 이메일 형식 체크(프론트 1차)
    function isValidEmail(email){
      // 너무 빡세지 않게 "@"와 "." 포함 정도만 체크
      if(isEmpty(email)) return false;
      return email.includes("@") && email.includes(".");
    }

    // 가입 로직을 함수로 분리(버튼 클릭/엔터 submit 모두에서 재사용)
    function doSignUpRequest(){

      // jQuery 로드 실패 대비
      if (typeof $ === "undefined") {
        alert("jQuery 로드에 실패했습니다. 경로를 확인하세요.\n(resources/assets/js/cmn/jquery.js)");
        return;
      }

      const userId = document.querySelector("#userId");
      const userName = document.querySelector("#userName");
      const userPw = document.querySelector("#userPw");
      const userTel = document.querySelector("#userTel");
      const userEmail = document.querySelector("#userEmail");
      const nickname = document.querySelector("#nickname");

      // 필드 존재 여부 방어
      if(!userId || !userName || !userPw || !userTel || !userEmail || !nickname){
        alert("화면 요소를 찾을 수 없습니다. (id 값 확인 필요)");
        return;
      }

      // 1) 프론트 최소 검증
      if(isEmpty(userId.value)){
        alert("아이디를 입력하세요.");
        userId.focus();
        return;
      }
      if(isEmpty(userName.value)){
        alert("이름을 입력하세요.");
        userName.focus();
        return;
      }
      if(isEmpty(userPw.value)){
        alert("비밀번호를 입력하세요.");
        userPw.focus();
        return;
      }
      if(isEmpty(userTel.value)){
        alert("전화번호를 입력하세요.");
        userTel.focus();
        return;
      }
      if(!isValidEmail(userEmail.value)){
        alert("이메일 형식을 확인하세요. (예: test@example.com)");
        userEmail.focus();
        return;
      }
      if(isEmpty(nickname.value)){
        alert("닉네임을 입력하세요.");
        nickname.focus();
        return;
      }

      if(confirm("가입 하시겠습니까?") === false){
        return;
      }

      // 2) 데이터 수집(serialize)
      let param = $("#signUpForm").serialize();
      console.log("param:\n" + param);

      // 3) AJAX 호출
      $.ajax({
        url: "<%=request.getContextPath()%>/user/doSignUpAjax.do",
        type: "POST",
        data: param,
        dataType: "json",
        success: function(res){
          console.log("success:", res);

          // 안전 방어: res가 예상 형태가 아니면 처리
          if(!res || typeof res.flag === "undefined" || typeof res.message === "undefined"){
            alert("서버 응답 형식이 올바르지 않습니다. (flag/message 확인 필요)");
            return;
          }

          if(res.flag === 1){
            alert(res.message); // 가입 완료
            location.href = "<%=request.getContextPath()%>/main/main.do";
          }else{
            alert(res.message); // 실패 사유
          }
        },
        error: function(xhr, status, err){
          console.log("error:", status, err);
          alert("통신 오류가 발생했습니다. (status: " + status + ")");
        }
      });
    }

    document.addEventListener('DOMContentLoaded', function(){

      const doSignUpBtn = document.querySelector("#doSignUp");
      const signUpForm  = document.querySelector("#signUpForm");

      if(!doSignUpBtn){
        alert("가입 버튼(#doSignUp)을 찾을 수 없습니다.");
        return;
      }
      if(!signUpForm){
        alert("폼(#signUpForm)을 찾을 수 없습니다.");
        return;
      }

      // 버튼 클릭 시 가입
      doSignUpBtn.addEventListener("click", function(){
        doSignUpRequest();
      });

      // 엔터(Submit) 눌러도 동일하게 처리(기본 submit 막기)
      signUpForm.addEventListener("submit", function(e){
        e.preventDefault();
        doSignUpRequest();
      });

    });
  </script>

</head>
<body>

  <div class="wrap">
    <h2>회원가입</h2>

    <!-- form submit 대신 serialize로 사용 (엔터 submit도 잡아주기 위해 method는 유지) -->
    <form method="post" id="signUpForm">

      <div class="row">
        <label for="userId">아이디(user_id) *</label>
        <input type="text" id="userId" name="userId" maxlength="20" />
      </div>

      <div class="row">
        <label for="userName">이름(user_name) *</label>
        <input type="text" id="userName" name="userName" maxlength="7" />
      </div>

      <div class="row">
        <label for="userPw">비밀번호(user_pw) *</label>
        <input type="password" id="userPw" name="userPw" maxlength="30" />
        <div class="hint">※ 다음 단계에서 비밀번호 암호화(BCrypt) 적용 권장</div>
      </div>

      <div class="row">
        <label for="userTel">전화번호(user_tel) *</label>
        <input type="text" id="userTel" name="userTel" maxlength="13" placeholder="010-1234-5678" />
      </div>

      <div class="row">
        <label for="userEmail">이메일(user_email) *</label>
        <input type="email" id="userEmail" name="userEmail" maxlength="255" />
      </div>

      <div class="row">
        <label for="nickname">닉네임(nickname) *</label>
        <input type="text" id="nickname" name="nickname" maxlength="12" />
      </div>

      <div class="row">
        <label for="userIntro">자기소개(user_intro)</label>
        <textarea id="userIntro" name="userIntro" rows="4" maxlength="50"></textarea>
      </div>

      <!-- 일반회원 기본값: N -->
      <input type="hidden" name="adminChk" value="N"/>

      <div class="btns">
        <button type="button" id="doSignUp">가입하기</button>
        <button type="button" onclick="location.href='<%=request.getContextPath()%>/main/main.do'">
          메인으로
        </button>
      </div>

    </form>
  </div>

</body>
</html>
