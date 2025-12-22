package com.pcwk.ehr.user.controller;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.user.domain.UserVO;
import com.pcwk.ehr.user.service.UserService;
@Controller
@RequestMapping("/user")
public class UserController {
	
	final Logger log = LogManager.getLogger(getClass());
	
	@Autowired
	UserService userService;
	public UserController() {
		super();
		
		log.debug("┌──────────────────────────┐");
		log.debug("│──UserController──────────│");
		log.debug("└──────────────────────────┘");
	}
	
	@GetMapping(value="/doRetrieve.do")
	public String doRetrieve(DTO dto, Model model) {
		String viewName = "user/user_list";
		log.debug("┌──────────────────────────┐");
		log.debug("│──doRetrieve──────────────│");
		log.debug("└──────────────────────────┘");
		log.debug("1.dto{}"+dto);
		
		if(dto.getPageNo()==0) {
			dto.setPageNo(1);
		}
		
		if(dto.getPageSize()==0) {
			dto.setPageSize(10);
		}
		
		List<UserVO> list=userService.doRetrieve(dto);
		
		model.addAttribute("user_list",list);
		
		return viewName;
	}
	
	@PostMapping(value="/doDelete.do")
	@ResponseBody
	public String doDelete(@RequestParam(required = false, defaultValue = "99")String userId) {
		log.debug("┌──────────────────────────┐");
		log.debug("│──doDelete────────────────│");
		log.debug("└──────────────────────────┘");
		log.debug("1.userId:{}", userId);
		
		
		String jsonString = "";
		UserVO param=new UserVO();
		param.setUserId(userId);
		
		int flag = userService.doDelete(param);
		log.debug("2.flag:{}", flag);
		
		MessageVO message=new MessageVO();
		
		String messageString = "";
		if(1== flag) {
			messageString = "삭제되었습니다.";
		}else {
			messageString = "삭제 실패!";
		}
		message.setFlag(flag);
		message.setMessage(messageString);
		
		jsonString = new Gson().toJson(message);
		log.debug("3.jsonString:\n{}", jsonString);
		
		return jsonString;
		
	}
	
	@GetMapping(value ="/doSelectOne.do")
	public String doSelectOne(@RequestParam(required = false, defaultValue ="99") String userId,Model model) {
		log.debug("┌──────────────────────────┐");
		log.debug("│──doSave──────────────────│");
		log.debug("└──────────────────────────┘");
		log.debug("1.userId:{}", userId);
		UserVO param=new UserVO();
		param.setUserId(userId);
		
		UserVO outVO = userService.doSelectOne(param);
		log.debug("2.outVO:{}", outVO);
		model.addAttribute("user",outVO);
		
		return "user/user_mng";
	}
	
	@GetMapping("/{userId}")
	public String pathVal(@PathVariable String userId) {
		log.debug("┌──────────────────────────┐");
		log.debug("│──doSave──────────────────│");
		log.debug("└──────────────────────────┘");
		
		log.debug("1.userId{}", userId);
		
		return "";
	}
	
	@GetMapping(value = "/viewDoSave.do")
	public String viewDoSave() {
		log.debug("┌──────────────────────────┐");
		log.debug("│─viewDoSave───────────────│");
		log.debug("└──────────────────────────┘");
		
		return "user/user_reg";
	}
	
	@GetMapping(value = "/ajaxWiewDoSave.do")
	public String ajaxWiewDoSave() {
		log.debug("┌──────────────────────────┐");
		log.debug("│ajaxWiewDoSave────────────│");
		log.debug("└──────────────────────────┘");
		
		return "user/ajax_user_reg";
	}
	
	//JSON -> JSON데이터
	@PostMapping(value = "/doSave.do",produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String doSave(UserVO param) {
		log.debug("┌──────────────────────────┐");
		log.debug("│──doSave──────────────────│");
		log.debug("└──────────────────────────┘");
		
		String viewName = "user/user_mng";
		
		log.debug("1.param:{}",param);
		
		int flag = userService.doSave(param);
		log.debug("2.flag:{}",flag);
		
		String message = "";
		if( 1==flag) {
			message = param.getName() + "님이 등록 되었습니다.";
		}else {
			message = param.getName() + "등록 실패했습니다.";
		}
		
		MessageVO messageVO = new MessageVO();
		messageVO.setFlag(flag);
		messageVO.setMessage(message);
		
		log.debug("3.message:{}",message);
		log.debug("4.viewName:{}",viewName);
		Gson gson=new Gson();
		String jsonString = gson.toJson(messageVO);
		log.debug("4.jsonString:{}\n:{}",jsonString);
		
		return jsonString;
		
	}
	
	
}
