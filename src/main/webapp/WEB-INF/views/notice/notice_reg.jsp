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
    </style>
    
    <jsp:include page="/WEB-INF/views/main/menu.jsp" />
</head>
<body>
    <main class="container">
        <div class="tab-content">
            <div class="reg-container">
                <h3 class="section-title">
                    <i data-lucide="megaphone"></i> <c:choose>
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
    // 아이콘 생성
    lucide.createIcons();

    $(document).ready(function() {
        console.log("JSP 로드 완료 - 버튼 이벤트 대기 중");

        $("#doSaveBtn").on("click", function() {
            console.log("버튼 클릭됨");

            // 1. 데이터 가져오기
            const sid = $("#noticeSid").val();
            const title = $("#noticeTitle").val();
            const content = $("#noticeContent").val();
            
            console.log("데이터 확인:", { sid, title, content });

            // 2. 유효성 검사
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

            // 3. 등록/수정 구분
            const isUpdate = (sid !== null && sid !== "" && sid !== "0");
            const url = isUpdate ? "${pageContext.request.contextPath}/notice/doUpdate.do" 
                                 : "${pageContext.request.contextPath}/notice/doSave.do";
            const confirmMsg = isUpdate ? "공지사항을 수정하시겠습니까?" : "공지사항을 등록하시겠습니까?";

            if(!confirm(confirmMsg)) return;

            // 4. Ajax 전송
            $.ajax({
                type: "POST",
                url: url,
                dataType: "json", // 응답 형식을 JSON으로 강제
                data: {
                    "noticeSid": isUpdate ? parseInt(sid) : 0,
                    "noticeTitle": title,
                    "noticeContent": content
                },
                success: function(data) {
                    console.log("서버 응답:", data);
                    // 컨트롤러 리턴 타입에 맞춰 분기 (status 또는 flag)
                    if(data.status === "success" || data.flag == 1) {
                        alert(isUpdate ? "수정되었습니다." : "등록되었습니다.");
                        location.href = "${pageContext.request.contextPath}/notice/noticeList.do";
                    } else {
                        alert(data.msg || "처리에 실패했습니다.");
                    }
                },
                error: function(xhr, status, error) {
                    console.error("에러 발생:", error);
                    alert("서버와 통신 중 오류가 발생했습니다. 이클립스 콘솔을 확인하세요.");
                }
            });
        });
    });
</script>
</body>
</html>