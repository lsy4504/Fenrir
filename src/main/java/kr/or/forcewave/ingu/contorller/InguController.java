package kr.or.forcewave.ingu.contorller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.forcewave.ingu.service.IinguService;

@Controller
public class InguController {
	@Inject IinguService service;
	@RequestMapping("ingu/list.do")
	public String inguList(Model model,String startYear,String endYear){
		List<String> yearArr= new ArrayList<>();
		List<String> yearPerArr= new ArrayList<>();
		for (int i = Integer.parseInt(startYear); i <= Integer.parseInt(endYear); i++) {
			yearArr.add("'"+i+"년 인구");
		}
		for (int i = Integer.parseInt(startYear); i < Integer.parseInt(endYear); i++) {
			yearPerArr.add("'"+i+"~"+(i+1)+"년 증감률");
		}
		List<Map<String, Object>> inguList=service.inguList(startYear,endYear);
		System.out.println(inguList.get(0).get("emd_nm"));
		model.addAttribute("inguList", inguList);
		model.addAttribute("yearArr",yearArr );
		model.addAttribute("yearPerArr",yearPerArr );
		model.addAttribute("start",startYear );
		model.addAttribute("end",endYear );
		return"inguAnal";
	}
}
