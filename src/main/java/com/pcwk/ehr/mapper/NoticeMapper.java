package com.pcwk.ehr.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.notice.NoticeVO; 

@Mapper
public interface NoticeMapper extends WorkDiv<NoticeVO> {

    List<NoticeVO> getAll();

    /** 전체 건수 조회 */
    int getCount();

    /** 전체 삭제 */
    int deleteAll();
    
    /** 다건 입력 테스트용 (필요시 사용) */
    int saveAll();

}