package com.pcwk.ehr.report.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.ui.Model;

import com.pcwk.ehr.diary.service.DiaryService;
import com.pcwk.ehr.report.domain.ReportVO;
import com.pcwk.ehr.report.service.ReportService;

import oracle.jdbc.proxy.annotation.Post;

import com.pcwk.ehr.diary.domain.DiaryVO;
import org.springframework.beans.factory.annotation.Autowired;

@Controller
public class reportController {

    private final Logger log = LogManager.getLogger(getClass());

    public reportController() {
        super();
        log.debug("┌──────────────────────────┐");
        log.debug("│reportController            │");
        log.debug("└──────────────────────────┘");
    }

    @Autowired
    DiaryService diaryService;

    @Autowired
    ReportService reportService;

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

    @PostMapping(value = "/report/doSave.do", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String doSave(ReportVO param, HttpSession session) {
        // 세션에서 로그인 사용자 정보 가져오기
        Object loginUser = session.getAttribute("loginUser");
        if (loginUser == null) {
            return "{\"result\":false,\"msg\":\"로그인 후 이용 가능합니다.\"}";
        }
        // UserVO로 캐스팅 후 regId 세팅 (UserVO에 getUserId() 또는 getId() 등 실제 필드명에 맞게 수정 필요)
        String regId = null;
        try {
            regId = (String)loginUser.getClass().getMethod("getUserId").invoke(loginUser);
        } catch (Exception e) {
            return "{\"result\":false,\"msg\":\"사용자 정보 오류\"}";
        }
        param.setRegId(regId);

        log.debug("┌---------------------------┐");
        log.debug("│doSave param: {}", param);
        log.debug("└---------------------------┘");
        log.debug("reportCategory value: {}", param.getReportCategory());

        // 신고사유 유효성 검사
        // if(param.getReportCategory() == 0) {
        //     return "{\"result\":false,\"msg\":\"신고사유를 선택하세요.\"}";
        // }

        int flag = reportService.doSave(param);
        if(flag > 0) {
            return "{\"result\":true,\"msg\":\"신고가 접수되었습니다.\"}";
        } else {
            return "{\"result\":false,\"msg\":\"신고 저장 실패\"}";
        }
    }

}