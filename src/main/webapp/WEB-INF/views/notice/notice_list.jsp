<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>내면의 흔적 - 공지사항</title>

    <script src="https://unpkg.com/lucide@latest"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/notice.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/notice_detail_board
    .css" />
    
    <style>
        .search-area {
            display: flex;
            justify-content: flex-end; /* 오른쪽 정렬 */
            gap: 8px;
            margin-bottom: 20px;
            align-items: center;
        }
        .search-select, .search-input {
            padding: 8px 12px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 0.9rem;
        }
        .btn-search {
            background-color: #3b82f6;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            display: flex; align-items: center; gap: 4px;
        }
        .btn-write {
            background-color: #10b981; /* 녹색 */
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            display: flex; align-items: center; gap: 4px;
            text-decoration: none; font-size: 0.9rem;
        }
        /* 페이징 */
        .pagination { display: flex; justify-content: center; margin-top: 30px; gap: 5px; }
        .page-item {
             padding: 6px 12px; border: 1px solid #e2e8f0; border-radius: 6px; 
             color: #64748b; cursor: pointer; text-decoration: none;
        }
        .page-item.active { background-color: #3b82f6; color: white; border-color: #3b82f6; }
    </style>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/notice.js"></script>
  </head>
  <body>
    <form action="/notice/noticeList.do" method="get" name="noticeForm" id="noticeForm">
        <input type="hidden" name="pageNo" id="pageNo" value="${vo.pageNo}">

        <header>
          <div class="container header-inner flex-between">
            <a href="/main/mainPage.do" class="logo-area" style="text-decoration: none">
              <h1 class="logo-text">내면의 흔적</h1>
            </a>

            <div class="auth-links">
              <c:choose>
                   <c:when test="${empty sessionScope.user}">
                      <a href="/user/signIn.do" class="auth-item">로그인</a>
                      <span class="divider">|</span>
                      <a href="/user/signUp.do" class="auth-item">회원가입</a>
                   </c:when>
                   <c:otherwise>
                      <span class="auth-item">${sessionScope.user.userName}님</span>
                      <span class="divider">|</span>
                      <a href="/user/doLogout.do" class="auth-item">로그아웃</a>
                   </c:otherwise>
               </c:choose>
            </div>
          </div>
        </header>

        <main class="container">
          <div class="tab-list">
            <div class="menu-label">메뉴</div>
            <a href="/main/overview.do" class="tab-btn">
              <i data-lucide="sparkles"></i> 개요
            </a>
            <a href="/notice/noticeList.do" class="tab-btn active">
              <i data-lucide="book-open"></i> 공지사항
            </a>
            <div class="dropdown-container">
              <a href="/diary/diaryList.do" class="tab-btn" style="width: 100%; border: none">
                <i data-lucide="pencil"></i> 게시판
              </a>
              <div class="dropdown-content">
                <a href="/diary/diaryList.do">📖 일기 공개 게시판</a>
                <a href="/famous/famousList.do">💬 명언 모음집</a>
              </div>
            </div>
            <a href="/user/myPage.do" class="tab-btn">
              <i data-lucide="user"></i> 마이페이지
            </a>
          </div>

          <div class="tab-content">
            <div class="notice-container">
              <div style="display:flex; justify-content:space-between; align-items:flex-end; margin-bottom:10px;">
                  <h3 class="section-title" style="margin-bottom:0;">
                    <i data-lucide="megaphone"></i> 공지사항
                  </h3>
              </div>

              <div class="search-area">
                   <select name="searchDiv" id="searchDiv" class="search-select">
                      <option value=""   <c:if test="${vo.searchDiv == ''}">selected</c:if>>전체</option>
                      <option value="10" <c:if test="${vo.searchDiv == '10'}">selected</c:if>>제목</option>
                      <option value="20" <c:if test="${vo.searchDiv == '20'}">selected</c:if>>내용</option>
                   </select>
                   <input type="text" name="searchWord" id="searchWord" class="search-input" 
                          placeholder="검색어 입력" value="${vo.searchWord}">
                   <button type="button" class="btn-search" onclick="doRetrieve(1)">
                       <i data-lucide="search" style="width: 14px;"></i> 검색
                   </button>
                   
                   <c:if test="${sessionScope.user.isAdmin == 'Y'}">
                    <a href="${pageContext.request.contextPath}/notice/moveToReg.do" class="btn-write">
                      <i data-lucide="pen-tool"></i> 글쓰기
                    </a>
                   </c:if>
                   
              </div>
              
              <hr style="margin: 10px 0 20px 0; border-color:#f1f5f9;">

              <ul style="list-style: none; padding:0;">
                <c:choose>
                    <c:when test="${not empty list}">
                        <c:forEach var="item" items="${list}">
                            <li class="notice-item" onclick="location.href='/notice/doSelectOne.do?noticeSid=${item.noticeSid}'">
                              <div class="notice-info">
                                <span style="font-weight: 600; font-size:1.05rem;">
                                    ${item.noticeTitle}
                                </span>
                                </div>
                              <span class="notice-date">${item.noticeTime}</span>
                            </li>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <li style="text-align:center; padding: 40px; color:#94a3b8;">
                            등록된 공지사항이 없습니다.
                        </li>
                    </c:otherwise>
                </c:choose>
              </ul>
              
              <div class="pagination">
                 </div>
              
            </div>
          </div>
        </main>
        
        <footer>
          <div class="container">
            <p>© 2024 내면의 흔적. All rights reserved.</p>
          </div>
        </footer>
    </form>

    <script>
        // Lucide 아이콘 실행
        if (typeof lucide !== 'undefined') lucide.createIcons();

        // 검색 함수
        function doRetrieve(pageNo) {
            document.getElementById("pageNo").value = pageNo;
            document.noticeForm.submit();
        }

        // 엔터키 검색
        document.getElementById("searchWord").addEventListener("keydown", function(e){
            if(e.key === "Enter") {
                e.preventDefault(); // 폼 자동 전송 방지
                doRetrieve(1);
            }
        });
    </script>
  </body>
</html>