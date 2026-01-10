<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>내면의 흔적 - 공지사항 상세보기</title>

    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/notice.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/notice_detail_board.css" />
    
    <style>
        /* 목록 버튼 커스텀 디자인 */
        .btn-list-container {
            margin-top: 40px;
            padding-top: 25px;
            border-top: 1px solid #f1f5f9;
            display: flex;
            justify-content: flex-end;
        }

        .btn-list-view {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 22px;
            background-color: #f8fafc; /* 연한 회색 배경 */
            color: #475569; /* 텍스트 색상 */
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            font-size: 0.95rem;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
        }

        .btn-list-view:hover {
            background-color: #f1f5f9;
            color: #1e293b;
            border-color: #cbd5e1;
            transform: translateY(-2px); /* 호버 시 살짝 위로 이동 */
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        .btn-list-view i {
            width: 16px;
            height: 16px;
            transition: transform 0.2s ease;
        }

        .btn-list-view:hover i {
            transform: translateX(-3px); /* 호버 시 아이콘 왼쪽으로 이동 */
        }
    </style>
    <jsp:include page="/WEB-INF/views/main/menu.jsp" />
</head>
<body>


    <main class="container">

      <div class="tab-content">
        <section class="content-area">
            <article class="detail-card">
                
                <header class="detail-header">
                    <span class="post-tag gratitude">공지</span>
                    <h2 class="detail-title">${vo.noticeTitle}</h2>
                    <div class="detail-meta-row">
                        <div class="meta-left">
                            <span class="meta-item"><i data-lucide="user" size="16"></i> ${vo.regId}</span>
                            <span class="meta-item"><i data-lucide="calendar" size="16"></i> ${vo.noticeTime}</span>
                        </div>
                    </div>
                </header>

                <div class="detail-body" style="white-space: pre-wrap; min-height: 400px; padding: 20px 0;">
                    ${vo.noticeContent}
                </div>
                
                <div class="btn-list-container">
                    <a href="${pageContext.request.contextPath}/notice/noticeList.do" class="btn-list-view">
                        <i data-lucide="arrow-left"></i>
                        <span>목록으로 돌아가기</span>
                    </a>
                </div>
                
            </article>
        </section>
      </div>
    </main>
    
    <footer>
      <div class="container">
        <p>© 2024 내면의 흔적. All rights reserved.</p>
      </div>
    </footer>

    <script>
        if (typeof lucide !== 'undefined') lucide.createIcons();
    </script>
</body>
</html>