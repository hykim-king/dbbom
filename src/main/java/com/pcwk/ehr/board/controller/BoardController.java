package com.pcwk.ehr.board.controller;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.pcwk.ehr.comment.domain.CommentVO;
import com.pcwk.ehr.comment.service.CommentService;

@Controller
@RequestMapping("/board")
public class BoardController {

    final Logger log = LogManager.getLogger(getClass());

    @Autowired
    private CommentService commentService;

    // 게시판 화면(지금은 고정 글 1개로 테스트)
    // 나중에는 diary 공개글 상세 화면으로 확장하면 됨.
    @GetMapping("/view.do")
    public String boardView(@RequestParam(defaultValue = "1") int diarySid, Model model) {

        // 1) 고정 게시글(오늘은 DB 연결 X)
        model.addAttribute("boardText", "이건 게시판 글 입니다. 댓글을 달아주세요");
        model.addAttribute("diarySid", diarySid);

        // 2) 댓글 목록
        List<CommentVO> comments = commentService.getListByDiarySid(diarySid);
        model.addAttribute("comments", comments);

        return "board/board_view";
    }
}
