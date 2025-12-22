<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My WebApp - 내면의 흔적</title>
    <style>
        /* CSS 스타일 정의 (이전과 동일) */
        .container {
            width: 800px; /* 전체 너비 설정 */
            margin: 20px auto;
            padding: 10px;
            background-color: #e0e0e0; /* 회색 배경 */
            border: 1px solid #c0c0c0;
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
        }

        .blue-box {
            background-color: #4a90e2;
            color: white;
            padding: 10px;
            margin-bottom: 10px;
            text-align: center;
            border: 1px solid #3a7bd5;
            box-sizing: border-box;
        }

        .header-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .header-top-right {
            background-color: #4a90e2;
            color: white;
            padding: 5px 10px;
            border: 1px solid #3a7bd5;
            font-size: 0.9em;
        }

        .main-menu {
            display: flex;
            justify-content: space-around;
        }

        .menu-group {
            display: flex;
            flex-grow: 1;
            justify-content: space-around;
        }

        .sub-menu-container {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }

        .sub-menu-item {
            width: 24%;
            text-align: center;
        }

        .sub-menu-button {
            background-color: #4a90e2;
            color: white;
            padding: 10px 0;
            margin-bottom: 5px;
            border: 1px solid #3a7bd5;
        }

        .sub-menu-description {
            background-color: #4a90e2;
            color: white;
            padding: 5px 0;
            font-size: 0.8em;
            border: 1px solid #3a7bd5;
        }

        .diary-section-title {
            margin-top: 20px;
            margin-bottom: 10px;
            font-weight: bold;
        }

        .diary-posts-container {
            display: flex;
            justify-content: space-between;
        }

        .diary-post {
            width: 24%;
            height: 150px;
            background-color: #4a90e2;
            color: white;
            padding: 15px;
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            border: 1px solid #3a7bd5;
        }

        .text-left {
            text-align: left;
        }
        
        /* 메뉴 링크 스타일 추가 */
        .menu-link {
            color: inherit;
            text-decoration: none;
            cursor: pointer;
        }
        
        .menu-link:hover {
            text-decoration: underline;
        }
        
    </style>
</head>
<body>

    <div class="container">
        
        <div class="header-top">
            <div class="text-left">내면의 흔적</div>
            <div class="header-top-right">회원가입/로그인/마이페이지</div>
        </div>

        <div class="blue-box main-menu">
            <div>메뉴</div>
            <div class="menu-group">
                <a href="summaryPage.jsp" class="menu-link">개요</a> / 
                <span class="menu-link">공지사항</span> / 
                <span class="menu-link">게시판</span> / 
                <span class="menu-link">나의 내면</span>
            </div>
        </div>

        <div class="sub-menu-container">
            <div class="sub-menu-item">
                <div class="sub-menu-button">명언</div>
                <div class="sub-menu-description">설명</div>
            </div>
            <div class="sub-menu-item">
                <div class="sub-menu-button">행운</div>
                <div class="sub-menu-description">설명</div>
            </div>
            <div class="sub-menu-item">
                <div class="sub-menu-button">감사</div>
                <div class="sub-menu-description">설명</div>
            </div>
            <div class="sub-menu-item">
                <div class="sub-menu-button">고해성사</div>
                <div class="sub-menu-description">설명</div>
            </div>
        </div>

        <div class="diary-section-title">일기 게시글</div>
        
        <div class="diary-posts-container">
            <div class="diary-post">
                <div>인기 공개 일기 1</div>
                <div>(명언)</div>
            </div>
            <div class="diary-post">
                <div>인기 공개 일기 1</div>
                <div>(행운)</div>
            </div>
            <div class="diary-post">
                <div>인기 공개 일기 1</div>
                <div>(행운)</div>
            </div>
            <div class="diary-post">
                <div>인기 공개 일기 1</div>
                <div>(고해성사)</div>
            </div>
        </div>

    </div>
    
</body>
</html>