package com.pcwk.ehr.diary.service;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.diary.domain.DiaryVO;
import com.pcwk.ehr.mapper.DiaryMapper;

@Service
public class DiaryServiceImpl implements DiaryService 
{
    final Logger log = LogManager.getLogger(getClass());

    @Autowired
    DiaryMapper diaryMapper;

    public DiaryVO upDoSelectOne(DiaryVO param) {
        log.debug("┌---------------------------┐");
        log.debug("│upDoSelectOne param: " + param);  
        log.debug("└---------------------------┘");

        int flag = diaryMapper.updateViewCount(param);
        log.debug("flag : " + flag);
        DiaryVO diaryVO =  diaryMapper.doSelectOne(param);

        return diaryVO;


    }

    @Override
    public List<DiaryVO> doRetrieve(DTO dto) {
        return diaryMapper.doRetrieve(dto);
    }

    @Override
    public int doUpdate(DiaryVO param) {
        return diaryMapper.doUpdate(param);
    }

    @Override
    public int doDelete(DiaryVO param) {
        return diaryMapper.doDelete(param);
    }

    @Override
    public DiaryVO doSelectOne(DiaryVO param) {
        return diaryMapper.doSelectOne(param);
    }

    @Override
    public int doSave(DiaryVO param) {
        return diaryMapper.doSave(param);
    }

    @Override
    public List<DiaryVO> doPublicRetrieve(DTO dto) {
        return diaryMapper.doPublicRetrieve(dto);
    }

    @Override
    public List<DiaryVO> getBest3() {
        return diaryMapper.getBest3();
    }

    

}