package com.pcwk.ehr.famous.service;

import java.util.List;

<<<<<<< HEAD
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
=======
>>>>>>> 18ed6dc36142b715f4fe2b6205e7bd779f8ffacc
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.cmn.DTO;
<<<<<<< HEAD
import com.pcwk.ehr.famous.domain.FamousVO;
=======
import com.pcwk.ehr.comment.domain.CommentVO;
import com.pcwk.ehr.famous.domain.FamousVO;
import com.pcwk.ehr.mapper.CommentMapper;
>>>>>>> 18ed6dc36142b715f4fe2b6205e7bd779f8ffacc
import com.pcwk.ehr.mapper.FamousMapper;

@Service
public class FamousServiceImpl implements FamousService {
<<<<<<< HEAD
	
	  final Logger log = LogManager.getLogger(getClass());

	@Autowired
	FamousMapper famousMapper;

	@Override
=======

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
>>>>>>> 18ed6dc36142b715f4fe2b6205e7bd779f8ffacc
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

<<<<<<< HEAD
	@Override
	public int updateViewCount(FamousVO vo) {
	    return famousMapper.updateViewCount(vo);
	    }
	
	@Override
	public int doUpdateLike(FamousVO vo) {
	    // vo에 담긴 famousReccount 값이 -1이면 감소, 1이면 증가가 되도록
	    // Mapper의 SQL 쿼리를 활용하거나 여기서 로직을 나눕니다.
	    
	    // 1. 좋아요 수 수정 (vo에 담긴 값에 따라 +1 혹은 -1 수행)
	    famousMapper.updateReCount(vo);

	    // 2. 반영된 최신 데이터 조회
	    FamousVO latestVO = famousMapper.doSelectOne(vo);

	    // 3. 최신 좋아요 개수 반환
	    return latestVO.getFamousReccount();
	}

	@Override
	public FamousVO getFamousDetail(FamousVO vo) {
	    // 1. 상세 조회 시 조회수 증가 (기존에 만든 메서드 활용)
	    famousMapper.updateViewCount(vo); 
	    
	    // 2. 상세 데이터 가져오기
	    return famousMapper.getFamousDetail(vo);
	}
	
	@Override
	public List<FamousVO> getBest3() {
		return famousMapper.getBest3();
	}

	@Override
	public List<FamousVO> allDoRetrieve(DTO dto) {
		return famousMapper.allDoRetrieve(dto);
	}

}
=======


}
>>>>>>> 18ed6dc36142b715f4fe2b6205e7bd779f8ffacc
