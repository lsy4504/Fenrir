package kr.or.forcewave.jiga.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.forcewave.jiga.service.IJigaService;




@Controller
public class JigaListController {
	@Inject
	IJigaService service;
	
	@RequestMapping(value="/jiga/list.do",method=RequestMethod.GET)
	public String getJigaList(Model model,String startYear,String endYear){
		System.out.println(startYear);
		System.out.println(endYear);
		List<String> yearArr= new ArrayList<>();
		List<String> yearPerArr= new ArrayList<>();
		for (int i = Integer.parseInt(startYear); i <= Integer.parseInt(endYear); i++) {
			yearArr.add("'"+i+"년 지가");
		}
		for (int i = Integer.parseInt(startYear); i < Integer.parseInt(endYear); i++) {
			yearPerArr.add("'"+i+"~"+(i+1)+"년 증감률");
		}
		List<Map<String, String>> jigaList=service.jigaList(startYear,endYear);
		System.out.println(jigaList.get(0).get("emd_nm"));
		model.addAttribute("jigaList", jigaList);
		model.addAttribute("yearArr",yearArr );
		model.addAttribute("yearPerArr",yearPerArr );
		model.addAttribute("start",startYear );
		model.addAttribute("end",endYear );
		
		return "jigaAnal";
	}
}
