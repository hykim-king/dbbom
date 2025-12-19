package com.pcwk.ehr.user.dao;

import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.user.domain.UserVO;

public interface UserDao {

	//목록조회
	List<UserVO> doRetrieve(DTO dto);

	//단건수정
	int doUpdate(UserVO param);

	//단건삭제
	int doDelete(UserVO param);

	// 전체조회
	List<UserVO> getAll();

	// 전체 데이터 건수 조회
	int getCount();

	//다건입력
	int saveAll();

	// 전체삭제:O
	int deleteAll() ;

	/**
	 * 단건조회
	 * 
	 * @param param
	 * @return UserVO
	 */
	UserVO doSelectOne(UserVO param);

	/**
	 * 단건저장
	 * 
	 * @param param
	 * @return 1(성공)/0(실패)
	 * @throws SQLException
	 */
	int doSave(UserVO param);

}