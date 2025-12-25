package com.pcwk.ehr.comment.service;

import java.util.List;
import com.pcwk.ehr.comment.domain.CommentVO;

public interface CommentService {
    List<CommentVO> getListByDiarySid(int diarySid);
    int doSave(CommentVO param);
}
