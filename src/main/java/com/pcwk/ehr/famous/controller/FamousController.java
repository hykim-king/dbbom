package com.pcwk.ehr.famous.controller;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.cmn.StringUtil;
import com.pcwk.ehr.famous.domain.FamousVO;
import com.pcwk.ehr.famous.service.FamousService;
import com.pcwk.ehr.mapper.FamousMapper;

@Controller
@RequestMapping("/famous")
public class FamousController {

	final Logger log = LogManager.getLogger(getClass());

	@Autowired
	FamousService famousService;

	@GetMapping(value = "/famous.do")
	public String famousList(DTO dto, Model model) {
		log.debug("┌───────────────────────────┐");
		log.debug("│famousList dto: " + dto);
		log.debug("└───────────────────────────┘");

		// 1. 좋아요 상위 3개 리스트 가져오기
		List<FamousVO> bestList = famousService.getBest3();
		

		// 2. 페이징 및 검색 파라미터 처리 (DiaryController 방식)
		int pageNo = StringUtil.nvlZero(dto.getPageNo(), 1);
		int pageSize = StringUtil.nvlZero(dto.getPageSize(), 12);

		String searchDiv = StringUtil.nullToEmpty(dto.getSearchDiv());
		String searchWord = StringUtil.nullToEmpty(dto.getSearchWord());

		dto.setPageNo(pageNo);
		dto.setPageSize(pageSize);
		dto.setSearchDiv(searchDiv);
		dto.setSearchWord(searchWord);

		log.debug("processed dto: " + dto);

		// 3. 전체 명언 리스트 조회
	    List<FamousVO> list = famousService.allDoRetrieve(dto);
	    //데이터 확인용 로그
	    for(FamousVO vo : list) {
	        log.debug("데이터 확인: " + vo.toString()); 
	        // 여기서 famousContent 내용이 비어있다면 MyBatis 매핑 문제입니다.
	    }
	   
	    
	    // 4. [수정 핵심] 전체 건수를 숫자(int)로 추출하여 모델에 전달
	    int totalCount = 0;
	    if (list != null && !list.isEmpty()) {
	        // 쿼리 결과(allDoRetrieve)의 각 행에 포함된 total_cnt 값을 가져옴
	        totalCount = list.get(0).getTotalCnt(); 
	    }

	    // 5. 모델에 데이터 추가
	    model.addAttribute("vo", dto);
	    model.addAttribute("list", list);
	    model.addAttribute("bestList", bestList);
	    model.addAttribute("totalCnt", totalCount); // <--- 이 값이 있어야 JSP에서 숫자를 그립니다.

	    return "famous/famous";
	}

	@PostMapping(value = "/doUpdateLike.do", produces = "application/json;charset=UTF-8")
	@ResponseBody // 데이터만 돌려주기 위해 반드시 필요
	public String doUpdateLike(FamousVO vo) {
		log.debug("┌───────────────────────────┐");
		log.debug("│ doUpdateLike famousSid: " + vo.getFamousSid());
		log.debug("└───────────────────────────┘");

		// 1. DB에 좋아요 수 증가 로직 실행
		famousService.doUpdateLike(vo);

//		log.debug("│ Result Count: " + updatedCount);

		// 2. 업데이트된 최신 좋아요 수 반환
		FamousVO latestVO = famousService.doSelectOne(vo);

		// 3. 실제 DB에 저장된 총 좋아요 수를 리턴
		return String.valueOf(latestVO.getFamousReccount());
	}
	
	
	@RequestMapping(value = "/doUpdateViewCount.do", produces = "application/json;charset=UTF-8")
	@ResponseBody // AJAX 통신을 위해 필요
	public String doUpdateViewCount(FamousVO inVO) {
	    int flag = famousService.updateViewCount(inVO);
	    return String.valueOf(flag);
	}
	
	@RequestMapping(value = "/getFamousDetail.do", produces = "application/json;charset=UTF-8")
	public String getFamousDetail(FamousVO vo, Model model) {
	    // 데이터 유효성 체크
	    if(vo.getFamousSid() == 0) {
	        return "redirect:/famous/famous.do"; 
	    }

	    // 서비스 호출
	    FamousVO outVO = famousService.getFamousDetail(vo);
	    
	    // JSP에서 사용할 데이터 이름을 "detail"로 지정
	    model.addAttribute("detail", outVO);
	    model.addAttribute("pageNo", vo.getPageNo()); 
	    model.addAttribute("pageSize", vo.getPageSize());
	    
	    return "famous/famous_detail"; // 생성한 상세페이지 JSP 경로
	}
	
	// 등록 화면으로 이동
	@RequestMapping(value = "/famousRegView.do")
	public String famousRegView() {
	    // /WEB-INF/views/famous/famous_reg.jsp 페이지를 호출합니다.
	    return "famous/famous_reg"; 
	}
	
	// 명언 등록 실행
	@PostMapping(value = "/doSave.do", produces = "application/json;charset=UTF-8")
	@ResponseBody // AJAX 응답을 위해 데이터(JSON)만 반환
	public String doSave(FamousVO vo) {
	    log.debug("┌───────────────────────────┐");
	    log.debug("│ doSave vo: " + vo);
	    log.debug("└───────────────────────────┘");

	    // 1. 서비스 호출 (성공 시 1, 실패 시 0 반환 예상)
	    int flag = famousService.doSave(vo);
	    
	    // 2. 응답 메시지 설정
	    String message = "";
	    if (flag == 1) {
	        message = "명언이 성공적으로 등록되었습니다.";
	    } else {
	        message = "등록에 실패했습니다.";
	    }

	    // 3. 다이어리와 동일한 형식의 JSON 결과 반환
	    return "{\"flag\":\"" + flag + "\", \"message\":\"" + message + "\"}";
	}
	
}
