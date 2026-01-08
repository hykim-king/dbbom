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
    <script>
      document.addEventListener('DOMContentLoaded', function() {
        $('#likeBtn').on('click', function() {
          $.ajax({
            url: '${pageContext.request.contextPath}/diary/updateRecCount.do',
            type: 'POST',
            data: { diarySid: '${diaryVO.diarySid}' },
            success: function(res) {
              // 서버에서 JSON 문자열로 응답이 오므로 파싱 필요
              if (typeof res === 'string') {
                try { res = JSON.parse(res); } catch(e) {}
              }
              if(res && res.flag === 0) {
                // 10분 제한 등 안내 메시지
                alert(res.message || '추천이 제한되었습니다.');
                return;
              }
              // 서버에서 newRecCount 반환 시
              if(res && res.newRecCount !== undefined) {
                $('#likeCount').text(res.newRecCount);
                $('#likeBtn').addClass('active');
                $('#heartIcon').css('fill', 'white');
              } else if(res && res.flag === 1 && res.recCount !== undefined) {
                $('#likeCount').text(res.recCount);
                $('#likeBtn').addClass('active');
                $('#heartIcon').css('fill', 'white');
              } else {
                // fallback: 새로고침
                location.reload();
              }
            },
            error: function() {
              alert('추천수 증가에 실패했습니다.');
            }
          });
        });
      });
    </script>
</head>
<header>
      <div class="container header-inner flex-between"> 
        <a
          href="../html/main.html"
          class="logo-area"
          style="text-decoration: none"
        >
          <h1 class="logo-text">내면의 흔적</h1>
        </a>
        <div class="auth-links">
          <a href="../html/login_page.html" class="auth-item">로그인</a>
          <span class="divider">|</span>
          <a href="../html/sign_in.html" class="auth-item">회원가입</a>
        </div>
      </div>
    </header>
    <main class="container">
      <div class="tab-list"> 
        <div class="menu-label">메뉴</div>
        <a href="../html/outline.html" class="tab-btn">
          <i data-lucide="sparkles"></i> 개요
        </a>
        <a href="../html/notice.html" class="tab-btn">
          <i data-lucide="book-open"></i> 공지사항
        </a>
        <div class="dropdown-container">
          <a
            href="../html/diary_board.html"
            class="tab-btn"
            style="width: 100%; border: none"
          >
            <i data-lucide="pencil"></i> 게시판
          </a>
          <div class="dropdown-content">
            <a
              href="../html/diary_board.html"
              style="
                color: var(--primary-blue);
                font-weight: bold;
                background-color: #f8fafc;
              "
              >📖 일기 공개 게시판</a
            >
            <a href="../html/famous_board.html">💬 명언 모음집</a>
          </div>
        </div>
        <a href="../html/mypage.html" class="tab-btn active">
          <i data-lucide="user"></i> 마이페이지
        </a>
      </div>

        <div style="flex: 1;">
          <a href="board_diary.html" class="back-btn">
            <i data-lucide="arrow-left" size="18"></i> 목록으로 돌아가기
          </a>

          <article class="detail-card">
            <header class="detail-header">

              <span class="post-tag gratitude">${diaryVO.diaryCategoryName}</span>
              <h2 class="detail-title">${diaryVO.diaryTitle}</h2>
              <div class="detail-meta-row">
                <div class="meta-left">
                  <span class="meta-item"><i data-lucide="user" size="16"></i> ${diaryVO.nickname}</span>
                  <span class="meta-item"><i data-lucide="calendar" size="16"></i> ${diaryVO.diaryUploadDate}</span>
                </div>
                <div class="meta-left">
                  <span class="meta-item"><i data-lucide="eye" size="16"></i> 조회 ${diaryVO.diaryViewCount}</span>
                </div>
              </div>    
            </header>

            <div class="detail-body">
              ${diaryVO.diaryContent}
            </div>

            <div class="action-buttons">
              <button class="btn-like" id="likeBtn">
                <i data-lucide="heart" id="heartIcon"></i>
                <span id="likeCount">${diaryVO.diaryRecCount}</span>
              </button>
            </div>

            <section class="comment-section">
              <div class="comment-header">
                <i data-lucide="message-circle" size="20"></i> 댓글 <span id="commentCount">${fn:length(commentList)}</span>
              </div>
                    
              <form class="comment-form" method="post" action="addComment.do">
                <input type="text" name="commentContent" id="commentInput" class="comment-input" placeholder="따뜻한 댓글로 공감을 나눠주세요.">
                <button class="btn-comment" type="submit">등록</button>
              </form>

              <div class="comment-list" id="commentList">
                <c:forEach var="comment" items="${commentList}">
                  <div class="comment-wrapper" id="comment-${comment.commentId}" style="background: #f8fafc; border-radius: 12px; padding: 20px; margin-bottom: 16px; border: none;">
                    <div class="comment-item">
                      <div class="comment-content">
                        <span class="comment-user" style="font-weight: bold; color: #1e293b;">
                          ${comment.writer}
                          <small style="font-weight:normal; color:#94a3b8; margin-left:8px;">${comment.regDate}</small>
                        </span>
                        <p class="comment-text" style="margin: 10px 0; color: #334155;">${comment.content}</p>
                        <div class="edit-form" style="display:none; gap:8px; margin-top:8px;">
                          <input type="text" class="edit-input" style="flex:1; padding:8px; border:1px solid #e2e8f0; border-radius:6px;">
                          <button class="btn-save" style="padding:4px 12px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;">저장</button>
                          <button class="btn-cancel" style="padding:4px 12px; background:#94a3b8; color:white; border:none; border-radius:4px; cursor:pointer;">취소</button>
                        </div>
                      </div>
                      <div class="comment-actions" style="display: flex; gap: 12px; margin-top: 12px;">
                        <button class="btn-action-text btn-like-comment" onclick="toggleCommentLike(this)" style="font-size:13px; cursor:pointer; background:none; border:none; color:#64748b; padding:0;">
                          좋아요 <span class="like-count">${comment.likeCount}</span>
                        </button>
                        <button class="btn-action-text" onclick="showEditForm(this)" style="font-size:13px; cursor:pointer; background:none; border:none; color:#64748b; padding:0;">수정</button>
                        <button class="btn-action-text" onclick="reportContent('comment', ${comment.commentId})" style="font-size:13px; cursor:pointer; background:none; border:none; color:#64748b; padding:0;">신고</button>
                        <button class="btn-action-text" onclick="deleteComment(${comment.commentId})" style="font-size:13px; cursor:pointer; background:none; border:none; color:#ef4444; padding:0;">삭제</button>
                      </div>
                    </div>
                  </div>
                </c:forEach>
              </div>
            </section>
          </article>
        </div>
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