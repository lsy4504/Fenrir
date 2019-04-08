package kr.or.forcewave.emd.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.forcewave.emd.service.IEmdService;

@Controller
public class EmdListController {
	@Inject IEmdService service;
	@RequestMapping(value="/emdList.do",method=RequestMethod.GET)
	public Model getList(Model model){
		List<String> emdList= service.emdList();
		System.out.println(emdList.size());
		model.addAttribute("emdList", emdList);
		
		return model;
	}
}
