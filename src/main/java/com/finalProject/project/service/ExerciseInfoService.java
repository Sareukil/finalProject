package com.finalProject.project.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import java.util.HashMap;
import com.finalProject.project.dao.IExerciseInfoDAO;
import com.finalProject.project.model.ExerciseInfoVO;


@Service
public class ExerciseInfoService implements IExerciseInfoService {
    @Autowired
    @Qualifier("IExerciseInfoDAO")
    private IExerciseInfoDAO dao;

    @Override
    public ExerciseInfoVO detailViewRoutineInfo(String routineNo) {
        return dao.detailViewRoutineInfo(routineNo);
    }

    @Override
    public ArrayList<ExerciseInfoVO> rankListInfo(int pNum){

        return dao.rankListInfo(pNum);
    }

    @Override
    public ArrayList<ExerciseInfoVO> itemListInfo(HashMap<String,Object> map) {

        return dao.itemListInfo(map);
    }

    @Override
    public int itemListCount(int pNum) {

        return dao.itemListCount(pNum);
    }

    @Override
    public ArrayList<HashMap<String, Object>> exVideoList(int pNum) {
        return dao.exVideoList(pNum);
    }

    @Override
    public void viewsExercise(String routineNo) {
        dao.viewsExercise(routineNo);

    }

    @Override
    public int saveMyList(HashMap<String, Object> map) {

        return dao.saveMyList(map);

    }

    @Override
    public void saveListCount(String routineNo) {
        dao.saveListCount(routineNo);

    }




}