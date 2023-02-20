package com.finalProject.project.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.finalProject.project.model.spmVO;

public interface ISpmDAO {
	public ArrayList<spmVO>efflistSpm(String spmEffCtg);
	public ArrayList<spmVO>inglistSpm(String spmIngCtg);
	
	public ArrayList<spmVO>listSupplement();  //전체 상품
	public spmVO spmDetail(String spmName);  //상세 상품
	public int savespmList(HashMap<String,Object> map);
}
