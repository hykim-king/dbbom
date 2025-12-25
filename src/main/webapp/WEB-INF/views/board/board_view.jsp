<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>

<style>
  .board-container{
    width: 800px;
    margin: 20px auto;
    padding: 15px;
    background: #e0e0e0;
    border: 1px solid #c0c0c0;
  }
  .post-box{
    background:#4a90e2;
    color:#fff;
    padding:15px;
    border:1px solid #3a7bd5;
    margin-bottom:15px;
  }
  .comment-box{
    background:#fff;
    padding:15px;
    border:1px solid #c0c0c0;
  }
  .comment-item{
    border-bottom:1px solid #eee;
    padding:10px 0;
  }
  .comment-item:last-child{ border-bottom:none; }
</style>

</head>
<body>

<div class="board-container">

  <h2>게시판</h2>

  <!-- 게시글(오늘은 고정) -->
  <div class="post-box">
    <div>${boardText}</div>
    <div style="margin-top:8px; font-size:12px; opacity:0.9;">
      diarySid = ${diarySid}
    </div>
  </div>

  <!-- 댓글 영역 -->
  <div class="comment-box">
    <h3>댓글</h3>

    <!-- 댓글 목록 -->
    <c:if test="${empty comments}">
      <div>아직 댓글이 없습니다. 첫 댓글을 달아주세요.</div>
    </c:if>

    <c:forEach var="cmt" items="${comments}">
      <div class="comment-item">
        <div><b>${cmt.regId}</b></div>
        <div>${cmt.commentContent}</div>
        <div style="font-size:12px; color:#666;">${cmt.commentUpdateDate}</div>
      </div>
    </c:forEach>

    <hr/>

    <!-- 댓글 등록 -->
    <form method="post" action="${pageContext.request.contextPath}/comment/doSave.do">
      <input type="hidden" name="diarySid" value="${diarySid}" />

      <!-- 로그인 붙이면 regId는 hidden/세션으로 바꾸면 됨 -->
      <input type="text" name="regId" value="guest" placeholder="작성자ID" style="width:150px;" />

      <br/><br/>
      <textarea name="commentContent" rows="3" style="width:100%;" placeholder="댓글을 입력하세요"></textarea>
      <br/><br/>
      <button type="submit">댓글 등록</button>
    </form>

  </div>

</div>

</body>
</html>
