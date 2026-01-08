package com.pcwk.ehr.diary.service;

import java.util.List;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.diary.domain.DiaryVO;

public interface DiaryService extends WorkDiv<DiaryVO>{

    DiaryVO upDoSelectOne(DiaryVO param);

    List<DiaryVO> doPublicRetrieve(DTO dto);

    List<DiaryVO> getBest3();
    
}