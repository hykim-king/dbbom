<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.pcwk.ehr.user.domain.UserVO" %>
<%
    // 세션에서 로그인 사용자 정보 가져오기 
    UserVO loginUser = (UserVO) session.getAttribute("loginUser");
    String welcomeName = "";
    boolean isLogin = false;
    if (loginUser != null) {
        isLogin = true;
        // 닉네임이 있으면 닉네임, 없으면 아이디 표시
        welcomeName = (loginUser.getNickname() != null && !loginUser.getNickname().trim().isEmpty()) 
                      ? loginUser.getNickname() : loginUser.getUserId();
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>내면의 흔적 - 홈</title>

    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="<%=request.getContextPath()%>/resources/assets/js/cmn/jquery.js"></script>
    <script src="<%=request.getContextPath()%>/resources/assets/js/common.js"></script>
    <script src="<%=request.getContextPath()%>/resources/assets/js/main.js"></script>
    <script src="<%=request.getContextPath()%>/resources/assets/js/famous_diary_board.js"></script>
    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/assets/css/common.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/assets/css/main.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/assets/css/diary_list.css" />

    <script>
        // 마이페이지 이동 로직 (로그인 여부 체크)
        function moveToMyPage() {
            var isLogin = <%= isLogin %>;
            if (!isLogin) {
                alert("로그인이 필요합니다.");
                location.href = "<%=request.getContextPath()%>/user/signIn.do";
                return;
            }
            location.href = "<%=request.getContextPath()%>/user/myPage.do";
        }

        // 로그아웃 로직
        function doLogout() {
            if (!confirm("로그아웃 하시겠습니까?")) return;
            $.ajax({
                url: "<%=request.getContextPath()%>/user/doLogoutAjax.do",
                type: "POST",
                dataType: "json",
                success: function(res) {
                    alert(res.message);
                    if (res.flag === 1) location.href = "<%=request.getContextPath()%>/main/main.do";
                },
                error: function(xhr, status, err) { alert("오류 발생"); }
            });
        }

        // 회원탈퇴 로직
        function doWithdraw() {
            if (!confirm("정말 회원탈퇴 하시겠습니까?\n(가입 정보가 DB에서 삭제됩니다.)")) return;
            $.ajax({
                url: "<%=request.getContextPath()%>/user/doWithdrawAjax.do",
                type: "POST",
                dataType: "json",
                success: function(res) {
                    alert(res.message);
                    if (res.flag === 1) location.href = "<%=request.getContextPath()%>/resources/main/main.do";
                },
                error: function(xhr, status, err) { alert("오류 발생"); }
            });
        }
    </script>
</head>
<body>
    <header>
      <div class="container header-inner flex-between">
        <a href="<%=request.getContextPath()%>/main/main.do" class="logo-area" style="text-decoration: none">
          <h1 class="logo-text">내면의 흔적</h1>
        </a>

        <div class="auth-links">
          <% if (!isLogin) { %>
              <a href="<%=request.getContextPath()%>/user/signIn.do" class="auth-item">로그인</a>
              <span class="divider">|</span>
              <a href="<%=request.getContextPath()%>/user/signUp.do" class="auth-item">회원가입</a>
          <% } else { %>
              <span class="auth-item"><b><%= welcomeName %></b>님 환영합니다</span>
              <span class="divider">|</span>
              <a href="javascript:doLogout();" class="auth-item">로그아웃</a>
              <span class="divider">|</span>
              <a href="javascript:doWithdraw();" class="auth-item" style="color:red; font-size:0.8rem;">회원탈퇴</a>
          <% } %>
        </div>
      </div>
    </header>

    <main class="container">
      <div class="tab-list">
        <div class="menu-label">메뉴</div>
        <a href="<%=request.getContextPath()%>/main/outline.do" class="tab-btn"><i data-lucide="sparkles"></i> 개요</a>
        <a href="<%=request.getContextPath()%>/notice/noticeList.do" class="tab-btn">
        <i data-lucide="book-open"></i> 공지사항</a>
        <div class="dropdown-container">
          <a href="<%=request.getContextPath()%>/diary/diaryList.do" class="tab-btn" style="width: 100%; border: none"><i data-lucide="pencil"></i> 게시판</a>
          <div class="dropdown-content">
            <a href="<%=request.getContextPath()%>/diary/diaryList.do">📖 일기 공개 게시판</a>
            <a href="<%=request.getContextPath()%>/famous/famous.do">💬 명언 모음집</a>
          </div>
        </div>
        <a href="javascript:moveToMyPage();" class="tab-btn"><i data-lucide="user"></i> 마이페이지</a>
      </div>

      <div class="tab-content">
        <section class="hero-section">
          <h2>오늘 당신의 마음은 어떤가요?</h2>
          <p>네 가지 주제로 당신의 하루를 기록해 보세요.</p>
        </section>

        <section class="diary-menu-section">
          <a href="<%=request.getContextPath()%>/diary/fDiaryStart.do" style="text-decoration: none; color: inherit">
            <div class="diary-card quote">
              <div class="icon-circle"><i data-lucide="quote"></i></div>
              <h3>명언 일기</h3>
              <p>마음에 울림을 주는 한 문장.</p>
            </div>
          </a>
          <a href="<%=request.getContextPath()%>/diary/tDiaryStart.do" style="text-decoration: none; color: inherit">
            <div class="diary-card gratitude">
              <div class="icon-circle"><i data-lucide="flower-2"></i></div>
              <h3>감사 일기</h3>
              <p>오늘 하루 감사했던 순간들.</p>
            </div>
          </a>
          <a href="<%=request.getContextPath()%>/diary/lDiaryStart.do" style="text-decoration: none; color: inherit">
            <div class="diary-card luck">
              <div class="icon-circle"><i data-lucide="clover"></i></div>
              <h3>행운 일기</h3>
              <p>나에게 찾아온 작은 행운.</p>
            </div>
          </a>
          <a href="<%=request.getContextPath()%>/diary/rDiaryStart.do" style="text-decoration: none; color: inherit">
            <div class="diary-card reflection">
              <div class="icon-circle"><i data-lucide="moon"></i></div>
              <h3>성찰 일기</h3>
              <p>나를 성장시키는 시간.</p>
            </div>
          </a>
        </section>

        <section class="top-diary-section" style="margin-top: 5rem; margin-bottom: 3rem">
          <div class="section-title" style="text-align: center; margin-bottom: 2rem;">
            <h3><i data-lucide="flame" style="color: #e11d48"></i> 인기 일기 Top 3</h3>
          </div>
                    <div class="posts-grid">
            <c:set var="best0" value="${bestList[0]}" />
            <c:set var="best1" value="${bestList[1]}" />
            <c:set var="best2" value="${bestList[2]}" />
            <a href="<%=request.getContextPath()%>/diary/doSelectOne.do?diarySid=${best0.diarySid}" class="post-card best-card" style="text-decoration:none;color:inherit;">
              <article style="all:unset;display:block;">
                <div style="font-size:0.85rem;font-weight:bold;color:#d97706;margin-bottom:8px;">🥇 1위</div>
                <c:choose>
                  <c:when test="${best0.diaryCategory == 10}">
                    <div class="post-tag quote">${best0.diaryCategoryName}</div>
                  </c:when>
                  <c:when test="${best0.diaryCategory == 20}">
                    <div class="post-tag luck">${best0.diaryCategoryName}</div>
                  </c:when>
                  <c:when test="${best0.diaryCategory == 30}">
                    <div class="post-tag gratitude">${best0.diaryCategoryName}</div>
                  </c:when>
                  <c:when test="${best0.diaryCategory == 40}">
                    <div class="post-tag reflection">${best0.diaryCategoryName}</div>
                  </c:when>
                  <c:otherwise>
                    <div class="post-tag">${best0.diaryCategoryName}</div>
                  </c:otherwise>
                </c:choose>
                <h4 class="post-title">${best0.diaryTitle}</h4>
                <p class="post-preview">${best0.diaryContent}</p>
                <div class="post-meta">
                  <span>${best0.nickname}</span>
                  <div style="display: flex; align-items: center; gap: 4px; color: #e11d48; font-weight: bold;">
                    <i data-lucide="heart" style="width: 14px; fill: #e11d48"></i>
                    ${best0.diaryRecCount}
                  </div>
                </div>
              </article>
            </a>
            <a href="<%=request.getContextPath()%>/diary/doSelectOne.do?diarySid=${best1.diarySid}" class="post-card best-card" style="text-decoration:none;color:inherit;">
              <article style="all:unset;display:block;">
                <div style="font-size:0.85rem;font-weight:bold;color:#94a3b8;margin-bottom:8px;">🥈 2위</div>
                <c:choose>
                  <c:when test="${best1.diaryCategory == 10}">
                    <div class="post-tag quote">${best1.diaryCategoryName}</div>
                  </c:when>
                  <c:when test="${best1.diaryCategory == 20}">
                    <div class="post-tag luck">${best1.diaryCategoryName}</div>
                  </c:when>
                  <c:when test="${best1.diaryCategory == 30}">
                    <div class="post-tag gratitude">${best1.diaryCategoryName}</div>
                  </c:when>
                  <c:when test="${best1.diaryCategory == 40}">
                    <div class="post-tag reflection">${best1.diaryCategoryName}</div>
                  </c:when>
                  <c:otherwise>
                    <div class="post-tag">${best1.diaryCategoryName}</div>
                  </c:otherwise>
                </c:choose>
                <h4 class="post-title">${best1.diaryTitle}</h4>
                <p class="post-preview">${best1.diaryContent}</p>
                <div class="post-meta">
                  <span>${best1.nickname}</span>
                  <div style="display: flex; align-items: center; gap: 4px; color: #e11d48; font-weight: bold;">
                    <i data-lucide="heart" style="width: 14px; fill: #e11d48"></i>
                    ${best1.diaryRecCount}
                  </div>
                </div>
              </article>
            </a>
            <a href="<%=request.getContextPath()%>/diary/doSelectOne.do?diarySid=${best2.diarySid}" class="post-card best-card" style="text-decoration:none;color:inherit;">
              <article style="all:unset;display:block;">
                <div style="font-size:0.85rem;font-weight:bold;color:#b45309;margin-bottom:8px;">🥉 3위</div>
                <c:choose>
                  <c:when test="${best2.diaryCategory == 10}">
                    <div class="post-tag quote">${best2.diaryCategoryName}</div>
                  </c:when>
                  <c:when test="${best2.diaryCategory == 20}">
                    <div class="post-tag luck">${best2.diaryCategoryName}</div>
                  </c:when>
                  <c:when test="${best2.diaryCategory == 30}">
                    <div class="post-tag gratitude">${best2.diaryCategoryName}</div>
                  </c:when>
                  <c:when test="${best2.diaryCategory == 40}">
                    <div class="post-tag reflection">${best2.diaryCategoryName}</div>
                  </c:when>
                  <c:otherwise>
                    <div class="post-tag">${best2.diaryCategoryName}</div>
                  </c:otherwise>
                </c:choose>
                <h4 class="post-title">${best2.diaryTitle}</h4>
                <p class="post-preview">${best2.diaryContent}</p>
                <div class="post-meta">
                  <span>${best2.nickname}</span>
                  <div style="display:flex;align-items:center;gap:4px;color:#e11d48;font-weight:bold;">
                    <i data-lucide="heart" style="width:14px;fill:#e11d48"></i>
                    ${best2.diaryRecCount}
                  </div>
                </div>
              </article>
            </a>
          </div>
        </section>
      </div>
    </main>

    <footer>
      <div class="container"><p>© 2024 내면의 흔적. All rights reserved.</p></div>
    </footer>

    <script>
      lucide.createIcons();
    </script>
</body>
</html>