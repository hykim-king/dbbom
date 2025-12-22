package com.pcwk.ehr.mapper;
import java.sql.SQLException;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.user.domain.UserVO;
/**
 *
 * @author user
 *
 */
@Mapper
public interface UserMapper extends WorkDiv<UserVO> {
	/**
	 * 전체 조회:O
	 *
	 * @return
	 */
	List<UserVO> getAll();
	/**
	 * 전체 데이터 건수 조회:O
	 *
	 * @return
	 */
	int getCount();
	/**
	 * 다건 입력 : O
	 *
	 * @return
	 */
	int saveAll();
	/**
	 * 전체삭제: 변경 없음 :O
	 *
	 * @return
	 * @throws SQLException
	 */
	int deleteAll();
}
