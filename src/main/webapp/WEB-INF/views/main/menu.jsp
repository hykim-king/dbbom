<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.pcwk.ehr.user.domain.UserVO" %>
<%
    // 1. 세션에서 로그인 사용자 정보 가져오기 
    UserVO loginUser = (UserVO) session.getAttribute("loginUser");
    String welcomeName = "";
    boolean isLogin = false;
    boolean isAdmin = false; // 관리자 여부 변수

    if (loginUser != null) {
        isLogin = true;
        // 2. 관리자 권한 확인 (DB 값이 'Y'인 경우 관리자로 판단)
        if("Y".equals(loginUser.getAdminChk())) {
            isAdmin = true;
        }
        welcomeName = (loginUser.getNickname() != null && !loginUser.getNickname().trim().isEmpty()) 
                      ? loginUser.getNickname() : loginUser.getUserId();
    }
    
    // JSTL 변수로 사용하기 위해 request 영역에 저장
    request.setAttribute("isLogin", isLogin);
    request.setAttribute("isAdmin", isAdmin);
    request.setAttribute("welcomeName", welcomeName);
%>
<header>
    <script>
        // [통합] 마이페이지 또는 관리자페이지 이동 로직
        function moveToManagement() {
            var isLogin = ${isLogin};
            var isAdmin = ${isAdmin};
            var cp = "<%=request.getContextPath()%>";
            
            if (!isLogin) {
                alert("로그인이 필요합니다.");
                location.href = cp + "/user/signIn.do";
                return;
            }
            
            // 관리자면 관리자페이지, 아니면 마이페이지로 이동
            if(isAdmin) {
                location.href = cp + "/admin/adminPage.do";
            } else {
                location.href = cp + "/user/myPage.do";
            }
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
                    if (res.flag === 1) location.href = "<%=request.getContextPath()%>/main/main.do";
                },
                error: function(xhr, status, err) { alert("오류 발생"); }
            });
        }
    </script>

  <div class="container header-inner flex-between">
    <a href="<%=request.getContextPath()%>/main/main.do" class="logo-area" style="text-decoration: none">
      <h1 class="logo-text">내면의 흔적</h1>
    </a>
    <div class="auth-links">
      <c:choose>
        <c:when test="${!isLogin}">
            <a href="<%=request.getContextPath()%>/user/signIn.do" class="auth-item">로그인</a>
            <span class="divider">|</span>
            <a href="<%=request.getContextPath()%>/user/signUp.do" class="auth-item">회원가입</a>
        </c:when>
        <c:otherwise>
            <span class="auth-item"><b>${welcomeName}</b>님 환영합니다</span>
            <span class="divider">|</span>
            
            <%-- [핵심] 사진처럼 닉네임 옆에 '관리자 페이지' 버튼 상시 노출 --%>
            <c:if test="${isAdmin}">
                <a href="<%=request.getContextPath()%>/admin/adminPage.do" class="auth-item" style="color:#2563eb; font-weight:bold;">관리자 페이지</a>
                <span class="divider">|</span>
            </c:if>
            
            <a href="javascript:doLogout();" class="auth-item">로그아웃</a>
            <span class="divider">|</span>
            <a href="javascript:doWithdraw();" class="auth-item" style="color:red; font-size:0.8rem;">회원탈퇴</a>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</header>

<div class="container">
    <div class="tab-list">
      <div class="menu-label">메뉴</div>
      <a href="<%=request.getContextPath()%>/main/outline.do" class="tab-btn"><i data-lucide="sparkles"></i> 개요</a>
      <a href="<%=request.getContextPath()%>/notice/noticeList.do" class="tab-btn"><i data-lucide="book-open"></i> 공지사항</a>
      <div class="dropdown-container">
        <a href="<%=request.getContextPath()%>/diary/diaryList.do" class="tab-btn" style="width: 100%; border: none"><i data-lucide="pencil"></i> 게시판</a>
        <div class="dropdown-content">
          <a href="<%=request.getContextPath()%>/diary/diaryList.do">📖 일기 공개 게시판</a>
          <a href="<%=request.getContextPath()%>/famous/famous.do">💬 명언 모음집</a>
        </div>
      </div>
      
      <%-- [핵심] 관리자 여부에 따라 아이콘과 이름 변경 --%>
      <a href="javascript:moveToManagement();" class="tab-btn">
        <c:choose>
            <c:when test="${isAdmin}">
                <i data-lucide="settings"></i> 관리자 페이지
            </c:when>
            <c:otherwise>
                <i data-lucide="user"></i> 마이페이지
            </c:otherwise>
        </c:choose>
      </a>
    </div>
</div>

<script>
    window.loginUserId = "<%= (loginUser != null) ? loginUser.getUserId() : "" %>";
    // 아이콘 생성 실행
    if(typeof lucide !== 'undefined') lucide.createIcons();
</script>