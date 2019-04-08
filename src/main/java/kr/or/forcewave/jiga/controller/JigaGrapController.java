package kr.or.forcewave.jiga.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.forcewave.jiga.service.IJigaService;

@Controller
public class JigaGrapController {
	@Inject IJigaService service;
	@RequestMapping(value="/jiga/jigaGrap.do",method=RequestMethod.GET)
	public String jigaGrap(Model model,String[] emdArry,String start, String end){
		List<String> emdList=new ArrayList<>();
		emdList.addAll(Arrays.asList(emdArry));
		Map<String, Object> emdMap=new HashMap<>();
		List<String> yearPerArr= new ArrayList<>();
		List<String> yearArr= new ArrayList<>();
		for (int i = Integer.parseInt(start); i <= Integer.parseInt(end); i++) {
			yearArr.add("20"+i+"년 ");
		}
		for (int i = Integer.parseInt(start); i < Integer.parseInt(end); i++) {
			yearPerArr.add(i+"년~"+(i+1)+"년 증감률");
		}
		emdMap.put("start", start);
		emdMap.put("end", end);
		emdMap.put("emdList", emdList);
		System.out.println(emdList.size());
		List<Map<String, String>> returnEmdList= service.jigaGrapData(emdMap);
		for (Map<String, String> map : returnEmdList) {
			Set<String> key=map.keySet();
			for (String string : key) {
				if(string.contains("jiga")){
					String newData=map.get(string).replace('원', ' ').trim();
					System.out.println(newData);
					map.put(string, newData);
				}
			}
			
			
		}
		model.addAttribute("emdList", returnEmdList);
		model.addAttribute("yearArr",yearArr );
		model.addAttribute("yearPerArr",yearPerArr );
		model.addAttribute("start",start);
		
		return "grapPop";
	}
}
