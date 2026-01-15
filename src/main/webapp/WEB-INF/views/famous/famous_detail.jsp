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

/* 좋아요 버튼 디자인 */
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
   box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05) !important;
}

.btn-like.active {
   background: #fff1f2 !important;
   border-color: #fda4af !important;
   color: #e11d48 !important;
}

.btn-like:hover {
   transform: translateY(-2px);
   box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1) !important;
}

#heartIcon {
   width: 20px;
   height: 20px;
   transition: all 0.2s ease;
}

/* 댓글/답글 디자인 보정 */
.reply-item {
   margin-left: 40px !important; /* 오른쪽으로 들여쓰기 */
   background-color: #f9fafb; /* 일반 댓글과 구분되는 연한 배경색 */
   border-left: 2px solid #e5e7eb; /* 왼쪽에 구분선 추가 */
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
         class="back-btn"> <i data-lucide="arrow-left"></i> 목록으로 돌아가기
      </a>

      <article class="detail-card">
         <header class="detail-header">
            <span
               class="post-tag ${fn:trim(detail.famousEmotion) eq 'P' ? 'gratitude' : 'emotion'}">
               <i
               data-lucide="${fn:trim(detail.famousEmotion) eq 'P' ? 'sun' : 'moon'}"></i>
            </span>
            <h2 class="detail-title">${detail.famousAuthor}</h2>
            <div
               style="display: flex; justify-content: space-between; color: #94a3b8; font-size: 0.9rem;">
               <div>
                  <span><i data-lucide="user" size="14"></i> ${detail.regId}</span>
                  <span style="margin-left: 15px;"><i data-lucide="calendar"
                     size="14"></i> ${detail.famousTime}</span>
               </div>
               <span><i data-lucide="eye" size="14"></i> 조회
                  ${detail.famousViewcount} <%-- [원문 신고] famousSid 전달 --%> <a
                  class="btn-action-text"
                  href="${pageContext.request.contextPath}/report/famousReportPage.do?id=${detail.famousSid}"
                  onclick="window.open(this.href, 'reportPopup', 'width=500,height=700,scrollbars=yes'); return false;"
                  style="font-size: 13px; cursor: pointer; background: none; border: none; color: #ef4444; padding: 0; margin-left: 12px; text-decoration: none;">🚨원문
                     신고</a> </span>
            </div>
         </header>

         <div class="detail-body">"${detail.famousContent}"</div>

         <div
            style="padding-bottom: 40px; display: flex; flex-direction: column; align-items: center; gap: 20px;">
            <button class="btn-like" id="likeBtn">
               <i data-lucide="heart" id="heartIcon"></i> <span id="likeCount">${detail.famousReccount}</span>
            </button>

            <c:if
               test="${not empty sessionUser && (sessionUser.userId == detail.regId || sessionUser.adminChk == '1')}">
               <div style="display: flex; gap: 10px;">
                  <button id="btnUpdate"
                     style="background: #4a90e2; color: white; border: none; padding: 10px 20px; border-radius: 8px; cursor: pointer;">수정</button>
                  <button id="btnDelete"
                     style="background: #e74c3c; color: white; border: none; padding: 10px 20px; border-radius: 8px; cursor: pointer;">삭제</button>
               </div>
            </c:if>
         </div>

         <section class="comments-section"
            style="margin-top: 50px; border-top: 1px solid #e2e8f0; padding-top: 40px;">
            <div
               style="display: flex; align-items: center; gap: 8px; margin-bottom: 24px;">
               <i data-lucide="message-square"
                  style="width: 24px; height: 24px; color: #6366f1;"></i>
               <h2
                  style="font-size: 1.25rem; font-weight: 600; color: #1e293b; margin: 0;">
                  전체 댓글 <span style="color: #6366f1;">${fn:length(commentList)}</span>
               </h2>
            </div>

            <div class="comment-form"
               style="background: #f8fafc; border-radius: 12px; padding: 20px; margin-bottom: 30px; border: 1px solid #f1f5f9;">
               <textarea id="commentContent"
                  placeholder="이 명언에 대한 생각을 자유롭게 남겨주세요."
                  style="width: 100%; min-height: 100px; padding: 15px; border: 1px solid #e2e8f0; border-radius: 8px; resize: none; margin-bottom: 12px; font-size: 15px;"></textarea>
               <div style="text-align: right;">
                  <button type="button" id="btnCommentSave"
                     class="btn-reply-save-action"
                     style="padding: 12px 30px; background: #6366f1; color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: 600;">댓글
                     등록</button>
               </div>
            </div>

            <div class="comments-list">
               <c:choose>
                  <c:when test="${not empty commentList}">
                     <c:forEach var="comment" items="${commentList}">
                        <div
                           class="comment-item ${comment.parentSid > 0 ? 'reply-item' : ''}"
                           style="padding: 15px; border-bottom: 1px solid #f1f5f9;">

                           <div class="comment-header"
                              style="display: flex; justify-content: space-between; margin-bottom: 8px;">
                              <span class="comment-author"
                                 style="font-weight: 600; color: #1e293b;">
                                 ${comment.regId} </span> <span class="comment-date"
                                 style="font-size: 12px; color: #94a3b8;">
                                 ${comment.commentUpdateDate} <%-- [수정] 댓글 신고 시 명언번호가 아닌 댓글번호(comment.commentSid)를 'id' 파라미터로 전달 --%>
                                 <a class="btn-action-text"
                                 href="${pageContext.request.contextPath}/report/commentReportPage.do?id=${comment.commentSid}"
                                 onclick="window.open(this.href, 'reportPopup', 'width=500,height=700,scrollbars=yes'); return false;"
                                 style="font-size: 13px; cursor: pointer; background: none; border: none; color: #ef4444; padding: 0; margin-left: 12px; text-decoration: none;">🚨신고</a>
                              </span>
                           </div>

                           <div class="comment-content"
                              style="color: #475569; line-height: 1.5; margin-bottom: 10px;">
                              ${comment.commentContent}</div>

                           <div class="comment-actions" style="display: flex; gap: 15px;">
                              <button type="button" class="btn-reply-toggle"
                                 style="color: #6366f1; cursor: pointer; border: none; background: none; font-size: 13px;">답글</button>

                              <c:if test="${sessionScope.loginUser.userId == comment.regId}">
                                 <button type="button" class="btn-comment-delete"
                                    data-sid="${comment.commentSid}"
                                    style="color: #ef4444; cursor: pointer; border: none; background: none; font-size: 13px;">삭제</button>
                              </c:if>
                           </div>

                           <div class="reply-form"
                              style="display: none; margin-top: 10px;">
                              <textarea class="reply-textarea" placeholder="답글을 남겨보세요"></textarea>
                              <div style="text-align: right;">
                                 <button type="button" class="btn-reply-save"
                                    data-parent="${comment.commentSid}"
                                    style="padding: 5px 12px; background: #6366f1; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 12px;">등록</button>
                              </div>
                           </div>
                        </div>
                     </c:forEach>
                  </c:when>
                  <c:otherwise>
                     <div
                        style="text-align: center; padding: 60px 0; color: #94a3b8; font-size: 15px;">첫
                        번째 댓글의 주인공이 되어보세요!</div>
                  </c:otherwise>
               </c:choose>
            </div>
         </section>
      </article>
   </main>
<script>
    $(document).ready(function() {
      // 1. 초기 UI 및 아이콘 렌더링
      lucide.createIcons();

      // 2. 주요 변수 설정
      const famousSid = "${detail.famousSid}";
      const loginUserId = "${sessionScope.loginUser.userId}";

      // 3. 좋아요 상태 복구 (localStorage 이용)
      let isRecommended = localStorage.getItem("famous_liked_" + famousSid) === "true";
      if (isRecommended) {
        $("#likeBtn").addClass("active");
        $("#heartIcon").attr({
          "fill" : "#ef4444",
          "stroke" : "#ef4444"
        });
        $("#likeBtn").css("color", "#ef4444");
      }

      // 4. 좋아요 클릭 (AJAX) - ID 기반으로 수정
      $("#likeBtn").on("click", function(e) {
        e.preventDefault();
        
        // 로그인 체크
        if (!loginUserId || loginUserId === "") {
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
            if (res === "LOGIN_REQUIRED") {
              alert("로그인이 필요합니다.");
            } else if (res.includes("TIME_LIMIT")) {
              alert("이미 추천하셨습니다. " + res.split(":")[1] + "분 후에 다시 가능합니다.");
            } else if (res === "ERROR") {
              alert("처리 중 오류가 발생했습니다.");
            } else {
              // 성공 시 카운트 업데이트
              $("#likeCount").text(res);
              
              // UI 상태 변경
              if (!isRecommended) {
                $("#likeBtn").addClass("active");
                $("#heartIcon").attr({"fill": "#ef4444", "stroke": "#ef4444"});
                $("#likeBtn").css("color", "#ef4444");
                localStorage.setItem("famous_liked_" + famousSid, "true");
                isRecommended = true;
                alert("추천되었습니다!");
              }
              lucide.createIcons();
            }
          },
          error: function() { 
            alert("통신 오류가 발생했습니다."); 
          }
        });
      });

      // 5. 일반 댓글 등록
      $("#btnCommentSave").on("click", function() {
        const content = $("#commentContent").val().trim();
        if (!content) {
          alert("내용을 입력해주세요.");
          return;
        }
        $.ajax({
          type : "POST",
          url : "${pageContext.request.contextPath}/comment/addComment.do",
          data : {
            "famousSid" : famousSid,
            "commentContent" : content
          },
          success : function(res) {
            const data = (typeof res === "string") ? JSON.parse(res) : res;
            if (data.flag == 1) location.reload();
            else alert(data.message);
          }
        });
      });

      // 6. 답글 폼 토글
      $(document).on("click", ".btn-reply-toggle", function() {
        $(this).closest(".comment-item").find(".reply-form").first().slideToggle(200);
      });

      // 7. 답글 저장
      $(document).on("click", ".btn-reply-save", function() {
        const parentSid = $(this).data("parent");
        const $replyForm = $(this).closest(".reply-form");
        const content = $replyForm.find(".reply-textarea").val().trim();
        if (!content) {
          alert("답글을 입력해주세요.");
          return;
        }
        $.ajax({
          type : "POST",
          url : "${pageContext.request.contextPath}/comment/addComment.do",
          data : {
            "famousSid" : famousSid,
            "parentSid" : parentSid,
            "commentContent" : content
          },
          success : function(res) {
            const data = (typeof res === "string") ? JSON.parse(res) : res;
            if (data.flag == 1) location.reload();
            else alert(data.message);
          }
        });
      });

      // 8. 댓글 삭제
      $(document).on("click", ".btn-comment-delete", function() {
        if (!confirm("정말 삭제하시겠습니까?")) return;
        const commentSid = $(this).data("sid");
        $.ajax({
          type : "POST",
          url : "${pageContext.request.contextPath}/comment/doDelete.do",
          data : { "commentSid" : commentSid },
          success : function(res) {
            const data = (typeof res === "string") ? JSON.parse(res) : res;
            if (data.flag == 1) location.reload();
            else alert(data.message);
          }
        });
      });

      // 9. 수정/삭제 버튼 (게시글)
      $("#btnUpdate").on("click", function() {
        location.href = "${pageContext.request.contextPath}/famous/moveToUpdate.do?famousSid=" + famousSid;
      });

      $("#btnDelete").on("click", function() {
        if (confirm("정말 이 명언을 삭제하시겠습니까?")) {
          $.ajax({
            type : "POST",
            url : "${pageContext.request.contextPath}/famous/doDelete.do",
            data : { "famousSid" : famousSid },
            success : function(res) {
              if (res == "1" || res.flag == "1") {
                alert("삭제되었습니다.");
                location.href = "${pageContext.request.contextPath}/famous/famous.do";
              } else {
                alert("삭제 실패: 권한이 없거나 오류가 발생했습니다.");
              }
            }
          });
        }
      });
    }); // end of ready
  </script>
</body>
</html>