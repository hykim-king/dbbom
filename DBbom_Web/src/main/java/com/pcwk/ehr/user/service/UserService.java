package com.pcwk.ehr.user.service;
import java.sql.SQLException;
import java.util.List;
import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.user.domain.UserVO;
public interface UserService {
	
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
	int doUpdate(UserVO param);
	/**
	 * 단건 삭제
	 * @param param
	 * @return
	 */
	int doDelete(UserVO param);
	
	/**
	 * 단건조회
	 * @param param
	 * @return UserVO
	 */
	UserVO doSelectOne(UserVO param);
	/**
	 * 단건저장
	 * @param param
	 * @return 1(성공)/0(실패)
	 * @throws SQLException
	 */
	int doSave(UserVO param) ;
}