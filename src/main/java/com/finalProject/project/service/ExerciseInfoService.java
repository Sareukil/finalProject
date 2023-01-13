package com.finalProject.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.finalProject.project.dao.IExerciseInfoDAO;
import com.finalProject.project.model.ExerciseInfoVO;


@Service
public class ExerciseInfoService implements IExerciseInfoService {
	@Autowired
	@Qualifier("IExerciseInfoDAO")
	IExerciseInfoDAO dao;
	
	@Override
	public ExerciseInfoVO detailViewRoutineInfo(String routineNo) {		
		return dao.detailViewRoutineInfo(routineNo);
	}

}
