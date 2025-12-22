<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>

<style>
  table { border-collapse: collapse; width: 900px; }
  th, td { border: 1px solid #cccccc; padding: 8px; text-align: left; }
  th { background-color: #f2f2f2; }
</style>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script>
  $(document).ready(function(){
    console.log("user_list ready");

    // 조회 버튼(필요시)
    $("#btnRetrieve").on("click", function(){
      location.href = "${pageContext.request.contextPath}/user/doRetrieve.do?pageNo=1&pageSize=10";
    });
  });

  // 삭제(AJAX)
  function doDelete(userId){
    if(!confirm(userId + " 삭제할까요?")) return;

    $.ajax({
      type: "POST",
      url: "${pageContext.request.contextPath}/user/doDelete.do",
      dataType: "json",
      data: { userId: userId },
      success: function(res){
        if(res.flag === 1){
          alert("성공! " + res.message);
          location.href = "${pageContext.request.contextPath}/user/doRetrieve.do?pageNo=1&pageSize=10";
        }else{
          alert("실패! " + res.message);
        }
      },
      error: function(xhr){
        alert("통신 오류: " + xhr.status);
      }
    });
  }
</script>
</head>

<body>
<h2>회원 목록</h2>

<table>
  <tr>
    <th>아이디</th>
    <th>이름</th>
    <th>이메일</th>
    <th>등급</th>
    <th>등록일</th>
    <th>관리</th>
  </tr>

  <c:choose>
    <c:when test="${empty user_list}">
      <tr><td colspan="6">데이터가 없습니다.</td></tr>
    </c:when>
    <c:otherwise>
      <c:forEach var="vo" items="${user_list}">
        <tr>
          <td>${vo.userId}</td>
          <td>${vo.name}</td>
          <td>${vo.email}</td>
          <td>${vo.grade}</td>
          <td>${vo.regDt}</td>
          <td>
            <a href="${pageContext.request.contextPath}/user/doSelectOne.do?userId=${vo.userId}">수정</a>
            /
            <button type="button" onclick="doDelete('${vo.userId}')">삭제</button>
          </td>
        </tr>
      </c:forEach>
    </c:otherwise>
  </c:choose>

</table>

<br/>
<button id="btnRetrieve" type="button">목록 새로고침</button>
<button type="button" onclick="location.href='${pageContext.request.contextPath}/user/portal.do'">포털</button>
<button type="button" onclick="location.href='${pageContext.request.contextPath}/resources/mainPage.jsp'">메인</button>

</body>
</html>
