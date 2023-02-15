package com.finalProject.project.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.finalProject.project.model.HealthcareGraphVO;

public interface IHealthcareDAO {
    public ArrayList<HealthcareGraphVO> graphView(HashMap<String,Object> map);
    public void hcdInput(HashMap<String,Object> map);
    public HealthcareGraphVO hcdOutput(HashMap<String,Object> map);
    public String heightOutput(String memId);
    public ArrayList<HashMap<String, Object>> topTodayList(HashMap<String,Object> map);
    public void itemCheck(HashMap<String,Object> map);
    public ArrayList<HashMap<String, Object>> dateCount(HashMap<String,Object> map);
    public ArrayList<HashMap<String, Object>> calendarMyList(HashMap<String, Object> map);
    public ArrayList<HashMap<String, Object>> exerciseMyList(String memId);
    public ArrayList<HashMap<String, Object>> exerciseRecommendList(HashMap<String,Object> map);
    public void createMyList(HashMap<String,Object> map);
    public void deleteMyList(HashMap<String,Object> map);
    public void deleteList(HashMap<String,Object> map);
    

}
