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
	// 2. 관리자 권한 확인 (DB 값이 'Y'인 경우)
	if ("Y".equals(loginUser.getAdminChk())) {
		isAdmin = true;
	}

	welcomeName = (loginUser.getNickname() != null && !loginUser.getNickname().trim().isEmpty())
	? loginUser.getNickname()
	: loginUser.getUserId();
}

// JS와 JSTL에서 사용하기 위해 request 영역에 값 세팅
request.setAttribute("isLogin", isLogin);
request.setAttribute("isAdmin", isAdmin);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script
	src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/outline.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/common.css" />
<script
	src="${pageContext.request.contextPath}/resources/assets/js/cmn/jquery.js"></script>

<script src="https://unpkg.com/lucide@latest"></script>
<title>개요 | 내면의 흔적</title>

<script>
	// 마이페이지 또는 관리자페이지 이동 로직
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

	// 로그아웃 로직
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
				<c:choose>
					<c:when test="${!isLogin}">
						<a href="${pageContext.request.contextPath}/user/signIn.do"
							class="auth-item">로그인</a>
						<span class="divider">|</span>
						<a href="${pageContext.request.contextPath}/user/signUp.do"
							class="auth-item">회원가입</a>
					</c:when>
					<c:otherwise>
						<span class="auth-item"><b><%=welcomeName%></b>님 환영합니다</span>
						<span class="divider">|</span>

						<%-- 관리자일 경우 닉네임 옆에 버튼 상시 노출 --%>
						<c:if test="${isAdmin}">
							<a href="${pageContext.request.contextPath}/admin/adminPage.do"
								class="auth-item" style="color: #2563eb; font-weight: bold;">관리자
								페이지</a>
							<span class="divider">|</span>
						</c:if>

						<a href="javascript:doLogout();" class="auth-item">로그아웃</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</header>

	<main class="container">
		<div class="tab-list">
			<div class="menu-label">메뉴</div>
			<%-- 각 메뉴 클릭 시에도 관리자 버튼 레이아웃은 유지됩니다 --%>
			<a href="<%=request.getContextPath()%>/main/outline.do"
				class="tab-btn"><i data-lucide="sparkles"></i> 개요</a> <a
				href="<%=request.getContextPath()%>/notice/noticeList.do"
				class="tab-btn"> <i data-lucide="book-open"></i> 공지사항
			</a>
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

			<a href="javascript:moveToManagement();" class="tab-btn"> <i
				data-lucide="user"></i> 마이페이지
			</a>
		</div>

		<div class="card">
			<div class="card-body">
				<h3 class="section-title">
					<i data-lucide="activity"></i> 다양한 감정과 생각을 기록하는 일기
				</h3>
				<p>
					저희 내면의 흔적은 당신의 <span class="p_font">"모든 감정을 존중하고 기록하는 곳"</span>입니다.
				</p>
				<hr />
				<div>
					<p>
						무거운 하루의 감정부터, 행복과 감사로 가득한 특별한 순간까지. <br />
					</p>
					<p style="color: #1837a0; line-height: 1.6" class="p_font">삶에서
						마주하는 모든 감정을 솔직하게 기록하세요.</p>
					<br />
					<p class="p_font">"좋고 나쁨을 나누지 않아도, 판단하지 않아도 괜찮습니다."</p>
					<p>부담 없이 찾아와 일기를 작성하는 것만으로 마음의 안정을 얻고, 스스로를 돌아볼 수 있습니다.</p>
					<p>‘내면의 흔적’에서 당신의 감정을 조용히 마주하고, 마음의 평온을 느껴보세요.</p>
					<p style="color: #1837a0; line-height: 1.6" class="p_font">당신의
						기록은 언제나 당신의 편으로 남아 있을 것입니다.</p>
				</div>
			</div>
		</div>

		<div class="card">
			<div class="card-body">
				<h3 class="section-title">
					<i data-lucide="heart-handshake"></i> 다양한 감정 유형 일기
				</h3>
				<p style="color: #374151; line-height: 1.6">
					기쁨, 슬픔, 성취, 취운 등 <span class="p_font">다양한 감정</span>을 기록할 수 있습니다.
				</p>

				<div class="info-grid">
					<div class="info-box blue">
						<h4>안전한 기록 공간</h4>
						<p class="p_font">모든 일기는 소중한 개인의 기록으로 안전하게 보호됩니다.</p>
						<p>편안한 환경에서 누구의 시선도 걱정하지 않고 감정을 솔직하게 남길 수 있습니다.</p>
					</div>
					<div class="info-box indigo">
						<h4>다양한 감정 맞춤형 일기</h4>
						<p class="p_font">그날의 기분에 따라 일기를 선택하고 글을 써보세요.</p>
						<p>기쁨, 슬픔, 설렘, 스트레스 등 다양한 감정을 쉽게 기록하고, 감정별로 일기를 분류할 수 있습니다.</p>
					</div>
					<div class="info-box blue">
						<h4>감정을 이해하는 기록</h4>
						<p class="p_font">단순한 글쓰기를 넘어, 나의 감정을 돌아보는 시간이 됩니다.</p>
						<p>하루하루 쌓인 기록을 통해 스스로의 마음을 더 깊이 이해할 수 있습니다.</p>
					</div>
					<div class="info-box indigo">
						<h4>자유로운 공유</h4>
						<p class="p_font">기록을 혼자 간직하거나, 공감하고 싶은 사람들과 자유롭게 이야기를 나누세요.</p>
						<p>커뮤니티와 감정을 공유하며 서로 위로와 격려를 주고받을 수 있습니다.</p>
					</div>
				</div>
			</div>
		</div>
	</main>

	<footer>
		<div class="container">
			<p style="margin-bottom: 0.5rem">© 2024 내면의 흔적. All rights
				reserved.</p>
			<p style="font-size: 0.875rem">당신의 감정을 소중히 여기는 공간</p>
		</div>
	</footer>

	<script>
		lucide.createIcons();
	</script>
</body>
</html>