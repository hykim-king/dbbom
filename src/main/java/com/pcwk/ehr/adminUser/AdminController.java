package com.pcwk.ehr.adminUser;

import java.util.List;
import javax.servlet.http.HttpSession;
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
import com.pcwk.ehr.user.domain.UserVO;
import com.pcwk.ehr.report.domain.ReportVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminMapper adminMapper;

	@RequestMapping(value = "/adminPage.do", method = RequestMethod.GET)
	public String adminPage(DTO dto, Model model, HttpSession session,
			@RequestParam(name = "menu", defaultValue = "all") String menu,
			@RequestParam(name = "searchDiv", defaultValue = "") String searchDiv,
			@RequestParam(name = "searchWord", defaultValue = "") String searchWord,
			@RequestParam(defaultValue = "1") int reportPage, @RequestParam(defaultValue = "1") int userPage,
			@RequestParam(defaultValue = "1") int diaryPage) {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		if (loginUser == null || !"Y".equals(loginUser.getAdminChk())) {
			return "redirect:/main/main.do";
		}

		// 검색 조건 및 검색어 DTO에 설정 (이 부분이 Mapper의 <if>문과 연결됩니다)
		dto.setSearchDiv(searchDiv);
		dto.setSearchWord(searchWord);

		int size = menu.equals("all") ? 5 : 10;
		dto.setPageSize(size);

		// 1. 신고 관리 데이터 조회
		dto.setPageNo(reportPage);
		model.addAttribute("reportList", adminMapper.doRetrieveReportList(dto));
		model.addAttribute("reportMaxPage", (int) Math.ceil((double) adminMapper.getReportTotalCount(dto) / size));

		// 2. 회원 관리 데이터 조회
		dto.setPageNo(userPage);
		model.addAttribute("userList", adminMapper.doRetrieveUserList(dto));
		model.addAttribute("userMaxPage", (int) Math.ceil((double) adminMapper.getUserTotalCount(dto) / size));

		// 3. 게시글 관리 데이터 조회
		dto.setPageNo(diaryPage);
		model.addAttribute("diaryList", adminMapper.doRetrieveDiaryList(dto));
		model.addAttribute("diaryMaxPage", (int) Math.ceil((double) adminMapper.getDiaryTotalCount(dto) / size));

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
	}

	@RequestMapping(value = "/doDeleteDiary.do", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String doDeleteDiary(DiaryVO vo) {
		return (adminMapper.doDeleteDiary(vo) > 0) ? "삭제되었습니다." : "실패";
	}
}