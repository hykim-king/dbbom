<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내면의 흔적 - 게시글 상세보기</title>
    <script src="https://unpkg.com/lucide@latest"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/diary_detail_board.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/common.css""/>
    <script src="${pageContext.request.contextPath}/resources/assets/js/cmn/jquery.js"></script>
    <%-- <script src="${pageContext.request.contextPath}/resources/assets/js/diary_detail_board.js"></script> --%>

    <jsp:include page="/WEB-INF/views/main/menu.jsp" />
</head>
<body>

<main class="container">
  <form id="diaryUpdateForm" method="post" action="${pageContext.request.contextPath}/diary/diaryUpdate.do" style="max-width:600px;margin:32px auto 0;">
    <input type="hidden" name="diarySid" value="${diaryVO.diarySid}" />
    <input type="hidden" name="diaryCategory" value="${diaryVO.diaryCategory}" />
    <div class="card diary-card" style="margin-top: 20px; background:#fff; border-radius:18px; box-shadow:0 2px 16px 0 rgba(30,41,59,.08); padding:32px 32px 24px 32px;">
      <div class="diary-header flex-between" style="margin-bottom:18px;">
        <input type="text" class="diary-title" name="diaryTitle" value="${diaryVO.diaryTitle}" placeholder="제목을 입력하세요" required style="width:100%; font-size:2rem; font-weight:700; color:#1e293b; border:none; outline:none; background:transparent;" />
      </div>
      <textarea class="diary-content" name="diaryContent" required placeholder="오늘의 일기를 작성해보세요" style="width:100%; min-height:220px; font-size:1.1rem; color:#334155; border:1px solid #e2e8f0; border-radius:10px; padding:18px; resize:vertical; background:#f8fafc; margin-bottom:18px;">${diaryVO.diaryContent}</textarea>
      <div class="diary-footer" style="margin-bottom:18px;">
        <div class="radio-group" style="display:flex; gap:24px; align-items:center;">
          <label class="radio-label" style="font-size:1rem; color:#334155;">
            <input type="radio" name="diaryStatus" value="Y" <c:if test='${diaryVO.diaryStatus eq "Y"}'>checked</c:if> /> 공개
          </label>
          <label class="radio-label" style="font-size:1rem; color:#334155;">
            <input type="radio" name="diaryStatus" value="N" <c:if test='${diaryVO.diaryStatus eq "N"}'>checked</c:if> /> 비공개
          </label>
        </div>
      </div>
      <div class="action-buttons" style="display:flex; gap:12px; justify-content:flex-end;">
        <button type="submit" class="btn-save" style="padding:10px 32px; background:#3b82f6; color:#fff; border:none; border-radius:8px; font-size:1rem; font-weight:600; cursor:pointer;">저장</button>
        <a href="${pageContext.request.contextPath}/diary/diaryList.do" class="btn-cancel" style="padding:10px 32px; background:#94a3b8; color:#fff; border:none; border-radius:8px; font-size:1rem; font-weight:600; text-decoration:none; display:inline-block; text-align:center;">취소</a>
      </div>
    </div>
  </form>
</main>

   <footer>
      <div class="container">
        <p>© 2024 내면의 흔적. All rights reserved.</p>
      </div>
    </footer>


<script>
  // Lucide 아이콘 전체 렌더링 (body 끝에서 한 번만 실행)
  document.addEventListener('DOMContentLoaded', function() {
    if (typeof lucide !== 'undefined') {
      lucide.createIcons();
    }
  });
</script>


  </body>
</html>