package com.pcwk.ehr.noticeController;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pcwk.ehr.notice.NoticeVO;
import com.pcwk.ehr.noticeService.*;
import com.pcwk.ehr.user.domain.UserVO;

@Controller
@RequestMapping("/notice")
public class NoticeController {

	final Logger log = LogManager.getLogger(getClass());

	@Autowired
	NoticeService noticeService;

	// 등록 화면으로 이동하는 메서드 추가
	@GetMapping("/moveToReg.do")
	public String moveToReg() {
		log.debug("moveToReg() - 등록 화면 이동");
		return "notice/notice_reg"; // WEB-INF/views/notice/notice_reg.jsp를 호출
	}

	@GetMapping("/noticeList.do")
	public String doRetrieve(NoticeVO inVO, Model model) {
		log.debug("목록 조회 진입");

		// 페이지 기본값 설정 (데이터가 안 나오는 문제 방지)
		if (inVO.getPageNo() == 0)
			inVO.setPageNo(1);
		if (inVO.getPageSize() == 0)
			inVO.setPageSize(10);

		// 서비스 호출하여 DB 데이터 가져오기
		List<NoticeVO> list = noticeService.doRetrieve(inVO);

		// 화면(JSP)으로 데이터 전달
		model.addAttribute("list", list);
		model.addAttribute("vo", inVO);

		return "notice/notice_list";
	}

	// 등록 (관리자 체크 포함)
	@RequestMapping(value = "/doSave.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String doSave(NoticeVO inVO, HttpSession session) {
		UserVO loginUser = (UserVO) session.getAttribute("user");

		// 관리자 권한 체크 (isAdmin 필드가 'Y'인 경우)
		if (loginUser == null || !"Y".equals(loginUser.getAdminChk())) {
			return "{\"status\":\"fail\", \"msg\":\"관리자만 작성 가능합니다.\"}";
		}

		inVO.setRegId(loginUser.getUserId());
		int flag = noticeService.doSave(inVO);

		return flag == 1 ? "{\"status\":\"success\"}" : "{\"status\":\"fail\"}";
	}

	// 상세 조회
	@RequestMapping(value = "/doSelectOne.do", method = RequestMethod.GET)
	public String doSelectOne(NoticeVO inVO, Model model) {
		NoticeVO outVO = noticeService.doSelectOne(inVO);
		model.addAttribute("vo", outVO);
		return "notice/notice_mng";
	}
}