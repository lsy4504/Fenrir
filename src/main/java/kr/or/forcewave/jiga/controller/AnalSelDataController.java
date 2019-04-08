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

import kr.or.forcewave.ingu.service.IinguService;
import kr.or.forcewave.jiga.service.IJigaService;

@Controller
public class AnalSelDataController {
	@Inject
	IJigaService service;
	@Inject IinguService inguService;
	@RequestMapping(value="/anal/getSelectData.do",method=RequestMethod.GET)
	public String analPopUp(Model model, String start, String end,String[] selFeatures){
		System.out.println(start);
		Map<String, Object> paramMap=new HashMap<>();
		List<String> pramList=new ArrayList<>();
		pramList.addAll(Arrays.asList(selFeatures));
		paramMap.put("start",start);
		paramMap.put("end",end);
		paramMap.put("emdList",pramList);
		List<String> yearPerArr= new ArrayList<>();
		List<Map<String, String>> analDataList = service.analSelData(paramMap);
		List<Map<String, String>> jigaDataList= service.jigaGrapData(paramMap);
		List<Map<String, String>> inguEmdList= inguService.inguGrapData(paramMap);
		List<Object> emdNameList = new ArrayList<>();
		for (Map<String, String> map : analDataList) {
			Set<String> key=map.keySet();
			for (String string : key) {
				System.out.println("컬럼명 ->"+string);
				if(string.contains("jiga")){
					String newData=map.get(string).replace('원', ' ').trim();
					System.out.println(newData);
					map.put(string, newData);
				}
			}
		}
		for (Map<String, String> map : jigaDataList) {
			Set<String> key=map.keySet();
			for (String string : key) {
				if(string.contains("per")){
					String newData=map.get(string).replace('%', ' ').trim();
					System.out.println(newData);
					map.put(string, newData);
				}
			}
			
			
		}
		for (Map<String, String> map : inguEmdList) {
			Set<String> key=map.keySet();
			for (String string : key) {
				if(string.contains("per")){
					String newData=map.get(string).replace('%', ' ').trim();
					System.out.println(newData);
					map.put(string, newData);
				}
			}
		}
		List<String> yearArr= new ArrayList<>();
		for (int i = Integer.parseInt(start); i <= Integer.parseInt(end); i++) {
			yearArr.add("20"+i+"년 ");
		}
		model.addAttribute("jigaDataList",jigaDataList );
		model.addAttribute("inguEmdList",inguEmdList );
		model.addAttribute("analDataList",analDataList );
		model.addAttribute("emdNameList",emdNameList );
		model.addAttribute("yearArr",yearArr );
		model.addAttribute("start",start);
		
		return "analGrap";
	}
}
