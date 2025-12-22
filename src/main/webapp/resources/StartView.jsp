<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내면의 흔적 - 시작 화면</title>
    <style>
        /* CSS 스타일 정의 */
        .container {
            width: 800px; /* 전체 너비 설정 (필요에 따라 조절) */
            margin: 20px auto; /* 중앙 정렬 */
            padding: 10px;
            background-color: #e0e0e0; /* 배경색 (캡처 화면의 회색 배경) */
            border: 1px solid #c0c0c0;
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
            display: flex; /* 내부 요소 배치를 위해 flex 사용 */
            flex-direction: column; /* 세로로 쌓기 */
            align-items: center; /* 가운데 정렬 */
            min-height: 500px; /* 최소 높이 설정 */
        }

        .blue-box {
            background-color: #4a90e2; /* 파란색 */
            color: white;
            padding: 20px;
            margin-bottom: 20px;
            text-align: center;
            border: 1px solid #3a7bd5;
            box-sizing: border-box;
            width: 90%; /* 박스 너비 */
            line-height: 1.5; /* 줄 간격 */
        }
        
        /* 상단 영역 스타일 */
        .header-section {
            display: flex;
            justify-content: space-between; /* 양 끝 정렬 */
            align-items: center;
            width: 90%; /* 컨테이너와 동일한 너비 */
            margin-bottom: 30px;
            margin-top: 10px;
        }

        .header-box {
            background-color: #4a90e2;
            color: white;
            padding: 10px 20px;
            border: 1px solid #3a7bd5;
            font-weight: bold;
            cursor: pointer;
        }

        /* 시작하기 버튼 스타일 (특별히 폼 안에 배치) */
        .start-form button {
            background-color: #4a90e2;
            color: white;
            padding: 10px 20px;
            border: 1px solid #3a7bd5;
            font-weight: bold;
            cursor: pointer;
            width: 100%; /* 부모 요소에 꽉 채우기 */
            /* 버튼 기본 스타일 제거 */
            border: none;
            font-size: 1em;
            font-family: inherit;
        }
        
        .start-form {
            /* 캡처화면의 '시작하기' 박스와 '내면의 흔적' 박스 크기를 비슷하게 맞추기 위해 너비 설정 */
            width: auto; 
            height: auto; 
            display: inline-block;
        }
    </style>
</head>
<body>

    <div class="container">
        
        <div class="header-section">
            <div class="header-box">내면의 흔적</div>
            
            <form action="mainPage.jsp" method="get" class="start-form">
                <button type="submit">시작하기</button>
            </form>
        </div>

        <div class="blue-box">
            오늘의 위로를 내일의 너에게: 
            "**내 걸음의 방향은 언제나 내가 선택할 수 있다**. **"내일의 내가 걱정되시나요? 하지만 언제 그랬냐는 듯 당신은 누구보다 멋지게 해낼 사람입니다. 당신의 이야기를 기록해보세요**"
        </div>

        <div class="blue-box">
            저희 "**내면의 흔적**"은 괴롭고 지치고 힘들거나, 또는 행복하고 감사한 일이 있을 때 부담 없이 찾아와 일기를 작성하며 마음의 안정을 얻을 수 있는 장소입니다. 내 감정의 맞는 일기를 작성해보시고 자유롭게 공유해보세요.
        </div>

    </div>
    
</body>
</html>