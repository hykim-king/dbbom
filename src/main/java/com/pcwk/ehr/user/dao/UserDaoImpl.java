package com.pcwk.ehr.user.dao;

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

    final String NAMESPACE = "com.pcwk.ehr.mapper.UserMapper";
    final String DOT = ".";

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    @Override
    public int doSave(UserVO param) {
        log.debug("1. parameter: {}", param);
        return sqlSessionTemplate.insert(NAMESPACE + DOT + "doSave", param);
    }

    @Override
    public UserVO doSelectOne(UserVO param) {
        log.debug("1. parameter: {}", param);
        return sqlSessionTemplate.selectOne(NAMESPACE + DOT + "doSelectOne", param);
    }

    @Override
    public int doUpdate(UserVO param) {
        log.debug("1. parameter: {}", param);
        return sqlSessionTemplate.update(NAMESPACE + DOT + "doUpdate", param);
    }

    @Override
    public int doDelete(UserVO param) {
        log.debug("1. parameter: {}", param);
        return sqlSessionTemplate.delete(NAMESPACE + DOT + "doDelete", param);
    }

    @Override
    public int deleteAll() {
        return sqlSessionTemplate.delete(NAMESPACE + DOT + "deleteAll");
    }

    @Override
    public int getCount() {
        return sqlSessionTemplate.selectOne(NAMESPACE + DOT + "getCount");
    }

    // 기존 doRetrieve 등 나머지 인터페이스 구현 생략 (구조 동일)
    @Override
    public List<UserVO> doRetrieve(DTO dto) {
        return sqlSessionTemplate.selectList(NAMESPACE + DOT + "doRetrieve", dto);
    }

    @Override
    public List<UserVO> getAll() {
        return sqlSessionTemplate.selectList(NAMESPACE + DOT + "getAll");
    }

    @Override
    public int saveAll() {
        return sqlSessionTemplate.insert(NAMESPACE + DOT + "saveAll");
    }
}