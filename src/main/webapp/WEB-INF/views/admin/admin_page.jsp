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

/* 텍스트 줄임표 */
.text-ellipsis {
	max-width: 250px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	margin: 0 auto;
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
	width: 500px;
	padding: 2rem;
	border-radius: 20px;
	position: relative;
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
	white-space: pre-wrap;
	word-break: break-all;
	text-align: left;
	max-height: 400px;
	overflow-y: auto;
}

/* 유형 배지 */
.type-badge {
	background: #e2e8f0;
	color: #475569;
	padding: 4px 10px;
	border-radius: 20px;
	font-size: 0.85rem;
	font-weight: 600;
}

.search-area {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin: 1.5rem 0;
	padding: 1rem;
	background: #f1f5f9;
	border-radius: 12px;
}

.btn-search {
	background: #64748b;
	color: white;
	border: none;
	padding: 8px 16px;
	border-radius: 8px;
	font-weight: 600;
	cursor: pointer;
}

.pagination {
	display: flex;
	justify-content: center;
	gap: 8px;
	margin-top: 20px;
}

.pagination a {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	width: 35px;
	height: 35px;
	border-radius: 8px;
	border: 1px solid #e2e8f0;
	text-decoration: none;
	color: #64748b;
	font-weight: 600;
}

.pagination a.active {
	background-color: #3b82f6;
	color: white;
	border-color: #3b82f6;
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
					class="divider">|</span> <a
					href="${pageContext.request.contextPath}/user/doLogoutAjax.do"
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
								<th>내용</th>
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
														<c:when
															test="${vo.reportCategory == 10 or vo.reportCategory eq '10'}">욕설</c:when>
														<c:when
															test="${vo.reportCategory == 20 or vo.reportCategory eq '20'}">음란</c:when>
														<c:when
															test="${vo.reportCategory == 30 or vo.reportCategory eq '30'}">홍보</c:when>
														<c:when
															test="${vo.reportCategory == 40 or vo.reportCategory eq '40'}">개인정보 유출</c:when>
														<c:when
															test="${vo.reportCategory == 50 or vo.reportCategory eq '50'}">불법정보</c:when>
														<c:when
															test="${vo.reportCategory == 60 or vo.reportCategory eq '60'}">기타</c:when>
														<c:otherwise>기타(${vo.reportCategory})</c:otherwise>
													</c:choose>
											</span></td>
											<td
												onclick="openModal('신고 내용 상세', '${fn:escapeXml(vo.reportContent)}')">
												<div class="text-ellipsis">${vo.reportContent}</div>
											</td>
											<td>${vo.regId}</td>
											<td><button type="button" class="btn-admin-del"
													onclick="deleteOne('report', '${vo.reportSid}')">삭제</button></td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="6">데이터가 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<form action="adminPage.do" method="get" class="search-area">
						<input type="hidden" name="menu" value="${menu}"> <select
							name="searchDiv" class="search-select">
							<option value="10" ${param.searchDiv == '10' ? 'selected' : ''}>내용</option>
							<option value="20" ${param.searchDiv == '20' ? 'selected' : ''}>작성자ID</option>
						</select> <input type="text" name="searchWord" class="search-input"
							placeholder="검색어 입력..." value="${param.searchWord}">
						<button type="submit" class="btn-search">검색</button>
					</form>
					<c:if test="${reportMaxPage > 0}">
						<div class="pagination">
							<c:forEach var="i" begin="1" end="${reportMaxPage}">
								<a
									href="adminPage.do?menu=${menu}&reportPage=${i}&searchDiv=${param.searchDiv}&searchWord=${param.searchWord}#section1"
									class="${(empty param.reportPage and i==1) or param.reportPage == i ? 'active' : ''}">${i}</a>
							</c:forEach>
						</div>
					</c:if>
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
										<td colspan="4">데이터가 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<form action="adminPage.do" method="get" class="search-area">
						<input type="hidden" name="menu" value="${menu}"> <select
							name="searchDiv">
							<option value="10" ${param.searchDiv == '10' ? 'selected' : ''}>아이디</option>
							<option value="20" ${param.searchDiv == '20' ? 'selected' : ''}>닉네임</option>
						</select> <input type="text" name="searchWord" value="${param.searchWord}">
						<button type="submit" class="btn-search">검색</button>
					</form>
					<c:if test="${userMaxPage > 0}">
						<div class="pagination">
							<c:forEach var="i" begin="1" end="${userMaxPage}">
								<a
									href="adminPage.do?menu=${menu}&userPage=${i}&searchDiv=${param.searchDiv}&searchWord=${param.searchWord}#section2"
									class="${(empty param.userPage and i==1) or param.userPage == i ? 'active' : ''}">${i}</a>
							</c:forEach>
						</div>
					</c:if>
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
												onclick="openModal('게시글 제목 상세', '${fn:escapeXml(diary.diaryTitle)}')"><div
													class="text-ellipsis">${diary.diaryTitle}</div></td>
											<td>${diary.nickname}</td>
											<td><button type="button" class="btn-admin-del"
													onclick="deleteOne('diary', '${diary.diarySid}')">삭제</button></td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="5">데이터가 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<form action="adminPage.do" method="get" class="search-area">
						<input type="hidden" name="menu" value="${menu}"> <select
							name="searchDiv">
							<option value="10" ${param.searchDiv == '10' ? 'selected' : ''}>제목</option>
							<option value="20" ${param.searchDiv == '20' ? 'selected' : ''}>작성자</option>
						</select> <input type="text" name="searchWord" value="${param.searchWord}">
						<button type="submit" class="btn-search">검색</button>
					</form>
					<c:if test="${diaryMaxPage > 0}">
						<div class="pagination">
							<c:forEach var="i" begin="1" end="${diaryMaxPage}">
								<a
									href="adminPage.do?menu=${menu}&diaryPage=${i}&searchDiv=${param.searchDiv}&searchWord=${param.searchWord}#section3"
									class="${(empty param.diaryPage and i==1) or param.diaryPage == i ? 'active' : ''}">${i}</a>
							</c:forEach>
						</div>
					</c:if>
				</div>
			</c:if>
		</div>
	</main>

	<script>
		$(document).ready(function() {
			if (typeof lucide !== 'undefined') {
				lucide.createIcons();
			}
		});
		function openModal(title, content) {
			$('#modalTitle').text(title);
			$('#modalBody').text(content);
			$('#detailModal').css('display', 'flex');
		}
		function closeModal() {
			$('#detailModal').hide();
		}
		$(window).on('click', function(e) {
			if ($(e.target).is('#detailModal'))
				closeModal();
		});
		function toggleAll(obj, target) {
			$("." + target).prop("checked", $(obj).is(":checked"));
		}
		function processDelete(type, id) {
			const cp = "${pageContext.request.contextPath}";
			let url = cp + "/admin/doDelete" + type.charAt(0).toUpperCase()
					+ type.slice(1) + ".do";
			let data = (type === 'user') ? {
				userId : id
			} : (type === 'diary' ? {
				diarySid : id
			} : {
				reportSid : id
			});
			return $.ajax({
				type : "POST",
				url : url,
				data : data
			});
		}
		function deleteOne(type, id) {
			event.stopPropagation();
			if (!confirm("정말로 삭제하시겠습니까?"))
				return;
			processDelete(type, id).done(function(res) {
				alert(res);
				location.reload();
			}).fail(function(xhr) {
				if (xhr.status === 200) {
					alert(xhr.responseText);
					location.reload();
				} else {
					alert("삭제 실패");
				}
			});
		}
		function deleteSelected() {
			const selected = [];
			$(".user-chk:checked, .diary-chk:checked, .report-chk:checked")
					.each(function() {
						const type = $(this).attr('class').split('-')[0];
						selected.push({
							id : $(this).val(),
							type : type
						});
					});
			if (selected.length === 0) {
				alert("항목을 선택해주세요.");
				return;
			}
			if (!confirm("일괄 삭제하시겠습니까?"))
				return;
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