package com.pcwk.ehr.cmn;
/**
 * Mapper 공통 인터페이스
 */
import java.sql.SQLException;
import java.util.List;
import com.pcwk.ehr.user.domain.UserVO;
public interface WorkDiv<T> {
	
	/**
	 * 목록 조회
	 * @param dto
	 * @return
	 */
	List<UserVO> doRetrieve(DTO dto);
	/**
	 * 단건 수정
	 * @param param
	 * @return
	 */
	int doUpdate(T param);
	/**
	 * 단건 삭제
	 * @param param
	 * @return
	 */
	int doDelete(T param);
	
	/**
	 * 단건조회
	 * @param param
	 * @return UserVO
	 */
	UserVO doSelectOne(T param);
	/**
	 * 단건저장
	 * @param param
	 * @return 1(성공)/0(실패)
	 * @throws SQLException
	 */
	int doSave(T param) ;
}