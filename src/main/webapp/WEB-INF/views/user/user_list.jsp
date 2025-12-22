<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style>
  table {
    border-collapse: collapse;
    width: 800px;
  }
  
  th,td{
    border: 1px solid #cccccc;
    padding: 8px;
  
  }
  th{
    background-color: #f0f0f0;
  }
</style>
<meta charset="UTF-8">
<title>회원목록</title>
</head>
<body>
  <h2>회원목록</h2>
  <table>
    <tr>
	      <th>번호</th>
	      <th>사용자ID</th>
	      <th>이름</th>
	      <th>로그인</th>
	      <th>추천</th>
	      <th>이메일</th>
	      <th>등급</th>
	      <th>등록일</th>    
    </tr>
    
    <c:choose>
      <c:when test="${empty user_list}">
        <tr>
          <td colspan="8">조회된 회원이 없습니다.</td>
        </tr>
      </c:when>
      <c:otherwise>
				<c:forEach var="vo" items="${user_list}">
					<tr>
						<td>${vo.no}</td>
						<td><a href="<c:url value='/user/doSelectOne.do?userId=${vo.userId}'/>">${vo.userId}</a></td>
						<td>${vo.name}</td>
						<td>${vo.login}</td>
						<td>${vo.recommend}</td>
						<td>${vo.email}</td>
						<td>${vo.grade}</td>
						<td>${vo.regDt}</td>
					</tr>
				</c:forEach>
			</c:otherwise>
    </c:choose>
    
    
  
  </table>
</body>
</html>