<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.pcwk.ehr.famous.domain.FamousVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<<<<<<< HEAD
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>내면의 흔적 - 명언 모음집</title>

<script src="https://unpkg.com/lucide@latest"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
=======
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>내면의 흔적 - 명언 모음집</title>


<script src="https://unpkg.com/lucide@latest"></script>
>>>>>>> 18ed6dc36142b715f4fe2b6205e7bd779f8ffacc

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/common.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/famous_diary_board.css" />
<<<<<<< HEAD

<script
	src="<%=request.getContextPath()%>/resources/assets/js/cmn/jquery.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>

<jsp:include page="/WEB-INF/views/main/menu.jsp" />

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
				<div class="section-title">
					<h3>💬 명언 모음집</h3>
					<span style="font-size: 0.9rem; color: #64748b; margin-left: 10px">마음을
						울리는 한 줄의 힘</span>
				</div>

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
							    // 1. 하트 클릭 시 상세페이지로 이동 방지
							    e.stopPropagation();

							    // 2. 로그인 체크 (문자열 에러 방지를 위해 변수 처리)
							    // 세션값이 없을 때 스크립트가 깨지지 않도록 ' ' 따옴표로 감싸는 것이 중요합니다.
							    const loginUser = "${sessionScope.loginUser}";
    
    if (loginUser === null || loginUser === "" || loginUser === "undefined") {
        if (confirm("좋아요는 로그인 후에 가능합니다.\n로그인 페이지로 이동하시겠습니까?")) {
            // menu.jsp의 경로에 맞춰 수정
            location.href = "<%=request.getContextPath()%>/user/signIn.do";
        }
        return;
    }

							    const $this = $(this);
							    const famousSid = $this.closest(".post-card").data("sid");
							    const isLiked = $this.data("is-liked") === true;
							    const changeValue = isLiked ? -1 : 1;

							    // UI 즉시 반영 (낙관적 업데이트) - 사용자님 기존 코드와 동일
							    const $allTriggers = $("[data-sid='" + famousSid + "'] .likes-trigger");
							    const $allCounts = $(".count-" + famousSid);

							    if (!isLiked) {
							        $allTriggers.data("is-liked", true);
							        localStorage.setItem("famous_liked_" + famousSid, "true");
							        $allTriggers.find(".heart-icon").attr({
							            "fill": "#ef4444",
							            "stroke": "#ef4444"
							        });
							    } else {
							        $allTriggers.data("is-liked", false);
							        localStorage.removeItem("famous_liked_" + famousSid);
							        $allTriggers.find(".heart-icon").attr({
							            "fill": "none",
							            "stroke": "currentColor"
							        });
							    }

							    // 숫자 업데이트 (NaN 방지를 위해 parseInt 처리)
							    var currentVal = parseInt($allCounts.first().text()) || 0;
							    $allCounts.text(currentVal + changeValue);

							    // 3. 서버 전송 - 사용자님 기존 코드와 동일
							    $.ajax({
							        type: "POST",
							        url: "${pageContext.request.contextPath}/famous/doUpdateLike.do",
							        data: {
							            "famousSid": famousSid,
							            "famousReccount": changeValue
							        },
							        success: function(response) {
							            console.log(famousSid + "번 좋아요 업데이트 성공");
							        },
							        error: function(err) {
							            console.log("좋아요 처리 중 오류 발생");
							        }
							    });
							});
						});
	</script>
=======
<script src="<%=request.getContextPath()%>/resources/assets/js/cmn/jquery.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/assets/js/famous_diary_board.js"></script>

<jsp:include page="/WEB-INF/views/main/menu.jsp" />
</head>
<body>


	<main class="container">
`

<div class="tab-content">
            <section class="board-best-section">
                <div class="section-title">
                    <h3>🏆 명예의 명언 (Best 3)</h3>
                    <span style="font-size: 0.9rem; color: #64748b; margin-left: 10px">실시간 추천 순위 반영</span>
                </div>
                <div id="best-posts-container" class="posts-grid">
                    <c:forEach var="best" items="${bestList}">
                        <article class="post-card" data-sid="${best.famousSid}">
                            <div class="sentiment-tag"></div>
                            <h4 class="post-title">"${best.famousContent}"</h4>
                            <p class="post-author">- ${best.famousAuthor}</p>
                            <div class="post-meta">
                                <span>${best.regId}</span>
                                <div class="likes-trigger" style="cursor:pointer;">
                                    <i data-lucide="heart"></i> 
                                    <span class="like-count count-${best.famousSid}">${best.famousReccount}</span>
                                </div>
                            </div>
                        </article>
                    </c:forEach>
                </div>
            </section>

<div id="paged-list-container" class="posts-grid">
    <c:if test="${empty list}">
        <p style="text-align: center; grid-column: 1/-1; padding: 50px; color: #64748b;">
            현재 등록된 명언이 없습니다. 첫 명언을 등록해보세요!
        </p>
    </c:if>

    <c:forEach var="vo" items="${list}">
        </c:forEach>
</div>

            <hr class="section-divider">

<section class="board-latest-section">
    <div class="section-title">
        <h3>💬 명언 모음집</h3>
        <span style="font-size: 0.9rem; color: #64748b; margin-left: 10px">마음을 울리는 한 줄의 힘</span>
    </div>
    
    <div id="paged-list-container" class="posts-grid">
        <c:choose>
            <c:when test="${empty list}">
                <p style="text-align: center; grid-column: 1/-1; padding: 50px; color: #64748b;">
                    현재 등록된 명언이 없습니다. 첫 명언을 등록해보세요!
                </p>
            </c:when>
            <c:otherwise>
                <c:forEach var="vo" items="${list}">
                    <article class="post-card" data-sid="${vo.famousSid}">
                        <div class="sentiment-tag"></div>
                        <h4 class="post-title">"${vo.famousContent}"</h4>
                        <p class="post-author">- ${vo.famousAuthor}</p>
                        <div class="post-meta">
                            <span>${vo.regId}</span>
                            <div class="likes-trigger" style="cursor:pointer;">
                                <i data-lucide="heart"></i> 
                                <span class="like-count count-${vo.famousSid}">${vo.famousReccount}</span>
                            </div>
                        </div>
                    </article>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

        <div id="pagination" class="pagination-container" style="text-align: center; margin-top: 20px;">
            <ul class="pagination-list" style="display: flex; justify-content: center; list-style: none; gap: 10px;">
                <c:if test="${totalCnt > 0}">
                    <%-- 전체 페이지 수 계산 --%>
                    <c:set var="totalPage" value="${Math.ceil(totalCnt / vo.pageSize).intValue()}" />
                    
                    <%-- 이전 버튼 --%>
                    <c:if test="${vo.pageNo > 1}">
                        <li><a href="?pageNo=${vo.pageNo - 1}&pageSize=${vo.pageSize}">이전</a></li>
                    </c:if>

                    <%-- 페이지 번호 반복 --%>
                    <c:forEach begin="1" end="${totalPage}" var="i">
                        <li>
                            <a href="?pageNo=${i}&pageSize=${vo.pageSize}" 
                               style="${vo.pageNo == i ? 'font-weight: bold; color: #000;' : 'color: #999;'}">
                               ${i}
                            </a>
                        </li>
                    </c:forEach>

                    <%-- 다음 버튼 --%>
                    <c:if test="${vo.pageNo < totalPage}">
                        <li><a href="?pageNo=${vo.pageNo + 1}&pageSize=${vo.pageSize}">다음</a></li>
                    </c:if>
                </c:if>
            </ul>
        </div>
    </section>
</main>

    <footer>
        <div class="container">
            <p>© 2024 내면의 흔적. All rights reserved.</p>
        </div>
    </footer>

    <script>
// 중복된 바깥쪽 리스너를 제거하고 하나만 남깁니다.
$(document).off("click", ".likes-trigger").on("click", ".likes-trigger", function(e) {
    const $this = $(this);
    const postCard = $this.closest(".post-card");
    const famousSid = postCard.data("sid");
    const $countText = postCard.find(".like-count");
    const $heartIcon = $this.find("i");

    if(!famousSid) return;

    // 1. 중복 클릭 방지
    if($this.data('requesting')) return;
    $this.data('requesting', true);

    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/famous/doUpdateLike.do",
        data: { "famousSid": famousSid },
        dataType: "json",
        success: function(response) {
            if(response !== undefined && response !== null) {
                // 2. 서버에서 받은 최신 숫자로 교체
                $countText.text(response);
                
                // 3. 하트 색상 변경 (CSS 클래스 추가)
                $heartIcon.addClass("liked");
                
                // Lucide 아이콘 내부 채우기 (필요시 직접 속성 조작)
                $heartIcon.attr("fill", "#ef4444");
                $heartIcon.attr("stroke", "#ef4444");

                // 4. 간단한 애니메이션
                $this.css("transform", "scale(1.3)");
                setTimeout(() => $this.css("transform", "scale(1.0)"), 100);
            }
        },
        error: function(xhr, status, error) {
            console.error("좋아요 처리 에러:", error);
        },
        complete: function() {
            // 5. 요청 완료 후 다시 클릭 가능하게 설정
            $this.data('requesting', false);
        }
    });
    
    function saveComment(famousSid) {
        const content = $("#comment_input_" + famousSid).val();
        
        if(!content) {
            alert("댓글 내용을 입력해주세요.");
            return;
        }

        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/famous/doSaveComment.do",
            data: {
                "famousSid": famousSid,
                "commentContent": content
            },
            success: function(res) {
                if(res.status === "success") {
                    alert("댓글이 등록되었습니다.");
                    location.reload(); // 리스트 갱신
                }
            }
        });
    }
});
</script>
        
        /*로그인 조건 좋아요*/
/*             $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/famous/doUpdateLike.do",
                data: { "famousSid": famousSid },
                // 서버에서 숫자(int)만 리턴하므로 dataType을 설정하면 안전합니다.
                dataType: "json", 
                success: function(response) {
                    // response에 latestVO.getFamousReccount() 값이 바로 담깁니다.
                    if(response !== undefined) {
                        // 1. 숫자 변경
                        $countText.text(response);
                        
                        // 2. 시각적 효과 (반짝임)
                        $countText.stop(true, true).fadeOut(100).fadeIn(100);
                        
                        // 3. 아이콘 색상 토글 (선택 사항: 클래스 추가/제거)
                        $(this).toggleClass("text-red-500 active"); 
                    }
                }.bind(this), // 클릭한 버튼 객체를 유지하기 위해 bind 사용
                error: function(xhr, status, error) {
                    console.error(error);
                    alert("로그인이 필요하거나 처리 중 오류가 발생했습니다.");
                }
            }); */
        
        // Lucide 아이콘 렌더링 (동적 생성 시 필요)
        lucide.createIcons();
    });
    </script>
>>>>>>> 18ed6dc36142b715f4fe2b6205e7bd779f8ffacc
</body>
</html>