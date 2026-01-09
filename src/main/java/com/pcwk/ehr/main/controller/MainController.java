package com.pcwk.ehr.main.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	 final Logger log = LogManager.getLogger(getClass());
	 
	 public MainController() {
	        super();
	        log.debug("┌──────────────────────────┐");
	        log.debug("│MainController()          │");
	        log.debug("└──────────────────────────┘");
	    }
	 
	 /**
	 * 회원가입 화면으로 이동
	  */
	@GetMapping(value = "/main/main.do")
	public String mainStart() {
		return "main/main_page";
	}
	 
	@GetMapping(value = "/notice/notice.do")
	public String noticeStart() {
		return "notice/notice_start";
	}
	
	@GetMapping(value = "/diary/diarylist.do")
	public String diaryList() {
		return "diary/diary_list";
	}
	
	@GetMapping(value = "/famous/famousboard.do")
	public String famousBoard() {
		return "famous/famous_board";
	}

}