package com.pcwk.ehr.user.controller;

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
        log.debug("│──UserController 생성     ──│");
        log.debug("└──────────────────────────┘");
    }

    // ✅ 포털(메인) 화면 이동
    @GetMapping(value = "/portal.do")
    public String portal() {
        log.debug("Step: portal 이동");
        return "user/portal";
    }

    // ✅ 회원 목록 조회
    @GetMapping(value = "/doRetrieve.do")
    public String doRetrieve(DTO dto, Model model) {
        log.debug("Step: doRetrieve [매개변수: {}]", dto);

        // 페이징 기본값 설정
        if (dto.getPageNo() == 0) dto.setPageNo(1);
        if (dto.getPageSize() == 0) dto.setPageSize(10);

        List<UserVO> list = userService.doRetrieve(dto);
        model.addAttribute("user_list", list);

        return "user/user_list";
    }

    // ✅ 회원 상세 조회 (수정 화면 진입용)
    @GetMapping(value = "/doSelectOne.do")
    public String doSelectOne(@RequestParam(required = true) String userId, Model model) {
        log.debug("Step: doSelectOne [ID: {}]", userId);

        UserVO param = new UserVO();
        param.setUserId(userId);

        UserVO outVO = userService.doSelectOne(param);
        log.debug("Result: outVO: {}", outVO);

        model.addAttribute("user", outVO);

        return "user/user_mng";
    }

    // ✅ 회원가입 화면 이동
    @GetMapping(value = "/viewDoSave.do")
    public String viewDoSave() {
        return "user/user_reg";
    }

    // ✅ 회원가입 저장 처리 (AJAX 호출 대응)
    @PostMapping(value = "/doSave.do", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String doSave(UserVO param) {
        log.debug("Step: doSave [데이터: {}]", param);

        int flag = userService.doSave(param);
        
        // VO 필드명 변경 반영: name -> userName
        String message = (flag == 1)
                ? param.getUserName() + "님이 성공적으로 등록되었습니다."
                : "회원 등록에 실패했습니다.";

        MessageVO messageVO = new MessageVO();
        messageVO.setFlag(flag);
        messageVO.setMessage(message);

        return new Gson().toJson(messageVO);
    }

    // ✅ 회원 정보 수정 처리 (AJAX 호출 대응)
    @PostMapping(value = "/doUpdate.do", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String doUpdate(UserVO param) {
        log.debug("Step: doUpdate [데이터: {}]", param);

        int flag = userService.doUpdate(param);
        
        MessageVO messageVO = new MessageVO();
        messageVO.setFlag(flag);
        messageVO.setMessage(flag == 1 ? "수정되었습니다." : "수정 실패!");

        return new Gson().toJson(messageVO);
    }

    // ✅ 회원 삭제 처리 (AJAX 호출 대응)
    @PostMapping(value = "/doDelete.do", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String doDelete(@RequestParam(required = true) String userId) {
        log.debug("Step: doDelete [ID: {}]", userId);

        UserVO param = new UserVO();
        param.setUserId(userId);

        int flag = userService.doDelete(param);

        MessageVO messageVO = new MessageVO();
        messageVO.setFlag(flag);
        messageVO.setMessage(flag == 1 ? "삭제되었습니다." : "삭제 실패!");

        return new Gson().toJson(messageVO);
    }
}