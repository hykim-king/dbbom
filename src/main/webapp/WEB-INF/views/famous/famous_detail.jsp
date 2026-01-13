\<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        /* 메뉴 너비와 일치시키기 위한 설정 */
        main.container {
            padding-top: 40px;
            padding-bottom: 80px;
            display: flex;
            justify-content: center;
        }

        .tab-content {
            width: 100%;
            /* 사진상의 메뉴바 너비와 맞추기 위해 max-width를 1200px 정도로 설정 */
            max-width: 1200px; 
        }

        .reg-container { 
            background: white; 
            padding: 40px; 
            border-radius: 16px; 
            border: 1px solid #e2e8f0; 
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            width: 100%;
            box-sizing: border-box;
        }

        /* 아이콘 및 텍스트 색상을 공지사항 목록의 파란색(#3b82f6)으로 변경 */
        .section-title {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 1.4rem;
            margin-bottom: 5px;
        }

        .form-group { margin-bottom: 25px; }
        .form-label { display: block; margin-bottom: 10px; font-weight: 600; color: #475569; }
        
        .form-control { 
            width: 100%; 
            padding: 14px; 
            border: 1px solid #e2e8f0; 
            border-radius: 10px; 
            font-size: 1rem; 
            box-sizing: border-box; 
            transition: all 0.2s;
        }
        
        /* 포커스 시 파란색 테두리 */
        .form-control:focus { 
            border-color: #3b82f6; 
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
            outline: none; 
        }

        /* 버튼 색상을 파란색(#3b82f6)으로 통일 */
        .btn-save { 
            background-color: #3b82f6; 
            color: white; 
            padding: 12px 28px; 
            border: none; 
            border-radius: 10px; 
            cursor: pointer; 
            font-weight: 600; 
            display: flex; 
            align-items: center; 
            gap: 8px; 
            transition: all 0.2s;
        }

        .btn-save:hover { 
            background-color: #2563eb; 
            transform: translateY(-1px); 
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.2);
        }

        .btn-cancel { 
            background-color: #f1f5f9; 
            color: #64748b; 
            padding: 12px 24px; 
            border: none; 
            border-radius: 10px; 
            cursor: pointer; 
            font-weight: 600; 
            text-decoration: none; 
            font-size: 0.95rem; 
            transition: background 0.2s;
        }
        
        .btn-cancel:hover {
            background-color: #e2e8f0;
        }
        
                main.container {
            display: block !important;
            margin-top: 30px !important; /* 메뉴바 높이에 따라 조절 (80~100px 권장) */
            padding-top: 0px !important;
            position: relative !important;
        }

        /* 2. 상세 페이지 헤더 고정 해제 및 정렬 */
        .detail-card .detail-header {
            position: relative !important;
            top: auto !important;
            left: auto !important;
            display: block !important;
            width: 100% !important;
            margin-bottom: 30px !important;
            padding-bottom: 20px !important;
            background: white !important;
            z-index: 10 !important;
            border-bottom: 2px solid #f1f5f9 !important;
        }

        /* 3. 목록으로 돌아가기 버튼 위치 확보 */
        .back-btn {
            display: inline-flex !important;
            margin-bottom: 20px !important;
            position: relative !important;
            z-index: 11;
        }
        
        /* 4. 헤더(메뉴바) 스타일 강제 고정 */
        header {
            z-index: 1000 !important; /* 메뉴바가 항상 맨 위에 오도록 */
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

<style>
    /* 1. Flex 레이아웃 강제 해제 (이미지 11번 body 설정 무력화) */
    html body {
        display: block !important;
        height: auto !important;
        margin: 0 !important;
        padding: 0 !important;
    }

    /* 2. 상단 메뉴바 고정 (common.css의 sticky 설정을 fixed로 변경) */
    header {
        position: fixed !important;
        top: 0 !important;
        left: 0 !important;
        width: 100% !important;
        z-index: 99999 !important;
        background-color: #ffffff !important;
        border-bottom: 1px solid #e2e8f0 !important;
    }

    /* 3. 본문 컨테이너: 메뉴바 높이(약 147px)만큼 확실히 아래로 밀기 */
    html body main.container {
        display: block !important;
        position: relative !important;
        margin-top: 180px !important; /* 넉넉하게 180px 설정 */
        margin-left: auto !important;
        margin-right: auto !important;
        padding: 0 20px 100px 20px !important;
        max-width: 1100px !important;
        z-index: 10 !important;
    }

    /* 4. 제목 영역(detail-header)이 상단에 고정되는 것 방지 */
    article.detail-card header.detail-header {
        position: relative !important;
        top: auto !important;
        display: block !important;
        background: #ffffff !important;
        margin-top: 0 !important;
        padding: 40px 30px !important;
        z-index: 1 !important;
    }

    /* 5. 공지사항 이미지처럼 텍스트가 가로로 뚫고 나가는 것 방지 */
    .detail-body {
        word-break: break-all !important;
        overflow-wrap: break-word !important;
        white-space: pre-wrap !important;
    }

    /* 6. 목록 버튼 위치 조정 */
    .back-btn {
        margin-top: 10px !important;
        margin-bottom: 30px !important;
        display: inline-flex !important;
    }
</style>

<script src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>
</body>
</html>