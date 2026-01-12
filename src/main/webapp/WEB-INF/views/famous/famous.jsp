<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.pcwk.ehr.famous.domain.FamousVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

<jsp:include page="/WEB-INF/views/main/menu.jsp" />

<style>
    /* 명언 모음집 전체 섹션의 중앙 정렬 해제 */
   .board-latest-section { text-align: left !important; }

    /* 타이틀과 버튼을 가로로 배치하는 컨테이너 */
   .custom-header-flex {
        display: flex !important;
        align-items: center !important;
        gap: 15px !important;
        margin-bottom: 25px !important;
        margin-left: 10px !important;
    }

    /* 타이틀 텍스트 스타일 */
    .custom-header-flex .title-group {
        text-align: left !important;
    }

    .custom-header-flex h3 {
        margin: 0 !important;
        font-size: 1.5rem !important;
        color: #1e293b !important;
    }

    /* 버튼 스타일 (기존 디자인 유지하며 정렬만 수정) */
    .btn-custom-famous {
        all: unset !important;
        display: inline-flex !important;
        align-items: center !important;
        gap: 8px !important;
        background: linear-gradient(135deg, #6366f1 0%, #a855f7 100%) !important;
        color: white !important;
        padding: 10px 20px !important;
        border-radius: 50px !important;
        font-weight: 600 !important;
        cursor: pointer !important;
        box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3) !important;
        transition: 0.3s !important;
    }
    /* 좋아요 버튼의 기본 상태를 빨간색으로 설정 */
/* 좋아요 버튼/아이콘 기본 빨간색 설정 (목록의 하트와 상세페이지 버튼 모두 대응) */
    .btn-like, .likes-trigger {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        color: #ff4d4d !important; /* 숫자 색상 */
        cursor: pointer;
    }

/* 목록과 상세페이지의 모든 하트 아이콘을 빨간색으로 */
    .heart-icon, #heartIcon {
        color: #ff4d4d !important; /* 테두리 */
        fill: #ff4d4d !important;  /* 내부 채우기 */
        width: 18px;
        height: 18px;
        transition: transform 0.2s ease;
    }
    
    .likes-trigger:hover .heart-icon {
        transform: scale(1.2);
    }

    /* 버튼에 마우스를 올렸을 때 효과 (선택 사항) */
    .btn-like:hover {
        background-color: #fff5f5;
        transform: scale(1.05);
    }
</style>


</head>
<body>

	<main class="container">
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

							<c:set var="bestEmotion" value="${fn:trim(best.famousEmotion)}" />
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
            <i data-lucide="eye"></i>
            <span>${best.famousViewcount}</span>
        </div>
        
        <div class="likes-trigger">
            <i data-lucide="heart" class="heart-icon"></i> 
            <span class="like-count count-${best.famousSid}">${best.famousReccount}</span>
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
    <div class="custom-header-flex">
        <div class="title-group">
            <h3>💬 명언 모음집</h3>
            <p style="margin: 4px 0 0 0; font-size: 0.9rem; color: #64748b;">마음을 울리는 한 줄의 힘</p>
        </div>

        <button id="btnMoveToReg" class="btn-custom-famous" type="button">
            <i data-lucide="plus-circle" style="width: 18px; height: 18px;"></i>
            <span>명언 등록하기</span>
        </button>
    </div>
    
    <div id="paged-list-container" class="posts-grid">
    
    </section>

				<div id="paged-list-container" class="posts-grid">
					<c:choose>
						<c:when test="${empty list}">
							<p
								style="text-align: center; grid-column: 1/-1; padding: 50px; color: #64748b;">
								현재 등록된 명언이 없습니다. 첫 명언을 등록해보세요!</p>
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
    <i data-lucide="eye"></i> 
    <span>${not empty vo.famousViewcount ? vo.famousViewcount : 0}</span>
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

				<div id="pagination" class="pagination-container"
					style="text-align: center; margin-top: 40px;">
					<ul class="pagination-list"
						style="display: flex; justify-content: center; list-style: none; gap: 10px;">
						<c:if test="${totalCnt > 0}">
							<%-- 전체 페이지 수 계산 --%>
							<c:set var="totalPage"
								value="${Math.ceil(totalCnt / vo.pageSize).intValue()}" />

							<c:if test="${vo.pageNo > 1}">
								<li><a
									href="?pageNo=${vo.pageNo - 1}&pageSize=${vo.pageSize}"
									class="page-link">이전</a></li>
							</c:if>

							<c:forEach begin="1" end="${totalPage}" var="i">
								<li><a href="?pageNo=${i}&pageSize=${vo.pageSize}"
									class="page-link ${vo.pageNo == i ? 'active' : ''}"
									style="${vo.pageNo == i ? 'font-weight: bold; color: #ef4444; text-decoration: underline;' : 'color: #64748b;'}">
										${i} </a></li>
							</c:forEach>

							<c:if test="${vo.pageNo < totalPage}">
								<li><a
									href="?pageNo=${vo.pageNo + 1}&pageSize=${vo.pageSize}"
									class="page-link">다음</a></li>
							</c:if>
						</c:if>
					</ul>
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
        $(document).ready( function() {
            
            $(document).ready(function() {
                // 명언 등록 페이지로 이동
                $("#btnMoveToReg").on("click", function() {
                    // 등록 페이지용 Controller 주소 호출
                    location.href = "${pageContext.request.contextPath}/famous/famousRegView.do";
                });
            });
            
                            // 1. 초기 UI 복구 및 아이콘 설정
                            function refreshRankUI() {
                                // 명예의 명언 섹션의 카드들을 순서대로 돌며 아이콘 설정
                                $("#best-posts-container .post-card")
                                        .each(
                                                function(index) {
                                                    const $card = $(this);
                                                    const rank = index + 1;
                                                    const $tag = $card
                                                            .find(".sentiment-tag");

                                                    // 순위 텍스트 업데이트
                                                    $tag.find(".rank-badge")
                                                            .text(rank + "위");

                                                    // 순위별 왕관 색상 강제 지정 (금, 은, 동)
                                                    const $crown = $tag
                                                            .find("[data-lucide='crown']");
                                                    if (rank === 1) {
                                                        $crown
                                                                .css({
                                                                    "color" : "#fbbf24",
                                                                    "fill" : "#fbbf24"
                                                                });
                                                    } else if (rank === 2) {
                                                        $crown
                                                                .css({
                                                                    "color" : "#94a3b8",
                                                                    "fill" : "#94a3b8"
                                                                });
                                                    } else {
                                                        $crown
                                                                .css({
                                                                    "color" : "#b45309",
                                                                    "fill" : "#b45309"
                                                                });
                                                    }
                                                });

                                // localStorage 기반 좋아요 상태 복구
                                $(".post-card")
                                        .each(
                                                function() {
                                                    const sid = $(this).data(
                                                            "sid");
                                                    if (localStorage
                                                            .getItem("famous_liked_"
                                                                    + sid) === "true") {
                                                        const $trigger = $(this)
                                                                .find(
                                                                        ".likes-trigger");
                                                        $trigger.data(
                                                                "is-liked",
                                                                true);
                                                        $trigger
                                                                .find(
                                                                        ".heart-icon")
                                                                .attr(
                                                                        {
                                                                            "fill" : "#ef4444",
                                                                            "stroke" : "#ef4444"
                                                                        });
                                                        $trigger.css("color",
                                                                "#ef4444");
                                                    }
                                                });

                                lucide.createIcons(); // 아이콘 최종 렌더링
                            }

                            refreshRankUI();

                            // 카드 클릭 이벤트 (조회수 증가 + 상세페이지 이동)
                            $(document).on("click", ".post-card", function(e) {
    // 1. 좋아요 버튼 클릭 시 상세페이지 이동 방지
    if ($(e.target).closest('.likes-trigger').length) return;

    // 2. 필요한 데이터 추출
    const famousSid = $(this).data("sid");
    const pNo = "${vo.pageNo}";   // 현재 목록의 페이지 번호
    const pSize = "${vo.pageSize}"; // 현재 목록의 페이지 사이즈

    // 3. 즉시 이동 (조회수 증가는 상세페이지 컨트롤러가 처리함)
    let url = "${pageContext.request.contextPath}/famous/getFamousDetail.do";
    url += "?famousSid=" + famousSid;
    url += "&pageNo=" + (pNo ? pNo : 1);
    url += "&pageSize=" + (pSize ? pSize : 12);
    
    location.href = url;
});// 2. 좋아요 클릭 이벤트
$(document).off("click", ".likes-trigger").on("click", ".likes-trigger", function(e) {
    e.stopPropagation();

    // 1. 로그인 체크
    const loginUser = "${sessionScope.loginUser}";
    if (!loginUser) {
        if (confirm("좋아요는 로그인 후에 가능합니다.\n로그인 페이지로 이동하시겠습니까?")) {
            location.href = "<%=request.getContextPath()%>/user/signIn.do";
        }
        return;
    }

    const $this = $(this);
    const famousSid = $this.closest(".post-card").data("sid");

    // 2. 서버 전송 (화면 업데이트는 서버 응답 후에 실행)
    $.ajax({
        type: "POST",
        url: "/ehr/famous/doUpdateLike.do",
        data: { "famousSid": famousSid },
        // dataType: "json" 이 설정되어 있다면 제거하거나 "text"로 변경하세요.
        dataType: "text", 
        success: function(res) {
            console.log("서버 응답 데이터:", res);
            
            if (res === "LOGIN_REQUIRED") {
                alert("로그인이 필요합니다.");
            } else if (res.includes("TIME_LIMIT")) {
                // "TIME_LIMIT:4" 형태에서 숫자만 추출
                var remainingMin = res.split(":")[1];
                alert("이미 추천하셨습니다. " + remainingMin + "분 후에 다시 가능합니다.");
            } else if (res === "ERROR") {
                alert("처리 중 오류가 발생했습니다.");
            } else {
                // 성공 시 숫자 업데이트
                $(".count-" + famousSid).text(res);
                alert("추천되었습니다!");
            }
        },
        error: function(xhr, status, error) {
            // 500 에러가 나더라도 서버가 보낸 텍스트가 있을 수 있습니다.
            if(xhr.responseText && xhr.responseText.includes("TIME_LIMIT")) {
                 var remainingMin = xhr.responseText.split(":")[1];
                 alert("이미 추천하셨습니다. " + remainingMin + "분 후에 다시 가능합니다.");
            } else {
                 console.error("Status:", status, "Error:", error);
                 alert("통신 오류가 발생했습니다. (관리자 문의)");
            }
        }
    });
});
           });
</script>
</body>
</html>