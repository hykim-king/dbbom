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
    public String doRetrieve(DTO dto, Model model) {
        log.debug("┌---------------------------┐");
        log.debug("│doRetrieve dto: " + dto);  
        log.debug("└---------------------------┘");

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

        List<DiaryVO> list = diaryService.doRetrieve(dto);
        model.addAttribute("vo" , dto);
        model.addAttribute("list", list);

        return viewname;


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
    
}
