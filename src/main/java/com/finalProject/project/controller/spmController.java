package com.finalProject.project.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.finalProject.project.model.spmVO;
import com.finalProject.project.service.SpmService;

@Controller
public class spmController {
	@Autowired
	private SpmService service;
	
	@RequestMapping("/spm/condition")
	public String spmCondition() {
		return "supplements/spmCondition";
	}
	
	@RequestMapping("/spm/effect")
	public String spmEffect() {
		return "supplements/spmEffectMenu";
	}
	
	//전체
	@RequestMapping("/spm/listSupplement")
	public String listSupplement(Model model) {
		ArrayList<spmVO>spmList=service.listSupplement();
		model.addAttribute("spmList",spmList);
		return "supplements/supplementA";
	}
	
	// Effspmprd
	@RequestMapping("/spm/spmlist/{spmEffCtg}")
	public String spmEffCtgList(@PathVariable String spmEffCtg, Model model) {
		ArrayList<spmVO>spmEffList=service.efflistSpm(spmEffCtg);
		model.addAttribute("spmEffList",spmEffList);
//		System.out.print(spmEffCtg);
		return "supplements/supplementEff";
	}

	// detail	
	@RequestMapping("/supplements/spmDetail/{spmName}")
	public String detailSpm(@PathVariable String spmName, Model model) {
		spmVO spm=service.spmDetail(spmName);
		model.addAttribute("spm",spm);
		System.out.print(spmName);
		return "supplements/spmDetail";
	}
	
	@ResponseBody
	@RequestMapping("/spm/spmDetail/like")
	public String detailViewRoutineInfoLike(@RequestParam String spmName,
										Model model, HttpSession session) {
		System.out.println(spmName);
		String memId = (String)session.getAttribute("sid");
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("spmName", spmName);
		map.put("memId", memId);
		int boolInt = service.savespmList(map);
		String result = "fail";
		if(boolInt == 1){
			result = "success";
		}
		return result;
	}
	
	
	
}
