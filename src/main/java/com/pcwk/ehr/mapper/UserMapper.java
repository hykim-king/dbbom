package com.pcwk.ehr.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.user.domain.UserVO;

@Mapper // 스프링이 이 인터페이스를 Mapper로 인식하게 함
public interface UserMapper extends WorkDiv<UserVO> {
    
    // WorkDiv에 정의된 doSave, doDelete, doUpdate, doSelectOne, doRetrieve는 자동 포함됨
    
    /** 전체 조회 */
    List<UserVO> getAll();

    /** 전체 건수 조회 */
    int getCount();

    /** 전체 삭제 */
    int deleteAll();
    
    /** 다건 입력 테스트용 */
    int saveAll();
}