package com.pcwk.ehr.famous;

//JUnit 단언(assert)과 컬렉션 사용
import static org.junit.jupiter.api.Assertions.*;
import java.util.List;

//로그 출력용
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

//JUnit 5 테스트 관련
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;

//Spring 연동 관련
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

//VO, Mapper, DTO, import
import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.famous.domain.FamousVO;
import com.pcwk.ehr.mapper.FamousMapper;

@ExtendWith(SpringExtension.class) // JUnit 5와 Spring 연동
//Spring 설정 파일 로드
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" }) // 스프링 설정 파일 로드
class famousDaoTest {

	final Logger log = LogManager.getLogger(getClass());

	@Autowired
	ApplicationContext context; // 스프링 컨테이너 자동 주입

	@Autowired
	private FamousMapper mapper;// 테스트 대상 : Mapper

	//테스트용 객체 선언
	FamousVO famous01;
	FamousVO famous02;
	FamousVO famous03;

	//DTO 객체 (추후 검색/페이징 등 테스트용)
	DTO dto;

	//테스트 전, 초기화
	@BeforeEach
	void setUp() throws Exception {
		log.debug("setup: 테스트 데이터 초기화");

		famous01 = new FamousVO();
		famous01.setFamousAuthor("홍길동");
		famous01.setFamousContent("시작이 반이다.");
		famous01.setFamousEmotion("행복");
		famous01.setRegId("admin");

		famous02 = new FamousVO();
		famous02.setFamousAuthor("김철수");
		famous02.setFamousContent("노력은 배신하지 않는다.");
		famous02.setFamousEmotion("성취");
		famous02.setRegId("admin");

		famous03 = new FamousVO();
		famous03.setFamousAuthor("이영희");
		famous03.setFamousContent("오늘 하루도 수고했어.");
		famous03.setFamousEmotion("위로");
		famous03.setRegId("admin");

		//DTO 초기화
		dto = new DTO();
	}

	//단건 저장 테스트
	@Test
	void doSave() {
		
		//DB 초기화
		mapper.deleteAll();

		//단건 저장
		int flag = mapper.doSave(famous01);
		//성공하면 메세지 출력 안됨
		assertEquals(1, flag, "등록 실패!");

		//전체 건수 조회
		int count = mapper.getCount();
		//성공하면 메세지 출력 안됨
		assertEquals(1, count, "건수 조회 실패!");

		//단건 조회
		FamousVO outVO = mapper.doSelectOne(famous01);
		//성공하면 메세지 출력 안됨
		assertNotNull(outVO, "단건 조회 실패!");
		isSameFamous(outVO, famous01); //필드 비교
	}

	//단건 수정 테스트
	@Disabled
	@Test
	void doUpdate() {
		//DB 초기화
		mapper.deleteAll();
		
		//단건 저장
		mapper.doSave(famous01);

		//단건 조회
		FamousVO outVO = mapper.doSelectOne(famous01);
		outVO.setFamousContent("수정된 명언"); //수정할 내용
		outVO.setFamousEmotion("중립"); //수정할 감정

		//수정 수행 및 확인
		int flag = mapper.doUpdate(outVO);
		assertEquals(1, flag, "수정 실패!");

		//수정 후, 단건 조회
		FamousVO upResult = mapper.doSelectOne(outVO);
		isSameFamous(upResult, outVO);//필드 비교
	}

	//단건 삭제 테스트
	@Disabled
	@Test
	void doDelete() {
		//DB 초기화
		mapper.deleteAll();
		
		//단건 저장
		mapper.doSave(famous01);

		//단건 삭제 및 성공 확인
		int flag = mapper.doDelete(famous01);
		assertEquals(1, flag);

		//건수 확인
		assertEquals(0, mapper.getCount());
	}

	//전체 목록 조회 테스트
	@Disabled
	@Test
	void getAll() {
		//DB 초기화
		mapper.deleteAll();
		
		//데이터 저장
		mapper.doSave(famous01);
		mapper.doSave(famous02);

		//전체 목록 조회
		List<FamousVO> list = mapper.getAll();
		assertNotNull(list);//NULL 체크
		
		//조회 건수 확인
		assertEquals(2, list.size(), "목록 조회 건수 오류!");
		log.debug("전체 목록: " + list);
	}

	//조회수 증가 테스트
	@Disabled
	@Test
	void updateViewCount() {
		//DB 초기화
		mapper.deleteAll();
		//단건 저장
		mapper.doSave(famous01);

		//조회수 +1 및 확인
		int flag = mapper.updateViewCount(famous01);
		assertEquals(1, flag);
	}

	//추천수 증가 테스트
	@Disabled
	@Test
	void updateReCount() {
		//DB 초기화
		mapper.deleteAll();
		//단건 저장
		mapper.doSave(famous01);

		//추천수 +1 및 확인
		int flag = mapper.updateReCount(famous01); 
		//성공하면 메세지 출력 안됨
		assertEquals(1, flag, "추천수 증가 실패!");
	}

	//공개 일기 자동 등록 테스트
	@Disabled
	@Test
	void saveFromDiary() {
		mapper.deleteAll();

		int flag = mapper.saveFromDiary(famous03);//공개 일기에서 자동 등록
		//성공하면 메세지 출력 안됨
		assertEquals(1, flag, "공개일기 자동 등록 실패!");
	}

	//전체 삭제 테스트
	@Disabled
	@Test
	void deleteAll() {
		mapper.doSave(famous01);
		mapper.doSave(famous02);

		//전체 삭제 수행
		mapper.deleteAll();
		//성공하면 메세지 출력 안됨
		assertEquals(0, mapper.getCount(), "전체 삭제 실패!");
	}

	// 객체의 각 필드 값 비교 헬퍼
	private void isSameFamous(FamousVO outVO, FamousVO vo) {
		assertEquals(outVO.getFamousAuthor(), vo.getFamousAuthor());
		assertEquals(outVO.getFamousContent(), vo.getFamousContent());
		assertEquals(outVO.getFamousEmotion(), vo.getFamousEmotion());
		assertEquals(outVO.getRegId(), vo.getRegId());
	}

	//테스트 후, 정리
	@AfterEach
	void tearDown() throws Exception {
		log.debug("┌───────────────────────┐");
		log.debug("│tearDown 테스트 종료               │");
		log.debug("└───────────────────────┘");
	}
}
