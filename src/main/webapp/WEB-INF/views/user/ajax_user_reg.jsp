<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원등록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
  $(document).ready(function(){
	  console.log("document ready");
	  
	  $('#btnSave').on('click',function(){//저장 button click 감지
		  console.log("btnSave click");
	  
		  console.log("userId:"+$('#userId').val());
		  console.log("name:"+$('#name').val());
		  console.log("password:"+$('#password').val());
		  console.log("login:"+$('#login').val());
		  console.log("recommend:"+$('#recommend').val());
		  console.log("email:"+$('#email').val());
		  console.log("grade:"+$('#grade').val());
		  //데이터 수집
		  let param = {
				  userId : $('#userId').val(),
				  name   : $('#name').val(),
				  password : $('#password').val(),
				  login: $('#login').val(),
				  recommend : $('#recommend').val(),
				  email: $('#email').val(),
				  grade: $('#grade').val()
		  }
	  
		   $.ajax({
			  url: "/ehr/user/doSave.do",  //Server URL
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
  <h2>회원등록</h2>
  <hr/>
  <table border="1">
    <tr>
      <td>회원ID</td>
      <td><input type="text" name="userId" id="userId"></td>
    </tr>
    <tr>
      <td>이름</td>
      <td><input type="text" name="name" id="name"></td>
    </tr>
    <tr>
      <td>비밀번호 </td>
      <td><input type="password" name="password" id="password"></td>
    </tr>
     <tr>
      <td>로그인(횟수)</td>
      <td><input type="number" name="login" id="login"></td>
    </tr>
    <tr>
      <td>추천</td>
      <td><input type="number" name="recommend" id="recommend"></td>
    </tr>
    <tr>
      <td>이메일 </td>
      <td><input type="email" name="email" id="email"></td>
    </tr>
    <tr>
      <td>등급 </td>
      <td><input type="text" name="grade" id="grade"></td>
    </tr>
    <tr>
      <td></td>
      <td><input type="button" value="저장" id="btnSave"></td>
    </tr>
  </table>
  
</body>
</html>