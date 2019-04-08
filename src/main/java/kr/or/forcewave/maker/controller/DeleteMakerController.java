package kr.or.forcewave.maker.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.forcewave.maker.service.IMakerService;

@Controller
@ResponseBody
public class DeleteMakerController {
	@Inject IMakerService service;
	@RequestMapping(value="/maker/delete.do",method=RequestMethod.POST)
	public boolean deleteMaker(String id,String content,Model model){
		boolean flag=service.deleteMaker(id,content);
		Map<String, Boolean> flagMap=new HashMap<>();
		model.addAttribute("flag", flag);
		return flag;
	}
}
