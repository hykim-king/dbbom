package com.pcwk.ehr.report;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

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
import com.pcwk.ehr.report.domain.ReportVO;
import com.pcwk.ehr.mapper.ReportMapper;

@ExtendWith(SpringExtension.class) // JUnit 5와 Spring 연동
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
}) // 스프링 설정 파일 로드

class ReportDaoTest {
    final Logger log = LogManager.getLogger(getClass());

	@Autowired
	ApplicationContext context; // 스프링 컨테이너
	
	@Autowired
	ReportMapper reportMapper; // 테스트 대상 Mapper

    ReportVO report01;
    ReportVO report02;

    DTO dto;

    @BeforeEach
    void setUp() throws Exception {
        log.debug("setup: 테스트 데이터 초기화");  
        
        int seq = 0;

        // diary만 값, 나머지는 null (제약조건 준수)
        // 테스트할떄 시퀀스 값 조정 필요
        report01 = new ReportVO(seq, "신고내용1", 10, null, null, 18, "user01");

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
        log.debug("┌──────────────────────────┐");
        log.debug("│─doSave()                 │");
        log.debug("└──────────────────────────┘");

        reportMapper.deleteAll();

        int flag = reportMapper.doSave(report01);
        assertEquals(1, flag, "doSave() 실패");

        log.debug("doSave() 성공: " + report01);
    }

    @Disabled
    @Test
    void doSelectOne() {
        log.debug("┌──────────────────────────┐");
        log.debug("│─doSelectOne()            │");
        log.debug("└──────────────────────────┘");

        // 먼저 저장
        reportMapper.deleteAll();
        int flag = reportMapper.doSave(report01);
        assertEquals(1, flag, "doSave() 실패");

        ReportVO outVO = reportMapper.doSelectOne(report01);
        assertNotNull(outVO, "doSelectOne() 실패");

        log.debug("doSelectOne() 성공: " + outVO);
    }
    
}
