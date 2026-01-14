package com.pcwk.ehr.adminUser;

<<<<<<< HEAD
import java.util.List;
import javax.servlet.http.HttpSession;
=======
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
>>>>>>> feature/donghan-backup
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.diary.domain.DiaryVO;
import com.pcwk.ehr.mapper.AdminMapper;
<<<<<<< HEAD
import com.pcwk.ehr.user.domain.UserVO;
import com.pcwk.ehr.report.domain.ReportVO;
=======
import com.pcwk.ehr.report.domain.ReportVO;
import com.pcwk.ehr.user.domain.UserVO;
>>>>>>> feature/donghan-backup

@Controller
@RequestMapping("/admin")
public class AdminController {

<<<<<<< HEAD
	@Autowired
	AdminMapper adminMapper;

	@RequestMapping(value = "/adminPage.do", method = RequestMethod.GET)
	public String adminPage(DTO dto, Model model, HttpSession session,
			@RequestParam(name = "menu", defaultValue = "all") String menu,
			@RequestParam(name = "searchDiv", defaultValue = "") String searchDiv,
			@RequestParam(name = "searchWord", defaultValue = "") String searchWord,
=======
	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	AdminMapper adminMapper;

	// 1. 관리자 페이지 메인 조회 (사용자님 원본 유지)
	@RequestMapping(value = "/adminPage.do", method = RequestMethod.GET)
	public String adminPage(DTO dto, Model model, HttpSession session,
			@RequestParam(name = "menu", defaultValue = "all") String menu,
>>>>>>> feature/donghan-backup
			@RequestParam(defaultValue = "1") int reportPage, @RequestParam(defaultValue = "1") int userPage,
			@RequestParam(defaultValue = "1") int diaryPage) {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		if (loginUser == null || !"Y".equals(loginUser.getAdminChk())) {
			return "redirect:/main/main.do";
		}

<<<<<<< HEAD
		// 검색 조건 및 검색어 DTO에 설정 (이 부분이 Mapper의 <if>문과 연결됩니다)
		dto.setSearchDiv(searchDiv);
		dto.setSearchWord(searchWord);

		int size = menu.equals("all") ? 5 : 10;
		dto.setPageSize(size);

		// 1. 신고 관리 데이터 조회
=======
		int size = menu.equals("all") ? 5 : 10;
		dto.setPageSize(size);

>>>>>>> feature/donghan-backup
		dto.setPageNo(reportPage);
		model.addAttribute("reportList", adminMapper.doRetrieveReportList(dto));
		model.addAttribute("reportMaxPage", (int) Math.ceil((double) adminMapper.getReportTotalCount(dto) / size));

<<<<<<< HEAD
		// 2. 회원 관리 데이터 조회
=======
>>>>>>> feature/donghan-backup
		dto.setPageNo(userPage);
		model.addAttribute("userList", adminMapper.doRetrieveUserList(dto));
		model.addAttribute("userMaxPage", (int) Math.ceil((double) adminMapper.getUserTotalCount(dto) / size));

<<<<<<< HEAD
		// 3. 게시글 관리 데이터 조회
=======
>>>>>>> feature/donghan-backup
		dto.setPageNo(diaryPage);
		model.addAttribute("diaryList", adminMapper.doRetrieveDiaryList(dto));
		model.addAttribute("diaryMaxPage", (int) Math.ceil((double) adminMapper.getDiaryTotalCount(dto) / size));

<<<<<<< HEAD
		// JSP로 검색 조건 다시 전달 (입력창 유지용)
		model.addAttribute("menu", menu);
		model.addAttribute("searchDiv", searchDiv);
		model.addAttribute("searchWord", searchWord);

		return "admin/admin_page";
	}

	@RequestMapping(value = "/doDeleteUser.do", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String doDeleteUser(UserVO vo) {
		return (adminMapper.doDeleteUser(vo) > 0) ? "삭제되었습니다." : "실패";
	}

	@RequestMapping(value = "/doDeleteReport.do", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String doDeleteReport(ReportVO vo) {
		return (adminMapper.doDeleteReport(vo) > 0) ? "삭제되었습니다." : "실패";
=======
		model.addAttribute("menu", menu);
		return "admin/admin_page";
	}

	@RequestMapping(value = "/doDeleteReport.do", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String doDeleteReport(ReportVO vo) {
		log.debug("신고 삭제 요청 수신: {}", vo);

		try {
			// 1. 원본 댓글 삭제 (commentSid가 있을 때만)
			if (vo.getCommentSid() != null && vo.getCommentSid() != 0) {
				adminMapper.doDeleteComment(vo);
			}

			// 2. 신고 내역 자체 삭제
			int result = adminMapper.doDeleteReport(vo);

			// [핵심 보정] result가 0이더라도(이미 지워졌거나 결과가 없더라도)
			// 예외가 발생하지 않았다면 관리자에게는 성공으로 보여주는 것이 정확합니다.
			return "정상적으로 처리되었습니다.";

		} catch (Exception e) {
			log.error("삭제 중 예외 발생: {}", e.getMessage());
			return "처리 중 오류가 발생했습니다: " + e.getMessage();
		}
	}

	@RequestMapping(value = "/doDeleteUser.do", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String doDeleteUser(UserVO vo, HttpServletRequest req) {
		// JSP에서 'id'로 보내든 'userId'로 보내든 둘 다 잡도록 보정
		if (vo.getUserId() == null || vo.getUserId().isEmpty()) {
			vo.setUserId(req.getParameter("id"));
		}
		int result = adminMapper.doDeleteUser(vo);
		return (result > 0) ? "해당 회원이 탈퇴 처리되었습니다." : "삭제 실패: 회원 ID를 확인해주세요.";
>>>>>>> feature/donghan-backup
	}

	@RequestMapping(value = "/doDeleteDiary.do", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
<<<<<<< HEAD
	public String doDeleteDiary(DiaryVO vo) {
		return (adminMapper.doDeleteDiary(vo) > 0) ? "삭제되었습니다." : "실패";
=======
	public String doDeleteDiary(DiaryVO vo, HttpServletRequest req) {
		// JSP에서 'id'로 보내든 'diarySid'로 보내든 둘 다 잡도록 보정
		if (vo.getDiarySid() == 0) {
			String idStr = req.getParameter("id");
			if (idStr != null)
				vo.setDiarySid(Integer.parseInt(idStr));
		}
		int result = adminMapper.doDeleteDiary(vo);
		return (result > 0) ? "게시글이 삭제되었습니다." : "삭제 실패: 게시글 번호를 확인해주세요.";
>>>>>>> feature/donghan-backup
	}
}