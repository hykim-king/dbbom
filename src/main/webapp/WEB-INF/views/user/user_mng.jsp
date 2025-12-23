<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  });
</script>
</head>
<body>
  <h2>회원상세</h2>
  <hr/>
  <table>
    <tr>
      <td>회원ID</td>
      <td><input type="text" name="userId" id="userId" value="${user.userId}" readonly></td>
    </tr>
    <tr>
      <td>이름</td>
      <td><input type="text" name="name" id="name" value="${user.name}"></td>
    </tr>
    <tr>
      <td>비밀번호 </td>
      <td><input type="password" name="password" id="password" value="${user.password}"></td>
    </tr>
     <tr>
      <td>로그인(횟수)</td>
      <td><input type="number" name="login" id="login" value="${user.login}"></td>
    </tr>
    <tr>
      <td>추천</td>
      <td><input type="number" name="recommend" id="recommend" value="${user.recommend}"></td>
    </tr>
    <tr>
      <td>이메일 </td>
      <td><input type="email" name="email" id="email" value="${user.email}"></td>
    </tr>
    <tr>
      <td>등급 </td>
      <td>
        <select name="grade" id="grade">
          <option value="BASIC"  <c:if test="${user.grade == 'BASIC'}">selected</c:if> >BASIC</option>
          <option value="SILVER" <c:if test="${user.grade == 'SILVER'}">selected</c:if> >SILVER</option>
          <option value="GOLD"   <c:if test="${user.grade == 'GOLD'}">selected</c:if> >GOLD</option>
        </select>
      </td>
      
    </tr>
    <tr>
      <td></td>
      <td>
        <input type="button" value="수정" id="btnUpdate" >
        <input type="button" value="삭제" id="btnDelete" >
        <input type="button" value="목록" id="btnRetrieve" >
       </td>
    </tr>
  </table>
  
</body>
</html>