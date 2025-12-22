<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h2>회원등록</h2>
  <hr/>
  <form action="/ehr/user/doSave.do" method="post">
      회원ID : <input type="text" name="userId"><br/>
      이름 : <input type="text" name="name"><br/>
      비밀번호 : <input type="text" name="password"><br/>
      로그인(횟수) : <input type="text" name="Login"><br/>
      추천 : <input type="text" name="recommend"><br/>
      이메일 : <input type="text" name="email"><br/>
      등급 : <input type="text" name="grade"><br/>
  <input type="submit" value="저장">0
        
  </form>
</body>
</html>