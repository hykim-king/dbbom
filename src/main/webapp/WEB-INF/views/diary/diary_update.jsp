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
    <input type="hidden" name="diaryStatus" value="${diaryVO.diaryStatus}" />
    <input type="hidden" name="diaryCategory" value="${diaryVO.diaryCategory}" />
    <article class="detail-card" style="padding:32px 32px 24px 32px; border-radius:18px; background:#fff; box-shadow:0 2px 16px 0 rgba(30,41,59,.08);">
      <header class="detail-header" style="margin-bottom:24px;">
        <h2 class="detail-title" style="font-size:2rem; font-weight:700; color:#1e293b; margin-bottom:16px; border:none; background:none; padding:0;">
          <input type="text" name="diaryTitle" value="${diaryVO.diaryTitle}" placeholder="제목을 입력하세요" required style="width:100%; font-size:2rem; font-weight:700; color:#1e293b; border:none; outline:none; background:transparent;" />
        </h2>
      </header>
      <div class="detail-body" style="margin-bottom:32px;">
        <textarea name="diaryContent" required style="width:100%; min-height:220px; font-size:1.1rem; color:#334155; border:1px solid #e2e8f0; border-radius:10px; padding:18px; resize:vertical; background:#f8fafc;">${diaryVO.diaryContent}</textarea>
      </div>
      <div class="action-buttons" style="display:flex; gap:12px; justify-content:flex-end;">
        <button type="submit" class="btn-save" style="padding:10px 32px; background:#3b82f6; color:#fff; border:none; border-radius:8px; font-size:1rem; font-weight:600; cursor:pointer;">저장</button>
        <a href="${pageContext.request.contextPath}/diary/diaryList.do" class="btn-cancel" style="padding:10px 32px; background:#94a3b8; color:#fff; border:none; border-radius:8px; font-size:1rem; font-weight:600; text-decoration:none; display:inline-block; text-align:center;">취소</a>
      </div>
    </article>
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