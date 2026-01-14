package com.pcwk.ehr.report.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.ui.Model;

import com.pcwk.ehr.diary.service.DiaryService;
import com.pcwk.ehr.famous.service.FamousService;
import com.pcwk.ehr.report.domain.ReportVO;
import com.pcwk.ehr.report.service.ReportService;

import com.pcwk.ehr.famous.domain.FamousVO;
import com.pcwk.ehr.comment.service.CommentService;
import com.pcwk.ehr.diary.domain.DiaryVO;
import com.pcwk.ehr.comment.domain.CommentVO;
import com.pcwk.ehr.user.domain.UserVO;
import org.springframework.beans.factory.annotation.Autowired;

@Controller
public class reportController {

    private final Logger log = LogManager.getLogger(getClass());

    public reportController() {
        super();
        log.debug("┌──────────────────────────┐");
        log.debug("│reportController          │");
        log.debug("└──────────────────────────┘");
    }

    @Autowired
    DiaryService diaryService;

    @Autowired
    FamousService famousService;

    @Autowired
    ReportService reportService;

    @Autowired
    CommentService commentService;

    // 1. 일기 신고 페이지 (기존 유지)
    @GetMapping(value = "/report/reportPage.do")
    public String reportPage(@RequestParam(value = "id", required = false) Integer diarySid, Model model, HttpSession session) {
        Object loginUser = session.getAttribute("loginUser");
        if (loginUser == null) {
            model.addAttribute("errorMsg", "로그인 후 이용 가능합니다.");
            return "report/report_page";
        }
        if (diarySid != null) {
            DiaryVO diaryVO = new DiaryVO();
            diaryVO.setDiarySid(diarySid);
            DiaryVO outVO = diaryService.upDoSelectOne(diaryVO);
            model.addAttribute("diaryVO", outVO);
        }
        return "report/report_page";
    }

    // 2. 명언 및 댓글 신고 페이지 통합 (기존 유지)
    @GetMapping(value = "/report/famousReportPage.do")
    public String famousReportPage(@RequestParam(value = "id", required = false) Integer famousSid, Model model, HttpSession session) {
        Object loginUser = session.getAttribute("loginUser");
        if (loginUser == null) {
            model.addAttribute("errorMsg", "로그인 후 이용 가능합니다.");
            return "report/famous_report_page";
        }
        if (famousSid != null) {
            FamousVO famousVO = new FamousVO();
            famousVO.setFamousSid(famousSid);
            FamousVO outVO = famousService.doSelectOne(famousVO);
            model.addAttribute("famousVO", outVO);
        }
        return "report/famous_report_page";
    }

    // 3. 댓글 전용 신고 페이지 (기존 유지)
    @GetMapping(value = "/report/commentReportPage.do")
    public String commentReportPage(@RequestParam(value = "id", required = false) Integer commentSid, Model model, HttpSession session) {
        Object loginUser = session.getAttribute("loginUser");
        if (loginUser == null) {
            model.addAttribute("errorMsg", "로그인 후 이용 가능합니다.");
            return "report/comment_report_page";
        }
        if (commentSid != null) {
            CommentVO commentVO = new CommentVO();
            commentVO.setCommentSid(commentSid);
            CommentVO outVO = commentService.doSelectOne(commentSid);
            model.addAttribute("commentVO", outVO);
        }
        return "report/comment_report_page";
    }

    // 4. [핵심 수정] 신고 저장 로직 (데이터 누락 및 세션 처리 보정)
    @PostMapping(value = "/report/doSave.do", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String doSave(ReportVO param, HttpSession session, HttpServletRequest request) {
        
        // [추가] JSP 파라미터 이름(id)과 VO 필드명(commentSid) 불일치 해결
        // 팝업창 URL에서 'id'로 넘어온 값을 commentSid에 수동으로 매핑합니다.
        String idParam = request.getParameter("id");
        if(idParam != null && !idParam.isEmpty()) {
            try {
                param.setCommentSid(Integer.parseInt(idParam));
            } catch (NumberFormatException e) {
                log.error("ID 파라미터 변환 오류: {}", idParam);
            }
        }

        // 세션에서 로그인 사용자 정보 가져오기
        Object loginObj = session.getAttribute("loginUser");
        if (loginObj == null) {
            return "{\"result\":false,\"msg\":\"로그인 후 이용 가능합니다.\"}";
        }

        // [보정] 가장 확실한 방식으로 regId 세팅
        String regId = null;
        try {
            if (loginObj instanceof UserVO) {
                regId = ((UserVO)loginObj).getUserId();
            } else {
                // 기존 리플렉션 방식 유지 (UserVO 임포트 오류 시 대비)
                regId = (String)loginObj.getClass().getMethod("getUserId").invoke(loginObj);
            }
        } catch (Exception e) {
            log.error("사용자 정보 추출 실패: {}", e.getMessage());
            return "{\"result\":false,\"msg\":\"사용자 정보 오류\"}";
        }
        param.setRegId(regId);

        log.debug("┌---------------------------┐");
        log.debug("│ 최종 전송 데이터: {}", param);
        log.debug("└---------------------------┘");

        try {
            int flag = reportService.doSave(param);
            if(flag > 0) {
                return "{\"result\":true,\"msg\":\"신고가 접수되었습니다.\"}";
            } else {
                return "{\"result\":false,\"msg\":\"신고 저장 실패\"}";
            }
        } catch (Exception e) {
            log.error("DB 저장 에러 (제약조건 위반 가능성): {}", e.getMessage());
            return "{\"result\":false,\"msg\":\"처리 중 오류가 발생했습니다.\"}";
        }
    }
}