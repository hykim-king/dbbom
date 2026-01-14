<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>신고하기</title>
    <%-- 원래 사용하시던 스타일과 외부 JS 경로 그대로 유지 --%>
    <script src="${pageContext.request.contextPath}/resources/assets/js/reportpage.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/reportpage.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body>
    <div class="header"><span class="header-icon">🚨</span> 신고하기</div>

    <%-- onsubmit을 제거하여 브라우저의 자동 제출 기능을 완전히 끕니다 --%>
    <form id="reportForm" onsubmit="return false;">
      
      <%-- 데이터 보정용 필드 --%>
      <input type="hidden" name="famousSid" id="famousSid" value="${famousVO.famousSid}" />
      <input type="hidden" name="commentSid" id="commentSid" value="" />
      
      <div class="container">
        <c:if test="${not empty errorMsg}">
          <script>alert('${errorMsg}'); window.close();</script>
        </c:if>
        
        <div class="row">
          <div class="label">명언 내용</div>
          <div class="value">${famousVO.famousContent}</div>
        </div>

        <div class="row">
          <div class="label">작성자 닉네임</div>
          <div class="value">${famousVO.nickname}</div>
        </div>

        <div class="row">
          <div class="label">신고자 닉네임</div>  
          <div class="value">
            <c:choose>
              <c:when test="${not empty sessionScope.loginUser.nickname}">${sessionScope.loginUser.nickname}</c:when>
              <c:otherwise>-</c:otherwise>
            </c:choose>
          </div>
        </div>

        <div class="row">
          <div class="label">신고사유</div>
          <div class="value radio-group">
            <label><input type="radio" name="reportCategory" value="10" checked required /> 욕설/비방</label>
            <label><input type="radio" name="reportCategory" value="20" /> 음란성</label>
            <label><input type="radio" name="reportCategory" value="30" /> 홍보/상업성</label>
            <label><input type="radio" name="reportCategory" value="40" /> 개인정보유출</label>
            <label><input type="radio" name="reportCategory" value="50" /> 도배</label>
            <label><input type="radio" name="reportCategory" value="60" /> 기타</label>
          </div>
        </div>
        <div class="row">
          <%-- id="reportContent" 추가 (스크립트 제어용) --%>
          <textarea class="textarea-box" name="reportContent" id="reportContent" placeholder="신고 사유를 상세히 입력해주세요." required></textarea>
        </div>
        <div class="info-box">
          신고 게시물은 삭제되며, 해당 게시물을 올린 유저는 덧글쓰기 및 글쓰기 제한을 받을 수 있습니다.<br />
          단, 허위신고일 경우, 신고자의 활동에 제한을 받게 되오니, 그 점 유의해 주시기 바랍니다.
        </div>
      </div>
      <div class="footer-buttons">
        <%-- type="button"으로 변경하고 onclick 함수만 실행되게 합니다 --%>
        <button type="button" class="btn btn-submit" onclick="doFinalSave()">🚨 신고하기</button>
        <button type="button" class="btn btn-close" onclick="window.close();">닫 기</button>
      </div>
    </form>

    <script>
      $(document).ready(function() {
          // 1. 페이지 로드 시 URL 파라미터에서 ID를 읽어 바구니에 담음
          const urlParams = new URLSearchParams(window.location.search);
          const cSid = urlParams.get('id') || urlParams.get('commentSid');
          if (cSid) $("#commentSid").val(cSid);
      });

      // 2. [최종 전송 함수] 알림창이 한 번만 뜨도록 AJAX로만 처리
      function doFinalSave() {
          const content = $("#reportContent").val().trim();
          if(!content) {
              alert("신고 사유를 입력해주세요.");
              return;
          }

          $.ajax({
              type: "POST",
              url: "${pageContext.request.contextPath}/report/doSave.do",
              data: $("#reportForm").serialize(),
              success: function(res) {
                  // 서버에서 오는 JSON 데이터를 안전하게 파싱
                  const data = (typeof res === "string") ? JSON.parse(res) : res;
                  
                  if (data.result) {
                      alert("신고가 정상적으로 접수되었습니다.");
                      window.close(); // 성공 시 팝업 즉시 닫기
                  } else {
                      alert(data.msg || "신고 처리에 실패했습니다.");
                  }
              },
              error: function() {
                  alert("서버 통신 중 오류가 발생했습니다.");
              }
          });
      }
    </script>
  </body>
</html>