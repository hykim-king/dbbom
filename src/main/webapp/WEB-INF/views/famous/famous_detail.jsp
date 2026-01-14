<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/common.css" />

<style>
html, body {
	display: block;
	margin: 0;
	padding: 0;
	background-color: #f8fafc;
	height: auto;
}

header, #header-wrapper {
	position: relative;
	width: 100%;
	background: #ffffff;
	border-bottom: 1px solid #e2e8f0;
	z-index: 1000;
}

.menu-list {
	display: flex;
	justify-content: center;
	gap: 30px;
	list-style: none;
	padding: 20px 0;
	margin: 0;
}

main.container {
	display: block;
	max-width: 900px;
	margin: 40px auto;
	padding: 0 20px 100px 20px;
}

.detail-card {
	background: #ffffff;
	border-radius: 20px;
	border: 1px solid #e2e8f0;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.04);
	overflow: hidden;
}

.detail-header {
	padding: 40px;
	border-bottom: 1px solid #f1f5f9;
}

.detail-title {
	font-size: 1.8rem;
	margin: 15px 0;
	color: #1e293b;
}

.detail-body {
	padding: 80px 40px;
	text-align: center;
	font-size: 1.5rem;
	line-height: 1.8;
	color: #334155;
	word-break: keep-all;
}

.btn-like {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	background: #ffffff;
	border: 1px solid #e2e8f0;
	padding: 10px 24px;
	border-radius: 50px;
	cursor: pointer;
	transition: all 0.2s;
}

.reply-item {
	margin-left: 40px !important;
	background-color: #f9fafb;
	border-left: 2px solid #e5e7eb;
	padding-left: 15px !important;
	position: relative;
}

.reply-item::before {
	content: "└";
	position: absolute;
	left: 5px;
	top: 15px;
	color: #9ca3af;
	font-weight: bold;
}

.reply-form {
	display: none;
	margin-top: 10px;
	padding: 10px;
	background: #f8f9fa;
	border-radius: 5px;
}

.reply-textarea {
	width: 100%;
	height: 60px;
	border: 1px solid #ddd;
	border-radius: 4px;
	padding: 8px;
	margin-bottom: 5px;
	resize: none;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/main/menu.jsp" />

	<main class="container">
		<a href="${pageContext.request.contextPath}/famous/famous.do"
			style="text-decoration: none; color: #64748b; display: inline-flex; align-items: center; gap: 8px; margin-bottom: 25px;">
			<i data-lucide="arrow-left"></i> 목록으로 돌아가기
		</a>

		<article class="detail-card">
			<header class="detail-header">
				<h2 class="detail-title">${detail.famousAuthor}</h2>
				<div
					style="display: flex; justify-content: space-between; color: #94a3b8; font-size: 0.9rem;">
					<div>
						<span><i data-lucide="user" size="14"></i> ${detail.regId}</span>
						<span style="margin-left: 15px;"><i data-lucide="calendar"
							size="14"></i> ${detail.famousTime}</span>
					</div>
					<span> 조회 ${detail.famousViewcount} <a
						href="${pageContext.request.contextPath}/report/famousReportPage.do?type=famous&id=${detail.famousSid}"
						onclick="window.open(this.href, 'reportPopup', 'width=500,height=700'); return false;"
						style="color: #ef4444; margin-left: 12px; text-decoration: none; font-size: 13px;">🚨신고</a>
					</span>
				</div>
			</header>

			<div class="detail-body">"${detail.famousContent}"</div>

			<div
				style="padding-bottom: 40px; display: flex; flex-direction: column; align-items: center; gap: 20px;">
				<button class="btn-like" id="likeBtn">
					<i data-lucide="heart"></i> <span>${detail.famousReccount}</span>
				</button>
			</div>

			<section class="comments-section"
				style="padding: 40px; border-top: 1px solid #e2e8f0;">
				<div
					style="display: flex; align-items: center; gap: 8px; margin-bottom: 24px;">
					<i data-lucide="message-square" style="color: #6366f1;"></i>
					<h2 style="font-size: 1.25rem; font-weight: 600; margin: 0;">
						댓글 <span style="color: #6366f1;">${fn:length(commentList)}</span>
					</h2>
				</div>

				<div class="comment-form"
					style="background: #f8fafc; border-radius: 12px; padding: 20px; margin-bottom: 30px; border: 1px solid #f1f5f9;">
					<textarea id="commentContent" placeholder="생각을 남겨보세요."
						style="width: 100%; min-height: 100px; padding: 15px; border: 1px solid #e2e8f0; border-radius: 8px; resize: none; margin-bottom: 12px;"></textarea>
					<div style="text-align: right;">
						<button type="button" id="btnCommentSave"
							style="padding: 10px 25px; background: #6366f1; color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: 600;">등록</button>
					</div>
				</div>

				<div class="comments-list">
					<c:forEach var="comment" items="${commentList}">
						<div
							class="comment-item ${comment.parentSid > 0 ? 'reply-item' : ''}"
							style="padding: 15px; border-bottom: 1px solid #f1f5f9;">
							<div style="display: flex; justify-content: space-between;">
								<strong style="color: #1e293b;">${comment.regId}</strong> <span
									style="font-size: 12px; color: #94a3b8;">
									${comment.commentUpdateDate} <a
									href="${pageContext.request.contextPath}/report/famousReportPage.do?type=comment&id=${comment.commentSid}&famousSid=${detail.famousSid}"
									onclick="window.open(this.href, 'reportPopup', 'width=500,height=700'); return false;"
									style="color: #ef4444; margin-left: 12px; text-decoration: none;">🚨신고</a>
								</span>
							</div>
							<div style="margin: 10px 0; color: #475569;">${comment.commentContent}</div>
							<div class="comment-actions">
								<button type="button" class="btn-reply-toggle"
									style="color: #6366f1; cursor: pointer; border: none; background: none; font-size: 13px;">답글</button>
								<c:if test="${sessionScope.loginUser.userId == comment.regId}">
									<button type="button" class="btn-comment-delete"
										data-sid="${comment.commentSid}"
										style="color: #ef4444; cursor: pointer; border: none; background: none; font-size: 13px; margin-left: 10px;">삭제</button>
								</c:if>
							</div>
							<div class="reply-form">
								<textarea class="reply-textarea" placeholder="답글 입력"></textarea>
								<div style="text-align: right;">
									<button type="button" class="btn-reply-save"
										data-parent="${comment.commentSid}"
										style="padding: 5px 12px; background: #6366f1; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 12px;">등록</button>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</section>
		</article>
	</main>

	<script>
		$(document)
				.ready(
						function() {
							lucide.createIcons();
							const famousSid = "${detail.famousSid}";

							// 댓글 저장
							$("#btnCommentSave")
									.on(
											"click",
											function() {
												const content = $(
														"#commentContent")
														.val().trim();
												if (!content)
													return alert("내용을 입력해주세요.");
												$
														.ajax({
															type : "POST",
															url : "${pageContext.request.contextPath}/comment/addComment.do",
															data : {
																"famousSid" : famousSid,
																"commentContent" : content
															},
															success : function() {
																location
																		.reload();
															}
														});
											});

							// 답글 폼 토글
							$(document).on(
									"click",
									".btn-reply-toggle",
									function() {
										$(this).closest(".comment-item").find(
												".reply-form").first()
												.slideToggle(200);
									});

							// 답글 저장
							$(document)
									.on(
											"click",
											".btn-reply-save",
											function() {
												const parentSid = $(this).data(
														"parent");
												const content = $(this)
														.closest(".reply-form")
														.find(".reply-textarea")
														.val().trim();
												if (!content)
													return alert("내용 입력");
												$
														.ajax({
															type : "POST",
															url : "${pageContext.request.contextPath}/comment/addComment.do",
															data : {
																"famousSid" : famousSid,
																"parentSid" : parentSid,
																"commentContent" : content
															},
															success : function() {
																location
																		.reload();
															}
														});
											});

							// 댓글 삭제
							$(document)
									.on(
											"click",
											".btn-comment-delete",
											function() {
												if (!confirm("삭제하시겠습니까?"))
													return;
												$
														.ajax({
															type : "POST",
															url : "${pageContext.request.contextPath}/comment/doDelete.do",
															data : {
																"commentSid" : $(
																		this)
																		.data(
																				"sid")
															},
															success : function() {
																location
																		.reload();
															}
														});
											});
						});
	</script>
</body>
</html>