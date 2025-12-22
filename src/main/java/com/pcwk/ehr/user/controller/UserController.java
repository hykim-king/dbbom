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

    // ✅ (추가) 포털 이동
    // URL: /user/portal.do
    // View: /WEB-INF/views/user/portal.jsp
    @GetMapping(value = "/portal.do")
    public String portal() {
        log.debug("┌──────────────────────────┐");
        log.debug("│──portal──────────────────│");
        log.debug("└──────────────────────────┘");

        return "user/portal";
    }

    // ✅ 목록조회
    @GetMapping(value = "/doRetrieve.do")
    public String doRetrieve(DTO dto, Model model) {
        String viewName = "user/user_list";
        log.debug("┌──────────────────────────┐");
        log.debug("│──doRetrieve──────────────│");
        log.debug("└──────────────────────────┘");
        log.debug("1.dto: {}", dto);

        if (dto.getPageNo() == 0) dto.setPageNo(1);
        if (dto.getPageSize() == 0) dto.setPageSize(10);

        List<UserVO> list = userService.doRetrieve(dto);
        model.addAttribute("user_list", list);

        return viewName;
    }

    // ✅ 단건조회(수정 화면 진입)
    @GetMapping(value = "/doSelectOne.do")
    public String doSelectOne(@RequestParam(required = true) String userId, Model model) {
        log.debug("┌──────────────────────────┐");
        log.debug("│──doSelectOne─────────────│");
        log.debug("└──────────────────────────┘");
        log.debug("1.userId: {}", userId);

        UserVO param = new UserVO();
        param.setUserId(userId);

        UserVO outVO = userService.doSelectOne(param);
        log.debug("2.outVO: {}", outVO);

        model.addAttribute("user", outVO);

        return "user/user_mng";
    }

    // ✅ 회원가입 화면
    @GetMapping(value = "/viewDoSave.do")
    public String viewDoSave() {
        log.debug("┌──────────────────────────┐");
        log.debug("│──viewDoSave──────────────│");
        log.debug("└──────────────────────────┘");

        return "user/user_reg";
    }

    // ✅ (선택) ajax 회원가입 화면
    @GetMapping(value = "/ajaxWiewDoSave.do")
    public String ajaxWiewDoSave() {
        log.debug("┌──────────────────────────┐");
        log.debug("│──ajaxWiewDoSave──────────│");
        log.debug("└──────────────────────────┘");

        return "user/ajax_user_reg";
    }

    // ✅ 회원가입 저장(JSON)
    // user_reg.jsp에서 AJAX로 호출
    @PostMapping(value = "/doSave.do", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String doSave(UserVO param) {
        log.debug("┌──────────────────────────┐");
        log.debug("│──doSave──────────────────│");
        log.debug("└──────────────────────────┘");
        log.debug("1.param: {}", param);

        int flag = userService.doSave(param);
        log.debug("2.flag: {}", flag);

        String message = (flag == 1)
                ? param.getName() + "님이 등록 되었습니다."
                : param.getName() + " 등록 실패했습니다.";

        MessageVO messageVO = new MessageVO();
        messageVO.setFlag(flag);
        messageVO.setMessage(message);

        String jsonString = new Gson().toJson(messageVO);
        log.debug("3.jsonString:\n{}", jsonString);

        return jsonString;
    }

    // ✅ 수정(JSON)  ← 대표님 user_mng.jsp가 호출하는 API
    @PostMapping(value = "/doUpdate.do", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String doUpdate(UserVO param) {
        log.debug("┌──────────────────────────┐");
        log.debug("│──doUpdate────────────────│");
        log.debug("└──────────────────────────┘");
        log.debug("1.param: {}", param);

        int flag = userService.doUpdate(param);
        log.debug("2.flag: {}", flag);

        MessageVO messageVO = new MessageVO();
        messageVO.setFlag(flag);
        messageVO.setMessage(flag == 1 ? "수정되었습니다." : "수정 실패!");

        String jsonString = new Gson().toJson(messageVO);
        log.debug("3.jsonString:\n{}", jsonString);

        return jsonString;
    }

    // ✅ 삭제(JSON)
    @PostMapping(value = "/doDelete.do", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String doDelete(@RequestParam(required = true) String userId) {
        log.debug("┌──────────────────────────┐");
        log.debug("│──doDelete────────────────│");
        log.debug("└──────────────────────────┘");
        log.debug("1.userId: {}", userId);

        UserVO param = new UserVO();
        param.setUserId(userId);

        int flag = userService.doDelete(param);
        log.debug("2.flag: {}", flag);

        MessageVO messageVO = new MessageVO();
        messageVO.setFlag(flag);
        messageVO.setMessage(flag == 1 ? "삭제되었습니다." : "삭제 실패!");

        String jsonString = new Gson().toJson(messageVO);
        log.debug("3.jsonString:\n{}", jsonString);

        return jsonString;
    }

    // ⚠️ (주의) 이 매핑은 없어도 됩니다.
    // /user/{userId}가 .do 보다 우선순위 낮긴 하지만, 초보 단계에선 혼동 원인이 될 수 있어요.
    // 필요하면 유지, 아니면 삭제 권장.
    @GetMapping("/{userId}")
    public String pathVal(@PathVariable String userId) {
        log.debug("┌──────────────────────────┐");
        log.debug("│──pathVal─────────────────│");
        log.debug("└──────────────────────────┘");
        log.debug("1.userId: {}", userId);

        return "";
    }
}
