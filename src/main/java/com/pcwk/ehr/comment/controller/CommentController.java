package com.pcwk.ehr.comment.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.pcwk.ehr.comment.domain.CommentVO;
import com.pcwk.ehr.comment.service.CommentService;

@Controller
@RequestMapping("/comment")
public class CommentController {

    final Logger log = LogManager.getLogger(getClass());

    @Autowired
    private CommentService commentService;

    @PostMapping("/doSave.do")
    public String doSave(
            @RequestParam int diarySid,
            @RequestParam String commentContent,
            @RequestParam(defaultValue = "guest") String regId // 로그인 붙이면 세션에서 꺼내도록 변경
    ) {
        CommentVO inVO = new CommentVO();
        inVO.setDiarySid(diarySid);
        inVO.setCommentContent(commentContent);
        inVO.setRegId(regId);

        int flag = commentService.doSave(inVO);
        log.debug("comment doSave flag={}", flag);

        return "redirect:/board/view.do?diarySid=" + diarySid;
    }
}
