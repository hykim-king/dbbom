<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.pcwk.ehr.user.domain.UserVO"%>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pcwk.ehr.user.domain.UserVO"%>
<%
    // 세션에서 로그인 정보 가져오기
    UserVO loginUser = (UserVO) session.getAttribute("loginUser");
    
    // 데이터 안전하게 추출
    String userId    = (loginUser != null) ? loginUser.getUserId() : "";
    String userName  = (loginUser != null) ? loginUser.getUserName() : "";
    String userEmail = (loginUser != null) ? loginUser.getUserEmail() : "";
    String nickname  = (loginUser != null) ? loginUser.getNickname() : "";
    String userIntro = (loginUser != null) ? loginUser.getUserIntro() : "";
   
    String displayName = (nickname != null && !nickname.isEmpty()) ? nickname : userId;
%>
>>>>>>> feature/donghan-backup
<!DOCTYPE html>
<html lang="ko">
<head>
<<<<<<< HEAD
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
=======
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>내면의 흔적 - 마이페이지</title>

<script src="${pageContext.request.contextPath}/resources/assets/js/cmn/jquery.js"></script>
<script src="https://unpkg.com/lucide@latest"></script>
<script src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/js/mypage.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/js/mypage_diary_list.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/mypage.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/mypage_diary_list.css" />
<style>
    .withdraw-box { text-align: center; padding: 40px 20px; }
    .withdraw-warning { background: #fff5f5; border: 1px solid #feb2b2; padding: 20px; border-radius: 8px; margin-bottom: 25px; color: #c53030; }
    .withdraw-warning ul { text-align: left; display: inline-block; margin-top: 10px; }
    .btn-withdraw-final { background-color: #e53e3e; color: white; border: none; padding: 12px 24px; border-radius: 6px; cursor: pointer; font-weight: bold; transition: 0.3s; }
    .btn-withdraw-final:hover { background-color: #c53030; }
    
    /* 비밀번호 변경 폼 스타일 전용 */
    .user-edit-form .form-row small { display: block; margin-top: 5px; color: #e53e3e; }
    
		    /* 비밀번호 변경 폼 스타일 수정 */
		.user-edit-form .form-row {
		    flex-wrap: wrap; /* 내부 요소가 넘치면 다음 줄로 넘어가도록 설정 */
		    align-items: center;
		}
		
		.user-edit-form .form-row label {
		    flex: 0 0 120px; /* 라벨 너비 고정 (기존 스타일에 맞춰 조절하세요) */
		}
		
		.user-edit-form .form-row input {
		    flex: 1; /* 인풋이 남은 공간 차지 */
		}
		
		.user-edit-form .form-row small {
		    display: block;
		    width: 100%; /* 너비를 100%로 주어 강제로 다음 줄로 이동 */
		    margin-top: 5px;
		    margin-left: 120px; /* 라벨 너비만큼 왼쪽 여백을 주어 인풋 아래에 맞춤 */
		    font-size: 0.85em;
					/* 신규 이동 버튼 스타일 */
		}
</style>
</head>

<body>
    <jsp:include page="/WEB-INF/views/main/menu.jsp" />

    <main class="container">

        <div class="tab-content mypage-content">
            <div class="wf-container">
                <section class="wf-card wf-profile-header">
                    <div class="wf-user-info-group">
                        <div class="wf-profile-img"></div>
                        <div class="wf-user-info">
                            <h2><%=displayName%></h2>
                            <p><i data-lucide="quote" size="12" style="margin-right: 5px; color: #999"></i> 
                               <span id="displayIntro"><%= (userIntro != null && !userIntro.isEmpty()) ? userIntro : "오늘도 나를 돌아보는 시간, 참 소중해요." %></span>
                            </p>
                        </div>
                    </div>
                    <div class="wf-stats-group">
										    <div class="wf-stat-card">
										        <i data-lucide="book" size="20" color="#4A90E2"></i> 
										        <span class="wf-stat-label">총 일기 수</span> 
										        <span class="wf-stat-value">${not empty totalCount ? totalCount : 0}</span>
										    </div>
										    <div class="wf-stat-card">
										        <i data-lucide="calendar-check" size="20" color="#2ECC71"></i> 
										        <span class="wf-stat-label">이번 달 작성</span> 
										        <span class="wf-stat-value">${not empty monthCount ? monthCount : 0}</span>
										    </div>
										</div>
                </section>

                <section>
                    <div class="wf-tab-menu">
                        <button class="wf-tab-btn active" onclick="switchCustomTab('my-diary', event)">
                            <i data-lucide="book-open-text" size="18"></i> 내 일기
                        </button>
                        <button class="wf-tab-btn" onclick="switchCustomTab('my-info', event)">
                            <i data-lucide="user-cog" size="18"></i> 내 정보 관리
                        </button>
                        <button class="wf-tab-btn" onclick="switchCustomTab('change-password', event)">
                            <i data-lucide="lock" size="18"></i> 비밀번호 변경
                        </button>
                        <button class="wf-tab-btn" onclick="switchCustomTab('withdraw-user', event)" style="color: #e53e3e;">
                            <i data-lucide="user-minus" size="18"></i> 회원탈퇴
                        </button>
                    </div>

                    <div class="wf-card wf-content-box">
                        <div id="my-diary" class="wf-tab-content active">
                            <div class="content-header">
                                <div class="content-title"><i data-lucide="history" color="#4A90E2"></i> 나의 일기목록</div>
                            </div>
                            <div class="diary-container">
                                <div class="diary-top-card">
                                    <div class="calendar">
                                        <div class="calendar-header flex-center" style="gap: 20px; margin-bottom: 25px;">
																				    <button type="button" id="prevMonth" class="month-btn">
																				        <i data-lucide="chevron-left"></i>
																				    </button>
																				    
																				    <h3 id="currentMonthText">2025년 11월</h3>
																				    
																				    <button type="button" id="nextMonth" class="month-btn">
																				        <i data-lucide="chevron-right"></i>
																				    </button>
																				</div>
                                        <div class="calendar-grid" id="calendar"></div>
                                    </div>
                                    <div class="diary-list">
                                        <h3 id="selectedDate">날짜를 선택하세요</h3>
                                        <ul id="diaryTypeList"></ul>
                                    </div>
                                </div>
                                <div class="diary-content-card">
                                    <p id="diaryContent">일기를 선택하면 내용이 표시됩니다 :)</p>
                                </div>
                            </div>
                        </div>

                        <div id="my-info" class="wf-tab-content">
                            <div class="content-header">
                                <div class="content-title"><i data-lucide="settings" color="#4A90E2"></i> 계정 및 정보 설정</div>
                            </div>
                            <form class="user-edit-form" id="userEditForm">
                                <div class="form-row"><label>아이디</label> <input type="text" value="<%=userId%>" readonly /></div>
                                <div class="form-row">
                                    <label>닉네임</label>
                                    <div class="inline-row">
                                        <input type="text" id="nickname" name="nickname" value="<%=nickname%>" />
                                        <button type="button" class="check-btn" onclick="checkNickname()">중복확인</button>
                                    </div>
                                    <small id="nicknameMsg"></small>
                                </div>
                                <div class="form-row">
                                    <label>자기소개</label>
                                    <textarea id="intro" name="userIntro" rows="3"><%=userIntro%></textarea>
                                </div>
                                <div class="form-row"><label>이름</label> <input type="text" value="<%=userName%>" readonly /></div>
                                <div class="form-row"><label>이메일</label> <input type="email" value="<%=userEmail%>" readonly /></div>
                                <div class="form-actions"><button type="submit" class="save-btn">정보 수정</button></div>
                            </form>
                        </div>

                        <%-- (이전 코드 동일) --%>

												<div id="change-password" class="wf-tab-content">
												    <div class="content-header">
												        <div class="content-title"><i data-lucide="shield-check" color="#4A90E2"></i> 비밀번호 변경</div>
												    </div>
												    <form class="user-edit-form" id="pwChangeForm">
												        <div class="form-row">
												            <label>기존 비밀번호</label>
												            <input type="password" id="oldPw" name="oldPw" placeholder="현재 비밀번호를 입력하세요" required />
												        </div>
												        <div class="form-row">
												            <label>새 비밀번호</label>
												            <input type="password" id="newPw" name="newPw" placeholder="새 비밀번호를 입력하세요" required />
												        </div>
												        
												        <div class="form-row" style="margin-bottom: 0;">
												            <label>새 비밀번호 확인</label>
												            <input type="password" id="newPwConfirm" placeholder="새 비밀번호를 다시 입력하세요" required />
												        </div>
												        <div class="form-row" style="min-height: 20px; padding-top: 0;">
												            <div style="flex: 0 0 120px;"></div> <small id="pwMatchMsg" style="display: block; transition: all 0.3s;"></small>
												        </div>
												
												        <div class="form-actions">
												            <button type="button" id="btnUpdatePw" class="save-btn">비밀번호 변경</button>
												        </div>
												    </form>
												</div>

<%-- (이하 스크립트 코드 동일) --%>

                        <div id="withdraw-user" class="wf-tab-content">
                            <div class="content-header">
                                <div class="content-title"><i data-lucide="user-x" color="#e53e3e"></i> 회원 탈퇴 안내</div>
                            </div>
                            <div class="withdraw-box">
                                <div class="withdraw-warning">
                                    <strong>정말로 탈퇴하시겠습니까?</strong><br>
                                    <ul>
                                        <li>탈퇴 시 모든 데이터와 활동 내역이 즉시 삭제됩니다.</li>
                                        <li>삭제된 데이터는 복구되지 않습니다.</li>
                                    </ul>
                                </div>
                                <button type="button" class="btn-withdraw-final" id="doWithdraw">회원 탈퇴하기</button>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </main>

    <footer>
        <div class="container">
            <p>© 2024 내면의 흔적. All rights reserved.</p>
        </div>
    </footer>

    <script>
$(document).ready(function() {
    lucide.createIcons();

    // 1. 비밀번호 변경 로직
    $('#btnUpdatePw').on('click', function() {
        let oldPw = $('#oldPw').val();
        let newPw = $('#newPw').val();
        let confirmPw = $('#newPwConfirm').val();
>>>>>>> feature/donghan-backup

        if(!oldPw) { alert("기존 비밀번호를 입력하세요."); return; }
        if(!newPw) { alert("새 비밀번호를 입력하세요."); return; }
        if(newPw !== confirmPw) {
            alert("새 비밀번호 재입력이 일치하지 않습니다.");
            return;
        }

        if(!confirm("비밀번호를 변경하시겠습니까?")) return;

        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/user/doUpdatePwAjax.do",
            data: { "oldPw": oldPw, "newPw": newPw },
            dataType: "json",
            success: function(res) {
                alert(res.message);
                if(res.flag == 1) {
                    location.reload(); 
                }
            },
            error: function() { alert("서버 통신 오류가 발생했습니다."); }
        });
    });

    // 2. 실시간 비밀번호 일치 확인
    $('#newPwConfirm').on('keyup', function() {
        if($('#newPw').val() === $(this).val()) {
            $('#pwMatchMsg').text("비밀번호가 일치합니다.").css("color", "green");
        } else {
            $('#pwMatchMsg').text("비밀번호가 일치하지 않습니다.").css("color", "#e53e3e");
        }
    });
    
    // 3. 내 정보 수정 로직 (AJAX)
    $('#userEditForm').on('submit', function(e) {
        e.preventDefault(); 

        let nickname = $('#nickname').val();
        let intro = $('#intro').val();

        if(!nickname) {
            alert("닉네임을 입력해주세요.");
            return;
        }

        if(!confirm("정보를 수정하시겠습니까?")) return;

        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/user/doUpdateInfoAjax.do",
            data: {
                "nickname": nickname,
                "userIntro": intro
            },
            dataType: "json",
            success: function(res) {
                alert(res.message);
                if(res.flag == 1) {
                    location.reload(); 
                }
            },
            error: function() {
                alert("서버 통신 오류가 발생했습니다.");
            }
        });
    });
}); // document.ready 종료

// --- 함수 정의 영역 (ready 바깥에 두는 것이 관리하기 편합니다) ---

// 닉네임 중복 체크 함수
function checkNickname() {
    let nickname = $('#nickname').val();
    if(!nickname) {
        alert("중복 확인을 할 닉네임을 입력하세요.");
        return;
    }
    // 현재는 알림창만 띄움 (추후 AJAX 연동 가능)
    alert("사용 가능한 닉네임입니다.");
} // 여기서 }); 가 아니라 } 로 끝나야 합니다.

// 탭 전환 함수
function switchCustomTab(tabId, event) {
    $('.wf-tab-content').removeClass('active');
    $('.wf-tab-btn').removeClass('active');

    $('#' + tabId).addClass('active');
    $(event.currentTarget).addClass('active');
}
</script>
</body>
</html>