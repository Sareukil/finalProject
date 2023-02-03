package com.finalProject.project.controller;





import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.finalProject.project.model.MemberVO;
import com.finalProject.project.service.MemberService;



@Controller
public class MemberController {
	
	@Autowired
	 MemberService service;

	
	// 로그인 폼 열기
	@RequestMapping("/member/loginForm")
	public String loginForm() {
		return "member/loginForm";
	}
	
	// 비밀번호 암호화하기 이전 로그인 처리 방식
	// 로그인 처리 : id와 pwd 전달 받아서 로그인 인증 완료 후 세션 설정
//	@ResponseBody
//	@RequestMapping("/member/login")
//	public String loginCheck(@RequestParam HashMap<String, Object> param,
//												HttpSession session) {
//		// 로그인 체크 결과 
//		String memId = service.loginCheck(param);
//		String result = "fail";
//		
//		// 아이디와 비밀번호 일치하면 (로그인 성공하면)
//		if(memId != null) {
//			//로그인 성공하면 세션 변수 지정
//			session.setAttribute("sid", memId);
//			result = "success";
//		}
//		
//		return result;
//	}
	
	// 비밀번호 암호화한 경우의 로그인 처리 방식
	@ResponseBody
	@RequestMapping("/member/login")
	public String loginCheck(@RequestParam HashMap<String, Object> param,
												HttpSession session) {
		// 로그인 체크 결과 
		String result = service.loginCheck(param); // result : "success" 또는 "fail"
		
		
		// 아이디와 비밀번호 일치하면 (로그인 성공하면)
		// 서비스에서 "success" 반환받았으면
		if(result.equals("success")) {
			//로그인 성공하면 세션 변수 지정
			session.setAttribute("sid", param.get("id"));			
		}
		
		return result;
	}
	
	
	
	
	// 로그아웃
	@RequestMapping("/member/logout")
	public String logout(HttpSession session) {
		//세션 무효화
		session.invalidate();		
		return "redirect:/"; // index로 포워딩 -> ProductController에 있는 @RequestMapping("/") 
	}
	
	// 회원가입 폼 열기
	@RequestMapping("/member/joinForm")
	public String joinForm() {
		return "member/joinForm";
	}
	
	// 회원가입
	@RequestMapping("/member/insert")
	public String insert(MemberVO vo,
									  @RequestParam("memHp1") String memHp1)
									  {
		vo.setMemHp(memHp1);
		service.insertMember(vo);
		return "member/loginForm"; // 회원 가입 후 로그인 폼으로 이동
	}
	//아이디 중복체크
	@ResponseBody
	@RequestMapping("/member/memIdCheck")
	public String memIdCheck(@RequestParam("memId") String memId) {
		// 서비스 호출하고 DB에 prdNo 존재하면 prdNo 받고, 존재하지 않으면 null 받음
		String memId_result = service.memIdCheck(memId);
		
		String result = "use";
		if(memId_result != null)  // 존재한다면
			result = "no_use";
		
		return result;
	}
	//마이페이지 회원 정보 띄우기
	
	@RequestMapping("/member/myPage")
	public String myPage(Model model, HttpSession session) { 
		String memId = (String)session.getAttribute ("sid");
		MemberVO memberVO = service.memberInfo(memId);
		
		if(memberVO == null) {
			return "index";
		}
		
		model.addAttribute("info", memberVO);
		return "/member/myPage";
			
		
		
	}

	// 회원 정보 수정 폼 열기
		// (수정할 데이터를 미리 출력하기 위해 회원 상세 정보 결과 출력)
		@RequestMapping("/member/memberUpdateForm")
		public String memberUpdateForm(HttpSession session, Model model) {
			// 서비스에게 받아오기?
			String memId = (String)session.getAttribute ("sid");
			MemberVO vo = service.memberInfo(memId);
			model.addAttribute("info", vo);
			
			return "member/memberUpdateForm";
		}
		
		
		// 회원 정보 수정 완료 후 폼 열기
				// (수정완료후)
				@RequestMapping("/member/memberUpdate")
				public String memberUpdate(HttpSession session, MemberVO vo) {
					// 서비스에게 받아오기?
					vo.setMemId((String)session.getAttribute ("sid"));
					service.updatemember(vo);
				
				System.out.println(vo.toString());
					return "redirect:/member/myPage";
				}
				
				//회원탈퇴
				@GetMapping("/member/deletemember/{memId}")
				public String deletemember(@PathVariable String memId, HttpSession session) {
					service.deletemember(memId);
					
					//세션 무효화
					// 데이터 삭제 후 메인 홈으로
					// 로그아웃
					session.invalidate();		
					return "redirect:/"; // index로 포워딩 -> ProductController에 있는 @RequestMapping("/") 
					
					
				}
				
				
				//비번 변경
				@GetMapping("/member/memPw")
				public String memPwForm() {
					
					return "member/memPw";
				}
				@RequestMapping("/member/memPw")
				public String passwd(String memPw, String newmemPw, String newmemPwConfirm, HttpSession session, 
						HashMap<String, Object> param){
					
					//현재 비밀번호 맞는지 체크
					String memId = (String)session.getAttribute ("sid");
					MemberVO vo = service.memberInfo(memId);
					
					 boolean ismemPwRight = BCrypt.checkpw(memPw, vo.getMemPw());
					 
					 if(ismemPwRight == false) {
						 String result = service.loginCheck(param); // result : "success" 또는 "fail"
							
							
							// 아이디와 비밀번호 일치하면 (로그인 성공하면)
							// 서비스에서 "success" 반환받았으면
							if(result.equals("success")) {
								//로그인 성공하면 세션 변수 지정
								session.setAttribute("sid", param.get("id"));			
							}
							
							return result;
					 }
					//새 비번, 새 비번 확인 맞는지 체크
					
					 
					 if(newmemPw.equals(newmemPwConfirm) == false) { //새 비번, 새 비번 확인이 서로 다름
						 String result = service.loginCheck(param); // result : "success" 또는 "fail"
							
							
							// 아이디와 비밀번호 일치하면 (로그인 성공하면)
							// 서비스에서 "success" 반환받았으면
							if(result.equals("success")) {
								//로그인 성공하면 세션 변수 지정
								session.setAttribute("sid", param.get("id"));			
							}
							
							return result;
						 
					 }
					
					MemberService memberService = new MemberService();
					//db비번 변경
					//비번 암호화
					BCrypt.hashpw(newmemPw, BCrypt.gensalt());
					 memberService.modifymemPw(memId, newmemPw);
					 
					 
					//비번 완료 메시지 띄우고 로그아웃 처리
					 	
							vo.setMemPw((String)session.getAttribute ("sid"));
							service.modifymemPw(memId, newmemPw);
						
						System.out.println(vo.toString());
							return "redirect:/member/logout";
						}
				
				
				
				
}
	


		
	







