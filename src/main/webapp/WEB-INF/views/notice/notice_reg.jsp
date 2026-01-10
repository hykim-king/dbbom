<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>내면의 흔적 - 공지사항 작성</title>
    <script src="https://unpkg.com/lucide@latest"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/notice.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .reg-container { background: white; padding: 30px; border-radius: 12px; border: 1px solid #e2e8f0; }
        .form-group { margin-bottom: 20px; }
        .form-label { display: block; margin-bottom: 8px; font-weight: 600; color: #475569; }
        .form-control { width: 100%; padding: 12px; border: 1px solid #e2e8f0; border-radius: 8px; font-size: 1rem; box-sizing: border-box; }
        .btn-save { background-color: #10b981; color: white; padding: 10px 20px; border: none; border-radius: 8px; cursor: pointer; font-weight: bold; display: flex; align-items: center; gap: 6px; }
        .btn-cancel { background-color: #f1f5f9; color: #64748b; padding: 10px 20px; border: none; border-radius: 8px; cursor: pointer; font-weight: bold; text-decoration: none; font-size: 0.9rem; }
    </style>
</head>
<body>
    <main class="container">

      <div class="tab-content">
        <div class="reg-container">
          <h3 class="section-title">
            <i data-lucide="pen-tool"></i> 공지사항 작성
          </h3>
          <hr style="margin: 10px 0 20px 0; border-color:#f1f5f9;">
          
          <form id="saveForm">
            <div class="form-group">
              <label class="form-label">제목</label>
              <input type="text" id="noticeTitle" name="noticeTitle" class="form-control" placeholder="공지사항 제목을 입력하세요">
            </div>
            <div class="form-group">
              <label class="form-label">내용</label>
              <textarea id="noticeContent" name="noticeContent" class="form-control" rows="15" placeholder="공지사항 상세 내용을 입력하세요"></textarea>
            </div>
            
            <div style="display: flex; justify-content: flex-end; gap: 10px; margin-top: 20px;">
              <a href="${pageContext.request.contextPath}/notice/noticeList.do" class="btn-cancel">취소</a>
              <button type="button" id="doSaveBtn" class="btn-save">
                <i data-lucide="check" style="width: 16px;"></i> 등록하기
              </button>
            </div>
          </form>
        </div>
      </div>
    </main>

    <script>
        lucide.createIcons();

        $(document).ready(function() {
            $("#doSaveBtn").on("click", function() {
                const title = $("#noticeTitle").val();
                const content = $("#noticeContent").val();

                if(!title) { alert("제목을 입력하세요."); return; }
                if(!content) { alert("내용을 입력하세요."); return; }

                if(!confirm("공지사항을 등록하시겠습니까?")) return;

                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/notice/doSave.do",
                    data: {
                        "noticeTitle": title,
                        "noticeContent": content
                    },
                    success: function(data) {
                        // 서버 응답 처리 (성공 시 리스트로 이동)
                        if(data.status === "success" || data.flag === "1") {
                            alert("공지사항이 등록되었습니다.");
                            location.href = "${pageContext.request.contextPath}/notice/noticeList.do";
                        } else {
                            alert(data.msg || "등록에 실패했습니다.");
                        }
                    },
                    error: function() {
                        alert("서버와 통신 중 오류가 발생했습니다.");
                    }
                });
            });
        });
    </script>
</body>
</html>