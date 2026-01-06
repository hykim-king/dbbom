package com.pcwk.ehr.user.service;

import com.pcwk.ehr.user.domain.UserVO;

public interface UserService {
	
	/** 아이디 찾기 */
	UserVO doFindId(UserVO param);
    /**
     * 회원가입
     * @return  1: 성공
     *          0: 실패
     *         -1: 아이디 중복
     */
    int doSignUp(UserVO param);

    /**
     * 로그인
     * @return  로그인 성공 시(UserVO), 실패 시 null
     */
    UserVO doSignIn(UserVO param);

    /**
     * 회원탈퇴(DB 삭제)
     * @return  1: 성공, 0: 실패
     */
    int doWithdraw(UserVO param);
}
