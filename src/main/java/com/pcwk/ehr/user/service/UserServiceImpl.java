package com.pcwk.ehr.user.service;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.mapper.UserMapper;
import com.pcwk.ehr.user.domain.UserVO;

@Service
public class UserServiceImpl implements UserService {

    final Logger log = LogManager.getLogger(getClass());

    @Autowired
    UserMapper userMapper;

    @Override
    public int doSignUp(UserVO param) {

        log.debug("┌──────────────────────────┐");
        log.debug("│doSignUp()                │");
        log.debug("└──────────────────────────┘");
        log.debug("param: {}", param);

        // 1) 필수값 최소 체크(최소한만)
        if (param == null || isEmpty(param.getUserId()) || isEmpty(param.getUserPw()) || isEmpty(param.getUserName())) {
            return 0;
        }

        // 2) 기본값 세팅(일반회원)
        if (isEmpty(param.getAdminChk())) {
            param.setAdminChk("N"); // 일반회원은 N (관리자는 Y)
        }

        // 3) 아이디 중복 체크
        UserVO check = new UserVO();
        check.setUserId(param.getUserId());
        UserVO outVO = userMapper.doSelectOne(check);

        if (outVO != null) {
            return -1; // 이미 존재하는 아이디
        }

        // 4) 저장
        int flag = userMapper.doSave(param);
        return flag; // 1이면 성공
    }

    @Override
    public UserVO doSignIn(UserVO param) {
        log.debug("┌──────────────────────────┐");
        log.debug("│doSignIn()                │");
        log.debug("└──────────────────────────┘");
        log.debug("param: {}", param);

        if (param == null || isEmpty(param.getUserId()) || isEmpty(param.getUserPw())) {
            return null;
        }

        // 1) 아이디로 조회
        UserVO inVO = new UserVO();
        inVO.setUserId(param.getUserId());
        UserVO dbVO = userMapper.doSelectOne(inVO);

        if (dbVO == null) {
            return null; // 아이디 없음
        }

        // 2) 비밀번호 비교(현재는 평문 비교)
        // ※ 다음 단계에서 BCrypt로 교체 권장
        if (param.getUserPw().equals(dbVO.getUserPw()) == false) {
            return null; // 비번 불일치
        }

        // 보안: 세션에 pw는 넣지 않는 게 좋음
        dbVO.setUserPw(null);
        return dbVO;
    }

    @Override
    public int doWithdraw(UserVO param) {
        log.debug("┌──────────────────────────┐");
        log.debug("│doWithdraw()              │");
        log.debug("└──────────────────────────┘");
        log.debug("param: {}", param);

        if (param == null || isEmpty(param.getUserId())) {
            return 0;
        }

        // WorkDiv.doDelete(UserVO) 사용 (보통 userId 기준으로 삭제되게 매핑되어 있음)
        return userMapper.doDelete(param);
    }

    private boolean isEmpty(String s) {
        return s == null || s.trim().isEmpty();
    }
}
