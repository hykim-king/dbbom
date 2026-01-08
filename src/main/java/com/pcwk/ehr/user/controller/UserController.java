package com.pcwk.ehr.user.controller;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
        log.debug("│UserController()라         │");
        log.debug("└──────────────────────────┘");
    }

    /**
     * 회원가입 화면으로 이동
     */
    @GetMapping(value="/signUp.do")
    public String signUpView() {
        return "user/signUp";
    }

    /**
     * 회원가입 처리 - AJAX
     */
    @PostMapping(value = "/doSignUpAjax.do", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String doSignUpAjax(UserVO param) {
        int flag = 0;
        String message = "";
        try {
            if (param != null && (param.getAdminChk() == null || param.getAdminChk().trim().isEmpty())) {
                param.setAdminChk("N");
            }
            flag = userService.doSignUp(param);
            if (flag == 1) message = "가입이 완료 되었습니다.";
            else if (flag == -1) message = "가입에 실패 했습니다. (이미 사용 중인 아이디입니다.)";
            else message = "가입에 실패 했습니다. (입력값을 확인하세요.)";
        } catch (Exception e) {
            log.error("doSignUpAjax() 예외", e);
            flag = 0;
            message = "가입에 실패 했습니다. (서버 오류)";
        }
        return "{\"flag\":" + flag + ",\"message\":\"" + escapeJson(message) + "\"}";
    }

    /**
     * 로그인 화면 이동
     */
    @GetMapping(value = "/signIn.do")
    public String signInView() {
        log.debug("signInView() 이동");
        return "user/signIn";
    }
    /**
     * ✅ (기존 방식) 회원가입 처리(저장) - submit 방식
     * URL: /user/doSignUp.do (POST)
     */
    @PostMapping(value = "/doSignUp.do")
    public String doSignUp(UserVO param, Model model) {

        log.debug("┌──────────────────────────┐");
        log.debug("│doSignUp() - submit 방식  │");
        log.debug("└──────────────────────────┘");
        log.debug("param: {}", param);

        int flag = 0;
        try {
            flag = userService.doSignUp(param);
        } catch (Exception e) {
            log.error("doSignUp() 예외", e);
            model.addAttribute("msg", "회원가입에 실패했습니다. (서버 오류)");
            return "user/signUp";
        }

        if (flag == 1) {
            return "redirect:/resources/mainPage.jsp";
        }

        if (flag == -1) {
            model.addAttribute("msg", "이미 사용 중인 아이디입니다.");
            return "user/signUp";
        }

        model.addAttribute("msg", "회원가입에 실패했습니다. 입력값을 확인하세요.");
        return "user/signUp";
    }


    /**
     * 로그인 처리 - AJAX
     */
    @PostMapping(value="/doSignInAjax.do", produces="application/json;charset=UTF-8")
    @ResponseBody
    public String doSignInAjax(UserVO param, HttpSession session) {
        int flag = 0;
        String message = "";
        try {
            UserVO loginUser = userService.doSignIn(param);
            if (loginUser != null) {
                session.setAttribute("loginUser", loginUser);
                flag = 1;
                String who = (loginUser.getNickname() != null && !loginUser.getNickname().trim().isEmpty())
                        ? loginUser.getNickname() : loginUser.getUserId();
                message = who + "님 환영합니다.";
            } else {
                message = "로그인에 실패했습니다.";
            }
        } catch (Exception e) {
            message = "로그인 오류";
        }
        return "{\"flag\":" + flag + ",\"message\":\"" + escapeJson(message) + "\"}";
    }

    /**
     * 아이디 찾기 화면으로 이동
     */
    @GetMapping(value="/findIdView.do")
    public String findIdView() {
        return "user/findId";
    }

    /**
     * 비밀번호 찾기 화면으로 이동
     */
    @GetMapping(value="/findPwView.do")
    public String findPwView() {
        return "user/findPw";
    }

    /**
     * 아이디 찾기 실행 - 결과 페이지 이동 방식 (수정됨)
     */
    @PostMapping(value="/doFindId.do")
    public String doFindId(UserVO param, Model model) {
        log.debug("doFindId() param: {}", param);
        
        UserVO outVO = userService.doFindId(param);
        
        if(outVO != null) {
            // 성공 시 결과 페이지에 보여줄 데이터 전달
            model.addAttribute("foundId", outVO.getUserId());
            model.addAttribute("userName", outVO.getUserName());
        } else {
            // 실패 시 메시지 전달
            model.addAttribute("message", "입력하신 정보와 일치하는 아이디가 없습니다.");
        }
        
        // 결과 페이지(/WEB-INF/views/user/findIdResult.jsp)로 이동
        return "user/findIdResult";
    }

    /**
     * 로그아웃 처리
     */
    @PostMapping(value="/doLogoutAjax.do", produces="application/json;charset=UTF-8")
    @ResponseBody
    public String doLogoutAjax(HttpSession session) {
        session.invalidate();
        return "{\"flag\":1,\"message\":\"로그아웃 되었습니다.\"}";
    }

    // JSON 문자열 안전 처리
    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", " ").replace("\r", " ");
    }
}