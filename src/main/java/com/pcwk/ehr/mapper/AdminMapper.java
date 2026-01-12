package com.pcwk.ehr.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.diary.domain.DiaryVO;
import com.pcwk.ehr.user.domain.UserVO;

@Mapper
public interface AdminMapper {
    // 1. 회원 목록 조회
    List<UserVO> doRetrieveUserList(DTO dto);
    
    // 2. 신고 목록 조회 (DiaryVO 활용)
    List<DiaryVO> doRetrieveReportList(DTO dto);
    
    // 3. 전체 게시글 목록 조회
    List<DiaryVO> doRetrieveDiaryList(DTO dto);
    
    // 4. 게시글 상태 변경
    int doUpdateDiaryStatus(DiaryVO vo);
}