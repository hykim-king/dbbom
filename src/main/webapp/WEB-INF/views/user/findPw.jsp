<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<style>
    .wrap { width: 400px; margin: 50px auto; padding: 30px; border: 1px solid #ddd; border-radius: 8px; }
    h2 { text-align: center; margin-bottom: 30px; }
    .row { margin-bottom: 15px; }
    label { display: block; margin-bottom: 5px; font-weight: bold; }
    input { width: 100%; padding: 10px; box-sizing: border-box; }
    button { width: 100%; padding: 12px; background-color: #4a90e2; color: white; border: none; margin-top: 10px; cursor: pointer; }
</style>
</head>
<body>
    <div class="wrap">
        <h2>비밀번호 찾기</h2>
        <form id="findPwForm">
            <div class="row">
                <label for="userId">아이디</label>
                <input type="text" id="userId" name="userId">
            </div>
            <div class="row">
                <label for="userName">이름</label>
                <input type="text" id="userName" name="userName">
            </div>
            <div class="row">
                <label for="userEmail">이메일</label>
                <input type="email" id="userEmail" name="userEmail">
            </div>
            <button type="button" id="doFindPw">비밀번호 찾기</button>
            <button type="button" style="background-color: #6c757d;" onclick="history.back();">취소</button>
        </form>
    </div>
</body>
</html>