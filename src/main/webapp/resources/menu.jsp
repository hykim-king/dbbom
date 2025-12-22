<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<title>임시메뉴</title>
</head>
<body>
  <h2>임시메뉴</h2>
  <table>
    <tr>
      <th>메뉴</th>
      <th>링크</th>
    </tr>
    <tr>
      <td>회원목록</td>
      <td><a href="/ehr/user/doRetrieve.do">회원목록</a></td>
    </tr>
    <tr>
      <td>회원등록</td>
      <td><a href="/ehr/user/viewDoSave.do">회원등록</a></td>
    </tr>
     <tr>
      <td>회원등록</td>
      <td><a href="/ehr/user/ajaxWiewDoSave.do">회원등록_ajax</a></td>
    </tr>
    
  </table>
  
</body>
</html>