<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>내면의 흔적 - 일기 공개 게시판</title>

    <script src="https://unpkg.com/lucide@latest"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/common.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/famous_diary_board.css"/>
   	
   	
    <script src="../../resources/assets/js/common.js"></script>
  </head>
  <body>
    <header>
      <div class="container header-inner flex-between">
        <a
          href="../html/index.html"
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
        <a href="../html/overview.html" class="tab-btn"
          ><i data-lucide="sparkles"></i> 개요</a
        >
        <a href="../html/notice.html" class="tab-btn"
          ><i data-lucide="book-open"></i> 공지사항</a
        >

        <div class="dropdown-container">
          <a
            href="../html/board_diary.html"
            class="tab-btn active"
            style="width: 100%; border: none"
          >
            <i data-lucide="pencil"></i> 게시판
          </a>
          <div class="dropdown-content">
            <a
              href="../html/board_diary.html"
              style="
                color: var(--primary-blue);
                font-weight: bold;
                background-color: #f8fafc;
              "
              >📖 일기 공개 게시판</a
            >
            <a href="../html/board_quotes.html">💬 명언 모음집</a>
          </div>
        </div>

        <a href="../html/myPage.html" class="tab-btn"
          ><i data-lucide="user"></i> 마이페이지</a
        >
      </div>

      <div class="tab-content">
        <section class="board-best-section">
          <div class="section-title" style="margin-bottom: 1.5rem">
            <h3>🏆 명예의 전당 (Best 3)</h3>
            <span
              style="
                font-size: 0.9rem;
                color: #64748b;
                font-weight: normal;
                margin-left: 10px;
              "
              >가장 많은 공감을 받은 이야기들입니다.</span
            >
          </div>

          <div class="posts-grid">
            <article class="post-card best-card">
              <div
                style="
                  font-size: 0.85rem;
                  font-weight: bold;
                  color: #d97706;
                  margin-bottom: 8px;
                "
              >
                🥇 1위
              </div>
              <div class="post-tag gratitude">감사</div>
              <h4 class="post-title">퇴근길에 본 노을이 너무 예뻐서...</h4>
              <p class="post-preview">
                지친 하루였지만 하늘을 보는 순간 모든 피로가 싹 풀리는
                기분이었어요. 살아있음에 감사합니다.
              </p>
              <div class="post-meta">
                <span>행복한구름</span>
                <div
                  style="
                    display: flex;
                    align-items: center;
                    gap: 4px;
                    color: #e11d48;
                    font-weight: bold;
                  "
                >
                  <i data-lucide="heart" style="width: 14px; fill: #e11d48"></i>
                  1,204
                </div>
              </div>
            </article>

            <article class="post-card best-card">
              <div
                style="
                  font-size: 0.85rem;
                  font-weight: bold;
                  color: #94a3b8;
                  margin-bottom: 8px;
                "
              >
                🥈 2위
              </div>
              <div class="post-tag quote">명언</div>
              <h4 class="post-title">중요한 건 꺾이지 않는 마음</h4>
              <p class="post-preview">
                오늘 실패했다고 해서 내일도 실패하란 법은 없습니다. 다시
                도전하는 용기를 가져봅니다.
              </p>
              <div class="post-meta">
                <span>오뚝이</span>
                <div
                  style="
                    display: flex;
                    align-items: center;
                    gap: 4px;
                    color: #e11d48;
                    font-weight: bold;
                  "
                >
                  <i data-lucide="heart" style="width: 14px; fill: #e11d48"></i>
                  982
                </div>
              </div>
            </article>

            <article class="post-card best-card">
              <div
                style="
                  font-size: 0.85rem;
                  font-weight: bold;
                  color: #b45309;
                  margin-bottom: 8px;
                "
              >
                🥉 3위
              </div>
              <div class="post-tag luck">행운</div>
              <h4 class="post-title">버스 정류장에 도착하자마자!</h4>
              <p class="post-preview">
                정류장에 가자마자 버스가 딱! 이런 작은 행운이 하루 전체의 기분을
                좋게 만드네요 ㅎㅎ
              </p>
              <div class="post-meta">
                <span>럭키비키</span>
                <div
                  style="
                    display: flex;
                    align-items: center;
                    gap: 4px;
                    color: #e11d48;
                    font-weight: bold;
                  "
                >
                  <i data-lucide="heart" style="width: 14px; fill: #e11d48"></i>
                  856
                </div>
              </div>
            </article>
          </div>
        </section>

        <section class="board-latest-section">
          <h3 class="section-title">📝 최신 글</h3>

          <div class="board-list-header">
            <span class="th-title">제목</span>
            <span class="th-author">작성자</span>
            <span class="th-date">날짜</span>
            <span class="th-likes">공감</span>
          </div>

          <c:forEach var="diary" items="${list}">
            <div class="board-row">
              <div class="row-content">
                <span class="post-tag gratitude" style="margin: 0">${diary.diaryCategoryName}</span>
                <span class="row-title">${diary.diaryTitle}</span>
                <!-- 신규글 표시 등은 필요시 추가 -->
              </div>
              <div class="row-meta">
                <span class="row-author">${diary.nickname}</span>
                <span class="row-date">${diary.diaryUploadDate}</span>
                <span class="row-likes">${diary.diaryRecCount}</span>
              </div>
            </div>
          </c:forEach>

        </section>
      </div>
    </main>

    <footer>
      <div class="container">
        <p>© 2024 내면의 흔적. All rights reserved.</p>
      </div>
    </footer>
  </body>
</html>
