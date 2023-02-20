package com.finalProject.project.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.finalProject.project.dao.ISpmDAO;
import com.finalProject.project.model.spmVO;

@Service
public class SpmService implements ISpmService {
	@Autowired
	@Qualifier("ISpmDAO")
	private ISpmDAO dao;

	@Override
	public ArrayList<spmVO> listSupplement() {
		return dao.listSupplement();
	}

	@Override
	public spmVO spmDetail(String spmName) {
		return dao.spmDetail(spmName);
	}

	@Override
	public ArrayList<spmVO> efflistSpm(String spmEffCtg) {
		return dao.efflistSpm(spmEffCtg);
	}

	@Override
	public int savespmList(HashMap<String, Object> map) {
		return dao.savespmList(map);
	}

	@Override
	public ArrayList<spmVO> inglistSpm(String spmIngCtg) {
		return dao.inglistSpm(spmIngCtg);
	}
	

	}

