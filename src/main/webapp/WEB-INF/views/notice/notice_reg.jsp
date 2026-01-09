<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>내면의 흔적 - 공지사항 상세보기</title>
    <script src="https://unpkg.com/lucide@latest"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/notice_detail_board.css" />
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/notice_detail_board.js"></script>
  </head>
  <body>
    <header>
      <div class="container header-inner flex-between">
        <a href="/main/mainPage.do" class="logo-area">
          <h1 class="logo-text">내면의 흔적</h1>
        </a>
        <div class="auth-links">
           <c:choose>
               <c:when test="${empty sessionScope.user}">
                  <a href="/user/signIn.do" class="auth-item">로그인</a>
               </c:when>
               <c:otherwise>
                  <span class="auth-item">${sessionScope.user.userName}님</span>
               </c:otherwise>
           </c:choose>
        </div>
      </div>
    </header>

    <main class="container main-layout">
      <aside class="tab-list">
        <div class="menu-label">메뉴</div>
        <a href="/main/overview.do" class="tab-btn"><i data-lucide="sparkles"></i> 개요</a>
        <a href="/notice/noticeList.do" class="tab-btn active"><i data-lucide="book-open"></i> 공지사항</a>
        <div class="dropdown-container">
          <a href="/diary/diaryList.do" class="tab-btn"><i data-lucide="pencil"></i> 게시판</a>
        </div>
        <a href="/user/myPage.do" class="tab-btn"><i data-lucide="user"></i> 마이페이지</a>
      </aside>

      <section class="content-area">
        <a href="/notice/noticeList.do" class="back-btn">
          <i data-lucide="arrow-left" size="18"></i> 목록으로 돌아가기
        </a>

        <article class="detail-card">
          <header class="detail-header">
            <span class="post-tag gratitude">공지</span>
            
            <h2 class="detail-title">${vo.noticeTitle}</h2>
            
            <div class="detail-meta-row">
              <div class="meta-left">
                <span class="meta-item">
                    <i data-lucide="user" size="16"></i> ${vo.regId}
                </span>
                <span class="meta-item">
                    <i data-lucide="calendar" size="16"></i> ${vo.noticeTime}
                </span>
                <span class="meta-item">
                    <i data-lucide="eye" size="16"></i> ${vo.readCnt}
                </span>
              </div>
              
              <c:if test="${sessionScope.user.isAdmin == 'Y'}">
                  <div class="meta-right" style="display:flex; gap:10px;">
                      <button onclick="doUpdate()" style="border:none; background:none; color:#64748b; cursor:pointer; font-weight:bold;">수정</button>
                      <button onclick="doDelete()" style="border:none; background:none; color:#ef4444; cursor:pointer; font-weight:bold;">삭제</button>
                  </div>
              </c:if>
            </div>
          </header>

          <div class="detail-body">
            ${vo.noticeContent}
          </div>
          
          <div class="action-buttons">
              <button id="likeBtn" class="btn-like">
                  <i data-lucide="heart" size="24"></i>
                  <span id="likeCount">0</span>
              </button>
          </div>
        </article>
        
        <div class="comment-section">
             <div class="comment-header">댓글 (준비중)</div>
             <div style="padding:20px; background:#f8fafc; text-align:center; color:#94a3b8; border-radius:12px;">
                 공지사항 댓글 기능은 준비 중입니다.
             </div>
        </div>

      </section>
    </main>

    <footer>
      <div class="container">
        <p>© 2024 내면의 흔적. All rights reserved.</p>
      </div>
    </footer>
    
    <form name="mngForm" id="mngForm" method="post">
        <input type="hidden" name="noticeSid" value="${vo.noticeSid}">
    </form>

    <script>
       if (typeof lucide !== 'undefined') lucide.createIcons();
       
       // 수정 페이지 이동 (구현 필요 시 notice_reg.jsp를 재활용하거나 notice_mod.jsp 생성)
       function doUpdate() {
           if(confirm("수정하시겠습니까?")) {
               // 수정 화면으로 이동 (Controller에 매핑 필요)
               // location.href = "/notice/moveToMod.do?noticeSid=${vo.noticeSid}";
               alert("수정 기능 연결이 필요합니다.");
           }
       }
       
       // 삭제 처리 (AJAX)
       function doDelete() {
           if(!confirm("정말 삭제하시겠습니까?")) return;
           
           $.ajax({
               type: "POST",
               url: "/notice/doDelete.do", // Controller에 이 매핑을 만들어야 함
               dataType: "json",
               data: { "noticeSid": "${vo.noticeSid}" },
               success: function(data) {
                   if(data.flag == 1) {
                       alert("삭제되었습니다.");
                       location.href = "/notice/noticeList.do";
                   } else {
                       alert("삭제 실패");
                   }
               },
               error: function() {
                   alert("서버 오류");
               }
           });
       }
    </script>
  </body>
</html>