<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내면의 흔적 - 게시글 상세보기</title>
    
    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/cmn/jquery.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/diary_detail_board.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/common.css"/>

<style>
    /* 1. 메뉴 컨테이너: 상하 높이를 충분히 확보 */
    .menu-container .tab-list {
        display: flex !important;
        flex-direction: row !important;
        align-items: center !important;
        justify-content: space-around !important;
        
        /* 두 번째 사진과 같은 깊이감을 위해 상하 패딩 조정 */
        padding: 8px 30px !important; 
        min-height: 50px !important;    /* 전체적인 바 두께 확정 */
        
        max-width: 1000px !important;
        margin: 0 auto !important;
    }

    /* 2. 모든 버튼 및 라벨: 가로 배열 강제 및 줄바꿈 방지 */
    .menu-container .menu-label,
    .menu-container .tab-list .tab-btn, 
    .menu-container .tab-list .dropdown-container,
    .menu-container .dropdown-btn {
        display: flex !important;
        flex-direction: row !important; /* 아이콘과 글자를 무조건 가로로 */
        align-items: center !important;
        justify-content: center !important;
        
        white-space: nowrap !important; /* 텍스트 꺾임 방지 핵심 */
        width: auto !important;         /* 너비 자동 확장 */
        gap: 10px !important;           /* 아이콘과 글자 사이 간격 */
        flex-shrink: 0 !important;      /* 좁아져도 찌그러지지 않게 함 */
    }

    /* 3. 텍스트 요소들 개별 설정 */
    .menu-container .tab-list span,
    .menu-container .menu-label {
        display: inline-block !important;
        line-height: 1 !important;      /* 줄 간격 때문에 생기는 세로 느낌 제거 */
        font-size: 15px !important;
        margin: 0 !important;
    }

    /* 4. '메뉴' 라벨 전용 (왼쪽 고정 느낌) */
    .menu-container .menu-label {
        font-weight: 800 !important;
        margin-right: 15px !important;
    }
</style>
    <script>
        $(document).ready(function() {
            if (typeof lucide !== 'undefined') { lucide.createIcons(); }

            const diarySid = '${diaryVO.diarySid}';
            const likeKey = 'diary_liked_' + diarySid;

            if (localStorage.getItem(likeKey) === 'true') {
                $('#likeBtn').addClass('active');
                $('#heartIcon').attr({ fill: '#ef4444', stroke: '#ef4444' });
            }

            $('#likeBtn').on('click', function() {
                const loginUser = "${sessionScope.loginUser}";
                if (!loginUser || loginUser === "" || loginUser === "null") {
                    if (confirm('좋아요는 로그인 후에 가능합니다.\n로그인 페이지로 이동하시겠습니까?')) {
                        location.href = "${pageContext.request.contextPath}/user/signIn.do";
                    }
                    return;
                }

                const isLiked = localStorage.getItem(likeKey) === 'true';
                const changeValue = isLiked ? -1 : 1;

                $.ajax({
                    type: 'POST',
                    url: '${pageContext.request.contextPath}/diary/updateRecCount.do',
                    data: { diarySid: diarySid, diaryRecCount: changeValue },
                    success: function(res) {
                        const status = (typeof res === 'string') ? JSON.parse(res) : res;
                        if(status.flag === 1 || status.newRecCount !== undefined) {
                            if (!isLiked) {
                                localStorage.setItem(likeKey, 'true');
                                $('#heartIcon').attr({ fill: '#ef4444', stroke: '#ef4444' });
                                $('#likeBtn').addClass('active');
                            } else {
                                localStorage.removeItem(likeKey);
                                $('#heartIcon').attr({ fill: 'none', stroke: 'currentColor' });
                                $('#likeBtn').removeClass('active');
                            }
                            $('#likeCount').text(status.newRecCount || status.recCount);
                        }
                    }
                });
            });
        });
    </script>
</head>
<body style="background-color: #f8fafc;">

   <div class="menu-container">
    <jsp:include page="/WEB-INF/views/main/menu.jsp" />
</div>

    <main class="container" style="max-width: 1200px; margin: 0 auto; padding: 0 20px;">
        <a href="${pageContext.request.contextPath}/diary/diaryList.do" class="back-btn" style="text-decoration: none; color: #64748b; display: inline-flex; align-items: center; margin: 15px 0;">
            <i data-lucide="arrow-left" style="width:18px; margin-right:5px;"></i> 목록으로 돌아가기
        </a>

        <article class="detail-card" style="background: white; border-radius: 15px; padding: 40px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);">
            <header style="border-bottom: 1px solid #f1f5f9; padding-bottom: 25px; margin-bottom: 30px;">
                <span style="background: #f1f5f9; padding: 4px 12px; border-radius: 20px; font-size: 13px; color: #64748b;">${diaryVO.diaryCategoryName}</span>
                <h2 style="font-size: 32px; margin: 15px 0; color: #1e293b; font-weight: 700;">${diaryVO.diaryTitle}</h2>
                
                <div style="display: flex; justify-content: space-between; align-items: center; color: #94a3b8; font-size: 14px;">
                    <div style="display: flex; gap: 20px;">
                        <span><i data-lucide="user" style="width:14px; vertical-align:middle; margin-right:4px;"></i> ${diaryVO.nickname}</span>
                        <span><i data-lucide="calendar" style="width:14px; vertical-align:middle; margin-right:4px;"></i> ${diaryVO.diaryUploadDate}</span>
                        <span><i data-lucide="eye" style="width:14px; vertical-align:middle; margin-right:4px;"></i> 조회 ${diaryVO.diaryViewCount}</span>
                    </div>
                    <div>
                        <a href="${pageContext.request.contextPath}/diary/diaryUpdateForm.do?diarySid=${diaryVO.diarySid}" style="color:#3b82f6; text-decoration:none; margin-right:15px;">수정</a>
                        <a href="${pageContext.request.contextPath}/report/reportPage.do?type=diary&id=${diaryVO.diarySid}" 
                           onclick="window.open(this.href, 'reportPopup', 'width=500,height=700'); return false;" 
                           style="color:#ef4444; text-decoration:none;">신고</a>
                    </div>
                </div>    
            </header>

            <div style="min-height: 300px; line-height: 1.8; color: #334155; font-size: 17px;">
                ${diaryVO.diaryContent}
            </div>

            <div style="display: flex; justify-content: center; margin: 50px 0; padding-top: 30px; border-top: 1px solid #f1f5f9;">
                <button id="likeBtn" style="background: white; border: 1px solid #e2e8f0; padding: 12px 30px; border-radius: 40px; cursor: pointer; display: flex; align-items: center; gap: 10px; transition: all 0.2s;">
                    <i data-lucide="heart" id="heartIcon" style="width:22px;"></i>
                    <span id="likeCount" style="font-weight: 600; font-size: 18px;">${diaryVO.diaryRecCount}</span>
                </button>
            </div>

            <section style="margin-top: 50px;">
                <h3 style="font-size: 20px; font-weight: 700; margin-bottom: 25px; display: flex; align-items: center; gap: 8px;">
                    <i data-lucide="message-circle" style="width:24px;"></i> 댓글 <span style="color:#3b82f6;">${fn:length(commentList)}</span>
                </h3>
                
                <form method="post" action="addComment.do" style="display: flex; gap: 12px; margin-bottom: 35px;">
                    <input type="text" name="commentContent" placeholder="따뜻한 위로와 공감의 댓글을 남겨주세요." style="flex:1; padding:15px; border:1px solid #e2e8f0; border-radius:12px; outline:none; font-size: 15px;">
                    <button type="submit" style="padding: 0 25px; background: #1e293b; color: white; border: none; border-radius: 12px; cursor: pointer; font-weight: 600;">등록</button>
                </form>

                <div class="comment-list">
                    <c:forEach var="comment" items="${commentList}">
                        <div style="background: #f8fafc; border-radius: 15px; padding: 20px; margin-bottom: 15px;">
                            <div style="margin-bottom: 10px;">
                                <span style="font-weight: 700; color: #1e293b;">${comment.writer}</span>
                                <span style="color: #94a3b8; font-size: 13px; margin-left: 12px;">${comment.regDate}</span>
                            </div>
                            <p style="margin: 0; color: #475569; line-height: 1.6;">${comment.content}</p>
                        </div>
                    </c:forEach>
                </div>
            </section>
        </article>
    </main>

    <footer style="text-align: center; padding: 60px 0; color: #94a3b8; font-size: 14px;">
        <p>© 2024 내면의 흔적. All rights reserved.</p>
    </footer>

</body>
</html>