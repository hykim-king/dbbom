package com.pcwk.ehr.user.service;

import java.util.List;
import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.user.domain.UserVO;

/**
 * 사용자 관리를 위한 비즈니스 로직 인터페이스
 */
public interface UserService {
    
    /**
     * 회원 목록 조회 (페이징 및 검색 포함)
     * @param dto 검색 조건 및 페이지 정보
     * @return UserVO 리스트
     */
    List<UserVO> doRetrieve(DTO dto);

    /**
     * 회원 정보 수정
     * @param param 수정할 사용자 정보가 담긴 VO
     * @return 1(성공) / 0(실패)
     */
    int doUpdate(UserVO param);

    /**
     * 회원 삭제 (단건 삭제)
     * @param param 삭제할 사용자 ID가 담긴 VO
     * @return 1(성공) / 0(실패)
     */
    int doDelete(UserVO param);
    
    /**
     * 회원 단건 조회 (상세 보기)
     * @param param 조회할 사용자 ID가 담긴 VO
     * @return 조회된 UserVO 객체
     */
    UserVO doSelectOne(UserVO param);

    /**
     * 회원 등록 (저장)
     * @param param 등록할 사용자 정보
     * @return 1(성공) / 0(실패)
     */
    int doSave(UserVO param);
}