package com.pcwk.ehr.diary.controller;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pcwk.ehr.diary.domain.DiaryVO;
import com.pcwk.ehr.diary.service.DiaryService;
import com.google.gson.Gson;
import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.StringUtil;


@Controller
@RequestMapping("/diary")

public class DiaryController {

    final Logger log = LogManager.getLogger(getClass());

    @Autowired
    DiaryService diaryService;

    public DiaryController() {
        // TODO Auto-generated constructor stub
    }

    @GetMapping(value="/diaryList.do")
    public String doPublicRetrieve(DTO dto, Model model) {
        log.debug("┌---------------------------┐");
        log.debug("│doPublicRetrieve dto: " + dto);  
        log.debug("└---------------------------┘");

        List<DiaryVO> bestList = diaryService.getBest3();

        log.debug("bestList : {}", bestList);

        String viewname = "diary/diary_list";

        int pageNo = StringUtil.nvlZero(dto.getPageNo(), 1);
        int pageSize = StringUtil.nvlZero(dto.getPageSize(), 10);

        String searchDiv = StringUtil.nullToEmpty(dto.getSearchDiv());
        String searchWord = StringUtil.nullToEmpty(dto.getSearchWord());

        dto.setPageNo(pageNo);
        dto.setPageSize(pageSize);
        dto.setSearchDiv(searchDiv);
        dto.setSearchWord(searchWord);
        log.debug("dto: " + dto);

        List<DiaryVO> list = diaryService.doPublicRetrieve(dto);
        // 좋아요 상위 3개 리스트 추가
        model.addAttribute("vo" , dto);
        model.addAttribute("list", list);
        model.addAttribute("bestList", bestList);

        return viewname;


    }

    @GetMapping("/fDiaryWrite.do")
    public String fDiaryWrite() {
        return "diary/f_diary_write";
    }

    @GetMapping("/fDiaryStart.do")
    public String fDiaryStart() {
        return "diary/f_diary_start";
    }

    @GetMapping("/lDiaryWrite.do")
    public String lDiaryWrite() {
        return "diary/l_diary_write";
    }

    @GetMapping("/lDiaryStart.do")
    public String lDiaryStart() {
        return "diary/l_diary_start";
    }

    @GetMapping("/tDiaryWrite.do")
    public String tDiaryWrite() {
        return "diary/t_diary_write";
    }
    @GetMapping("/tDiaryStart.do")
    public String tDiaryStart() {
        return "diary/t_diary_start";
    }

    @GetMapping("/rDiaryWrite.do")
    public String rDiaryWrite() {
        return "diary/r_diary_write";
    }
    @GetMapping("/rDiaryStart.do")
    public String rDiaryStart() {
        return "diary/r_diary_start";
    }


    @PostMapping(value="/diarySave.do", produces="application/json;charset=UTF-8")
    @ResponseBody
    public String doSave(DiaryVO param) {
        log.debug("┌---------------------------┐");
        log.debug("│doSave diaryVO: " + param);  
        log.debug("└---------------------------┘");

        String jsonString = "";

        int flag = diaryService.doSave(param);
        String message = "";
        if  (1 == flag) {
            message = param.getDiaryTitle() + "일기가 저장되었습니다.";
        }
        else {
            message = "일기 저장에 실패하였습니다.";
        }

        MessageVO messageVO = new MessageVO();
        messageVO.setFlag(flag);
        messageVO.setMessage(message);

        log.debug("mesasagevo: {}",messageVO);

        jsonString = new Gson().toJson(messageVO);


        return jsonString;
    }

    // @RequestMapping(value = "/diaryList.do", method = RequestMethod.GET)
    //     public String diaryList(Model model) {
    //     List<DiaryVO> bestList = diaryService.getBest3();
    //     List<DiaryVO> list = diaryService.getAll(); // 기존 전체 리스트
    //     model.addAttribute("bestList", bestList);
    //     model.addAttribute("list", list);
    //     return "diary/diary_list";
    // }
    
}
