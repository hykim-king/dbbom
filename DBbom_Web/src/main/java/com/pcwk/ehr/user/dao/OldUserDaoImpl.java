/**
 * 파일명: UserDao.java
 * 설명: User 데이터 엑세스 오브젝트
 * 작성자: user
 * 작성일: 2025-11-19
 * 버전 : 1.0
 */
package com.pcwk.ehr.user.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.user.domain.Grade;
import com.pcwk.ehr.user.domain.UserVO;

public class OldUserDaoImpl implements UserDao {

	Logger log = LogManager.getLogger(getClass());

	private DataSource dataSource;

	private JdbcTemplate jdbcTemplate;

	private RowMapper<UserVO>  userMapper = new RowMapper<UserVO>() {

		@Override
		public UserVO mapRow(ResultSet rs, int rowNum) throws SQLException {
			UserVO resultVO = new UserVO();

			resultVO.setUserId(rs.getString("user_id"));
			resultVO.setName(rs.getString("name"));
			resultVO.setPassword(rs.getString("password"));
			
			//-------------------------------------------------------
			resultVO.setLogin(rs.getInt("login"));
			resultVO.setRecommend(rs.getInt("recommend"));
			resultVO.setEmail(rs.getString("email"));
			//1 -> BASIC
			resultVO.setGrade( Grade.valueOf(rs.getInt("grade")));
			
			
			resultVO.setRegDt(rs.getString("reg_dt"));
			return resultVO;
		}

	};
	
	
	public OldUserDaoImpl() {
	}


	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;

		jdbcTemplate = new JdbcTemplate(dataSource);
	}


	//목록조회
	@Override
	public List<UserVO> doRetrieve(DTO  dto){
		List<UserVO> list=new ArrayList<UserVO>();
		
		StringBuilder sb = new StringBuilder(1500);
		sb.append(" SELECT A.*, B.*                                                         \n");
		sb.append("   FROM (                                                                \n");
		sb.append("         SELECT tt1.rnum AS no,                                          \n");
		sb.append("                tt1.user_id,                                             \n");
		sb.append("                tt1.name,                                                \n");
		sb.append("                tt1.password,                                            \n");
		sb.append("                tt1.login,                                               \n");
		sb.append("                tt1.recommend,                                           \n");
		sb.append("                tt1.email,                                               \n");
		sb.append("                tt1.grade,                                               \n");
		sb.append("                TO_CHAR(tt1.reg_dt,'YYYY/MM/DD') reg_dt                  \n");
		sb.append("           FROM (                                                        \n");
		sb.append("                 SELECT ROWNUM AS rnum,t1.*                              \n");
		sb.append("                   FROM (                                                \n");
		sb.append("                         SELECT *                                        \n");
		sb.append("                           FROM member                                   \n");
		sb.append("                         --검색조건                                                                                \n");
		sb.append("                         ORDER BY reg_dt DESC                            \n");
		sb.append("                 )t1                                                     \n");
		//sb.append("                 WHERE ROWNUM<=:page_size * (:page_no - 1) + :page_size \n");
		sb.append("                 WHERE ROWNUM<=? * ( ? - 1 ) + ?                         \n");
		
		sb.append("         )tt1                                                            \n");
		//sb.append("         WHERE rnum >=:page_size * (:page_no - 1) + 1                  \n");
		sb.append("         WHERE rnum >= ? * ( ? - 1 ) + 1                                 \n");
		
		
		sb.append("   ) A CROSS JOIN (                                                      \n");
		sb.append("         SELECT COUNT(*) total_cnt                                       \n");
		sb.append("           FROM member                                                   \n");
		sb.append("           --검색조건                                                                                                            \n");
		sb.append("   ) B                                                                   \n");		
		
		log.debug("1. sql:\n" + sb.toString());
		log.debug("2. dto:\n" + dto.toString());
		Object []args = {dto.getPageSize(), dto.getPageNo(),  dto.getPageSize(),
				dto.getPageSize(), dto.getPageNo()};
		
		RowMapper<UserVO> rowMapper = new RowMapper<UserVO>() {

			@Override
			public UserVO mapRow(ResultSet rs, int rowNum) throws SQLException {
				UserVO resultVO = new UserVO();

				resultVO.setUserId(rs.getString("user_id"));
				resultVO.setName(rs.getString("name"));
				resultVO.setPassword(rs.getString("password"));
				
				//-------------------------------------------------------
				resultVO.setLogin(rs.getInt("login"));
				resultVO.setRecommend(rs.getInt("recommend"));
				resultVO.setEmail(rs.getString("email"));
				//1 -> BASIC
				resultVO.setGrade( Grade.valueOf(rs.getInt("grade")));
				
				resultVO.setRegDt(rs.getString("reg_dt"));
				//-------------------------------------------------------
				resultVO.setNo(rs.getInt("no"));
				resultVO.setTotalCnt(rs.getInt("total_cnt"));
				
				
				return resultVO;
			}
			
		};
		
		
		list=jdbcTemplate.query(sb.toString(), args, rowMapper);
		
		for(UserVO vo  :list) {
			log.debug(vo);
		}
		
		return list;
	}
	
	//단건수정
	@Override
	public int doUpdate(UserVO  param) {
		int flag = 0;
		StringBuilder sb = new StringBuilder(300);
		sb.append(" UPDATE member             \n");
		sb.append(" SET                       \n");
		sb.append("     name      = ?,        \n");
		sb.append("     password  = ?,        \n");
		sb.append("     login     = ?,        \n");
		sb.append("     recommend = ?,        \n");
		sb.append("     email     = ?,        \n");
		sb.append("     grade     = ?,        \n");
		sb.append("     reg_dt    = SYSDATE   \n");
		sb.append(" WHERE                     \n");
		sb.append("         user_id = ?       \n");		
		
		log.debug("1 sql:\n" + sb.toString());
		log.debug("2 param:\n" + param.toString());
		
		Object[] args = { param.getName(), param.getPassword(),
                param.getLogin(), param.getRecommend(),param.getEmail(),param.getGrade().getValue(),
                param.getUserId()
        };
		
		log.debug("3 args: ");
		for(Object obj  :args) {
			log.debug(obj.toString());
		}
		
		flag=jdbcTemplate.update(sb.toString(), args);
		
		return flag;
	}
	
	//단건삭제
	@Override
	public int doDelete(UserVO  param) {
		int flag = 0;
		StringBuilder sb = new StringBuilder(100);
		sb.append(" DELETE FROM member   \n");
		sb.append(" WHERE user_id = ?    \n");
		
		log.debug("1 sql:\n" + sb.toString());
		log.debug("2 param:\n" + param.toString());
		
		Object[] args = {param.getUserId() };
		
		log.debug("3 args: ");
		for(Object obj  :args) {
			log.debug(obj.toString());
		}
		
		flag = this.jdbcTemplate.update(sb.toString(), args);
		
		
		return flag;
	}
	
	
	// 전체조회
	@Override
	public List<UserVO> getAll() {
		List<UserVO> list = new ArrayList<UserVO>();

		StringBuilder sb = new StringBuilder(300);
		sb.append(" SELECT                                                    \n");   
		sb.append("     user_id,                                              \n");
		sb.append("     name,                                                 \n");
		sb.append("     password,                                             \n");
		sb.append("     login,                                                \n");
		sb.append("     recommend,                                            \n");
		sb.append("     email,                                                \n");
		sb.append("     grade,                                                \n");
		sb.append("     TO_CHAR(reg_dt,'YYYY/MM/DD HH24:MI:SS')  AS reg_dt    \n");
		sb.append(" FROM                                                      \n");
		sb.append("     member                                                \n");
		sb.append(" ORDER BY reg_dt                                           \n");

		log.debug("1. sql:\n" + sb.toString());

		list = this.jdbcTemplate.query(sb.toString(), userMapper);

		return list;
	}

	// 전체 데이터 건수 조회
	@Override
	public int getCount() {
		int count = 0;

		StringBuilder sb = new StringBuilder(100);
		sb.append("SELECT COUNT(*) AS CNT FROM member");
		log.debug("2.1 sql:\n" + sb.toString());

		count = jdbcTemplate.queryForObject(sb.toString(), Integer.class);

		log.debug("count:" + count);

		return count;
	}

	//다건입력
	@Override
	public int saveAll() {
		int flag = 0;
		
		StringBuilder sb = new StringBuilder(1000);
		sb.append(" INSERT INTO member                                  \n");
		sb.append(" SELECT  'pcwk'||level AS user_id,                   \n");
		sb.append("         '이상무'||level AS name,                     \n");
		sb.append("         '4321a' AS password,                        \n");
		sb.append("         MOD(level,50)+1 AS login,                   \n");
		sb.append("         MOD(level,30)+1 AS recommand,               \n");
		sb.append("         'jamesol'||level||'@paran.com' AS email,    \n");
		sb.append("         MOD(level,3)+1 AS grade,                    \n");
		sb.append("         SYSDATE - level AS reg_dt                   \n");
		sb.append("   FROM dual                                         \n");
		sb.append(" CONNECT BY LEVEL <=1002                             \n");
		
		log.debug("1 sql:\n" + sb.toString());
		
		flag=this.jdbcTemplate.update(sb.toString());
		log.debug("2 flag: " + flag);
		return flag;
	}
	
	
	// 전체삭제:O
	@Override
	public int deleteAll() {
		int flag = 0;
		StringBuilder sb = new StringBuilder(100);
		sb.append("  DELETE FROM member     \n");
		log.debug("1 sql:\n" + sb.toString());

		flag = jdbcTemplate.update(sb.toString());
		log.debug("2 flag:" + flag);
		return flag;
	}

	/**
	 * 단건조회
	 * 
	 * @param param
	 * @return UserVO
	 */
	@Override
	public UserVO doSelectOne(UserVO param) {
		UserVO outVO = null;

		StringBuilder sb = new StringBuilder(300);
		sb.append(" SELECT                                                    \n");   
		sb.append("     user_id,                                              \n");
		sb.append("     name,                                                 \n");
		sb.append("     password,                                             \n");
		sb.append("     login,                                                \n");
		sb.append("     recommend,                                            \n");
		sb.append("     email,                                                \n");
		sb.append("     grade,                                                \n");
		sb.append("     TO_CHAR(reg_dt,'YYYY/MM/DD HH24:MI:SS')  AS reg_dt    \n");
		sb.append(" FROM                                                      \n");
		sb.append("     member                                                \n");
		sb.append(" WHERE  user_id = ?                                        \n");
		log.debug("1. sql:\n" + sb.toString());
		log.debug("2. param:\n" + param.toString());

		Object[] args = { param.getUserId() };

		outVO = jdbcTemplate.queryForObject(sb.toString(), userMapper, args);

		// --------------------------------------
		// 조회된 데이터가 없는 경우 : 예외발생
		if (null == outVO) {
			throw new EmptyResultDataAccessException(param.getUserId() + " (아이디)를 확인하세요.", 0);
		}
		// --------------------------------------

		return outVO;
	}

	/**
	 * 단건저장
	 * 
	 * @param param
	 * @return 1(성공)/0(실패)
	 * @throws SQLException
	 */
	@Override
	public int doSave(UserVO param) {
		int flag = 0;

		StringBuilder sb = new StringBuilder(100);
		sb.append(" INSERT INTO member ( \n");
		sb.append("     user_id,         \n");
		sb.append("     name,            \n");
		sb.append("     password,        \n");
		sb.append("     login,           \n");
		sb.append("     recommend,       \n");
		sb.append("     email,           \n");
		sb.append("     grade,           \n");
		sb.append("     reg_dt           \n");
		sb.append(" ) VALUES (           \n");
		sb.append("     ?,               \n");
		sb.append("     ?,               \n");
		sb.append("     ?,               \n");
		sb.append("     ?,               \n");
		sb.append("     ?,               \n");
		sb.append("     ?,               \n");
		sb.append("     ?,               \n");
		sb.append("     SYSDATE          \n");
		sb.append(" )                    \n");

		log.debug("1 sql:\n" + sb.toString());
		log.debug("2 param:\n" + param.toString());

		Object[] args = { param.getUserId(), param.getName(), param.getPassword(),
		                  param.getLogin(), param.getRecommend(),param.getEmail(),param.getGrade().getValue()		
		};

		log.debug("3 args: ");
		for(Object obj  :args) {
			log.debug(obj.toString());
		}
		
		flag = jdbcTemplate.update(sb.toString(), args);

		return flag;
	}

}
