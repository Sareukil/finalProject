package com.finalProject.project.dao;


import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.finalProject.project.model.MemberVO;

public interface IMemberDAO {
	// 비밀번호 암호화 하기 이전에 사용하는 메소드
	//public String loginCheck(HashMap<String, Object> map);
	
	// 비밀번호 암호화하는 경우 사용하는 메소드
	public String loginCheck(String id);
	public void insertMember(MemberVO vo);
	public String memIdCheck(String memId);// 아이디 중복 확인
	public MemberVO memberInfo(String memId); //회원 정보 조회
	public void updatemember(MemberVO memId);// 회원 정보수정
	public void deletemember(String memId); // 회원 탈퇴
	 // 비번 변경
	public void modifymemPw(HashMap<String, Object> map);
	public ArrayList<HashMap<String,Object>> exLikeList(String memId);
	public ArrayList<HashMap<String,Object>> spLikeList(String memId);
	
	public void deleteExList(HashMap<String, Object> map);
	public void deleteSpList(HashMap<String, Object> map);

	}
	


		
	
