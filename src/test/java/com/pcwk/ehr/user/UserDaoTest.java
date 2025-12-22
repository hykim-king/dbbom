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
import com.pcwk.ehr.user.domain.Grade;
import com.pcwk.ehr.user.domain.UserVO;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
class UserDaoTest {
	final Logger log = LogManager.getLogger(getClass());

	@Autowired
	ApplicationContext  context;
	
	@Autowired
	UserMapper userMapper;
	
	UserVO user01;
	UserVO user02;
	UserVO user03;	
	
	DTO    dto;
	
	@BeforeEach
	void setUp() throws Exception {
		log.debug("┌──────────────────────────┐");
		log.debug("│──setup───────────────────│");
		log.debug("└──────────────────────────┘");	
		
		user01 = new UserVO("pcwk01_김", "이상무01", "4321a",1,0,"jamesol@paran.com",Grade.BASIC,"날짜 없음!" );		
		user02 = new UserVO("pcwk02_김", "이상무02", "4321a",50,29,"jamesol@paran.com",Grade.SILVER,"날짜 없음!" );
		user03 = new UserVO("pcwk03_김", "이상무03", "4321a",88,31,"jamesol@paran.com",Grade.GOLD,"날짜 없음!" );
		dto    = new DTO();		
	}

	@AfterEach
	void tearDown() throws Exception {
		log.debug("┌──────────────────────────┐");
		log.debug("│─tearDown()               │");
		log.debug("└──────────────────────────┘");			
	}

	@Test
	//@Disabled
	void doRetrieve() {
		// 매번 동일 결과가 도출 되도록 작성.
		// 1. 전체 삭제
		// 2. 1002건 등록
		// 3. 페이징 조회
		// 4. 결과확인
		
		//1.
		userMapper.deleteAll();
		int count = userMapper.getCount();
		assertEquals(0, count);				

		// 2.
		userMapper.saveAll();
		count = userMapper.getCount();
		assertEquals(1002, count);		
		
		// 3. 
		dto.setPageNo(1);
		dto.setPageSize(20);
		
		//검색조건
		dto.setSearchDiv("10");
		dto.setSearchWord("pcwk1");
		
		List<UserVO> list = userMapper.doRetrieve(dto);
		
		// 4.
		assertEquals(dto.getPageSize(), list.size());
		
	}
	
	
	@Disabled
	@Test
	void getAll() {
		// 매번 동일 결과가 도출 되도록 작성.
		// 1. 전체 삭제
		// 2. 한건등록
		// 2.1 한건등록				
		// 2.2 한건등록			
		// 3. 전체조회
		// 4. 건수조회
		
		//1.
		userMapper.deleteAll();
		int count = userMapper.getCount();
		assertEquals(0, count);			
		
		// 2.
		int flag = userMapper.doSave(user01);
		assertEquals(1, flag);
		count = userMapper.getCount();
		assertEquals(1, count);		
		
		// 2-1.
		flag = userMapper.doSave(user02);
		assertEquals(1, flag);
		count = userMapper.getCount();
		assertEquals(2, count);			
		
		
		// 2-2.
		flag = userMapper.doSave(user03);
		assertEquals(1, flag);
		count = userMapper.getCount();
		assertEquals(3, count);		
		
		// 3. 
		List<UserVO> list = userMapper.getAll();
		
		// 4.
		assertEquals(3, list.size());
		
		
		
	}
	
	@Disabled
	@Test
	void doDelete() {
		// 매번 동일 결과가 도출 되도록 작성.
		// 1. 전체 삭제
		// 2. 한건등록
		// 2.1 한건등록		
		// 3. 단건삭제
		// 4. 건수비교
		
		//1.
		userMapper.deleteAll();
		int count = userMapper.getCount();
		assertEquals(0, count);			
		
		// 2.
		int flag = userMapper.doSave(user01);
		assertEquals(1, flag);
		count = userMapper.getCount();
		assertEquals(1, count);	
		
		// 2-1.
		flag = userMapper.doSave(user02);
		assertEquals(1, flag);
		count = userMapper.getCount();
		assertEquals(2, count);		
		
		//3.
		flag=userMapper.doDelete(user01);
		assertEquals(1, flag);
		
		//4.
		count = userMapper.getCount();
		assertEquals(1, count);		
	}
	
	@Disabled
	@Test
	void doUpdate() {
		// 매번 동일 결과가 도출 되도록 작성.
		// 1. 전체 삭제
		// 2. 단건등록(user01)
		// 2-1. 단건등록(user02)
		// 3. 단건조회(user01)
		// 3-1.단건조회후 수정
		// 3-2.update수행
		// 4. 단건조회(user01)
		// 5. 비교
		
		//1.
		userMapper.deleteAll();
		int count = userMapper.getCount();
		assertEquals(0, count);				
		
		// 2.
		int flag = userMapper.doSave(user01);
		assertEquals(1, flag);
		count = userMapper.getCount();
		assertEquals(1, count);			
		
		// 2-1.
		flag = userMapper.doSave(user02);
		assertEquals(1, flag);
		count = userMapper.getCount();
		assertEquals(2, count);		
		
		// 3. 
		UserVO outVO = userMapper.doSelectOne(user01);
		assertNotNull(outVO);	
		
		// 3-1.
		String upString = "_U";
		int    upInt    = 88;
		outVO.setName(outVO.getName()+upString);
		outVO.setPassword(outVO.getPassword()+upString);
		
		outVO.setLogin(outVO.getLogin()+upInt);
		outVO.setRecommend(outVO.getRecommend()+upInt);
		
		outVO.setEmail(outVO.getEmail()+upString);
		outVO.setGrade(Grade.SILVER);
		
		// 3-2.
		flag = userMapper.doUpdate(outVO);
		assertEquals(1, flag);
		
		// 4. 
		UserVO upResultVO=userMapper.doSelectOne(outVO);
		isSameUser(upResultVO, outVO);		
	}
	
	@Disabled
	@Test
	void doSave() {
		// 매번 동일 결과가 도출 되도록 작성.
		// 1. 전체 삭제
		// 2. 단건등록(user01)	
		// 3. 전체건수 조회
		// 4. 실제데이터 조회
		
		
		//1.
		userMapper.deleteAll();
		
		//2.
		int flag = userMapper.doSave(user01);
		assertEquals(1, flag);
		
		//3.
		int count = userMapper.getCount();
		assertEquals(1, count);
		
		//4.
		UserVO outVO=userMapper.doSelectOne(user01);
		assertNotNull(outVO);
		
		isSameUser(outVO,user01);
		
	}
	
	private void isSameUser(UserVO outVO, UserVO user01) {
		assertEquals(outVO.getUserId(), user01.getUserId());
		assertEquals(outVO.getName(), user01.getName());
		assertEquals(outVO.getPassword(), user01.getPassword());
		//-------------------------------------------------------
		assertEquals(outVO.getLogin(), user01.getLogin());
		assertEquals(outVO.getRecommend(), user01.getRecommend());
		assertEquals(outVO.getEmail(), user01.getEmail());
		assertEquals(outVO.getGrade(), user01.getGrade());
		
	}
	
	
	@Disabled
	@Test
	void deleteAll() { 
		int flag = userMapper.deleteAll();
		
		log.debug("flag: "+flag);
	}
	
	
	@Disabled
	@Test
	void beans() {
		log.debug("┌──────────────────────────┐");
		log.debug("│─beans()                  │");
		log.debug("└──────────────────────────┘");	
		
		log.debug("context:"+context);
		log.debug("userMapper:"+userMapper);
		assertNotNull(context);
		assertNotNull(userMapper);
	}

}
