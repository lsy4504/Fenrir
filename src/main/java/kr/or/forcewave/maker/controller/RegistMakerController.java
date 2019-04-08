package kr.or.forcewave.maker.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.forcewave.maker.service.IMakerService;

@Controller
@ResponseBody
public class RegistMakerController {
	@Inject IMakerService service;
	@RequestMapping(value="/maker/insert.do",method=RequestMethod.POST,produces="application/json; charset=utf-8")
	public boolean registMeker( @RequestBody List<Map<String, Object>> jsonData,Model model){
		
		System.out.println("아이야");
		System.out.println(jsonData.size());
		int result=service.insertMaker(jsonData);
		boolean flag=false;
		if(result>0){
			flag=true;
		}
		return flag;
	}
}
