<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.pcwk.ehr.user.domain.UserVO"%>
<%
	// 1. 세션에서 로그인 사용자 정보 가져오기
UserVO loginUser = (UserVO) session.getAttribute("loginUser");
String welcomeName = "";
boolean isLogin = false;
boolean isAdmin = false;

if (loginUser != null) {
	isLogin = true;
	// 2. 관리자 권한 확인 (DB 값이 'Y'인 경우 관리자로 판단)
	if ("Y".equals(loginUser.getAdminChk())) {
		isAdmin = true;
	}
	welcomeName = (loginUser.getNickname() != null && !loginUser.getNickname().trim().isEmpty())
	? loginUser.getNickname()
	: loginUser.getUserId();
}

// 하단 JSTL 및 스크립트에서 사용할 수 있도록 request 영역에 세팅
request.setAttribute("isLogin", isLogin);
request.setAttribute("isAdmin", isAdmin);
request.setAttribute("welcomeName", welcomeName);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>내면의 흔적 - 공지사항</title>

<script src="https://unpkg.com/lucide@latest"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/common.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/notice.css" />

<style>
/* 검색 및 글쓰기 영역 */
.search-area {
	display: flex;
	justify-content: flex-end;
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

.search-input:focus {
	border-color: #3b82f6;
	outline: none;
}

.btn-search {
	background-color: #3b82f6;
	color: white;
	padding: 8px 16px;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	font-weight: bold;
	display: flex;
	align-items: center;
	gap: 4px;
}

.btn-write {
	background-color: #10b981;
	color: white;
	padding: 8px 16px;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	font-weight: bold;
	display: flex;
	align-items: center;
	gap: 4px;
	text-decoration: none;
	font-size: 0.9rem;
}

.pagination {
	display: flex;
	justify-content: center;
	margin-top: 30px;
	gap: 5px;
}

.page-item {
	padding: 6px 14px;
	border: 1px solid #e2e8f0;
	border-radius: 8px;
	color: #64748b;
	cursor: pointer;
	text-decoration: none;
	transition: all 0.2s;
}

.page-item:hover {
	background-color: #f1f5f9;
}

.page-item.active {
	background-color: #3b82f6;
	color: white;
	border-color: #3b82f6;
	font-weight: bold;
}

.no-data-area {
	text-align: center;
	padding: 80px 0;
	color: #94a3b8;
	background: #f8fafc;
	border-radius: 16px;
	border: 1px dashed #e2e8f0;
}

.search-keyword-highlight {
	color: #3b82f6;
	text-decoration: underline;
	font-weight: bold;
}
</style>

<script>
	// 마이페이지 이동 로직 (관리자여도 본인 정보 수정을 위해 마이페이지로 이동)
	function moveToManagement() {
		var isLogin = "${isLogin}" === "true";
		var cp = "${pageContext.request.contextPath}";

		if (!isLogin) {
			alert("로그인이 필요합니다.");
			location.href = cp + "/user/signIn.do";
			return;
		}
		location.href = cp + "/user/myPage.do";
	}

	function doLogout() {
		if (!confirm("로그아웃 하시겠습니까?"))
			return;
		$
				.ajax({
					url : "${pageContext.request.contextPath}/user/doLogoutAjax.do",
					type : "POST",
					dataType : "json",
					success : function(res) {
						alert(res.message);
						if (res.flag === 1)
							location.href = "${pageContext.request.contextPath}/main/main.do";
					},
					error : function(xhr, status, err) {
						alert("오류 발생");
					}
				});
	}

	function doWithdraw() {
		if (!confirm("정말 회원탈퇴 하시겠습니까?\n(가입 정보가 DB에서 삭제됩니다.)"))
			return;
		$
				.ajax({
					url : "${pageContext.request.contextPath}/user/doWithdrawAjax.do",
					type : "POST",
					dataType : "json",
					success : function(res) {
						alert(res.message);
						// [Syntax Error 해결] 따옴표와 줄바꿈을 한 줄로 연결
						if (res.flag === 1) {
							location.href = "${pageContext.request.contextPath}/main/main.do";
						}
					},
					error : function(xhr, status, err) {
						alert("오류 발생");
					}
				});
	}
</script>
</head>
<body>
	<header>
		<div class="container header-inner flex-between">
			<a href="<%=request.getContextPath()%>/main/main.do"
				class="logo-area" style="text-decoration: none">
				<h1 class="logo-text">내면의 흔적</h1>
			</a>
			<div class="auth-links">
				<%
					if (!isLogin) {
				%>
				<a href="<%=request.getContextPath()%>/user/signIn.do"
					class="auth-item">로그인</a> <span class="divider">|</span> <a
					href="<%=request.getContextPath()%>/user/signUp.do"
					class="auth-item">회원가입</a>
				<%
					} else {
				%>
				<span class="auth-item"><b><%=welcomeName%></b>님 환영합니다</span> <span
					class="divider">|</span>
				<%
					if (isAdmin) {
				%>
				<a href="<%=request.getContextPath()%>/admin/adminPage.do"
					class="auth-item" style="color: #2563eb; font-weight: bold;">관리자
					페이지</a> <span class="divider">|</span>
				<%
					}
				%>
				<a href="javascript:doLogout();" class="auth-item">로그아웃</a>
				<%-- [핵심 수정 1] 관리자가 아닐 때만 회원탈퇴 버튼 노출 --%>
				<%
					if (!isAdmin) {
				%>
				<span class="divider">|</span> <a href="javascript:doWithdraw();"
					class="auth-item" style="color: red; font-size: 0.8rem;">회원탈퇴</a>
				<%
					}
				%>
				<%
					}
				%>
			</div>
		</div>
	</header>

	<main class="container">
		<div class="tab-list">
			<div class="menu-label">메뉴</div>
			<a href="<%=request.getContextPath()%>/main/outline.do"
				class="tab-btn"><i data-lucide="sparkles"></i> 개요</a> <a
				href="<%=request.getContextPath()%>/notice/noticeList.do"
				class="tab-btn active"><i data-lucide="book-open"></i> 공지사항</a>
			<div class="dropdown-container">
				<a href="<%=request.getContextPath()%>/diary/diaryList.do"
					class="tab-btn" style="width: 100%; border: none"><i
					data-lucide="pencil"></i> 게시판</a>
				<div class="dropdown-content">
					<a href="<%=request.getContextPath()%>/diary/diaryList.do">📖
						일기 공개 게시판</a> <a href="<%=request.getContextPath()%>/famous/famous.do">💬
						명언 모음집</a>
				</div>
			</div>
			<%-- [핵심 수정 2] 텍스트를 '마이페이지'로 통일하고 아이콘을 user로 고정 --%>
			<a href="javascript:moveToManagement();" class="tab-btn"> <i
				data-lucide="user"></i> 마이페이지
			</a>
		</div>

		<form action="${pageContext.request.contextPath}/notice/noticeList.do"
			method="get" name="noticeForm" id="noticeForm">
			<input type="hidden" name="pageNo" id="pageNo" value="${vo.pageNo}">
			<div class="tab-content">
				<div class="notice-container">
					<div
						style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 10px;">
						<h3 class="section-title">
							<i data-lucide="megaphone"></i> 공지사항
						</h3>
					</div>

					<div class="search-area">
						<select name="searchDiv" id="searchDiv" class="search-select">
							<option value="">전체</option>
							<option value="10" ${vo.searchDiv == '10' ? 'selected' : ''}>제목</option>
							<option value="20" ${vo.searchDiv == '20' ? 'selected' : ''}>내용</option>
							<option value="30" ${vo.searchDiv == '30' ? 'selected' : ''}>제목+내용</option>
						</select> <input type="text" name="searchWord" id="searchWord"
							class="search-input" value="${vo.searchWord}"
							placeholder="검색어를 입력하세요" autocomplete="off">
						<button type="button" class="btn-search" onclick="doRetrieve(1)">
							<i data-lucide="search" style="width: 14px;"></i> 검색
						</button>
						<c:if test="${isAdmin}">
							<a href="${pageContext.request.contextPath}/notice/moveToReg.do"
								class="btn-write"><i data-lucide="pen-tool"></i> 글쓰기</a>
						</c:if>
					</div>

					<hr style="margin: 10px 0 20px 0; border-color: #f1f5f9;">

					<ul style="list-style: none; padding: 0;">
						<c:choose>
							<c:when test="${not empty list && list.size() > 0}">
								<c:forEach var="item" items="${list}">
									<li class="notice-item"
										onclick="location.href='${pageContext.request.contextPath}/notice/doSelectOne.do?noticeSid=${item.noticeSid}'"
										style="cursor: pointer;">
										<div class="notice-info">
											<span style="font-weight: 600; font-size: 1.05rem;">${item.noticeTitle}</span>
										</div> <span class="notice-date">${item.noticeTime}</span>
									</li>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<li class="no-data-area"><i data-lucide="search-x"
									style="width: 48px; height: 48px; margin-bottom: 15px; opacity: 0.5; color: #3b82f6;"></i>
									<p style="font-size: 1.1rem; font-weight: 600; color: #475569;">검색된
										공지사항이 없습니다.</p> <c:if test="${not empty vo.searchWord}">
										<p style="font-size: 0.9rem; margin-top: 8px;">
											입력하신 검색어 <span class="search-keyword-highlight">"${vo.searchWord}"</span>에
											매칭되는 내용이 없습니다.
										</p>
									</c:if></li>
							</c:otherwise>
						</c:choose>
					</ul>

					<div class="pagination">
						<c:if test="${totalCnt > 0}">
							<fmt:parseNumber var="totalPage"
								value="${Math.ceil(totalCnt / vo.pageSize)}" integerOnly="true" />
							<c:forEach var="i" begin="1" end="${totalPage}">
								<a href="javascript:doRetrieve(${i});"
									class="page-item ${vo.pageNo == i ? 'active' : ''}">${i}</a>
							</c:forEach>
						</c:if>
					</div>
				</div>
			</div>
		</form>
	</main>

	<footer>
		<div class="container">
			<p>© 2024 내면의 흔적. All rights reserved.</p>
		</div>
	</footer>

	<script>
		if (typeof lucide !== 'undefined')
			lucide.createIcons();
		function doRetrieve(pageNo) {
			const pageNoField = document.getElementById("pageNo");
			if (pageNoField)
				pageNoField.value = pageNo;
			const form = document.getElementById("noticeForm");
			if (form)
				form.submit();
		}
		document.getElementById("searchWord").addEventListener("keydown",
				function(e) {
					if (e.key === "Enter") {
						e.preventDefault();
						doRetrieve(1);
					}
				});
	</script>
</body>
</html>