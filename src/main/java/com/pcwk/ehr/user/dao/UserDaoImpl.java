package com.pcwk.ehr.user.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.user.domain.UserVO;

@Repository
public class UserDaoImpl implements UserDao {
	Logger log = LoggerFactory.getLogger(getClass());

	// ✅ mapper xml namespace로 맞춤
    final String NAMESPACE = "com.pcwk.ehr.mapper.UserMapper";
    final String DOT = ".";

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public UserDaoImpl() {
		super();
	}

	
	@Override
	public List<UserVO> doRetrieve(DTO dto) {
		List<UserVO> list=new ArrayList<UserVO>();
		
		String statement = NAMESPACE + DOT+"doRetrieve";
		log.debug("1. parameter: {}",dto);
		log.debug("2. statement: {}",statement);
		
		list = this.sqlSessionTemplate.selectList(statement, dto);
		
		log.debug("3. list:");
		list.forEach(vo -> log.debug("vo:{}",vo));
		
		return list;
	}


	@Override
	public int saveAll() {
		int flag = 0;
		String statement = NAMESPACE + DOT+"saveAll";
		log.debug("1. parameter: none");
		log.debug("2. statement: {}",statement);		
		
		flag = sqlSessionTemplate.insert(statement);
		log.debug("3. flag: {}",flag);	
		return flag;
	}
	
	
	
	
	@Override
	public List<UserVO> getAll() {
		List<UserVO> list = new ArrayList<UserVO>();
		String statement = NAMESPACE + DOT+"getAll";
		
		log.debug("1. parameter: none");
		log.debug("2. statement:"+statement);	
		
		list= sqlSessionTemplate.selectList(statement);
		
		log.debug("3. list:");
		list.forEach(vo -> log.debug("vo:{}",vo));
//		for(UserVO vo :list) {
//			log.debug("vo: "+vo);
//		}

		
		return list;
	}
	
	
	@Override
	public UserVO doSelectOne(UserVO param) {
		UserVO  outVO = null;
		String statement = NAMESPACE + DOT+"doSelectOne";
		log.debug("1. parameter: "+param);
		log.debug("2. statement:"+statement);			
		
		outVO=sqlSessionTemplate.selectOne(statement, param);
		log.debug("3. outVO:"+outVO);		
		
		return outVO;
	}
	
	@Override
	public int getCount() {
		int count = 0;
		String statement = NAMESPACE + DOT+"getCount";
		log.debug("1. parameter: none");
		log.debug("2. statement:"+statement);				
		
		count=sqlSessionTemplate.selectOne(statement);//단건 조회
		log.debug("3. count:"+count);	
		return count;
	}
	
	@Override
	public int deleteAll() {
		int flag = 0;
		String statement = NAMESPACE + DOT+"deleteAll";		
		log.debug("1. parameter: none");
		log.debug("2. statement:"+statement);		
		
		flag = sqlSessionTemplate.delete(statement);
		log.debug("3. flag:"+flag);
		return flag;
	}
	
	@Override
	public int doUpdate(UserVO param) {
		int flag = 0;
		
		String statement = NAMESPACE + DOT+"doUpdate";		
		log.debug("1. parameter: "+param);
		log.debug("2. statement:"+statement);			
		flag = sqlSessionTemplate.update(statement, param);
		log.debug("3. flag:"+flag);
		
		return flag;
	}
	
	@Override
	public int doSave(UserVO param) {
		int flag = 0;
		String statement = NAMESPACE + DOT+"doSave";		
		log.debug("1. parameter: "+param);
		log.debug("2. statement:"+statement);	
		
		flag = sqlSessionTemplate.insert(statement, param);
		
		log.debug("3. flag:"+flag);
		
		return flag;
	}

	@Override
	public int doDelete(UserVO param) {
		int flag = 0;
		String statement = NAMESPACE + DOT+"doDelete";	
		log.debug("1. parameter: "+param);
		log.debug("2. statement:"+statement);
		
		flag=sqlSessionTemplate.delete(statement, param);
		log.debug("3. flag:"+flag);
		return flag;
	}


}
