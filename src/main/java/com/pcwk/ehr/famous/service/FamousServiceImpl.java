package com.pcwk.ehr.famous.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.comment.domain.CommentVO;
import com.pcwk.ehr.famous.domain.FamousVO;
import com.pcwk.ehr.mapper.CommentMapper;
import com.pcwk.ehr.mapper.FamousMapper;

@Service
public class FamousServiceImpl implements FamousService {

	@Autowired
	FamousMapper famousMapper;
	
	@Autowired
	CommentMapper commentMapper;
	
	@Override
	public int doSaveComment(CommentVO vo) {
		return commentMapper.doSave(vo);
	}
	
	@Override
	public List<CommentVO> getCommentList(DTO dto) {
	    return commentMapper.doRetrieve(dto);
	}
	
	@Override
	public int doUpdateLike(FamousVO vo) {
	    // 1. 좋아요 수 증가 (UPDATE 수행)
	    // 기존에 호출하던 famousMapper.updateReCount(vo) 등
	    famousMapper.updateReCount(vo); 
	    
	    // 2. 증가된 최신 데이터 한 건을 다시 조회 (SELECT 수행)
	    // vo에 담긴 famousSid를 이용하여 해당 게시물을 다시 가져옵니다.
	    FamousVO latestVO = famousMapper.doSelectOne(vo);
	    
	    // 3. '1'이 아닌 실제 DB에 저장된 총 좋아요 개수를 반환!
	    return latestVO.getFamousReccount();
	}

	@Override
	public List<FamousVO> getBest3() {
		return famousMapper.getBest3();
	}

	@Override
	public List<FamousVO> allDoRetrieve(DTO dto) {
	    return famousMapper.allDoRetrieve(dto);
	}
	
	
	
	@Override
	public List<FamousVO> doRetrieve(DTO dto) {
		return famousMapper.doRetrieve(dto);
	}

	@Override
	public int doUpdate(FamousVO param) {
		return famousMapper.doUpdate(param);
	}

	@Override
	public int doDelete(FamousVO param) {
		return famousMapper.doDelete(param);
	}

	@Override
	public FamousVO doSelectOne(FamousVO param) {
		return famousMapper.doSelectOne(param);
	}

	@Override
	public int doSave(FamousVO param) {
		return famousMapper.doSave(param);
	}



}
