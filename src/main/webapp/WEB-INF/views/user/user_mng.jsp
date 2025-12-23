<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원상세</title>

<!-- Jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script>
  $(document).ready(function(){

	  console.log("document ready");
	  
	  //수정
	  $('#btnUpdate').on('click',function(){
		  console.log('btnUpdate click');
	  });
	  
	  $('#btnDelete').on('click',function() {
		  console.log('btnDelete click');
		  
		  let param = {
				  userId : $('#userId').val()
		  }
		  
		  console.log("userId:"+param.userId);
		  
		  if(confirm('삭제하시겠습니까?')===false) {
			  return;
		  }
		  
		  $.ajax({
		        url: "/ehr/user/doDelete.do",  //Server URL
		        type: "POST",            //호출방식
		        data: param,             //전송 데이터
		        dataType: "json",        //Controller에서 Json으로 반환
		        success: function(res) { //통신 성공시처리
		          if(res.flag === 1) { //데이터 타입까지 비교
		            console.log('res.message:'+res.message)
		            alert("성공! "+res.message);
		            //목록으로 이동 
		            location.href = "/ehr/user/doRetrieve.do";
		          }else{
		            alert("실패"+res.message);
		          }
		          console.log("성공", res);
		        },
		        error: function() {      //실패 
		          console.log("실패");
		        }
		      }); 
		  
		  
	  });

    console.log("user_mng ready");

    // 목록
    $('#btnRetrieve').on('click', function(){
      location.href = "${pageContext.request.contextPath}/user/doRetrieve.do?pageNo=1&pageSize=10";
    });

    // 삭제
    $('#btnDelete').on('click', function(){
      const userId = $('#userId').val();
      if(!confirm(userId + " 삭제할까요?")) return;

      $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/user/doDelete.do",
        dataType: "json",
        data: { userId: userId },
        success: function(res){
          alert(res.message);
          if(res.flag === 1){
            location.href = "${pageContext.request.contextPath}/user/doRetrieve.do?pageNo=1&pageSize=10";
          }
        },
        error: function(xhr){
          alert("통신 오류: " + xhr.status);
        }
      });
    });

    // 수정
    $('#btnUpdate').on('click', function(){
      const param = {
        userId: $('#userId').val(),
        name: $('#name').val(),
        password: $('#password').val(),
        login: $('#login').val(),
        recommend: $('#recommend').val(),
        email: $('#email').val(),
        grade: $('#grade').val()
      };

      $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/user/doUpdate.do",
        dataType: "json",
        data: param,
        success: function(res){
          alert(res.message);
          if(res.flag === 1){
            location.href = "${pageContext.request.contextPath}/user/doRetrieve.do?pageNo=1&pageSize=10";
          }
        },
        error: function(xhr){
          alert("통신 오류: " + xhr.status);
        }
      });
    });
>>>>>>> e7f5c21994b8b141cb47d797bdc495a8ba2b336b
  });
</script>
</head>

<body>
<h2>회원상세/수정</h2>

<c:if test="${empty user}">
  <div>데이터가 없습니다.</div>
  <button type="button" onclick="history.back()">뒤로</button>
</c:if>

<c:if test="${not empty user}">
  <table>
    <tr>
      <td>아이디</td>
      <td><input type="text" id="userId" value="${user.userId}" readonly></td>
    </tr>
    <tr>
      <td>이름</td>
      <td><input type="text" id="name" value="${user.name}"></td>
    </tr>
    <tr>
      <td>비밀번호</td>
      <td><input type="text" id="password" value="${user.password}"></td>
    </tr>
    <tr>
      <td>login</td>
      <td><input type="number" id="login" value="${user.login}"></td>
    </tr>
    <tr>
      <td>recommend</td>
      <td><input type="number" id="recommend" value="${user.recommend}"></td>
    </tr>
    <tr>
      <td>email</td>
      <td><input type="text" id="email" value="${user.email}"></td>
    </tr>
    <tr>
      <td>grade</td>
      <td>
        <input type="text" id="grade" value="${user.grade}">
      </td>
    </tr>

    <tr>
      <td></td>
      <td>
        <input type="button" value="수정" id="btnUpdate">
        <input type="button" value="삭제" id="btnDelete">
        <input type="button" value="목록" id="btnRetrieve">
      </td>
    </tr>
  </table>
</c:if>

</body>
</html>
