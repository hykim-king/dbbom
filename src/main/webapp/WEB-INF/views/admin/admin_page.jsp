<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>내면의 흔적 - 관리자 콘솔</title>

<script src="https://unpkg.com/lucide@latest"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/common.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/main.css" />

<style>
/* 관리자 전용 스타일 */
.admin-header-area {
	margin-bottom: 2rem;
	display: flex;
	justify-content: space-between;
	align-items: flex-end;
}

.admin-table-card {
	background: white;
	border-radius: 20px;
	padding: 2rem;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
	border: 1px solid rgba(0, 0, 0, 0.05);
	margin-bottom: 3rem;
}

.custom-table {
	width: 100%;
	border-collapse: separate;
	border-spacing: 0 10px;
}

.custom-table th {
	padding: 12px;
	color: #64748b;
	font-weight: 700;
	border-bottom: 2px solid #e2e8f0;
	text-align: center;
}

.custom-table td {
	padding: 15px;
	background-color: #f8fafc;
	text-align: center;
	vertical-align: middle;
}

.custom-table tr td:first-child {
	border-radius: 12px 0 0 12px;
}

.custom-table tr td:last-child {
	border-radius: 0 12px 12px 0;
}

.custom-table tr:hover td {
	background-color: #f1f5f9;
	color: #3b82f6;
	cursor: pointer;
}

/* 텍스트 줄임표 및 신고사유 강조 */
.text-ellipsis {
	max-width: 250px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	margin: 0 auto;
}

.clickable-reason {
	color: #2563eb;
	font-weight: 600;
	text-decoration: underline;
	text-underline-offset: 3px;
}

/* 모달 스타일 */
.modal-overlay {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	z-index: 1000;
	justify-content: center;
	align-items: center;
}

.modal-content {
	background: white;
	width: 550px;
	padding: 2rem;
	border-radius: 20px;
	position: relative;
	box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
}

.modal-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 1.5rem;
	border-bottom: 1px solid #eee;
	padding-bottom: 1rem;
}

.modal-close {
	cursor: pointer;
	color: #64748b;
}

.modal-body {
	line-height: 1.6;
	color: #334155;
	text-align: left;
	max-height: 500px;
	overflow-y: auto;
}

/* 신고 상세 박스 디자인 */
.report-box {
	margin-bottom: 15px;
	padding: 15px;
	background: #fff1f2;
	border-radius: 10px;
	border: 1px solid #fecaca;
}

.diary-box {
	padding: 15px;
	background: #f8fafc;
	border-radius: 10px;
	border: 1px solid #e2e8f0;
}

.box-label {
	font-size: 0.85rem;
	font-weight: 700;
	margin-bottom: 5px;
	display: flex;
	align-items: center;
	gap: 5px;
}

.type-badge {
	background: #e2e8f0;
	color: #475569;
	padding: 4px 10px;
	border-radius: 20px;
	font-size: 0.85rem;
	font-weight: 600;
}

.btn-search {
	background: #3b82f6;
	color: white;
	border: none;
	padding: 10px 16px;
	border-radius: 8px;
	font-weight: 600;
	cursor: pointer;
}

.btn-admin-del {
	background-color: #fee2e2;
	color: #ef4444;
	border: none;
	padding: 8px 16px;
	border-radius: 8px;
	font-weight: 600;
	cursor: pointer;
}

.btn-batch-del {
	background-color: #3b82f6;
	color: white;
	padding: 10px 20px;
	border-radius: 10px;
	border: none;
	font-weight: 700;
	cursor: pointer;
	display: flex;
	align-items: center;
	gap: 8px;
}
</style>
</head>
<body>
	<div id="detailModal" class="modal-overlay">
		<div class="modal-content">
			<div class="modal-header">
				<h3 id="modalTitle">상세 내용</h3>
				<i data-lucide="x" class="modal-close" onclick="closeModal()"></i>
			</div>
			<div id="modalBody" class="modal-body"></div>
		</div>
	</div>

	<header>
		<div class="container header-inner flex-between">
			<a href="${pageContext.request.contextPath}/main/main.do"
				class="logo-area" style="text-decoration: none">
				<h1 class="logo-text">내면의 흔적</h1>
			</a>
			<div class="auth-links">
				<span class="auth-item" style="color: #3b82f6">관리자님 환영합니다</span> <span
					class="divider">|</span> <a href="javascript:doLogout();"
					class="auth-item">로그아웃</a>
			</div>
		</div>
	</header>

	<main class="container">
		<div class="tab-list">
			<a href="${pageContext.request.contextPath}/main/main.do"
				class="menu-label" style="text-decoration: none; cursor: pointer;">
				<i data-lucide="home"
				style="width: 16px; margin-right: 4px; vertical-align: middle;"></i>
				메인으로
			</a> <a href="adminPage.do?menu=all"
				class="tab-btn ${menu eq 'all' ? 'active' : ''}">전체보기</a> <a
				href="adminPage.do?menu=section1"
				class="tab-btn ${menu eq 'section1' ? 'active' : ''}">신고관리</a> <a
				href="adminPage.do?menu=section2"
				class="tab-btn ${menu eq 'section2' ? 'active' : ''}">회원관리</a> <a
				href="adminPage.do?menu=section3"
				class="tab-btn ${menu eq 'section3' ? 'active' : ''}">게시글관리</a>
		</div>

		<div class="tab-content">
			<div class="admin-header-area">
				<section class="hero-section" style="text-align: left; margin: 0;">
					<h2>관리자 통합 콘솔</h2>
					<p>커뮤니티의 건전한 유지와 회원 관리를 수행합니다.</p>
				</section>
				<button type="button" class="btn-batch-del"
					onclick="deleteSelected()">
					<i data-lucide="trash-2"></i> 선택 항목 일괄 삭제
				</button>
			</div>

			<%-- 1. 신고 관리 섹션 --%>
			<c:if test="${menu eq 'section1' || menu eq 'all'}">
				<div class="admin-table-card" id="section1">
					<div class="section-title" style="margin-bottom: 1.5rem;">
						<i data-lucide="flame" style="color: #ef4444"></i> 신고 내역 관리
					</div>
					<table class="custom-table">
						<thead>
							<tr>
								<th><input type="checkbox"
									onclick="toggleAll(this, 'report-chk')"></th>
								<th>번호</th>
								<th>신고 유형</th>
								<th>신고 사유 (클릭하여 원본 확인)</th>
								<th>작성자</th>
								<th>관리</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty reportList}">
									<c:forEach var="vo" items="${reportList}">
										<tr>
											<td><input type="checkbox" class="report-chk"
												value="${vo.reportSid}"></td>
											<td>#${vo.reportSid}</td>
											<td><span class="type-badge"> <c:choose>
														<c:when test="${vo.reportCategory == '10'}">욕설</c:when>
														<c:when test="${vo.reportCategory == '20'}">음란</c:when>
														<c:when test="${vo.reportCategory == '30'}">홍보</c:when>
														<c:when test="${vo.reportCategory == '40'}">개인정보</c:when>
														<c:when test="${vo.reportCategory == '50'}">불법정보</c:when>
														<c:otherwise>기타</c:otherwise>
													</c:choose>
											</span></td>
											<td
												onclick="openReportModal('${fn:escapeXml(vo.reportContent)}', '${fn:escapeXml(vo.diaryContent)}', '${vo.diarySid}')">
												<div class="text-ellipsis clickable-reason">${vo.reportContent}</div>
											</td>
											<td>${vo.regId}</td>
											<td><button type="button" class="btn-admin-del"
													onclick="deleteOne('report', '${vo.reportSid}')">삭제</button></td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="6" style="text-align: center;">데이터가 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</c:if>

			<%-- 2. 회원 관리 섹션 --%>
			<c:if test="${menu eq 'section2' || menu eq 'all'}">
				<div class="admin-table-card" id="section2">
					<div class="section-title" style="margin-bottom: 1.5rem;">
						<i data-lucide="users" style="color: #3b82f6"></i> 회원 정보 관리
					</div>
					<table class="custom-table">
						<thead>
							<tr>
								<th><input type="checkbox"
									onclick="toggleAll(this, 'user-chk')"></th>
								<th>아이디</th>
								<th>닉네임</th>
								<th>관리</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty userList}">
									<c:forEach var="user" items="${userList}">
										<tr>
											<td><input type="checkbox" class="user-chk"
												value="${user.userId}"></td>
											<td>${user.userId}</td>
											<td>${user.nickname}</td>
											<td><button type="button" class="btn-admin-del"
													onclick="deleteOne('user', '${user.userId}')">강퇴</button></td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="4" style="text-align: center;">데이터가 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</c:if>

			<%-- 3. 게시글 관리 섹션 --%>
			<c:if test="${menu eq 'section3' || menu eq 'all'}">
				<div class="admin-table-card" id="section3">
					<div class="section-title" style="margin-bottom: 1.5rem;">
						<i data-lucide="files" style="color: #10b981"></i> 게시글 내역 관리
					</div>
					<table class="custom-table">
						<thead>
							<tr>
								<th><input type="checkbox"
									onclick="toggleAll(this, 'diary-chk')"></th>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>관리</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty diaryList}">
									<c:forEach var="diary" items="${diaryList}">
										<tr>
											<td><input type="checkbox" class="diary-chk"
												value="${diary.diarySid}"></td>
											<td>${diary.diarySid}</td>
											<td
												onclick="openDiaryModal('게시글 상세', '${fn:escapeXml(diary.diaryTitle)}', '${fn:escapeXml(diary.diaryContent)}', '${diary.diarySid}')">
												<div class="text-ellipsis">${diary.diaryTitle}</div>
											</td>
											<td>${diary.nickname}</td>
											<td><button type="button" class="btn-admin-del"
													onclick="deleteOne('diary', '${diary.diarySid}')">삭제</button></td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="5" style="text-align: center;">데이터가 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</c:if>
		</div>
	</main>

	<script>
        const cp = "${pageContext.request.contextPath}";

        $(document).ready(function() {
            if (typeof lucide !== 'undefined') lucide.createIcons();
        });

        function doLogout() {
            if (!confirm("로그아웃 하시겠습니까?")) return;
            $.ajax({
                url: cp + "/user/doLogoutAjax.do",
                type: "POST", // 반드시 POST 방식이어야 합니다.
                dataType: "json",
                success: function(res) {
                    alert(res.message);
                    if (res.flag === 1) location.href = cp + "/main/main.do";
                },
                error: function() { 
                    location.href = cp + "/main/main.do"; 
                }
            });
        }
        function openReportModal(reportContent, diaryContent, diarySid) {
            console.log("받아온 diarySid:", diarySid); // 여기서 0인지 확인

            // 0이거나 빈값이면 이동 불가 처리
            if (!diarySid || diarySid === '0' || diarySid === '' || diarySid === 'null') {
                alert("해당 신고는 일기와 연결된 식별 번호가 없습니다(0).");
                return;
            }

            $('#modalTitle').text("신고 상세 확인");
            const detailUrl = cp + "/diary/doSelectOne.do?diarySid=" + diarySid;

            let html = `
                <div class="report-box">
                    <div style="font-weight:bold; color:#e11d48;">신고 내용</div>
                    <div>\${reportContent}</div>
                </div>
                <div class="diary-box" style="margin-top:10px;">
                    <div style="font-weight:bold; color:#475569;">원본 일기 본문</div>
                    <div style="white-space:pre-wrap; background:#fff; padding:10px; border-radius:5px; margin-bottom:15px; max-height:200px; overflow-y:auto;">
                        \${diaryContent || "내용을 불러올 수 없습니다."}
                    </div>
                    <a href="\${detailUrl}" target="_blank" class="btn-search" 
                       style="display:block; text-align:center; color:white; background:#3b82f6; padding:10px; text-decoration:none; border-radius:8px; font-weight:bold;">
                       원본 게시글 바로가기
                    </a>
                </div>
            `;
            $('#modalBody').html(html);
            $('#detailModal').css('display', 'flex');
            lucide.createIcons();
        }

        // 3. 게시글 관리 모달
        function openDiaryModal(title, subTitle, content, diarySid) {
            $('#modalTitle').text(title);
            const detailUrl = cp + "/diary/doSelectOne.do?diarySid=" + diarySid;
            let html = `
                <div style="margin-bottom:15px; padding-bottom:10px; border-bottom:1px solid #eee;">
                    <strong>제목:</strong> \${subTitle}
                </div>
                <div style="white-space: pre-wrap; line-height:1.8; max-height:250px; overflow-y:auto; margin-bottom:15px;">\${content}</div>
                <a href="\${detailUrl}" target="_blank" class="btn-search" 
                   style="display: block; text-align: center; text-decoration: none; color:white;">
                     실제 게시글 새창보기
                </a>
            `;
            $('#modalBody').html(html);
            $('#detailModal').css('display', 'flex');
        }

        function closeModal() { $('#detailModal').hide(); }
        $(window).on('click', function(e) { if ($(e.target).is('#detailModal')) closeModal(); });

        function toggleAll(obj, target) { $("." + target).prop("checked", $(obj).is(":checked")); }

        function processDelete(type, id) {
            let url = cp + "/admin/doDelete" + type.charAt(0).toUpperCase() + type.slice(1) + ".do";
            let data = (type === 'user') ? { userId: id } : (type === 'diary' ? { diarySid: id } : { reportSid: id });
            return $.ajax({ type: "POST", url: url, data: data });
        }

        function deleteOne(type, id) {
            event.stopPropagation();
            if (!confirm("정말로 삭제하시겠습니까?")) return;
            processDelete(type, id).done(function(res) {
                alert(res);
                location.reload();
            }).fail(function() { alert("삭제 실패"); });
        }

        function deleteSelected() {
            const selected = [];
            $(".user-chk:checked, .diary-chk:checked, .report-chk:checked").each(function() {
                const type = $(this).attr('class').split('-')[0];
                selected.push({ id: $(this).val(), type: type });
            });
            if (selected.length === 0) { alert("항목을 선택해주세요."); return; }
            if (!confirm("일괄 삭제하시겠습니까?")) return;
            let completed = 0;
            selected.forEach(function(item) {
                processDelete(item.type, item.id).always(function() {
                    completed++;
                    if (completed === selected.length) {
                        alert("처리가 완료되었습니다.");
                        location.reload();
                    }
                });
            });
        }
    </script>
</body>
</html>