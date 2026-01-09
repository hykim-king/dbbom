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
}
