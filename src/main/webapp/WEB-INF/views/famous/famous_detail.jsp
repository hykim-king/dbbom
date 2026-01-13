<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pcwk.ehr.famous.domain.FamousVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내면의 흔적 - 게시글 상세보기</title>
    <script src="https://unpkg.com/lucide@latest"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/diary_detail_board.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/common.css" />


    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>


<style>
    /* 1. 메뉴바 레이아웃 복구 (세로 겹침 및 위치 오류 해결) */
    /* menu.jsp의 원래 디자인을 방해하는 display: flex 강제 설정을 해제합니다. */
    header {
        position: relative !important;
        display: block !important; /* flex가 아닌 block이어야 내부 container가 제대로 잡힙니다 */
        width: 100% !important;
        height: auto !important;
        top: auto !important;
    }

    /* 로고바 내부 정렬 유지 */
    header .header-inner.flex-between {
        display: flex !important;
        justify-content: space-between !important;
        align-items: center !important;
        width: 100% !important;
        max-width: 1152px;
        margin: 0 auto;
        padding: 0 20px;
        height: 64px;
    }

    /* 메뉴 탭바(.tab-list)가 포함된 컨테이너 */
    header + .container {
        display: block !important;
        position: relative !important;
        width: 100% !important;
        max-width: 1152px !important;
        margin: 0 auto !important;
    }

    /* 2. 본문 카드와의 간격 */
    main.container {
        display: block !important;
        margin-top: 40px !important; 
        padding: 0 20px !important;
    }

    /* 3. 상세보기 카드 내부 헤더 (제목 영역 둥둥 떠다님 방지) */
    /* diary_detail_board.css에서 강제로 준 fixed를 여기서 해제합니다. */
    .detail-card .detail-header {
        position: relative !important;
        top: auto !important;
        left: auto !important;
        width: 100% !important;
        height: auto !important;
        padding: 40px 30px 25px 30px !important;
        background-color: #ffffff !important;
        border-bottom: 1px solid #f1f5f9 !important;
        display: block !important;
        z-index: 10 !important;
    }

    /* 4. 제목 스타일 보정 */
    .detail-title {
        font-size: 1.8rem !important;
        font-weight: bold !important;
        margin: 10px 0 !important;
        color: #1e293b !important;
        display: block !important;
    }
</style>
</head>

<body> 
    <jsp:include page="/WEB-INF/views/main/menu.jsp" />

    <main class="container"> 
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

                    <a class="btn-action-text" href="${pageContext.request.contextPath}/report/famousReportPage.do?type=famous&id=${famousVO.famousSid}"
                    onclick="window.open(this.href, 'reportPopup', 'width=500,height=700,scrollbars=yes'); return false;"
                    style="font-size:13px; cursor:pointer; background:none; border:none; color:#ef4444;
                     padding:0; margin-left:12px; text-decoration:none;">🚨신고</a>

                    </div>
                </div>
            </header>

<div class="detail-body" style="text-align: center; padding: 50px 20px; font-size: 1.4rem;">
    "${detail.famousContent}"
</div>

<div class="action-buttons" style="display: flex; flex-direction: column; align-items: center; gap: 20px; padding-bottom: 30px;">
    
    <button class="btn-like" id="likeBtn">
        <i data-lucide="heart" id="heartIcon"></i>
        <span id="likeCount">${detail.famousReccount}</span>
    </button>

    <c:if test="${not empty sessionUser && (sessionUser.userId == detail.regId || sessionUser.adminChk == '1')}">
        <div class="edit-delete-group" style="display: flex; gap: 10px;">
            <button type="button" class="btn-edit" id="btnUpdate" style="background-color: #4a90e2; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer;">수정</button>
            <button type="button" class="btn-delete" id="btnDelete" style="background-color: #e74c3c; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer;">삭제</button>
        </div>
    </c:if>
</div>        </article>
    </div>
</main>

<footer>
    <div class="container">
        <p>© 2024 내면의 흔적. All rights reserved.</p>
    </div>
</footer>

<script src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>

<script>  
$(document).ready(function() {
    // 1. EL 태그 값을 안전하게 문자열로 받기
    // 값이 없을 경우를 대비해 기본값 ''를 설정합니다.
    const famousSid = "${not empty detail.famousSid ? detail.famousSid : ''}";
    const loginUserId = "${not empty sessionUser ? sessionUser.userId : ''}";
    
    console.log("자바스크립트 인식 ID:", loginUserId);
    console.log("게시글 SID:", famousSid);

    // 2. 초기화 (Lucide 아이콘 및 좋아요 상태)
    let isRecommended = localStorage.getItem("famous_liked_" + famousSid) === "true";
    if (isRecommended) {
        $("#heartIcon").attr({"fill": "#ff4d4d", "stroke": "#ff4d4d"});
        $("#likeBtn").addClass("active");
    }
    lucide.createIcons();

    // 3. 좋아요 클릭 이벤트
$(document).off("click", "#likeBtn").on("click", "#likeBtn", function(e) {
        e.stopPropagation();

        if (!loginUserId || loginUserId.trim() === "" || loginUserId === "null") {
            if (confirm("좋아요는 로그인 후에 가능합니다.\n로그인 페이지로 이동하시겠습니까?")) {
                location.href = "${pageContext.request.contextPath}/user/signIn.do";
            }
            return;
        }

        const changeValue = isRecommended ? -1 : 1;

     // 상세페이지는 목록과 달리 '낙관적 업데이트'를 하지 않고 
        // 서버의 응답을 받은 후 UI를 변경하도록 순서를 조정합니다.
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/famous/doUpdateLike.do",
            data: {
                "famousSid": famousSid
            },
            dataType: "text", // 응답 형식을 텍스트로 명시
            success: function(data) {
                console.log("서버 응답:", data);

                if (data === "LOGIN_REQUIRED") {
                    alert("로그인이 필요합니다.");
                } else if (data.indexOf("TIME_LIMIT") > -1) {
                    // 서버에서 "TIME_LIMIT:X" 메시지가 온 경우
                    let remaining = data.split(":")[1];
                    alert("이미 추천하셨습니다. " + remaining + "분 후에 다시 가능합니다.");
                } else if (data === "ERROR") {
                    alert("처리 중 오류가 발생했습니다.");
                } else {
                    // 정상적으로 추천수가 리턴된 경우 (성공)
                    $("#likeCount").text(data);
                    
                    if (!isRecommended) {
                        // 추천 성공 시 UI 변경
                        $("#heartIcon").attr({"fill": "#ff4d4d", "stroke": "#ff4d4d"});
                        localStorage.setItem("famous_liked_" + famousSid, "true");
                        isRecommended = true;
                        alert("추천되었습니다.");
                    } else {
                        // 추천 취소 성공 시 UI 변경 (서버 로직이 취소를 지원할 경우)
                        $("#heartIcon").attr({"fill": "none", "stroke": "currentColor"});
                        localStorage.removeItem("famous_liked_" + famousSid);
                        isRecommended = false;
                        alert("추천이 취소되었습니다.");
                    }
                }
            },
            error: function() {
                alert("서버와 통신 중 오류가 발생했습니다.");
            }
        });
    });

    // 4. 이동 및 삭제 로직
   $("#btnDelete").on("click", function() {
    if (confirm("정말 이 명언을 삭제하시겠습니까?")) {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/famous/doDelete.do",
            data: { "famousSid": famousSid }, // 현재 페이지의 게시글 번호
            success: function(data) {
                // 서버 리턴값이 "1"이면 성공
                if (data == "1" || data.flag == "1") {
                    alert("삭제되었습니다.");
                    location.href = "${pageContext.request.contextPath}/famous/famous.do"; // 목록으로 이동
                } else {
                    alert(data.message || "삭제 실패: 권한이 없습니다.");
                }
            },
            error: function() {
                alert("삭제 처리 중 오류가 발생했습니다.");
            }
        });
    }
});

    $("#btnUpdate").on("click", function() {
        location.href = "${pageContext.request.contextPath}/famous/moveToUpdate.do?famousSid=" + famousSid;
    });

    $("#btnMoveToList").on("click", function() {
        location.href = "${pageContext.request.contextPath}/famous/famous.do";
    });
});
</script>
</body>
</html>