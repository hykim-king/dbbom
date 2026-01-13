<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>내면의 흔적 - 공지사항 <c:choose><c:when test="${not empty vo.noticeSid}">수정</c:when><c:otherwise>작성</c:otherwise></c:choose></title>
    
    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/notice.css" />
    
<style>
    /* 1. 헤더 영역 강제 고정 및 투명도 제거 */
    /* menu.jsp 내부의 실제 태그를 모두 타겟팅합니다. */
    header, 
    .menu-container, 
    nav {
        position: fixed !important;
        top: 0 !important;
        left: 0 !important;
        width: 100% !important;
        z-index: 99999 !important; /* 최상위 보장 */
        background-color: #ffffff !important; /* 배경을 불투명하게 흰색으로 설정 */
        border-bottom: 1px solid #e2e8f0 !important;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1) !important;
    }

    /* 2. 본문 컨테이너: 헤더에 가려지지 않게 여백 확보 */
    body {
        /* 헤더가 고정이므로 body 전체에 여백을 주어 밀려 내려오게 함 */
        padding-top: 100px !important; 
    }

    body main.container {
        position: relative !important;
        z-index: 1 !important; /* 헤더보다 낮게 설정 */
        display: block !important;
        margin-top: 20px !important;
    }

    /* 3. 공지사항 카드 설정 */
    .reg-container {
        background: #ffffff !important;
        position: relative !important;
        z-index: 1 !important; 
        overflow: hidden; /* 내부 요소가 튀어나오지 않게 함 */
    }

    /* 4. 헤더 안의 링크나 텍스트가 겹치지 않게 배경 강제 */
    .menu-container *, header * {
        background-color: transparent !important; /* 개별 요소는 투명하게 하되 부모인 header가 흰색을 유지 */
    }
</style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/main/menu.jsp" />
    
    <main class="container">
        <div class="tab-content">
            <div class="reg-container">
                <h3 class="section-title">
                    <i data-lucide="megaphone"></i> 
                    <c:choose>
                        <c:when test="${not empty vo.noticeSid}">공지사항 수정</c:when>
                        <c:otherwise>공지사항 작성</c:otherwise>
                    </c:choose>
                </h3>
                <hr style="margin: 20px 0 30px 0; border: 0; border-top: 1px solid #f1f5f9;">
                
                <form id="saveForm">
                    <input type="hidden" id="noticeSid" name="noticeSid" value="${vo.noticeSid}">
                    
                    <div class="form-group">
                        <label class="form-label">제목</label>
                        <input type="text" id="noticeTitle" name="noticeTitle" class="form-control" 
                               placeholder="공지사항 제목을 입력하세요" value="${vo.noticeTitle}" maxlength="30">
                    </div>
                    <div class="form-group">
                        <label class="form-label">내용</label>
                        <textarea id="noticeContent" name="noticeContent" class="form-control" 
                                  rows="15" placeholder="공지사항 상세 내용을 입력하세요">${vo.noticeContent}</textarea>
                    </div>
                    
                    <div style="display: flex; justify-content: flex-end; gap: 12px; margin-top: 30px;">
                        <a href="${pageContext.request.contextPath}/notice/noticeList.do" class="btn-cancel">취소</a>
                        <button type="button" id="doSaveBtn" class="btn-save">
                            <i data-lucide="check" style="width: 18px;"></i> 
                            <c:choose>
                                <c:when test="${not empty vo.noticeSid}">수정완료</c:when>
                                <c:otherwise>등록하기</c:otherwise>
                            </c:choose>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </main>

<script>
    lucide.createIcons();
    // ... 이하 기존 스크립트와 동일
    $(document).ready(function() {
        $("#doSaveBtn").on("click", function() {
            const sid = $("#noticeSid").val();
            const title = $("#noticeTitle").val();
            const content = $("#noticeContent").val();
            
            if(!title || title.trim() === "") { 
                alert("제목을 입력하세요."); 
                $("#noticeTitle").focus();
                return; 
            }
            if(!content || content.trim() === "") { 
                alert("내용을 입력하세요."); 
                $("#noticeContent").focus();
                return; 
            }

            const isUpdate = (sid !== null && sid !== "" && sid !== "0");
            const url = isUpdate ? "${pageContext.request.contextPath}/notice/doUpdate.do" 
                                 : "${pageContext.request.contextPath}/notice/doSave.do";
            const confirmMsg = isUpdate ? "공지사항을 수정하시겠습니까?" : "공지사항을 등록하시겠습니까?";

            if(!confirm(confirmMsg)) return;

            $.ajax({
                type: "POST",
                url: url,
                dataType: "json",
                data: {
                    "noticeSid": isUpdate ? parseInt(sid) : 0,
                    "noticeTitle": title,
                    "noticeContent": content
                },
                success: function(data) {
                    if(data.status === "success" || data.flag == 1) {
                        alert(isUpdate ? "수정되었습니다." : "등록되었습니다.");
                        location.href = "${pageContext.request.contextPath}/notice/noticeList.do";
                    } else {
                        alert(data.msg || "처리에 실패했습니다.");
                    }
                },
                error: function(xhr, status, error) {
                    alert("서버와 통신 중 오류가 발생했습니다.");
                }
            });
        });
    });
</script>
</body>
</html>