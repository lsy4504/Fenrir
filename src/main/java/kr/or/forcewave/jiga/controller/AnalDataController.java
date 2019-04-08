package kr.or.forcewave.jiga.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.forcewave.jiga.service.IJigaService;

@Controller
public class AnalDataController {
	@Inject
	IJigaService service;

	@RequestMapping("/anal/getData.do")
	public String analGetData(Model model, String start, String end) {
		List<Map<String, String>> analDataList = service.analGetData(start, end);
		List<Object> emdNameList = new ArrayList<>();
		
		for (Map<String, String> map : analDataList) {
			Set<String> key=map.keySet();
			for (String string : key) {
				System.out.println(string);
				if(string.contains("jiga")){
					String newData=map.get(string).replace('원', ' ').trim();
					System.out.println(newData);
					map.put(string, newData);
				}
			}
			
			
		}
		List<String> yearArr= new ArrayList<>();
		for (int i = Integer.parseInt(start); i <= Integer.parseInt(end); i++) {
			yearArr.add("20"+i+"년 ");
		}
		model.addAttribute("analDataList",analDataList );
		model.addAttribute("emdNameList",emdNameList );
		model.addAttribute("yearArr",yearArr );
		model.addAttribute("start",start);
		
		return "analGrap";
	}
}
