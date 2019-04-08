package kr.or.forcewave.emd.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AnalPopController {
	@RequestMapping("/anal/popUp.do")
	public String analPopUp(){
		return "analPop";
	}
}
