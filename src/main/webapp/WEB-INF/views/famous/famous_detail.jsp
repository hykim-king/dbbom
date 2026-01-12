<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.pcwk.ehr.famous.domain.FamousVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- JSP 최상단에 추가 --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내면의 흔적 - 게시글 상세보기</title>
    <script src="https://unpkg.com/lucide@latest"></script>
    
    <link rel="stylesheet" 
    href="${pageContext.request.contextPath}/resources/assets/css/diary_detail_board.css">
    <link rel="stylesheet"
    href="${pageContext.request.contextPath}/resources/assets/css/common.css" />
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <jsp:include page="/WEB-INF/views/main/menu.jsp" />

</head>


<body> 
<main class="container"> <div style="flex: 1; padding: 20px;">
            <a href="javascript:void(0);" class="back-btn" id="btnMoveToList">
                <i data-lucide="arrow-left"></i> 목록으로 돌아가기
            </a>

            <article class="detail-card">
    <header class="detail-header">
        <span class="post-tag ${fn:trim(detail.famousEmotion) eq 'P' ? 'gratitude' : 'emotion'}">
            <i data-lucide="${fn:trim(detail.famousEmotion) eq 'P' ? 'sun' : 'moon'}" size="16"></i>
         
        </span>
        
        <h2 class="detail-title">${detail.famousAuthor}</h2>
        
        <div class="detail-meta-row">
           <div class="meta-left">
    <span class="meta-item"><i data-lucide="user" size="16"></i> ${detail.regId}</span>
    <span class="meta-item"><i data-lucide="calendar" size="16"></i> ${detail.famousTime}</span>
</div>
            <div class="meta-right">
                <span class="meta-item"><i data-lucide="eye" size="16"></i> 조회 ${detail.famousViewcount}</span>
            </div>
        </div>
    </header>

    <div class="detail-body" style="text-align: center; padding: 50px 20px; font-size: 1.4rem;">
        "${detail.famousContent}"
    </div>

    <div class="action-buttons">
        <button class="btn-like" id="likeBtn">
            <i data-lucide="heart" id="heartIcon"></i>
            <span id="likeCount">${detail.famousReccount}</span>
        </button>
    </div>
</article>
        </div>
    </main>

 <footer>
        <div class="container">
            <p>© 2024 내면의 흔적. All rights reserved.</p>
        </div>
    </footer>
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>
    
    <script>
    $(document).ready(function() {
        // 아이콘 생성
        lucide.createIcons();

        // [수정된 클릭 이벤트]
        $("#btnMoveToList").on("click", function() {
            // 1. 스프링이 자동으로 넘겨주는 커맨드 객체(famousVO)에서 값을 꺼냅니다.
            // 만약 FamousVO vo로 받았다면 객체명은 famousVO가 됩니다.
            let pNo = "${famousVO.pageNo}";
            let pSize = "${famousVO.pageSize}";
            
            // 디버깅: 브라우저 콘솔에서 값이 찍히는지 확인 (F12)
            console.log("넘어온 페이지 번호: " + pNo);

            // 2. 값이 비어있을 경우를 대비한 기본값 처리
            if(!pNo || pNo === "" || pNo === "0") pNo = "1";
            if(!pSize || pSize === "" || pSize === "0") pSize = "12";
            
            const url = "${pageContext.request.contextPath}/famous/famous.do";
            
            // 3. 목록으로 이동
            location.href = url + "?pageNo=" + pNo + "&pageSize=" + pSize;
        });
    });
    </script>
</body>
</html>