<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>통합 관리 콘솔</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    body, html { margin: 0; padding: 0; height: 100vh; font-family: sans-serif; overflow: hidden; }
    .admin-grid { display: grid; grid-template-columns: 200px 1fr; grid-template-rows: 60px 1fr; height: 100vh; }
    .sidebar { grid-row: 1/3; background: #fff; border-right: 2px solid #000; padding: 20px; }
    .header { grid-column: 2/3; background:#fff; display: flex; align-items: center; justify-content: space-between; padding: 0 20px; border-bottom: 2px solid #000; }
    .content { grid-column: 2/3; padding: 20px; overflow-y: auto; background: #fff; scroll-behavior: smooth; }
    .section { border: 2px solid #000; padding: 20px; margin-bottom: 40px; width: 95%; margin: 0 auto; }
    table { width: 100%; border-collapse: collapse; margin-top: 15px; }
    th, td { border: 1px solid #000; padding: 10px; text-align: center; }
    th { background: #f0f0f0; }
    .sidebar p { cursor: pointer; margin: 15px 0; font-weight: bold; padding: 10px; border-radius: 4px; }
    .sidebar p:hover { background: #eee; }

    /* 페이지 버튼 스타일 */
    .pagination { display: flex; justify-content: center; margin-top: 15px; }
    .pagination a { border: 1px solid #000; padding: 5px 12px; margin: 0 3px; text-decoration: none; color: #000; font-size: 13px; font-weight: bold; }
    
    /* [요청사항] 현재 페이지: 배경 검정, 글자 흰색 */
    .pagination a.active { background-color: #000 !important; color: #fff !important; }
</style>
</head>
<body>
    <div class="admin-grid">
        <div class="sidebar">
            <h2 onclick="location.href='adminPage.do?menu=all'" style="cursor:pointer">Diary Admin</h2>
            <div style="margin-top: 50px">
                <p onclick="location.href='adminPage.do?menu=section1'">🚩 신고 관리</p>
                <p onclick="location.href='adminPage.do?menu=section2'">👥 회원 관리</p>
                <p onclick="location.href='adminPage.do?menu=section3'">📝 게시글 관리</p>
            </div>
        </div>

        <div class="header">
            <span style="font-size: 1.2rem; font-weight: bold">관리자 모드 > 
                <c:choose>
                    <c:when test="${menu eq 'section1'}">신고 상세</c:when>
                    <c:when test="${menu eq 'section2'}">회원 상세</c:when>
                    <c:when test="${menu eq 'section3'}">게시글 상세</c:when>
                    <c:otherwise>전체 요약</c:otherwise>
                </c:choose>
            </span>
            <button onclick="location.href='${pageContext.request.contextPath}/login/logout.do'">로그아웃</button>
        </div>

        <div class="content">
            <c:choose>
                <%-- ========================================== --%>
                <%-- 1. 신고 상세 (10건)                       --%>
                <%-- ========================================== --%>
                <c:when test="${menu eq 'section1'}">
                    <div class="section">
                        <strong>🚩 신고 내역 관리 (상세 10건)</strong>
                        <table>
                            <thead><tr><th>유형</th><th>제목</th><th>작성자</th></tr></thead>
                            <tbody>
                                <c:forEach var="vo" items="${reportList}">
                                    <tr><td>일기</td><td>${vo.diaryTitle}</td><td>${vo.regId}</td></tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="pagination">
                            <c:forEach var="i" begin="1" end="10"><a href="adminPage.do?menu=section1&reportPage=${i}" class="${reportPage == i ? 'active' : ''}">${i}</a></c:forEach>
                        </div>
                    </div>
                </c:when>

                <%-- ========================================== --%>
                <%-- 2. 회원 상세 (10건)                       --%>
                <%-- ========================================== --%>
                <c:when test="${menu eq 'section2'}">
                    <div class="section">
                        <strong>👥 회원 정보 관리 (상세 10건)</strong>
                        <table>
                            <thead><tr><th>ID</th><th>닉네임</th><th>권한</th></tr></thead>
                            <tbody>
                                <c:forEach var="vo" items="${userList}">
                                    <tr><td>${vo.userId}</td><td>${vo.nickname}</td><td>${vo.adminChk}</td></tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="pagination">
                            <c:forEach var="i" begin="1" end="10"><a href="adminPage.do?menu=section2&userPage=${i}" class="${userPage == i ? 'active' : ''}">${i}</a></c:forEach>
                        </div>
                    </div>
                </c:when>

                <%-- ========================================== --%>
                <%-- 3. 게시글 상세 (10건)                     --%>
                <%-- ========================================== --%>
                <c:when test="${menu eq 'section3'}">
                    <div class="section">
                        <strong>📝 게시글 목록 관리 (상세 10건)</strong>
                        <table>
                            <thead><tr><th>번호</th><th>작성자</th><th>제목</th><th>상태</th></tr></thead>
                            <tbody>
                                <c:forEach var="vo" items="${diaryList}">
                                    <tr><td>${vo.diarySid}</td><td>${vo.regId}</td><td>${vo.diaryTitle}</td><td>${vo.diaryStatus}</td></tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="pagination">
                            <c:forEach var="i" begin="1" end="10"><a href="adminPage.do?menu=section3&diaryPage=${i}" class="${diaryPage == i ? 'active' : ''}">${i}</a></c:forEach>
                        </div>
                    </div>
                </c:when>

                <%-- ========================================== --%>
                <%-- 4. 메인 화면 (전체 요약, 표 형식 유지, 5건씩) --%>
                <%-- ========================================== --%>
                <c:otherwise>
                    <div class="section" id="section1">
                        <strong>🚩 신고 내역 (최근 5건)</strong>
                        <table>
                            <thead><tr><th>유형</th><th>제목</th><th>작성자</th></tr></thead>
                            <tbody>
                                <c:forEach var="vo" items="${reportList}">
                                    <tr><td>일기</td><td>${vo.diaryTitle}</td><td>${vo.regId}</td></tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="pagination">
                            <c:forEach var="i" begin="1" end="5"><a href="adminPage.do?menu=all&reportPage=${i}&userPage=${userPage}&diaryPage=${diaryPage}#section1" class="${reportPage == i ? 'active' : ''}">${i}</a></c:forEach>
                        </div>
                    </div>

                    <div class="section" id="section2">
                        <strong>👥 회원 정보 (최근 5건)</strong>
                        <table>
                            <thead><tr><th>ID</th><th>닉네임</th><th>권한</th></tr></thead>
                            <tbody>
                                <c:forEach var="vo" items="${userList}">
                                    <tr><td>${vo.userId}</td><td>${vo.nickname}</td><td>${vo.adminChk}</td></tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="pagination">
                            <c:forEach var="i" begin="1" end="5"><a href="adminPage.do?menu=all&reportPage=${reportPage}&userPage=${i}&diaryPage=${diaryPage}#section2" class="${userPage == i ? 'active' : ''}">${i}</a></c:forEach>
                        </div>
                    </div>

                    <div class="section" id="section3">
                        <strong>📝 게시글 목록 (최근 5건)</strong>
                        <table>
                            <thead><tr><th>번호</th><th>작성자</th><th>제목</th><th>상태</th></tr></thead>
                            <tbody>
                                <c:forEach var="vo" items="${diaryList}">
                                    <tr><td>${vo.diarySid}</td><td>${vo.regId}</td><td>${vo.diaryTitle}</td><td>${vo.diaryStatus}</td></tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="pagination">
                            <c:forEach var="i" begin="1" end="5"><a href="adminPage.do?menu=all&reportPage=${reportPage}&userPage=${userPage}&diaryPage=${i}#section3" class="${diaryPage == i ? 'active' : ''}">${i}</a></c:forEach>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>