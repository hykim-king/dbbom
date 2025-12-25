package com.pcwk.ehr.comment.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.comment.domain.CommentVO;
import com.pcwk.ehr.mapper.CommentMapper;

@Service("commentService")
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentMapper commentMapper;

    @Override
    public List<CommentVO> getListByDiarySid(int diarySid) {
        return commentMapper.getListByDiarySid(diarySid);
    }

    @Override
    public int doSave(CommentVO param) {
        return commentMapper.doSave(param);
    }
}
