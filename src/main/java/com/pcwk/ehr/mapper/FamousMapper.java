package com.pcwk.ehr.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.famous.domain.FamousVO;

/*
 * FamousMapper 역할
 * - DB와 직접 통신하지 않고
 * - SQL이 정의된 Mapper XML과 자바 코드를 연결해주는 "중간 통로"
 * - 이 인터페이스 자체에는 SQL이 없음
 */


@Mapper 
//MyBatis가 이 인터페이스를 보고
//실행 시 자동으로 구현 클래스(프록시 객체)를 생성
public interface FamousMapper extends WorkDiv<FamousVO>  { 
    
    // 명언 전체 목록 조회(조건X)/ DB의 여러 행을 List로 받음
    List<FamousVO> getAll();
    
    //전체 건수 조회
    int getCount();
    
    //조회수 증가
    int updateViewCount(FamousVO vo);
    
    //추천수 증가
    int updateReCount(FamousVO vo);
    
    //공개일기인 경우 명언 자동 등록
    int saveFromDiary(FamousVO vo);
    
    //전체 삭제: 테스트용
    int deleteAll();

    //대량 데이터 입력: 테스트 용
    int saveAll();
    

}
