package com.finalProject.project.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.finalProject.project.model.PagerVO;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.finalProject.project.model.ExerciseInfoVO;
import com.finalProject.project.service.ExerciseInfoService;

@Controller
public class ExerciseController {
	@Autowired
	ExerciseInfoService service;
	
	// TODO index 연결

	@RequestMapping("/exercise/exerciseInfo")
	public String exerciseInfo(Model model) {

		return "exercise/exerciseInfo";
	}
	@ResponseBody
	@RequestMapping("/exercise/exerciseRankList/{pNum}")
	public String exerciseRankList(@PathVariable int pNum, Model model) {

		ArrayList<ExerciseInfoVO> exList = service.rankListInfo(pNum);
		JSONObject obj = new JSONObject();

		obj.put("exListR", exList);
		System.out.println(obj.toString());
		return obj.toString();
	}

	@ResponseBody
	@RequestMapping("/exercise/exerciseItemList/{pNum}/{num}")
	public String exerciseItemList(@PathVariable int pNum,@PathVariable int num, Model model) {
		PagerVO page = new PagerVO();
		HashMap<String,Object> map = new HashMap<String,Object>();
		page.setPostNum(5);
		page.setPageNumCnt(5);
		page.setNum(num);
		page.setDataCount(service.itemListCount(pNum));  
		map.put("displayPost", page.getDisplayPost());
		map.put("postNum", page.getPostNum());
		map.put("pNum", pNum);
		ArrayList<ExerciseInfoVO> exList = service.itemListInfo(map);
		JSONObject obj = new JSONObject();
		
		obj.put("exListI", exList);
		obj.put("next", page.getNext());
		obj.put("select", num);
		obj.put("prev", page.getPrev());
		obj.put("startPageNum", page.getStartPageNum());
		obj.put("endPageNum", page.getEndPageNum());
		System.out.println(obj.toString());
		return obj.toString();
	}

	@ResponseBody
	@RequestMapping("/exercise/exVideoList/{pNum}")
	public String exVideoList(@PathVariable int pNum, Model model) {

		ArrayList<HashMap<String,Object>> exVideoList = service.exVideoList(pNum);
		JSONObject obj = new JSONObject();

		obj.put("exVideoList", exVideoList);
		System.out.println(obj.toString());
		return obj.toString();
	}
	@RequestMapping("/exercise/detailViewRoutineInfo/{routineNo}")
	public String detailViewRoutineInfo(@PathVariable ("routineNo") String routineNo,
										Model model,
										HttpServletRequest request, HttpServletResponse response) {
		ExerciseInfoVO routine = service.detailViewRoutineInfo(routineNo);
		
		Cookie oldCookie = null;
 		Cookie[] cookies = request.getCookies();
 		if (cookies != null) {
 			for (Cookie cookie : cookies) {
 				if (cookie.getName().equals("postView")) {
 					oldCookie = cookie;
 				}
 			}
 		}
		 if (oldCookie != null) {
			if (!oldCookie.getValue().contains("[" + routineNo + "]")) {
				service.viewsExercise(routineNo);
				oldCookie.setValue(oldCookie.getValue() + "_[" + routineNo + "]");
				oldCookie.setPath("/");
				oldCookie.setMaxAge(60 * 60 * 24);
				response.addCookie(oldCookie);
			}
		} else {
			service.viewsExercise(routineNo);
			Cookie newCookie = new Cookie("postView","[" + routineNo + "]");
			newCookie.setPath("/");
			newCookie.setMaxAge(60 * 60 * 24);
			response.addCookie(newCookie);
		}
		model.addAttribute("routine", routine);
		return "exercise/detailRoutineInfo";
	}
	
	@ResponseBody
	@RequestMapping("/exercise/detailViewRoutineInfo/like")
	public String detailViewRoutineInfoLike(@RequestParam String routineNo,
										Model model, HttpSession session) {
		System.out.println(routineNo);
		String memId = (String)session.getAttribute("sid");
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("routineNo", routineNo);
		map.put("memId", memId);
		int boolInt = service.saveMyList(map);
		String result = "fail";
		if(boolInt == 1){
			result = "success";
			service.saveListCount(routineNo);
		}
		return result;
	}

	
}
