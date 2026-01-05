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
        log.debug("│UserController()          │");
        log.debug("└──────────────────────────┘");
    }

    /**
     * 회원가입 화면으로 이동
     * URL: /user/signUp.do (GET)
     * VIEW: /WEB-INF/views/user/signUp.jsp
     */
    @GetMapping(value="/signUp.do")
    public String signUpView() {
        log.debug("┌──────────────────────────┐");
        log.debug("│signUpView()              │");
        log.debug("└──────────────────────────┘");
        return "user/signUp";
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
     * ✅ 회원가입 처리 - AJAX(JSON)
     * URL: /user/doSignUpAjax.do (POST)
     * 응답 예: {"flag":1,"message":"가입이 완료 되었습니다."}
     */
    @PostMapping(value = "/doSignUpAjax.do", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String doSignUpAjax(UserVO param) {

        log.debug("┌──────────────────────────┐");
        log.debug("│doSignUpAjax() - AJAX 방식│");
        log.debug("└──────────────────────────┘");
        log.debug("param: {}", param);

        int flag = 0;
        String message = "";

        try {
            // 일반회원 기본값 강제(N). (관리자=Y, 일반=N 규칙)
            if (param != null && (param.getAdminChk() == null || param.getAdminChk().trim().isEmpty())) {
                param.setAdminChk("N");
            }

            flag = userService.doSignUp(param);

            if (flag == 1) {
                message = "가입이 완료 되었습니다.";
            } else if (flag == -1) {
                message = "가입에 실패 했습니다. (이미 사용 중인 아이디입니다.)";
            } else {
                message = "가입에 실패 했습니다. (입력값을 확인하세요.)";
            }

        } catch (Exception e) {
            log.error("doSignUpAjax() 예외", e);
            flag = 0;
            message = "가입에 실패 했습니다. (서버 오류: " + e.getMessage() + ")";
        }

        return "{\"flag\":" + flag + ",\"message\":\"" + escapeJson(message) + "\"}";
    }

    /**
     * 로그인 화면(GET)
     * URL: /user/signIn.do
     * VIEW: /WEB-INF/views/user/signIn.jsp
     */
    @GetMapping(value = "/signIn.do")
    public String signInView() {
        log.debug("┌──────────────────────────┐");
        log.debug("│signInView()              │");
        log.debug("└──────────────────────────┘");
        return "user/signIn";
    }
    
    
    /**
     * 마이페이지 화면(GET)
     * URL: /user/myPage.do
     * VIEW: /WEB-INF/views/user/myPage.jsp
     */
    @GetMapping(value="/myPage.do")
    public String myPageView(HttpSession session, Model model) {

        // 1) 로그인 체크
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            // 혹시 URL로 직접 접근할 수 있으니 방어
            return "redirect:/resources/mainPage.jsp";
        }

        // 2) 화면에서 쓰도록 모델에 담기(권장)
        model.addAttribute("loginUser", loginUser);

        return "user/myPage";
    }

    

    /**
     * ✅ 로그인 처리 - AJAX(JSON)
     * URL: /user/doSignInAjax.do (POST)
     * 성공 시 세션(session)에 loginUser 저장
     * 응답 예: {"flag":1,"message":"OO님 환영합니다."}
     */
    @PostMapping(value="/doSignInAjax.do", produces="application/json;charset=UTF-8")
    @ResponseBody
    public String doSignInAjax(UserVO param, HttpSession session) {

        log.debug("┌──────────────────────────┐");
        log.debug("│doSignInAjax() - AJAX     │");
        log.debug("└──────────────────────────┘");
        log.debug("param: {}", param);

        int flag = 0;
        String message = "";

        try {
            // userService에 doSignIn(UserVO) 메서드가 있어야 함
            UserVO loginUser = userService.doSignIn(param);

            if (loginUser != null) {
                session.setAttribute("loginUser", loginUser);
                flag = 1;

                // 닉네임이 있으면 닉네임, 없으면 userId로 환영문구
                String who = (loginUser.getNickname() != null && !loginUser.getNickname().trim().isEmpty())
                        ? loginUser.getNickname()
                        : loginUser.getUserId();

                message = who + "님 환영합니다.";
            } else {
                flag = 0;
                message = "로그인에 실패했습니다. (아이디/비밀번호를 확인하세요.)";
            }

        } catch (Exception e) {
            log.error("doSignInAjax() 예외", e);
            flag = 0;
            message = "로그인에 실패했습니다. (서버 오류: " + e.getMessage() + ")";
        }

        return "{\"flag\":" + flag + ",\"message\":\"" + escapeJson(message) + "\"}";
    }

    /**
     * ✅ 로그아웃 처리 - AJAX(JSON)
     * URL: /user/doLogoutAjax.do (POST)
     * - 로그인 상태면: "로그아웃 되었습니다." + 세션 종료
     * - 비회원이면: "로그인을 진행 해주세요!"
     */
    @PostMapping(value="/doLogoutAjax.do", produces="application/json;charset=UTF-8")
    @ResponseBody
    public String doLogoutAjax(HttpSession session) {

        log.debug("┌──────────────────────────┐");
        log.debug("│doLogoutAjax() - AJAX     │");
        log.debug("└──────────────────────────┘");

        int flag = 0;
        String message = "";

        try {
            Object loginUser = session.getAttribute("loginUser");
            if (loginUser == null) {
                flag = 0;
                message = "로그인을 진행 해주세요!";
            } else {
                session.invalidate();
                flag = 1;
                message = "로그아웃 되었습니다.";
            }
        } catch (Exception e) {
            log.error("doLogoutAjax() 예외", e);
            flag = 0;
            message = "로그아웃 처리 중 오류: " + e.getMessage();
        }

        return "{\"flag\":" + flag + ",\"message\":\"" + escapeJson(message) + "\"}";
    }

    /**
     * ✅ 회원탈퇴(DB 삭제) - AJAX(JSON)
     * URL: /user/doWithdrawAjax.do (POST)
     * - 로그인 상태에서만 가능
     * - 성공 시: DB 삭제 + 세션 종료
     */
    @PostMapping(value="/doWithdrawAjax.do", produces="application/json;charset=UTF-8")
    @ResponseBody
    public String doWithdrawAjax(HttpSession session) {

        log.debug("┌──────────────────────────┐");
        log.debug("│doWithdrawAjax() - AJAX   │");
        log.debug("└──────────────────────────┘");

        int flag = 0;
        String message = "";

        try {
            UserVO loginUser = (UserVO) session.getAttribute("loginUser");

            if (loginUser == null) {
                flag = 0;
                message = "로그인을 진행 해주세요!";
            } else {
                UserVO param = new UserVO();
                param.setUserId(loginUser.getUserId());

                // userService에 doWithdraw(UserVO) 메서드가 있어야 함
                int delFlag = userService.doWithdraw(param);

                if (delFlag == 1) {
                    session.invalidate();
                    flag = 1;
                    message = "회원탈퇴가 완료 되었습니다.";
                } else {
                    flag = 0;
                    message = "회원탈퇴에 실패 했습니다.";
                }
            }

        } catch (Exception e) {
            log.error("doWithdrawAjax() 예외", e);
            flag = 0;
            message = "회원탈퇴 처리 중 오류: " + e.getMessage();
        }

        return "{\"flag\":" + flag + ",\"message\":\"" + escapeJson(message) + "\"}";
    }

    // JSON 문자열 안전 처리(따옴표/개행 등 최소 처리)
    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", " ")
                .replace("\r", " ");
    }
}
