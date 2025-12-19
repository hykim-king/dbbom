package com.pcwk.ehr.user.service;
import java.util.List;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.mapper.UserMapper;
import com.pcwk.ehr.user.domain.UserVO;
@Service
public class UserServiceImpl implements UserService {
	final Logger log = LogManager.getLogger(getClass());
	@Autowired
	UserMapper userMapper;
	public UserServiceImpl() {
		super();
		log.debug("┌──────────────────────────┐");
		log.debug("│──UserServiceImpl─────────│");
		log.debug("└──────────────────────────┘");
	}
	@Override
	public List<UserVO> doRetrieve(DTO dto) {
		return userMapper.doRetrieve(dto);
	}
	@Override
	public int doUpdate(UserVO param) {
		return userMapper.doUpdate(param);
	}
	@Override
	public int doDelete(UserVO param) {
		return userMapper.doDelete(param);
	}
	@Override
	public UserVO doSelectOne(UserVO param) {
		return userMapper.doSelectOne(param);
	}
	@Override
	public int doSave(UserVO param) {
		return userMapper.doSave(param);
	}
}













