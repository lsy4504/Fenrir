package kr.or.forcewave.ingu.contorller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.forcewave.ingu.service.IinguService;

@Controller
public class InguGrapController {
	@Inject IinguService service;
	@RequestMapping("/ingu/inguGrap.do")
	public String inguGrap(Model model,String[] emdArry,String start, String end){
		List<String> emdList=new ArrayList<>();
		emdList.addAll(Arrays.asList(emdArry));
		Map<String, Object> inguMap=new HashMap<>();
		List<String> yearArr= new ArrayList<>();
		List<String> yearPerArr= new ArrayList<>();
		for (int i = Integer.parseInt(start); i <= Integer.parseInt(end); i++) {
			yearArr.add("20"+i+"년 ");
		}
		for (int i = Integer.parseInt(start); i < Integer.parseInt(end); i++) {
			yearPerArr.add(i+"년~"+(i+1)+"년 증감률");
		}
		inguMap.put("start", start);
		inguMap.put("end", end);
		inguMap.put("emdList", emdList);
		List<Map<String, String>> returnEmdList= service.inguGrapData(inguMap);
		model.addAttribute("emdList", returnEmdList);
		model.addAttribute("yearArr",yearArr );
		model.addAttribute("yearPerArr",yearPerArr );
		model.addAttribute("start",start);
		return"inguGrap";
	}
}
