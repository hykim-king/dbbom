<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script>
  $(document).ready(function(){
    $("#btnSave").on("click", function(){
      const param = {
        userId: $("#userId").val(),
        name: $("#name").val(),
        password: $("#password").val(),
        login: $("#login").val(),
        recommend: $("#recommend").val(),
        email: $("#email").val(),
        grade: $("#grade").val()
      };

      $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/user/doSave.do",
        dataType: "json",
        data: param,
        success: function(res){
          alert(res.message);
          if(res.flag === 1){
            location.href = "${pageContext.request.contextPath}/resources/mainPage.jsp";
          }
        },
        error: function(xhr){
          alert("통신 오류: " + xhr.status);
        }
      });
    });

    $("#btnCancel").on("click", function(){
      location.href = "${pageContext.request.contextPath}/resources/mainPage.jsp";
    });
  });
</script>
</head>

<body>
<h2>회원가입</h2>

<table>
  <tr><td>아이디</td><td><input type="text" id="userId"></td></tr>
  <tr><td>이름</td><td><input type="text" id="name"></td></tr>
  <tr><td>비밀번호</td><td><input type="password" id="password"></td></tr>
  <tr><td>login</td><td><input type="number" id="login" value="0"></td></tr>
  <tr><td>recommend</td><td><input type="number" id="recommend" value="0"></td></tr>
  <tr><td>email</td><td><input type="text" id="email"></td></tr>
  <tr><td>grade</td><td><input type="text" id="grade" value="BASIC"></td></tr>
</table>

<br/>
<button type="button" id="btnSave">가입 완료</button>
<button type="button" id="btnCancel">취소</button>

</body>
</html>
