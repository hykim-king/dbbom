package com.pcwk.ehr.diary;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

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
import com.pcwk.ehr.diary.domain.DiaryVO;
import com.pcwk.ehr.mapper.DiaryMapper;
import com.pcwk.ehr.user.domain.UserVO;

@ExtendWith(SpringExtension.class) // JUnit 5와 Spring 연동
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
}) // 스프링 설정 파일 로드

class DiaryDaoTest {
    final Logger log = LogManager.getLogger(getClass());

	@Autowired
	ApplicationContext context; // 스프링 컨테이너
	
	@Autowired
	DiaryMapper diaryMapper; // 테스트 대상 Mapper

    DiaryVO diary01;
    DiaryVO diary02;

    DTO dto;

    @BeforeEach
	void setUp() throws Exception {
		log.debug("setup: 테스트 데이터 초기화");	
		
        int seq = 0;

		diary01 = new DiaryVO(seq, "제목1", "내용1", 0, 0, "Y", 10, "임시reg_dt", "11");
        diary02 = new DiaryVO(seq, "제목2", "내용2", 0, 0, "Y", 10, "임시reg_dt", "11");


		dto = new DTO();		
	}

    @AfterEach
	void tearDown() throws Exception {
		log.debug("┌──────────────────────────┐");
		log.debug("│─tearDown()               │");
		log.debug("└──────────────────────────┘");			
	}

    //@Disabled
	@Test
	void doSave() {
        
		//1.
		diaryMapper.deleteAll();
		
		//2.
		int flag = diaryMapper.doSave(diary01);
		assertEquals(1, flag);

        flag = diaryMapper.doSave(diary02);
		assertEquals(1, flag);
		
		//3.
		int count = diaryMapper.getCount();
		assertEquals(2, count);
		
	}
    
}
