<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내면의 흔적 - 명언 상세보기</title>
    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/common.css" />

    <style>
        /* [충돌 방지] 모든 Flex 레이아웃 초기화 */
        html, body {
            display: block !important;
            margin: 0 !important;
            padding: 0 !important;
            background-color: #f8fafc !important;
            height: auto !important;
        }

        /* [메뉴바 복구] 사진처럼 글자가 세로로 나오는 현상 수정 */
        header, #header-wrapper {
            position: relative !important;
            display: block !important;
            width: 100% !important;
            background: #ffffff !important;
            border-bottom: 1px solid #e2e8f0 !important;
            z-index: 1000 !important;
        }

        header nav ul, .menu-list {
            display: flex !important;
            flex-direction: row !important; /* 가로 정렬 강제 */
            justify-content: center !important;
            align-items: center !important;
            gap: 30px !important;
            list-style: none !important;
            padding: 20px 0 !important;
            margin: 0 !important;
        }

        header a {
            text-decoration: none !important;
            color: #334155 !important;
            font-weight: 500 !important;
            white-space: nowrap !important;
        }

        /* [본문 레이아웃] 메뉴바와 겹치지 않게 마진 설정 */
        main.container {
            display: block !important;
            max-width: 900px !important;
            margin: 40px auto !important;
            padding: 0 20px 100px 20px !important;
        }

        /* [상세 카드] 박스 깨짐 방지 */
        .detail-card {
            background: #ffffff !important;
            border-radius: 20px !important;
            border: 1px solid #e2e8f0 !important;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.04) !important;
            overflow: hidden !important;
            display: block !important;
        }

        .detail-header {
            padding: 40px !important;
            border-bottom: 1px solid #f1f5f9 !important;
            background: #ffffff !important;
        }

        .detail-title {
            font-size: 1.8rem !important;
            margin: 15px 0 !important;
            color: #1e293b !important;
        }

        /* 명언 내용 박스 */
        .detail-body {
            padding: 80px 40px !important;
            text-align: center !important;
            font-size: 1.5rem !important;
            line-height: 1.8 !important;
            color: #334155 !important;
            word-break: keep-all !important;
        }

        /* 버튼 및 기타 UI */
        .back-btn {
            display: inline-flex !important;
            align-items: center;
            gap: 8px;
            color: #64748b !important;
            text-decoration: none !important;
            margin-bottom: 25px !important;
        }

        .btn-like {
            background: white !important;
            border: 1px solid #f1f5f9 !important;
            padding: 12px 25px !important;
            border-radius: 30px !important;
            cursor: pointer !important;
            display: flex !important;
            align-items: center !important;
            gap: 10px !important;
            transition: all 0.3s !important;
        }
        
        /* 좋아요 버튼 컨테이너 */
.action-buttons {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 20px;
    padding: 30px 0;
}

/* 좋아요 버튼 디자인 (공지사항 스타일) */
.btn-like {
    display: inline-flex !important;
    align-items: center !important;
    gap: 8px !important;
    background: #ffffff !important;
    border: 1px solid #e2e8f0 !important;
    padding: 10px 24px !important;
    border-radius: 50px !important;
    cursor: pointer !important;
    transition: all 0.2s ease !important;
    font-size: 1.1rem !important;
    color: #64748b !important;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05) !important;
}

/* 활성화(클릭 후) 상태 */
.btn-like.active {
    background: #fff1f2 !important;
    border-color: #fda4af !important;
    color: #e11d48 !important;
}

.btn-like:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0,0,0,0.1) !important;
}

#heartIcon {
    width: 20px;
    height: 20px;
    transition: all 0.2s ease;
}
    </style>
</head>

<body> 
    <jsp:include page="/WEB-INF/views/main/menu.jsp" />

    <main class="container"> 
        <a href="${pageContext.request.contextPath}/famous/famous.do" class="back-btn">
            <i data-lucide="arrow-left"></i> 목록으로 돌아가기
        </a>

        <article class="detail-card">
            <header class="detail-header">
                <span class="post-tag ${fn:trim(detail.famousEmotion) eq 'P' ? 'gratitude' : 'emotion'}">
                    <i data-lucide="${fn:trim(detail.famousEmotion) eq 'P' ? 'sun' : 'moon'}"></i>
                </span>
                <h2 class="detail-title">${detail.famousAuthor}</h2>
                <div style="display: flex; justify-content: space-between; color: #94a3b8; font-size: 0.9rem;">
                    <div>
                        <span><i data-lucide="user" size="14"></i> ${detail.regId}</span>
                        <span style="margin-left: 15px;"><i data-lucide="calendar" size="14"></i> ${detail.famousTime}</span>
                    </div>
                    <span><i data-lucide="eye" size="14"></i> 조회 ${detail.famousViewcount}</span>
                </div>
            </header>

            <div class="detail-body">
                "${detail.famousContent}"
            </div>

            <div style="padding-bottom: 40px; display: flex; flex-direction: column; align-items: center; gap: 20px;">
                <button class="btn-like" id="likeBtn">
                    <i data-lucide="heart" id="heartIcon"></i>
                    <span id="likeCount">${detail.famousReccount}</span>
                </button>

                <c:if test="${not empty sessionUser && (sessionUser.userId == detail.regId || sessionUser.adminChk == '1')}">
                    <div style="display: flex; gap: 10px;">
                        <button id="btnUpdate" style="background: #4a90e2; color: white; border: none; padding: 10px 20px; border-radius: 8px; cursor: pointer;">수정</button>
                        <button id="btnDelete" style="background: #e74c3c; color: white; border: none; padding: 10px 20px; border-radius: 8px; cursor: pointer;">삭제</button>
                    </div>
                </c:if>
            </div>
        </article>
    </main>

<script>
$(document).ready(function() {
    // 1. 초기 UI 및 아이콘 렌더링
    lucide.createIcons();

    // 2. 주요 변수 설정
    // EL 태그를 통해 서버 데이터를 자바스크립트 변수로 할당
    const famousSid = "${detail.famousSid}";
    const loginUserId = "${sessionUser.userId}"; // famous.jsp의 sessionScope.loginUser와 본인 환경에 맞는 것 확인 필요
    
    console.log("현재 게시글 SID:", famousSid);
    console.log("로그인 사용자 ID:", loginUserId);

    // 3. 좋아요 상태 복구 (localStorage 이용)
    let isRecommended = localStorage.getItem("famous_liked_" + famousSid) === "true";
    if (isRecommended) {
        $("#likeBtn").addClass("active");
        $("#heartIcon").attr({
            "fill": "#ef4444", 
            "stroke": "#ef4444"
        });
        $("#likeBtn").css("color", "#ef4444");
    }

    // 4. 좋아요 클릭 이벤트 (AJAX)
    $(document).off("click", "#likeBtn").on("click", "#likeBtn", function(e) {
        e.preventDefault();

        // 로그인 체크 (sessionUser가 비어있는지 확인)
        if (!loginUserId || loginUserId === "null" || loginUserId === "") {
            if (confirm("좋아요는 로그인 후에 가능합니다.\n로그인 페이지로 이동하시겠습니까?")) {
                location.href = "${pageContext.request.contextPath}/user/signIn.do";
            }
            return;
        }

        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/famous/doUpdateLike.do",
            data: { "famousSid": famousSid },
            dataType: "text",
            success: function(res) {
                console.log("서버 응답:", res);

                if (res === "LOGIN_REQUIRED") {
                    alert("로그인이 필요합니다.");
                } else if (res.includes("TIME_LIMIT")) {
                    const remaining = res.split(":")[1];
                    alert("이미 추천하셨습니다. " + remaining + "분 후에 다시 가능합니다.");
                } else if (res === "ERROR") {
                    alert("처리 중 오류가 발생했습니다.");
                } else {
                    // 정상 처리 (res는 업데이트된 추천수)
                    $("#likeCount").text(res);

                    if (!isRecommended) {
                        // 추천 성공 UI 업데이트
                        $("#likeBtn").addClass("active");
                        $("#heartIcon").attr({"fill": "#ef4444", "stroke": "#ef4444"});
                        $("#likeBtn").css("color", "#ef4444");
                        localStorage.setItem("famous_liked_" + famousSid, "true");
                        isRecommended = true;
                        alert("추천되었습니다!");
                    } else {
                        // 추천 취소 UI 업데이트 (서버 로직이 취소를 지원할 경우)
                        $("#likeBtn").removeClass("active");
                        $("#heartIcon").attr({"fill": "none", "stroke": "currentColor"});
                        $("#likeBtn").css("color", "");
                        localStorage.removeItem("famous_liked_" + famousSid);
                        isRecommended = false;
                        alert("추천이 취소되었습니다.");
                    }
                    lucide.createIcons(); // 아이콘 상태 다시 렌더링
                }
            },
            error: function() {
                alert("통신 오류가 발생했습니다.");
            }
        });
    });

    // 5. 버튼 이벤트 (목록 이동, 수정, 삭제)
    
    // 목록으로 돌아가기
    $("#btnMoveToList").on("click", function() {
        // famous.jsp의 검색어 유지 로직과 맞추려면 아래처럼 이동
        location.href = "${pageContext.request.contextPath}/famous/famous.do";
    });

    // 수정 페이지 이동
    $("#btnUpdate").on("click", function() {
        location.href = "${pageContext.request.contextPath}/famous/moveToUpdate.do?famousSid=" + famousSid;
    });

    // 삭제 실행
    $("#btnDelete").on("click", function() {
        if (confirm("정말 이 명언을 삭제하시겠습니까?")) {
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/famous/doDelete.do",
                data: { "famousSid": famousSid },
                success: function(res) {
                    // 서버 응답이 "1"이면 삭제 성공
                    if (res == "1" || res.flag == "1") {
                        alert("삭제되었습니다.");
                        location.href = "${pageContext.request.contextPath}/famous/famous.do";
                    } else {
                        alert("삭제 실패: 권한이 없거나 오류가 발생했습니다.");
                    }
                },
                error: function() {
                    alert("삭제 처리 중 통신 오류가 발생했습니다.");
                }
            });
        }
    });
});
</script>
</body>
</html>