<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.pcwk.ehr.user.domain.UserVO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>

<!-- (선택) jQuery: 나중에 AJAX 확장 시 쓰기 좋음 -->
<script
	src="<%=request.getContextPath()%>/resources/assets/js/cmn/jquery.js"></script>

<style>
body {
	font-family: Arial, sans-serif;
	background: #f4f6fb;
}

.wrap {
	width: 980px;
	margin: 30px auto;
}

.card {
	background: #fff;
	border-radius: 12px;
	padding: 22px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
}

.top {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-bottom: 14px;
}

.title {
	font-size: 18px;
	font-weight: 800;
}

.btn {
	padding: 8px 12px;
	border: 1px solid #ddd;
	background: #fff;
	cursor: pointer;
	border-radius: 8px;
}

.btn:hover {
	background: #f2f2f2;
}

.profile {
	display: flex;
	gap: 14px;
	align-items: center;
	margin-bottom: 16px;
}

.avatar {
	width: 56px;
	height: 56px;
	border-radius: 50%;
	background: #e9edf5;
}

.name {
	font-size: 20px;
	font-weight: 900;
}

.sub {
	color: #666;
	font-size: 13px;
	margin-top: 4px;
}

/* 상단 2개 버튼(내 일기 / 내 정보관리) */
.actions {
	display: flex;
	gap: 10px;
	margin-top: 14px;
}

.actionBtn {
	flex: 1;
	padding: 14px;
	border: 0;
	cursor: pointer;
	border-radius: 10px;
	background: #3b82f6;
	color: #fff;
	font-weight: 800;
}

.actionBtn:hover {
	filter: brightness(0.96);
}

.actionBtn.gray {
	background: #64748b;
}

.actionBtn.active {
	outline: 3px solid rgba(59, 130, 246, 0.25);
}

/* 아래 내용 영역 */
.contentWrap {
	margin-top: 18px;
}

.section {
	display: none;
}

.section.active {
	display: block;
}

.sectionTitle {
	font-size: 16px;
	font-weight: 900;
	margin: 6px 0 14px;
}

/* 내 정보관리 폼 스타일(회원가입 폼 느낌) */
.formBox {
	border: 1px solid #e5e7eb;
	border-radius: 12px;
	padding: 18px;
	background: #fff;
}

.row {
	margin-bottom: 12px;
}

label {
	display: block;
	margin-bottom: 6px;
	font-weight: 700;
	color: #111827;
}

input, textarea {
	width: 100%;
	padding: 10px;
	box-sizing: border-box;
	border: 1px solid #d1d5db;
	border-radius: 10px;
	background: #f9fafb;
}

input[readonly], textarea[readonly] {
	color: #111827;
}

.hint {
	font-size: 12px;
	color: #6b7280;
	margin-top: 6px;
}

/* 내 일기(빈 컨테이너) */
.emptyBox {
	border: 1px dashed #cbd5e1;
	border-radius: 12px;
	padding: 28px;
	background: #f8fafc;
	color: #64748b;
	text-align: center;
}
</style>

<script>
	function showSection(which) {
		const diaryBtn = document.getElementById("btnDiary");
		const infoBtn = document.getElementById("btnInfo");

		const diarySec = document.getElementById("sectionDiary");
		const infoSec = document.getElementById("sectionInfo");

		// 초기화
		diaryBtn.classList.remove("active");
		infoBtn.classList.remove("active");
		diarySec.classList.remove("active");
		infoSec.classList.remove("active");

		if (which === "diary") {
			diaryBtn.classList.add("active");
			diarySec.classList.add("active");
		} else {
			infoBtn.classList.add("active");
			infoSec.classList.add("active");
		}
	}

	document.addEventListener("DOMContentLoaded", function() {
		// 기본은 "내 정보관리" 먼저 보여주기(원하시면 diary로 바꿔드릴게요)
		showSection("info");
	});
</script>
</head>

<body>
	<%
		// 1) 세션에서 로그인 사용자 가져오기
	UserVO loginUser = (UserVO) session.getAttribute("loginUser");

	// 2) 로그인 안 했으면 메인으로
	if (loginUser == null) {
		response.sendRedirect(request.getContextPath() + "/resources/mainPage.jsp");
		return;
	}

	// 닉네임 우선, 없으면 아이디
	String displayName = (loginUser.getNickname() != null && !loginUser.getNickname().trim().isEmpty())
			? loginUser.getNickname()
			: loginUser.getUserId();

	// 혹시 null 방어(출력용)
	String userId = loginUser.getUserId() == null ? "" : loginUser.getUserId();
	String userName = loginUser.getUserName() == null ? "" : loginUser.getUserName();
	String userTel = loginUser.getUserTel() == null ? "" : loginUser.getUserTel();
	String userEmail = loginUser.getUserEmail() == null ? "" : loginUser.getUserEmail();
	String nickname = loginUser.getNickname() == null ? "" : loginUser.getNickname();
	String userIntro = loginUser.getUserIntro() == null ? "" : loginUser.getUserIntro();
	String adminChk = loginUser.getAdminChk() == null ? "" : loginUser.getAdminChk();
	%>

	<div class="wrap">
		<div class="card">

			<div class="top">
				<div class="title">내면의 흔적 - 마이페이지</div>
				<button class="btn"
					onclick="location.href='<%=request.getContextPath()%>/resources/mainPage.jsp'">메인으로</button>
			</div>

			<div class="profile">
				<div class="avatar"></div>
				<div>
					<div class="name"><%=displayName%></div>
					<div class="sub">아래 버튼을 눌러 ‘내 일기’ / ‘내 정보관리’를 화면 안에서 전환합니다.</div>
				</div>
			</div>

			<!-- 상단 2개 버튼 -->
			<div class="actions">
				<button class="actionBtn" id="btnDiary" type="button"
					onclick="showSection('diary')">내 일기</button>
				<button class="actionBtn gray" id="btnInfo" type="button"
					onclick="showSection('info')">내 정보관리</button>
			</div>

			<!-- 아래 내용 영역(페이지 이동 없이 표시) -->
			<div class="contentWrap">

				<!-- 1) 내 일기(일단 빈 컨테이너) -->
				<div class="section" id="sectionDiary">
					<div class="sectionTitle">내 일기</div>
					<div class="emptyBox">아직 ‘내 일기’ 화면은 준비 중입니다. (지금은 빈 컨테이너만 표시)
					</div>
				</div>

				<!-- 2) 내 정보관리(가입정보 폼 형태로 표시 / 읽기전용) -->
				<div class="section" id="sectionInfo">
					<div class="sectionTitle">내 정보관리</div>

					<div class="formBox">
						<div class="row">
							<label>아이디(user_id)</label> <input type="text"
								value="<%=userId%>" readonly />
						</div>

						<div class="row">
							<label>이름(user_name)</label> <input type="text"
								value="<%=userName%>" readonly />
						</div>

						<div class="row">
							<label>전화번호(user_tel)</label> <input type="text"
								value="<%=userTel%>" readonly />
						</div>

						<div class="row">
							<label>이메일(user_email)</label> <input type="text"
								value="<%=userEmail%>" readonly />
						</div>

						<div class="row">
							<label>닉네임(nickname)</label> <input type="text"
								value="<%=nickname%>" readonly />
						</div>

						<div class="row">
							<label>자기소개(user_intro) (지금은 읽기만)</label>
							<textarea rows="4" readonly><%=userIntro%></textarea>
							<div class="hint">※ 대표님 요청대로 자기소개는 우선 나중에 수정/관리 기능에서 확장합니다.</div>
						</div>

						<div class="row">
							<label>관리자 여부(admin_chk)</label> <input type="text"
								value="<%=adminChk%>" readonly />
							<div class="hint">※ 일반회원은 보통 N 입니다.</div>
						</div>

						<div class="hint">※ 비밀번호(user_pw)는 보안상 화면에 그대로 노출하지 않습니다.
							(나중에 “비밀번호 변경” 기능으로 처리)</div>
					</div>
				</div>

			</div>

		</div>
	</div>

</body>
</html>
