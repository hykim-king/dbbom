<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>내면의 흔적 - 게시글 상세보기</title>
<script src="https://unpkg.com/lucide@latest"></script>
<script
	src="${pageContext.request.contextPath}/resources/assets/js/cmn/jquery.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/diary_detail_board.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/common.css" "/>

<%-- <script src="${pageContext.request.contextPath}/resources/assets/js/diary_detail_board.js"></script> --%>

<style>
/* 1. 메뉴 컨테이너: 상하 높이를 충분히 확보 */
.menu-container .tab-list {
	display: flex !important;
	flex-direction: row !important;
	align-items: center !important;
	justify-content: space-around !important;
	/* 두 번째 사진과 같은 깊이감을 위해 상하 패딩 조정 */
	padding: 8px 30px !important;
	min-height: 50px !important; /* 전체적인 바 두께 확정 */
	max-width: 1000px !important;
	margin: 0 auto !important;
	
	
/*===========================추가_20260114_11:09==============================*/
	position: sticky; /* 스크롤 시 상단에 고정 */
	top: 0; /* 최상단에 붙음 */
	z-index: 1000; /* 다른 요소보다 위에 보이도록 설정 */
	background-color: #f8fafc; /* 배경색을 주어 본문 글씨와 겹치지 않게 함 */
}

/*========================추가_20260114_11:09=======================================*/
.menu-container .tab-list {
	display: flex !important;
	flex-direction: row !important;
	align-items: center !important;
	justify-content: space-around !important;
	/* 두 번째 사진과 같은 깊이감을 위해 상하 패딩 조정 */
	padding: 8px 30px !important;
	min-height: 50px !important; /* 전체적인 바 두께 확정 */
	max-width: 1000px !important;
	margin: 0 auto !important;
}

/* 2. 모든 버튼 및 라벨: 가로 배열 강제 및 줄바꿈 방지 */
.menu-container .menu-label, .menu-container .tab-list .tab-btn,
	.menu-container .tab-list .dropdown-container, .menu-container .dropdown-btn
	{
	display: flex !important;
	flex-direction: row !important; /* 아이콘과 글자를 무조건 가로로 */
	align-items: center !important;
	justify-content: center !important;
	white-space: nowrap !important; /* 텍스트 꺾임 방지 핵심 */
	width: auto !important; /* 너비 자동 확장 */
	gap: 10px !important; /* 아이콘과 글자 사이 간격 */
	flex-shrink: 0 !important; /* 좁아져도 찌그러지지 않게 함 */
}

/* 3. 텍스트 요소들 개별 설정 */
.menu-container .tab-list span, .menu-container .menu-label {
	display: inline-block !important;
	line-height: 1 !important; /* 줄 간격 때문에 생기는 세로 느낌 제거 */
	font-size: 15px !important;
	margin: 0 !important;
}

/* 4. '메뉴' 라벨 전용 (왼쪽 고정 느낌) */
.menu-container .menu-label {
	font-weight: 800 !important;
	margin-right: 15px !important;
}

/* 답글 들여쓰기 스타일 */
.reply-item { margin-left: 40px; border-left: 2px solid #eee; padding-left: 15px; background-color: #fafafa; }
.reply-form { display: none; margin-top: 10px; padding: 10px; background: #f8f9fa; border-radius: 5px; }
.reply-textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; resize: none; margin-bottom: 5px; }
</style>
<script>
      $(document).ready(function() {
        // 좋아요 상태 복구
        const diarySid = '${diaryVO.diarySid}';
        const likeKey = 'diary_liked_' + diarySid;
        let isRecommended = localStorage.getItem(likeKey) === 'true';
        if (isRecommended) {
          $('#likeBtn').addClass('active');
          $('#heartIcon').attr({ fill: '#ef4444', stroke: '#ef4444' });
        }
        if (typeof lucide !== 'undefined') {
          lucide.createIcons();
        }
        // 좋아요 버튼 클릭
        $(document).off('click', '#likeBtn').on('click', '#likeBtn', function(e) {
          e.stopPropagation();
          // 로그인 체크 (sessionScope.loginUser는 객체)
          const loginUser = "${sessionScope.loginUser}";
          if (loginUser === null || loginUser === '' || loginUser === 'undefined') {
            if (confirm('좋아요는 로그인 후에 가능합니다.\n로그인 페이지로 이동하시겠습니까?')) {
              location.href = "${pageContext.request.contextPath}/user/signIn.do";
            }
            return;
          }
          // 서버 전송 후 UI 변경
          $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/diary/updateRecCount.do',
            data: { diarySid: diarySid },
            dataType: 'text',
            success: function(data) {
              if (data === 'LOGIN_REQUIRED') {
                alert('로그인이 필요합니다.');
                return;
              } else if (data.indexOf('TIME_LIMIT') > -1) {
                let remaining = data.split(':')[1];
                alert('이미 추천하셨습니다. ' + remaining + '분 후에 다시 가능합니다.');
                return;
              } else if (data === 'ERROR') {
                alert('추천 처리 중 오류가 발생했습니다.');
                return;
              } else {
                // 정상적으로 추천수가 리턴된 경우 (성공)
                $('#likeCount').text(data);
                if (!isRecommended) {
                  $('#likeBtn').addClass('active');
                  $('#heartIcon').attr({ fill: '#ef4444', stroke: '#ef4444' });
                  localStorage.setItem(likeKey, 'true');
                  isRecommended = true;
                  alert('추천되었습니다.');
                } 
                <%-- else {
                  $('#likeBtn').removeClass('active');
                  $('#heartIcon').attr({ fill: 'none', stroke: 'currentColor' });
                  localStorage.removeItem(likeKey);
                  isRecommended = false;
                  alert('추천이 취소되었습니다.');
                } --%>
              }
            },
            error: function() {
              alert('추천 처리 중 오류가 발생했습니다.');
            }
          });
        });
//--------------------------------------------
        // --- [답글 기능 로직] 공통 저장 함수 ---
        function saveComment(formObj) {
            // 일반 input(text) 혹은 textarea 모두 대응 가능하도록 find 처리
            const content = formObj.find('input[name="commentContent"], textarea[name="commentContent"]').val();
            
            if(!content || content.trim() === '') {
                alert('내용을 입력해주세요.');
                return;
            }

            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/comment/addComment.do",
                data: formObj.serialize(),
                success: function(res) {
                    if(typeof res === 'string') { try { res = JSON.parse(res); } catch(e) {} }
                    if(res.flag === 1) {
                        alert("등록되었습니다.");
                        location.reload();
                    } else {
                        alert(res.message);
                    }
                },
                error: function() { alert("서버 통신 오류가 발생했습니다."); }
            });
        }

        // 1. 일반 댓글 저장
        $('#btnCommentSave').on('click', function() {
            saveComment($('#commentForm'));
        });

        // 2. 답글 버튼 클릭 시 폼 토글
        $(document).on('click', '.btn-reply-toggle', function() {
            $(this).closest('.comment-item').find('.reply-form').first().slideToggle();
        });

        // 3. 답글 저장 버튼
        $(document).on('click', '.btn-reply-save', function() {
            const form = $(this).closest('form');
            saveComment(form);
        });







      });


	        // --- [기존 기능] 댓글 삭제 함수 ---
      function deleteComment(commentSid) {
          if (confirm("댓글을 삭제하시겠습니까?")) {
              $.ajax({
                  type: "POST",
                  url: "${pageContext.request.contextPath}/comment/doDelete.do",
                  data: { "commentSid": commentSid },
                  success: function(res) {
                      if(typeof res === 'string') res = JSON.parse(res);
                      if (res.flag === 1) {
                          alert(res.message);
                          location.reload();
                      } else {
                          alert(res.message);
                      }
                  },
                  error: function() { alert("서버 통신 오류가 발생했습니다."); }
              });
          }
      }
	  
    </script>
<%-- <jsp:include page="/WEB-INF/views/main/menu.jsp" /> --%>
</head>
<body style="background-color: #f8fafc;">
	<div class="menu-container">
		<jsp:include page="/WEB-INF/views/main/menu.jsp" />
	</div>
	<main class="container"
		style="max-width: 1200px; margin: 0 auto; padding: 0 20px;">

		<div style="flex: 1;">
			<a href="${pageContext.request.contextPath}/diary/diaryList.do"
				class="back-btn"
				style="text-decoration: none; color: #64748b; display: inline-flex; align-items: center; margin: 15px 0;">
				<i data-lucide="arrow-left" style="width: 18px; margin-right: 5px;"></i>
				목록으로 돌아가기
			</a>
			<article class="detail-card"
				style="background: white; border-radius: 15px; padding: 40px; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);">
				<header
					style="border-bottom: 1px solid #f1f5f9; padding-bottom: 25px; margin-bottom: 30px;">

					<span class="post-tag gratitude">${diaryVO.diaryCategoryName}</span>
					<h2 class="detail-title">${diaryVO.diaryTitle}</h2>
					<div class="detail-meta-row">
						<div class="meta-left">
							<span class="meta-item"><i data-lucide="user" size="16"></i>
								${diaryVO.nickname}</span> <span class="meta-item"><i
								data-lucide="calendar" size="16"></i> ${diaryVO.diaryUploadDate}</span>
						</div>
						<div class="meta-left">
							<span class="meta-item"><i data-lucide="eye" size="16"></i>
								조회 ${diaryVO.diaryViewCount}</span>

							<!-- 디버깅용: 로그인 유저와 게시글 작성자 정보 출력 -->
							<%-- <div style="color:red; font-size:12px;">
                  [DEBUG] loginUser.userId: ${sessionScope.loginUser.userId}, regId: ${diaryVO.regId}
                </div> --%>
							<c:if
								test="${sessionScope.loginUser ne null and sessionScope.loginUser.userId eq diaryVO.regId}">
								<a
									href="${pageContext.request.contextPath}/diary/diaryUpdateForm.do?diarySid=${diaryVO.diarySid}"
									class="btn-action-text"
									style="margin-left: 16px; font-size: 14px; color: #3b82f6; text-decoration: none;">수정</a>
							</c:if>

							<%-- <button class="btn-action-text" onclick="reportContent('diary', '${diaryVO.diarySid}')" style="font-size:13px; cursor:pointer; background:none; border:none; color:#ef4444; padding:0; margin-left:12px;">신고</button> --%>
							<a class="btn-action-text"
								href="${pageContext.request.contextPath}/report/reportPage.do?type=diary&id=${diaryVO.diarySid}"
								onclick="window.open(this.href, 'reportPopup', 'width=500,height=700,scrollbars=yes'); return false;"
								style="font-size: 13px; cursor: pointer; background: none; border: none; color: #ef4444; padding: 0; margin-left: 12px; text-decoration: none;">🚨신고</a>
						</div>
					</div>
				</header>

				<div class="detail-body">${fn:trim(diaryVO.diaryContent)}</div>

				<div class="action-buttons">
					<button class="btn-like" id="likeBtn">
						<i data-lucide="heart" id="heartIcon"></i> <span id="likeCount">${diaryVO.diaryRecCount}</span>
					</button>

				</div>

            <section class="comment-section">
                <div class="comment-header" style="margin-bottom: 20px; font-weight: bold;">
                    <i data-lucide="message-circle" size="20"></i> 전체 댓글 
                    <span id="commentCount" style="color: #6366f1;">${fn:length(commentList)}</span>
                </div>

                <form id="commentForm" class="comment-form" style="margin-bottom: 30px;">
                    <input type="hidden" name="diarySid" value="${diaryVO.diarySid}">
                    <div style="display: flex; gap: 10px;">
                        <input type="text" name="commentContent" id="commentInput" 
                               placeholder="따뜻한 댓글을 남겨주세요." style="flex: 1; padding: 10px; border: 1px solid #ddd; border-radius: 5px;">
                        <button type="button" id="btnCommentSave" style="padding: 10px 20px; background: #6366f1; color: white; border: none; border-radius: 5px; cursor: pointer;">등록</button>
                    </div>
                </form>

                <div class="comment-list" id="commentListArea">
                    <c:choose>
                        <c:when test="${not empty commentList}">
                            <c:forEach var="comment" items="${commentList}">
                                <div class="comment-item ${comment.parentSid != null ? 'reply-item' : ''}" style="padding: 15px 0; border-bottom: 1px solid #f1f5f9;">
                                    <div style="display: flex; justify-content: space-between; margin-bottom: 5px;">
                                        <span class="comment-user" style="font-weight: 600; color: #334155;">
                                            <c:if test="${comment.parentSid != null}"><i data-lucide="corner-down-right" size="14"></i> </c:if>
                                            ${comment.nickname}
                                        </span>
                                        <span class="comment-date" style="font-size: 12px; color: #94a3b8;">
                                            <fmt:formatDate value="${comment.commentUpdateDate}" pattern="yyyy-MM-dd HH:mm"/>

                                                                                    							<a class="btn-action-text"
								href="${pageContext.request.contextPath}/report/commentReportPage.do?type=comment&id=${comment.commentSid}"
								onclick="window.open(this.href, 'reportPopup', 'width=500,height=700,scrollbars=yes'); return false;"
								style="font-size: 13px; cursor: pointer; background: none; border: none; color: #ef4444; padding: 0; margin-left: 12px; text-decoration: none;">🚨신고</a>
                                        </span>

                                    </div>
                                    <p class="comment-text" style="color: #475569; margin: 0;">${comment.commentContent}</p>

                                    <div style="text-align: right; margin-top: 10px; display: flex; justify-content: flex-end; gap: 8px;">
                                        <c:if test="${comment.parentSid == null}">
                                            <button type="button" class="btn-reply-toggle"
                                                style="padding: 5px 12px; background: #6366f1; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 12px;">
                                                답글</button>
                                        </c:if>
                                        
                                        <c:if test="${sessionScope.loginUser.userId == comment.regId}">
                                            <button type="button" onclick="deleteComment(${comment.commentSid})"
                                                style="padding: 5px 12px; background: #ef4444; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 12px;">
                                                삭제</button>
                                        </c:if>
                                    </div>

                                    <div class="reply-form">
                                        <form>
                                            <input type="hidden" name="diarySid" value="${diaryVO.diarySid}">
                                            <input type="hidden" name="parentSid" value="${comment.commentSid}">
                                            <textarea name="commentContent" class="reply-textarea" placeholder="답글을 남겨보세요"></textarea>
                                            <div style="text-align: right;">
                                                <button type="button" class="btn-reply-save" style="padding: 5px 12px; background: #6366f1; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 12px;">등록</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p style="text-align: center; color: #94a3b8; padding: 20px;">등록된 댓글이 없습니다.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </section>
			</article>
		</div>
	</main>

	<footer>
		<div class="container">
			<p>© 2024 내면의 흔적. All rights reserved.</p>
		</div>
	</footer>


	<script>
      // Lucide 아이콘 전체 렌더링 (body 끝에서 한 번만 실행)
      document.addEventListener('DOMContentLoaded', function() {
        if (typeof lucide !== 'undefined') {
          lucide.createIcons();
        }
      });
    </script>


</body>
</html>