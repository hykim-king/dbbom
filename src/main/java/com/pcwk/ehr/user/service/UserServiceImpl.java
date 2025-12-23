package com.pcwk.ehr.user.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.mapper.UserMapper; // Mapper 바로 사용
import com.pcwk.ehr.user.domain.UserVO;

@Service("userService")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper; // 이제 DAOImpl 대신 Mapper 인터페이스를 주입받음

    @Override
    public int doSave(UserVO param) {
        // 비즈니스 로직 예시: 기본 권한 설정
        if (param.getAdminChk() == null) param.setAdminChk("N");
        return userMapper.doSave(param);
    }

    @Override
    public UserVO doSelectOne(UserVO param) {
        return userMapper.doSelectOne(param);
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
    public List<UserVO> doRetrieve(DTO dto) {
        return userMapper.doRetrieve(dto);
    }
}