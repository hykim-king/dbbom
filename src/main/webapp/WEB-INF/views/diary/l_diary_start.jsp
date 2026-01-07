<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>명언일기 | 오늘의 흔적</title>

    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="../javascript/common.js"></script>
    <script src="../javascript/l_diary_start.js"></script>
    <link rel="stylesheet" href="../css/l_diary_start.css" />
  </head>
  <body>
    <header>
      <div class="container header-inner flex-between">
        <a href="main.html" class="logo-area" style="text-decoration: none">
          <h1 class="logo-text">내면의 흔적</h1>
        </a>

        <div class="auth-links">
          <a href="login_page.html" class="auth-item">로그인</a>
          <span class="divider">|</span>
          <a href="sign_in.html" class="auth-item">회원가입</a>
        </div>
      </div>
    </header>

    <main class="container">
      <div class="tab-list">
        <div class="menu-label">메뉴</div>

        <a href="outline.html" class="tab-btn">
          <i data-lucide="sparkles"></i> 개요
        </a>

        <a href="notice.html" class="tab-btn">
          <i data-lucide="book-open"></i> 공지사항
        </a>

        <div class="dropdown-container">
          <a
            href="diary_board.html"
            class="tab-btn"
            style="width: 100%; border: none"
          >
            <i data-lucide="pencil"></i> 게시판
          </a>
          <div class="dropdown-content">
            <a href="diary_board.html">📖 일기 공개 게시판</a>
            <a href="famous_board.html">💬 명언 모음집</a>
          </div>
        </div>

        <a href="myPage.html" class="tab-btn">
          <i data-lucide="user"></i> 마이페이지
        </a>
      </div>

      <div class="card">
        <div class="card-body">
          <h3 class="section-title">
            <i data-lucide="heart-pulse"></i> 오늘의 흔적
          </h3>
          <p>하루의 흔적을 일기에 남겨 주세요.</p>
          <p style="color: #18a067; line-height: 1.6" class="p_font">
            그 날의 감정과 내용에 맞는 명언이 조용히 찾아와 여러분께
            전해드립니다.
          </p>

          <div class="info-grid">
            <div style="grid-column: span 2">
              <p>
                기쁨, 슬픔, 설렘부터 고민스러운 마음까지 당신이 느낀 감정을
                그대로 이해하고,<br />
                <span class="p_font"
                  >남겨진 흔적으로 하루를 돌아보는 소중한 순간이
                  되어줍니다.</span
                >
              </p>
              <br />
              <p>
                이렇게 기록을 이어가다 보면, 단순히 일기를 쓰는 것을 넘어<br />
                자신의 마음을 더 깊이 이해하고,<br />
                <span class="p_font">작은 위로와 힘을 얻을 수 있습니다.</span>
              </p>
            </div>
          </div>
        </div>
      </div>

      <div class="card">
        <div class="card-body">
          <h3 class="section-title">
            <i data-lucide="edit"></i> 오늘의 흔적 작성 요령
          </h3>
          <p style="color: #374151; line-height: 1.6">
            더 잘 어울리는 명언을 만나기 위해 아래의 요령을 참고해 주세요.
          </p>

          <div class="info-grid">
            <div class="info-box blue">
              <h4>솔직한 하루를 적어주세요</h4>
              <p class="p_font">
                잘한 일, 힘들었던 순간, 사소한 감정까지 있는 그대로 적을수록
                명언이 더 정확해져요.
              </p>
              <p>예) “괜히 우울했던 하루였다”, “별일 없었지만 마음이 편했다”</p>
            </div>
            <div class="info-box indigo">
              <h4>감정을 한 단어로 표현해 보세요</h4>
              <p class="p_font">
                기쁨, 불안, 설렘, 후회처럼 짧은 감정 표현은 명언을 찾는 중요한
                힌트가 됩니다.
              </p>
            </div>
            <div class="info-box blue">
              <h4>길지 않아도 괜찮아요</h4>
              <p class="p_font">중요한 건 분량이 아니라 지금의 마음이에요.</p>
              <p>한두 문장만 적어도 충분해요.</p>
            </div>
            <div class="info-box indigo">
              <h4>판단하지 말고 기록하세요</h4>
              <p class="p_font">명언 일기는 당신의 감정을 평가하지 않습니다.</p>
              <p>좋은 생각, 나쁜 생각을 나누지 않아도 돼요.</p>
            </div>
          </div>

          <div style="text-align: center; margin-top: 20px">
            <a
              href="l_diary_write.html"
              class="diary-btn"
              style="
                text-decoration: none;
                display: inline-block;
                padding: 10px 20px;
                background-color: #18a067;
                color: #fff;
                border-radius: 5px;
              "
              >일기 작성하기</a
            >
          </div>
        </div>
      </div>
    </main>

    <footer>
      <div class="container">
        <p style="margin-bottom: 0.5rem">
          © 2024 내면의 흔적. All rights reserved.
        </p>
        <p style="font-size: 0.875rem">당신의 감정을 소중히 여기는 공간</p>
      </div>
    </footer>

    <script>
      lucide.createIcons();
    </script>
  </body>
</html>