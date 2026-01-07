<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>명언일기 | 작성하기</title>
        <script src="https://unpkg.com/lucide@latest"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/f_diary_write.js"></script>
    <link rel="stylesheet" href="../css/f_diary_write.css">
</head>
<body>
 <!-- Header -->
   <header>
  <div class="container header-inner flex-between">
    <div class="logo-area">
     
      <h1 class="logo-text">내면의 흔적</h1>
    </div>
    <button class="login-btn">로그인</button>
  </div>
</header>

    <!-- Main Content -->
    <main class="container">
      <!-- Navigation Tabs -->
     <div class="tab-list">
  <div class="menu-label">메뉴</div>
  <button class="tab-btn" data-tab="overview" aria-selected="false">
    <i data-lucide="sparkles"></i> 개요
  </button>
  <button class="tab-btn" data-tab="notice" aria-selected="false">
    <i data-lucide="book-open"></i> 공지사항
  </button>
  <button class="tab-btn" data-tab="board" aria-selected="false">
    <i data-lucide="pencil"></i> 게시판
  </button>
  <button class="tab-btn" data-tab="mypage" aria-selected="false">
    <i data-lucide="user"></i> 마이페이지
  </button>
   </main>
</div>

    <!-- Diary Entry Form -->
    <main class="container">
        <div class="card diary-card">
          <div class="diary-st">
  <span class="icon-circle">
    <i data-lucide="quote"></i>
  </span>
  <span class="diary-title-text">오늘의 흔적</span>
</div>
            <div class="diary-header flex-between">
                <input type="text" class="diary-title" id="diaryTitle" name="diaryTitle" placeholder="제목을 입력하세요">
            </div>
            <textarea class="diary-content" id="diaryContent" name="diaryContent" placeholder="오늘의 일기를 작성해보세요"></textarea>
            
<div class="diary-footer">
    <div class="radio-group">
        <label class="radio-label">
            <input type="radio" name="diaryStatus" value="Y"> 공개
        </label>
        <label class="radio-label">
            <input type="radio" name="diaryStatus" value="N"> 비공개
        </label>
    </div>
    <button class="diary-btn" id="savefDiary">등록</button>
</div>

    </main>


</body>
<script src="https://unpkg.com/lucide@latest"></script>
<script>
    lucide.createIcons();
</script>
</html>
