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
import com.pcwk.ehr.mapper.UserMapper;
import com.pcwk.ehr.user.domain.UserVO;

@ExtendWith(SpringExtension.class) // JUnit 5와 Spring 연동
// Spring 설정 파일 로드
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" }) // 스프링 설정 파일 로드
class famousDaoTest {

	final Logger log = LogManager.getLogger(getClass());

	@Autowired
	ApplicationContext context; // 스프링 컨테이너 자동 주입

	@Autowired
	FamousMapper famousMapper;// 테스트 대상 : Mapper

	@Autowired
	UserMapper userMapper;

	// 테스트용 객체 선언
	FamousVO famous01;
	FamousVO famous02;
	FamousVO famous03;

	UserVO user01;
	UserVO user02;
	UserVO user03;

	// DTO 객체 (추후 검색/페이징 등 테스트용)
	DTO dto;

	// 테스트 전, 초기화
	@BeforeEach
	void setUp() throws Exception {
		log.debug("setup: 테스트 데이터 초기화");

		user01 = new UserVO("user01", "홍길동", "1234", "010-1111-1111", "hong@gmail.com", "홍홍", "반가워요", null, null, "N");
		user02 = new UserVO("user02", "김철수", "1234", "010-2222-2222", "kim@gmail.com", "철이", "안녕하세요", null, null, "N");
		user03 = new UserVO("user03", "이영희", "1234", "010-3333-3333", "lee@gmail.com", "영희", "반갑습니다", null, null, "Y");

		famous01 = new FamousVO(0, "알베르트 아인슈타인", "상상력은 지식보다 중요하다.", "P", 0, 0, null, null, "user01");
		famous02 = new FamousVO(1, "아리스토텔레스", "인내는 쓰지만 그 열매는 달다.", "P", 0, 0, null, null, "user02");
		famous03 = new FamousVO(2, "공자", "화가 치밀어 오를때, 그 결과를 생각하라.", "N", 0, 0, null, null, "user03");

		// DTO 초기화
		dto = new DTO();
	}

	// 단건 저장 테스트
	@Disabled
	@Test
	void doSave() {

		// DB 초기화
		famousMapper.deleteAll();
		userMapper.deleteAll();

		// 단건 저장
		int save = userMapper.doSave(user01);
		assertEquals(1, save, "등록 실패!"); // 결과가 1인지 확인

		int flag = famousMapper.doSave(famous01);
		// 성공하면 메세지 출력 안됨
		assertEquals(1, flag, "등록 실패!");

		// 전체 건수 조회
		int count = famousMapper.getCount();
		// 성공하면 메세지 출력 안됨
		assertEquals(1, count, "건수 조회 실패!");

		// 단건 조회
		// FamousVO outVO = famousMapper.doSelectOne(famous01);
		// //성공하면 메세지 출력 안됨
		// assertNotNull(outVO, "단건 조회 실패!");
		// isSameFamous(outVO, famous01); //필드 비교
	}

	// 단건 수정 테스트
	@Disabled
	@Test
	void doUpdate() {

		// DB 초기화
		famousMapper.deleteAll();
		userMapper.deleteAll();

		// 유저 저장
		int save = userMapper.doSave(user01);
		assertEquals(1, save);

		// 명언 저장
		int flag = famousMapper.doSave(famous01);
		assertEquals(1, flag);

		// 저장된 데이터 다시 조회 (PK 확실한 객체)
		List<FamousVO> list = famousMapper.getAll();
		assertEquals(1, list.size());

		FamousVO outVO = list.get(0);
		assertNotNull(outVO, "조회 결과 null");

		// 수정
		outVO.setFamousContent("수정된 명언");
		outVO.setFamousEmotion("P");

		// 수정 실행
		flag = famousMapper.doUpdate(outVO);
		assertEquals(1, flag, "수정 실패!");

		// 수정 후 재조회
		FamousVO upResult = famousMapper.doSelectOne(outVO);
		assertNotNull(upResult);

		isSameFamous(upResult, outVO);
	}

	// 단건 삭제 테스트
	 @Disabled
	@Test
	void doDelete() {

		// DB 초기화
		famousMapper.deleteAll();
		userMapper.deleteAll();

		// 유저 저장 (FK 때문에 반드시 필요)
		int save = userMapper.doSave(user01);
		assertEquals(1, save);

		// 명언 저장
		int flag = famousMapper.doSave(famous01);
		assertEquals(1, flag);

		// SID 확보 (가장 최근 데이터)
		List<FamousVO> list = famousMapper.getAll();
		assertEquals(1, list.size());

		FamousVO savedVO = list.get(0); // 최신 1건
		assertNotNull(savedVO);

		// 단건 삭제 (PK 있는 객체로!)
		int deleteFlag = famousMapper.doDelete(savedVO);
		assertEquals(1, deleteFlag);

		// 건수 확인
		int count = famousMapper.getCount();
		assertEquals(0, famousMapper.getCount());
		log.debug("전체 목록: " + count);
	}

	// 전체 목록 조회 테스트
	@Disabled
	@Test
	void getAll() {
		// DB 초기화
		famousMapper.deleteAll();
		userMapper.deleteAll();

		// 유저 저장 (FK 때문에 반드시 필요)
		userMapper.doSave(user01);
		userMapper.doSave(user02);
		userMapper.doSave(user03);

		// 명언 저장
		famousMapper.doSave(famous01);
		famousMapper.doSave(famous02);
		famousMapper.doSave(famous03);

		// 전체 목록 조회
		List<FamousVO> list = famousMapper.getAll();
		assertNotNull(list);// NULL 체크

		// 조회 건수 확인;
		assertEquals(3, list.size(), "목록 조회 건수 오류!");
		log.debug("전체 목록: " + list);
	}

	// 조회수 증가 테스트
	@Disabled
	@Test
	void updateViewCount() {

		// DB 초기화
		famousMapper.deleteAll();
		userMapper.deleteAll();

		// 유저 저장
		int save = userMapper.doSave(user01);
		assertEquals(1, save);

		// 명언 저장
		int flag = famousMapper.doSave(famous01);
		assertEquals(1, flag);

		// PK 확보 (DB에서 다시 조회)
		List<FamousVO> list = famousMapper.getAll();
		assertEquals(1, list.size());

		FamousVO savedVO = list.get(0);
		assertNotNull(savedVO);

		// 조회수 증가
		int count = famousMapper.updateViewCount(savedVO);
		assertEquals(1, count);
		log.debug("조회수 증가: " + count);

		// 증가 확인
		FamousVO result = famousMapper.doSelectOne(savedVO);
		assertEquals(1, result.getFamousViewcount());
		log.debug("조회수 증가 확인: " + result);
	}

	// 추천수 증가 테스트
	@Disabled
	@Test
	void updateReCount() {

		// DB 초기화
		famousMapper.deleteAll();
		userMapper.deleteAll();

		// 유저 저장
		int save = userMapper.doSave(user01);
		assertEquals(1, save);

		// 명언 저장
		int flag = famousMapper.doSave(famous01);
		assertEquals(1, flag);

		// PK 확보
		List<FamousVO> list = famousMapper.getAll();
		assertEquals(1, list.size());

		FamousVO savedVO = list.get(0);
		assertNotNull(savedVO);

		// 추천수 증가
		int count = famousMapper.updateReCount(savedVO);
		assertEquals(1, count);
		log.debug("추천수 증가 update 결과: " + count);

		// 증가 확인
		FamousVO result = famousMapper.doSelectOne(savedVO);
		assertNotNull(result);

		assertEquals(1, result.getFamousReccount());
		log.debug("추천수 증가 확인: " + result.getFamousReccount());
	}

	// 전체 삭제 테스트
	@Disabled
	@Test
	void deleteAll() {

		// DB 초기화
		famousMapper.deleteAll();
		userMapper.deleteAll();

		// 유저 저장 (FK 필수)
		userMapper.doSave(user01);
		userMapper.doSave(user02);

		// 명언 저장
		famousMapper.doSave(famous01);
		famousMapper.doSave(famous02);

		// 전체 삭제
		famousMapper.deleteAll();

		// 검증
		assertEquals(0, famousMapper.getCount(), "전체 삭제 실패!");
	}

	// 객체의 각 필드 값 비교 헬퍼
	private void isSameFamous(FamousVO outVO, FamousVO vo) {
		assertEquals(outVO.getFamousAuthor(), vo.getFamousAuthor());
		assertEquals(outVO.getFamousContent(), vo.getFamousContent());
		assertEquals(outVO.getFamousEmotion(), vo.getFamousEmotion());
		assertEquals(outVO.getRegId(), vo.getRegId());
	}

	// 테스트 후, 정리
	@AfterEach
	void tearDown() throws Exception {
		log.debug("┌───────────────────────┐");
		log.debug("│tearDown 테스트 종료   │");
		log.debug("└───────────────────────┘");
	}
}
