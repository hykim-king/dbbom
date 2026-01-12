package com.pcwk.ehr.famous.service;

import java.util.List;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.famous.domain.FamousVO;

public interface FamousService extends WorkDiv<FamousVO> {
	
	/**
     * 추천(좋아요) 처리
     * @param vo (명언 번호, 사용자 ID 등 포함)
     * @return 1:성공, 0:실패, 2:이미 추천함
     */
    int doUpdateLike(FamousVO vo);
 

    /**
     * 실시간 베스트 3 명언 조회
     * @return 좋아요 순 상위 3개 리스트
     */
    List<FamousVO> getBest3();
    
    /**
     * 전체 명언 건수 조회
     * @param dto
     * @return
     */
    List<FamousVO> allDoRetrieve(DTO dto);
    
    /**
     * 명언 조회수
     * @param inVO
     * @return
     */
    int updateViewCount(FamousVO inVO);
    
    /** 명언 상세 조회 */
    FamousVO getFamousDetail(FamousVO vo);
}