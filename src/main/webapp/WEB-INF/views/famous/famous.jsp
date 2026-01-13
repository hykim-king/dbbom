<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.pcwk.ehr.famous.domain.FamousVO"%>
<%@ page import="com.pcwk.ehr.user.domain.UserVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	// 세션에서 로그인 사용자 정보 및 권한 가져오기
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
<title>내면의 흔적 - 명언 모음집</title>

<script src="https://unpkg.com/lucide@latest"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/common.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/famous_diary_board.css" />

<script
	src="<%=request.getContextPath()%>/resources/assets/js/cmn/jquery.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>

<script>
	// [수정] cp 변수를 활용한 경로 통일 및 줄바꿈 에러 방지
	var cp = "${pageContext.request.contextPath}";

	function moveToManagement() {
		var isLogin =
<%=isLogin%>
	;
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
		$.ajax({
			url : cp + "/user/doLogoutAjax.do",
			type : "POST",
			dataType : "json",
			success : function(res) {
				alert(res.message);
				if (res.flag === 1)
					location.href = cp + "/main/main.do";
			},
			error : function(xhr, status, err) {
				alert("오류 발생");
			}
		});
	}

	function doWithdraw() {
		if (!confirm("정말 회원탈퇴 하시겠습니까?\n(가입 정보가 DB에서 삭제됩니다.)"))
			return;
		$.ajax({
			url : cp + "/user/doWithdrawAjax.do",
			type : "POST",
			dataType : "json",
			success : function(res) {
				alert(res.message);
				// [수정] 줄바꿈 에러 해결 완료
				if (res.flag === 1) {
					location.href = cp + "/main/main.do";
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
			<a href="${pageContext.request.contextPath}/main/main.do"
				class="logo-area" style="text-decoration: none">
				<h1 class="logo-text">내면의 흔적</h1>
			</a>
			<div class="auth-links">
				<%
					if (!isLogin) {
				%>
				<a href="${pageContext.request.contextPath}/user/signIn.do"
					class="auth-item">로그인</a> <span class="divider">|</span> <a
					href="${pageContext.request.contextPath}/user/signUp.do"
					class="auth-item">회원가입</a>
				<%
					} else {
				%>
				<span class="auth-item"><b><%=welcomeName%></b>님 환영합니다</span> <span
					class="divider">|</span>
				<%
					if (isAdmin) {
				%>
				<a href="${pageContext.request.contextPath}/admin/adminPage.do"
					class="auth-item" style="color: #2563eb; font-weight: bold;">관리자
					페이지</a> <span class="divider">|</span>
				<%
					}
				%>
				<a href="javascript:doLogout();" class="auth-item">로그아웃</a>
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
			<a href="${pageContext.request.contextPath}/main/outline.do"
				class="tab-btn"><i data-lucide="sparkles"></i> 개요</a> <a
				href="${pageContext.request.contextPath}/notice/noticeList.do"
				class="tab-btn"><i data-lucide="book-open"></i> 공지사항</a>
			<div class="dropdown-container">
				<a href="${pageContext.request.contextPath}/diary/diaryList.do"
					class="tab-btn active" style="width: 100%; border: none"> <i
					data-lucide="pencil"></i> 게시판
				</a>
				<div class="dropdown-content">
					<a href="${pageContext.request.contextPath}/diary/diaryList.do">📖
						일기 공개 게시판</a> <a
						href="${pageContext.request.contextPath}/famous/famous.do">💬
						명언 모음집</a>
				</div>
			</div>
			<a href="javascript:moveToManagement();" class="tab-btn"><i
				data-lucide="user"></i> 마이페이지</a>
		</div>

		<div class="tab-content">
			<section class="board-best-section">
				<div class="section-title">
					<h3>🏆 명예의 명언 (Best 3)</h3>
					<span style="font-size: 0.9rem; color: #64748b; margin-left: 10px">실시간
						추천 순위 반영</span>
				</div>
				<div id="best-posts-container" class="posts-grid">
					<c:forEach var="best" items="${bestList}" varStatus="status">
						<article class="post-card best-card" data-sid="${best.famousSid}">
							<div
								style="position: absolute; top: 15px; right: 15px; display: flex; align-items: center; gap: 4px; z-index: 10;">
								<span class="rank-badge">${status.count}위</span> <i
									data-lucide="crown"
									style="width: 18px; height: 18px; color: ${status.index == 0 ? '#fbbf24' : (status.index == 1 ? '#94a3b8' : '#b45309')}; fill: currentColor;"></i>
							</div>
							<div
								class="sentiment-tag ${fn:trim(best.famousEmotion) eq 'P' ? 'tag-positive' : 'tag-negative'}"
								style="position: absolute; top: 15px; left: 15px; z-index: 10;">
								<i
									data-lucide="${fn:trim(best.famousEmotion) eq 'P' ? 'sun' : 'moon'}"></i>
							</div>
							<div class="post-content-main">
								<h3 class="display-author">${best.famousAuthor}</h3>
								<p class="display-content">"${best.famousContent}"</p>
							</div>
							<div class="post-meta">
								<span class="reg-id">${best.regId}</span>
								<div class="meta-icons">
									<div class="views-info">
										<i data-lucide="eye"></i> <span>${best.famousViewcount}</span>
									</div>
									<div class="likes-trigger">
										<i data-lucide="heart" class="heart-icon"></i> <span
											class="like-count count-${best.famousSid}">${best.famousReccount}</span>
									</div>
									<i data-lucide="chevron-right" class="arrow-icon"></i>
								</div>
							</div>
						</article>
					</c:forEach>
				</div>
			</section>

			<hr class="section-divider">

			<section class="board-latest-section">
				<div class="section-title">
					<h3>💬 명언 모음집</h3>
				</div>
				<div id="paged-list-container" class="posts-grid">
					<c:choose>
						<c:when test="${empty list}">
							<p
								style="text-align: center; grid-column: 1/-1; padding: 50px; color: #64748b;">등록된
								명언이 없습니다.</p>
						</c:when>
						<c:otherwise>
							<c:forEach var="vo" items="${list}">
								<article class="post-card" data-sid="${vo.famousSid}">
									<div
										class="sentiment-tag ${fn:trim(vo.famousEmotion) eq 'P' ? 'tag-positive' : 'tag-negative'}"
										style="position: absolute; top: 15px; left: 15px; z-index: 10;">
										<i
											data-lucide="${fn:trim(vo.famousEmotion) eq 'P' ? 'sun' : 'moon'}"></i>
									</div>
									<div class="post-content-main">
										<h3 class="display-author">${vo.famousAuthor}</h3>
										<p class="display-content">"${vo.famousContent}"</p>
									</div>
									<div class="post-meta">
										<span class="reg-id">${vo.regId}</span>
										<div class="meta-icons">
											<div class="views-info">
												<i data-lucide="eye"></i> <span>${not empty vo.famousViewcount ? vo.famousViewcount : 0}</span>
											</div>
											<div class="likes-trigger">
												<i data-lucide="heart" class="heart-icon"></i> <span
													class="like-count count-${vo.famousSid}">${vo.famousReccount}</span>
											</div>
											<i data-lucide="chevron-right" class="arrow-icon"></i>
										</div>
									</div>
								</article>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</section>
		</div>
	</main>

	<footer>
		<div class="container">
			<p>© 2026 내면의 흔적. All rights reserved.</p>
		</div>
	</footer>

	<script>
		$(document)
				.ready(
						function() {
							function refreshRankUI() {
								lucide.createIcons();
								// ... (생략된 랭킹 색상 로직 기존과 동일)
							}
							refreshRankUI();

							$(document)
									.on(
											"click",
											".post-card",
											function(e) {
												if ($(e.target).closest(
														'.likes-trigger').length)
													return;
												const famousSid = $(this).data(
														"sid");
												location.href = cp
														+ "/famous/getFamousDetail.do?famousSid="
														+ famousSid
														+ "&pageNo=${vo.pageNo}&pageSize=${vo.pageSize}";
											});

							$(document)
									.off("click", ".likes-trigger")
									.on(
											"click",
											".likes-trigger",
											function(e) {
												e.stopPropagation();
												const loginUser = "${sessionScope.loginUser}";
												if (!loginUser
														|| loginUser === "null") {
													if (confirm("좋아요는 로그인 후에 가능합니다. 로그인 페이지로 이동하시겠습니까?")) {
														location.href = cp
																+ "/user/signIn.do";
													}
													return;
												}
												// ... (Ajax 좋아요 로직 기존과 동일)
											});
						});
	</script>
</body>
</html>