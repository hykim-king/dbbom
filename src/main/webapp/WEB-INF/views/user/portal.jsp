<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 포털</title>
</head>
<body>
<h2>회원 포털</h2>

<ul>
  <li><a href="${pageContext.request.contextPath}/user/viewDoSave.do">회원가입</a></li>
  <li><a href="${pageContext.request.contextPath}/user/doRetrieve.do?pageNo=1&pageSize=10">회원목록(조회)</a></li>
  <li>로그인/마이페이지는 CRUD 완료 후 다음 단계로 연결</li>
</ul>

<br/>
<button type="button" onclick="location.href='${pageContext.request.contextPath}/resources/mainPage.jsp'">메인</button>
</body>
</html>
