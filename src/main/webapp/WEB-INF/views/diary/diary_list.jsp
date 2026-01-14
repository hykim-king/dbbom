<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.pcwk.ehr.user.domain.UserVO"%>
<%
    UserVO loginUser = (UserVO) session.getAttribute("loginUser");
    String welcomeName = "";
    boolean isLogin = false;
    boolean isAdmin = false;

    if (loginUser != null) {
        isLogin = true;
        if ("Y".equals(loginUser.getAdminChk())) {
            isAdmin = true;
        }
        welcomeName = (loginUser.getNickname() != null && !loginUser.getNickname().trim().isEmpty())
                    ? loginUser.getNickname()
                    : loginUser.getUserId();
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>내면의 흔적 - 일기 공개 게시판</title>

<script src="https://unpkg.com/lucide@latest"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/diary_list.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/serch.css" />
<script src="${pageContext.request.contextPath}/resources/assets/js/cmn/jquery.js"></script>

<script>
    // ContextPath를 전역 변수로 설정
    const cp = "${pageContext.request.contextPath}";

<<<<<<< HEAD
    // 마이페이지 이동
    function moveToManagement() {
        const isLogin = <%=isLogin%>;
        if (!isLogin) {
            alert("로그인이 필요합니다.");
            location.href = cp + "/user/signIn.do";
            return;
        }
        location.href = cp + "/user/myPage.do";
    }

    // 로그아웃
    function doLogout() {
        if (!confirm("로그아웃 하시겠습니까?")) return;
        $.ajax({
            url: cp + "/user/doLogoutAjax.do",
            type: "POST",
            dataType: "json",
            success: function(res) {
                alert(res.message);
                if (res.flag === 1) location.href = cp + "/main/main.do";
            },
            error: function(xhr, status, err) { alert("오류 발생"); }
        });
    }

    // 회원탈퇴
    function doWithdraw() {
        if (!confirm("정말 회원탈퇴 하시겠습니까?\n(가입 정보가 DB에서 삭제됩니다.)")) return;
        $.ajax({
            url: cp + "/user/doWithdrawAjax.do",
            type: "POST",
            dataType: "json",
            success: function(res) {
                alert(res.message);
                if (res.flag === 1) {
                    location.href = cp + "/main/main.do";
                }
            },
            error: function(xhr, status, err) { alert("오류 발생"); }
        });
    }

    // 검색 및 페이지 이동
    function doRetrieve(pageNo) {
        const pageNoField = document.getElementById("pageNo");
        if (pageNoField) pageNoField.value = pageNo;
        const form = document.getElementById("diaryForm");
        if (form) form.submit();
    }
</script>
</head>
<body>
    <header>
        <div class="container header-inner flex-between">
            <a href="${pageContext.request.contextPath}/main/main.do" class="logo-area" style="text-decoration: none">
                <h1 class="logo-text">내면의 흔적</h1>
            </a>
            <div class="auth-links">
                <% if (!isLogin) { %>
                    <a href="${pageContext.request.contextPath}/user/signIn.do" class="auth-item">로그인</a>
                    <span class="divider">|</span>
                    <a href="${pageContext.request.contextPath}/user/signUp.do" class="auth-item">회원가입</a>
                <% } else { %>
                    <span class="auth-item"><b><%=welcomeName%></b>님 환영합니다</span>
                    <span class="divider">|</span>
                    <% if (isAdmin) { %>
                        <a href="${pageContext.request.contextPath}/admin/adminPage.do" class="auth-item" style="color: #2563eb; font-weight: bold;">관리자 페이지</a>
                        <span class="divider">|</span>
                    <% } %>
                    <a href="javascript:doLogout();" class="auth-item">로그아웃</a>
                    <% if (!isAdmin) { %>
                        <span class="divider">|</span>
                        <a href="javascript:doWithdraw();" class="auth-item" style="color: red; font-size: 0.8rem;">회원탈퇴</a>
                    <% } %>
                <% } %>
            </div>
        </div>
    </header>
=======

  </head>
  <body>
>>>>>>> feature/donghan-backup

    <main class="container">
        <div class="tab-list">
            <div class="menu-label">메뉴</div>
            <a href="${pageContext.request.contextPath}/main/outline.do" class="tab-btn"><i data-lucide="sparkles"></i> 개요</a>
            <a href="${pageContext.request.contextPath}/notice/noticeList.do" class="tab-btn"><i data-lucide="book-open"></i> 공지사항</a>
            <div class="dropdown-container">
                <a href="${pageContext.request.contextPath}/diary/diaryList.do" class="tab-btn active" style="width: 100%; border: none"><i data-lucide="pencil"></i> 게시판</a>
                <div class="dropdown-content">
                    <a href="${pageContext.request.contextPath}/diary/diaryList.do">📖 일기 공개 게시판</a>
                    <a href="${pageContext.request.contextPath}/famous/famous.do">💬 명언 모음집</a>
                </div>
<<<<<<< HEAD
            </div>
            <a href="javascript:moveToManagement();" class="tab-btn"><i data-lucide="user"></i> 마이페이지</a>
        </div>
=======
              </article>
            </a>
            <a href="doSelectOne.do?diarySid=${best1.diarySid}" class="post-card best-card" style="text-decoration:none;color:inherit;">
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
            <a href="doSelectOne.do?diarySid=${best2.diarySid}" class="post-card best-card" style="text-decoration:none;color:inherit;">
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
                <!-- 페이징 UI  -->
        <%-- <div class="pagination" style="display: flex; justify-content: center; margin-top: 30px; gap: 5px;">
          <c:if test="${vo.totalCnt > 0}">
            <c:set var="totalPage" value="${(vo.totalCnt + vo.pageSize - 1) / vo.pageSize}" />
            <c:set var="totalPageInt" value="${fn:split(totalPage, '.')[0]}" />
            <c:forEach var="i" begin="1" end="${totalPageInt}">
              <a href="diaryList.do?pageNo=${i}&pageSize=${vo.pageSize}&searchDiv=${vo.searchDiv}&searchWord=${vo.searchWord}"
                 class="page-item${vo.pageNo == i ? ' active' : ''}">
                ${i}
              </a>
            </c:forEach>
          </c:if>
        </div> --%>

<%-- 페이징 변수 계산 --%>
<c:set var="pageBlock" value="5" />
<c:set var="startPage" value="${((vo.pageNo - 1) / pageBlock) * pageBlock + 1}" />
<c:set var="endPage" value="${startPage + pageBlock - 1}" />
<c:if test="${endPage > totalPageNum}">
  <c:set var="endPage" value="${totalPageNum}" />
</c:if>

<div class="pagination-container">
  <ul class="pagination-list">
    <c:if test="${totalCnt > 0}">
    
      <c:if test="${vo.pageNo > 1}">
        <li>
          <a href="?pageNo=${vo.pageNo - 1}&pageSize=${vo.pageSize}&searchDiv=${vo.searchDiv}&searchWord=${vo.searchWord}" 
             class="page-link prev-next">이전</a>
        </li>
      </c:if>
      
      <c:forEach begin="${startPage}" end="${endPage}" var="i">
        <li>
          <a href="?pageNo=${i}&pageSize=${vo.pageSize}&searchDiv=${vo.searchDiv}&searchWord=${vo.searchWord}"
             class="page-link ${vo.pageNo == i ? 'active' : ''}">${i}</a>
        </li>
      </c:forEach>
      
      <c:if test="${vo.pageNo < totalPageNum}">
        <li>
          <a href="?pageNo=${vo.pageNo + 1}&pageSize=${vo.pageSize}&searchDiv=${vo.searchDiv}&searchWord=${vo.searchWord}" 
             class="page-link prev-next">다음</a>
        </li>
      </c:if>
    </c:if>
  </ul>
</div>





>>>>>>> feature/donghan-backup

        <div class="tab-content">
            <form action="${pageContext.request.contextPath}/diary/diaryList.do" method="get" name="diaryForm" id="diaryForm" style="margin-bottom: 20px;">
                <div class="search-area">
                    <select name="searchDiv" id="searchDiv" class="search-select">
                        <option value="10" ${vo.searchDiv == '10' ? 'selected' : ''}>제목</option>
                        <option value="20" ${vo.searchDiv == '20' ? 'selected' : ''}>내용</option>
                        <option value="30" ${vo.searchDiv == '30' ? 'selected' : ''}>제목+내용</option>
                    </select>
                    <input type="text" name="searchWord" id="searchWord" class="search-input" value="${vo.searchWord}" placeholder="검색어를 입력하세요" autocomplete="off">
                    <button type="button" class="btn-search" onclick="doRetrieve(1)">
                        <i data-lucide="search" style="width: 14px;"></i> 검색
                    </button>
                </div>
                <input type="hidden" name="pageNo" id="pageNo" value="${vo.pageNo}">
            </form>

            <%-- 명예의 전당 및 게시판 리스트 섹션 (기존과 동일) --%>
            <section class="board-best-section">
                <div class="section-title" style="margin-bottom: 1.5rem">
                    <h3>🏆 명예의 전당 (Best 3)</h3>
                </div>
                <div class="posts-grid">
                    <c:forEach var="best" items="${bestList}" varStatus="status">
                        <a href="doSelectOne.do?diarySid=${best.diarySid}" class="post-card best-card" style="text-decoration: none; color: inherit;">
                            <article style="all: unset; display: block;">
                                <div style="font-size: 0.85rem; font-weight: bold; color: ${status.index == 0 ? '#d97706' : (status.index == 1 ? '#94a3b8' : '#b45309')}; margin-bottom: 8px;">
                                    ${status.index == 0 ? '🥇 1위' : (status.index == 1 ? '🥈 2위' : '🥉 3위')}
                                </div>
                                <div class="post-tag ${best.diaryCategory == 10 ? 'quote' : (best.diaryCategory == 20 ? 'luck' : (best.diaryCategory == 30 ? 'gratitude' : (best.diaryCategory == 40 ? 'reflection' : '')))}">
                                    ${best.diaryCategoryName}
                                </div>
                                <h4 class="post-title">${best.diaryTitle}</h4>
                                <p class="post-preview">${best.diaryContent}</p>
                                <div class="post-meta">
                                    <span>${best.nickname}</span>
                                    <div style="display: flex; align-items: center; gap: 4px; color: #e11d48; font-weight: bold;">
                                        <i data-lucide="heart" style="width: 14px; fill: #e11d48"></i> ${best.diaryRecCount}
                                    </div>
                                </div>
                            </article>
                        </a>
                    </c:forEach>
                </div>
            </section>

            <section class="board-latest-section">
                <h3 class="section-title">📝 최신 글</h3>
                <div class="board-list-header">
                    <span class="th-title">제목</span> <span class="th-author">작성자</span>
                    <span class="th-date">날짜</span> <span class="th-likes">공감</span> <span class="th-count">조회수</span>
                </div>
                <c:forEach var="diary" items="${list}">
                    <a href="doSelectOne.do?diarySid=${diary.diarySid}" class="board-row" style="display: flex; text-decoration: none; color: inherit;">
                        <div class="row-content">
                            <span class="post-tag ${diary.diaryCategory == 10 ? 'quote' : (diary.diaryCategory == 20 ? 'luck' : (diary.diaryCategory == 30 ? 'gratitude' : (diary.diaryCategory == 40 ? 'reflection' : '')))}" style="margin: 0">${diary.diaryCategoryName}</span>
                            <span class="row-title">${diary.diaryTitle}</span>
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

            <div class="pagination" style="display: flex; justify-content: center; margin-top: 30px; gap: 5px;">
                <c:if test="${vo.totalCnt > 0}">
                    <fmt:parseNumber var="totalPage" value="${Math.ceil(vo.totalCnt / vo.pageSize)}" integerOnly="true" />
                    <c:forEach var="i" begin="1" end="${totalPage}">
                        <a href="javascript:doRetrieve(${i});" class="page-item${vo.pageNo == i ? ' active' : ''}">${i}</a>
                    </c:forEach>
                </c:if>
            </div>
        </div>
    </main>

    <footer>
        <div class="container">
            <p>© 2024 내면의 흔적. All rights reserved.</p>
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            if (typeof lucide !== 'undefined') lucide.createIcons();

            const $searchWord = document.getElementById("searchWord");
            if ($searchWord) {
                $searchWord.addEventListener("keydown", function(e) {
                    if (e.key === "Enter") {
                        e.preventDefault();
                        doRetrieve(1);
                    }
                });
                if ($searchWord.value) {
                    $searchWord.focus();
                    $searchWord.setSelectionRange($searchWord.value.length, $searchWord.value.length);
                }
            }
        });
    </script>
</body>
</html>