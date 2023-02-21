package com.finalProject.project.service;

import java.util.HashMap;
import java.util.ArrayList;
import org.apache.ibatis.javassist.compiler.ast.Member;

import com.finalProject.project.model.MemberVO;


public interface IMemberService {
	public String loginCheck(HashMap<String, Object> map);
	public void insertMember(MemberVO vo);
	public String memIdCheck(String memId);// 아이디 중복 확인
	public MemberVO memberInfo(String memId); //회원 정보 조회
	public void updatemember(MemberVO memId); // 회원 정보수정
	
	public void deletemember(String memId); // 회원 탈퇴
	public void modifymemPw(HashMap<String,Object>map); // 비번 변경
	public ArrayList<HashMap<String,Object>> exLikeList(String memId);
	public ArrayList<HashMap<String,Object>> spLikeList(String memId);
	
	public void deleteExList(HashMap<String, Object> map);
	public void deleteSpList(HashMap<String, Object> map);

	

}