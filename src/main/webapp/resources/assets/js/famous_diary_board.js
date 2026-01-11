$(document).off("click", ".likes-trigger").on("click", ".likes-trigger", function() {
    const $this = $(this);
    const $countSpan = $this.find(".like-count");
    const $heartIcon = $this.find("i");
    
    // 1. 현재 숫자를 가져와서 확실하게 숫자로 변환 (NaN 방지)
    let currentCount = parseInt($countSpan.text().replace(/[^0-9]/g, "")) || 0;
    
    // 2. 현재 상태 체크 (클래스나 data 속성 활용)
    const isLiked = $this.hasClass("active");

    if (!isLiked) {
        // 좋아요 누를 때
        $this.addClass("active");
        $countSpan.text(currentCount + 1); // 정확히 1만 증가
        $heartIcon.attr("fill", "#ef4444").attr("stroke", "#ef4444");
    } else {
        // 좋아요 취소할 때
        $this.removeClass("active");
        $countSpan.text(currentCount - 1); // 정확히 1만 감소
        $heartIcon.attr("fill", "none").attr("stroke", "currentColor");
    }

    // 서버 전송 (이 부분은 유지하되 응답값 처리에 주의)
    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/famous/doUpdateLike.do",
        data: { "famousSid": $this.closest(".post-card").data("sid") },
        success: function(res) {
            // 서버 응답 res가 랜덤값이라면 여기서는 아무것도 하지 마세요.
            console.log("DB 업데이트 완료");
        }
    });
});