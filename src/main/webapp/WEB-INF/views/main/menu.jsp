<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.pcwk.ehr.user.domain.UserVO"%>
<%
	// 1. 세션에서 로그인 사용자 정보 가져오기 
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

// 2. 현재 페이지 경로 확인 (게시판 활성화 체크용)
String currentURI = request.getRequestURI();
// 목록(diaryList.do) 또는 상세(doSelectOne.do) 페이지인 경우 true
boolean isDiaryPage = currentURI.contains("diaryList.do") || currentURI.contains("doSelectOne.do");

// JSTL 변수로 저장
request.setAttribute("isLogin", isLogin);
request.setAttribute("isAdmin", isAdmin);
request.setAttribute("welcomeName", welcomeName);
request.setAttribute("isDiaryPage", isDiaryPage);
%>
<header>
	<script>
        const cp = "<%=request.getContextPath()%>";

        // 마이페이지 이동 (관리자/일반 공통)
        function moveToManagement() {
            var isLogin = ${isLogin};
            if (!isLogin) {
                alert("로그인이 필요합니다.");
                location.href = cp + "/user/signIn.do";
                return;
            }
            location.href = cp + "/user/myPage.do";
        }

        // 로그아웃 (POST)
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
                error: function() { alert("오류 발생"); }
            });
        }

<<<<<<< HEAD
        // 회원탈퇴 (관리자 보호)
        function doWithdraw() {
            var isAdmin = ${isAdmin};
            if(isAdmin) {
                alert("관리자 계정은 시스템 보호를 위해 탈퇴가 불가능합니다.");
                return;
            }
            if (!confirm("정말 회원탈퇴 하시겠습니까?")) return;
=======
        // 회원탈퇴 로직
        <%-- function doWithdraw() {
            if (!confirm("정말 회원탈퇴 하시겠습니까?\n(가입 정보가 DB에서 삭제됩니다.)")) return;
>>>>>>> feature/donghan-backup
            $.ajax({
                url: cp + "/user/doWithdrawAjax.do",
                type: "POST",
                dataType: "json",
                success: function(res) {
                    alert(res.message);
                    if (res.flag === 1) location.href = cp + "/main/main.do";
                },
                error: function() { alert("오류 발생"); }
            });
        } --%>
    </script>
<<<<<<< HEAD

	<div class="container header-inner flex-between">
		<a href="<%=request.getContextPath()%>/main/main.do" class="logo-area"
			style="text-decoration: none">
			<h1 class="logo-text">내면의 흔적</h1>
		</a>
		<div class="auth-links">
			<c:choose>
				<c:when test="${!isLogin}">
					<a href="<%=request.getContextPath()%>/user/signIn.do"
						class="auth-item">로그인</a>
					<span class="divider">|</span>
					<a href="<%=request.getContextPath()%>/user/signUp.do"
						class="auth-item">회원가입</a>
				</c:when>
				<c:otherwise>
					<span class="auth-item"><b>${welcomeName}</b>님 환영합니다</span>
					<span class="divider">|</span>
					<c:if test="${isAdmin}">
						<a href="<%=request.getContextPath()%>/admin/adminPage.do"
							class="auth-item" style="color: #2563eb; font-weight: bold;">관리자
							페이지</a>
						<span class="divider">|</span>
					</c:if>
					<a href="javascript:doLogout();" class="auth-item">로그아웃</a>
					<c:if test="${!isAdmin}">
						<span class="divider">|</span>
						<a href="javascript:doWithdraw();" class="auth-item"
							style="color: red; font-size: 0.8rem;">회원탈퇴</a>
					</c:if>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
=======
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
          <%-- <span class="divider">|</span>
          <a href="javascript:doWithdraw();" class="auth-item" style="color:red; font-size:0.8rem;">회원탈퇴</a> --%>
      <% } %>
    </div>
  </div>
>>>>>>> feature/donghan-backup
</header>

<div class="container">
	<div class="tab-list">
		<div class="menu-label">메뉴</div>
		<a href="<%=request.getContextPath()%>/main/outline.do"
			class="tab-btn"><i data-lucide="sparkles"></i> 개요</a> <a
			href="<%=request.getContextPath()%>/notice/noticeList.do"
			class="tab-btn"><i data-lucide="book-open"></i> 공지사항</a>

		<div class="dropdown-container">
			<%-- 게시글 상세 페이지에서도 active 클래스가 붙도록 수정 --%>
			<a href="<%=request.getContextPath()%>/diary/diaryList.do"
				class="tab-btn ${isDiaryPage ? 'active' : ''}"
				style="width: 100%; border: none"> <i data-lucide="pencil"></i>
				게시판
			</a>
			<div class="dropdown-content">
				<a href="<%=request.getContextPath()%>/diary/diaryList.do">📖 일기
					공개 게시판</a> <a href="<%=request.getContextPath()%>/famous/famous.do">💬
					명언 모음집</a>
			</div>
		</div>

		<a href="javascript:moveToManagement();" class="tab-btn"> <i
			data-lucide="user"></i> 마이페이지
		</a>
	</div>
</div>

<script>
    window.loginUserId = "<%=(loginUser != null) ? loginUser.getUserId() : ""%>
	";
	if (typeof lucide !== 'undefined')
		lucide.createIcons();
</script>