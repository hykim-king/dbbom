package com.pcwk.ehr.adminUser;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.diary.domain.DiaryVO;
import com.pcwk.ehr.mapper.AdminMapper;
import com.pcwk.ehr.user.domain.UserVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    AdminMapper adminMapper;

    @RequestMapping(value = "/adminPage.do", method = RequestMethod.GET)
    public String adminPage(DTO dto, Model model, 
                            @RequestParam(name="menu", defaultValue="all") String menu,
                            @RequestParam(defaultValue = "1") int reportPage,
                            @RequestParam(defaultValue = "1") int userPage,
                            @RequestParam(defaultValue = "1") int diaryPage) {
        
        // 요약은 5개, 상세는 10개
        int size = menu.equals("all") ? 5 : 10;
        dto.setPageSize(size);

        // 각 섹션 조회
        dto.setPageNo(reportPage);
        model.addAttribute("reportList", adminMapper.doRetrieveReportList(dto));
        dto.setPageNo(userPage);
        model.addAttribute("userList", adminMapper.doRetrieveUserList(dto));
        dto.setPageNo(diaryPage);
        model.addAttribute("diaryList", adminMapper.doRetrieveDiaryList(dto));

        model.addAttribute("reportPage", reportPage);
        model.addAttribute("userPage", userPage);
        model.addAttribute("diaryPage", diaryPage);
        model.addAttribute("menu", menu);
        model.addAttribute("dto", dto);
        
        return "admin/admin_page";
    }
}