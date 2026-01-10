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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/diary_list.css"/>
    <script src="<%=request.getContextPath()%>/resources/assets/js/cmn/jquery.js"></script>
    <%-- <script src="${pageContext.request.contextPath}/resources/assets/js/cmn/common.js"></script> --%>
    <jsp:include page="/WEB-INF/views/main/menu.jsp" />
  </head>
  <body>

    <main class="container">

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
            <c:set var="best0" value="${bestList[0]}" />
            <c:set var="best1" value="${bestList[1]}" />
            <c:set var="best2" value="${bestList[2]}" />
            <article class="post-card best-card">
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
                  ${best0.diaryRecCount}
                </div>
              </div>
            </article>
            <article class="post-card best-card">
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
                  ${best1.diaryRecCount}
                </div>
              </div>
            </article>
            <article class="post-card best-card">
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
          </div>
        </section>

        <section class="board-latest-section">
          <h3 class="section-title">📝 최신 글</h3>

          <div class="board-list-header">
            <span class="th-title">제목</span>
            <span class="th-author">작성자</span>
            <span class="th-date">날짜</span>
            <span class="th-likes">공감</span>
            <span class="th-count">조회수</span>
          </div>

          <c:forEach var="diary" items="${list}">
            <a href="doSelectOne.do?diarySid=${diary.diarySid}" class="board-row" style="display:flex; text-decoration:none; color:inherit;">
              <div class="row-content">
                <c:choose>
                  <c:when test="${diary.diaryCategory == 10}">
                    <span class="post-tag quote" style="margin: 0">${diary.diaryCategoryName}</span>
                  </c:when>
                  <c:when test="${diary.diaryCategory == 20}">
                    <span class="post-tag luck" style="margin: 0">${diary.diaryCategoryName}</span>
                  </c:when>
                  <c:when test="${diary.diaryCategory == 30}">
                    <span class="post-tag gratitude" style="margin: 0">${diary.diaryCategoryName}</span>
                  </c:when>
                  <c:when test="${diary.diaryCategory == 40}">
                    <span class="post-tag reflection" style="margin: 0">${diary.diaryCategoryName}</span>
                  </c:when>
                  <c:otherwise>
                    <span class="post-tag" style="margin: 0">${diary.diaryCategoryName}</span>
                  </c:otherwise>
                </c:choose>
                <span class="row-title">${diary.diaryTitle}</span>
                <!-- 신규글 표시 등은 필요시 추가 -->
              </div>
              <div class="row-meta">
                <span class="row-author">${diary.nickname}</span>
                <span class="row-date">${diary.diaryUploadDate}</span>
                <span class="row-likes">${diary.diaryRecCount}</span>
                <span class="row-count">${diary.diaryViewCount}</span>
              </div>
            </a>
          </c:forEach>

        </section>
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
