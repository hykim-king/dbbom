package com.pcwk.ehr.user;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.mapper.UserMapper;
import com.pcwk.ehr.user.domain.UserVO;

@ExtendWith(SpringExtension.class) // JUnit 5와 Spring 연동
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
}) // 스프링 설정 파일 로드
class UserDaoTest {
	final Logger log = LogManager.getLogger(getClass());

	@Autowired
	ApplicationContext context; // 스프링 컨테이너
	
	@Autowired
	UserMapper userMapper; // 테스트 대상 Mapper
	
	UserVO user01;
	UserVO user02;
	UserVO user03;	
	
	DTO dto;
	
	@BeforeEach
	void setUp() throws Exception {
		log.debug("setup: 테스트 데이터 초기화");	
		
		// ERD 및 수정한 UserVO 구조에 맞게 데이터 세팅
		// UserVO(userId, userName, userPw, userTel, userEmail, nickname, userIntro, lastRecTime, lastReportTime, adminChk)
		user01 = new UserVO("user01", "홍길동", "1234", "010-1111-1111", "hong@gmail.com", "홍홍", "반가워요", null, null, "N");
		user02 = new UserVO("user02", "김철수", "1234", "010-2222-2222", "kim@gmail.com", "철이", "안녕하세요", null, null, "N");
		user03 = new UserVO("user03", "이영희", "1234", "010-3333-3333", "lee@gmail.com", "영희", "반갑습니다", null, null, "Y");
		
		dto = new DTO();		
	}

	@Test
	//@Disabled // 테스트 실행 시 제외하고 싶을 때 사용
	void doSave() {
		// 1. 기존 데이터 전체 삭제
		userMapper.deleteAll();
		
		// 2. 단건 등록
		int flag = userMapper.doSave(user01);
		assertEquals(1, flag, "등록 실패!"); // 결과가 1인지 확인
		
		// 3. 전체 건수 조회
		int count = userMapper.getCount();
		assertEquals(1, count);
		
		// 4. 저장된 데이터 상세 조회 및 비교
		UserVO outVO = userMapper.doSelectOne(user01);
		assertNotNull(outVO);
		
		isSameUser(outVO, user01);
	}
	
	@Disabled
	@Test
	void doUpdate() {
		// 1. 초기화
		userMapper.deleteAll();
		userMapper.doSave(user01);
		
		// 2. 수정 데이터 설정
		UserVO outVO = userMapper.doSelectOne(user01);
		outVO.setUserName(outVO.getUserName() + "_수정");
		outVO.setNickname("닉네임수정");
		outVO.setUserIntro("소개글수정");
		
		// 3. 수정 수행
		int flag = userMapper.doUpdate(outVO);
		assertEquals(1, flag);
		
		// 4. 결과 검증
		UserVO upResultVO = userMapper.doSelectOne(outVO);
		isSameUser(upResultVO, outVO);
	}
	@Disabled
	@Test
	void doDelete() {
		userMapper.deleteAll();
		userMapper.doSave(user01);
		
		int flag = userMapper.doDelete(user01);
		assertEquals(1, flag);
		
		assertEquals(0, userMapper.getCount());
	}

	// 객체의 각 필드 값이 일치하는지 비교하는 헬퍼 메서드
	private void isSameUser(UserVO outVO, UserVO user) {
		assertEquals(outVO.getUserId(), user.getUserId());
		assertEquals(outVO.getUserName(), user.getUserName());
		assertEquals(outVO.getUserPw(), user.getUserPw());
		assertEquals(outVO.getUserTel(), user.getUserTel());
		assertEquals(outVO.getUserEmail(), user.getUserEmail());
		assertEquals(outVO.getNickname(), user.getNickname());
		assertEquals(outVO.getAdminChk(), user.getAdminChk());
	}

	@AfterEach
	void tearDown() throws Exception {
		log.debug("tearDown: 테스트 종료");			
	}
}