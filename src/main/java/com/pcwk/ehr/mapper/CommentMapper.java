package com.pcwk.ehr.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.pcwk.ehr.comment.domain.CommentVO;

@Mapper
public interface CommentMapper {

    // 특정 게시글(=diarySid)의 댓글 목록
    List<CommentVO> getListByDiarySid(@Param("diarySid") int diarySid);

    // 댓글 등록
    int doSave(CommentVO param);
}
