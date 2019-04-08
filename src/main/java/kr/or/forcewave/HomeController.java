package kr.or.forcewave;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.forcewave.emd.service.IEmdService;
import kr.or.forcewave.test.dao.test;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Inject
	test tt;
	@Inject
	IEmdService service;
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model,HttpSession request) {
		logger.info("Welcome home! The client locale is {}.", locale);
		System.out.println("타주지?");
		//url 포트 바꿔주기
//		request.getServletContext().setAttribute("myURL", "http://192.168.0.16:8080/geoserver/");//내자리
//		request.getServletContext().setAttribute("myURL", "http://192.168.10.28:8080/geoserver/");//내자리
	request.getServletContext().setAttribute("myURL", "http://192.168.0.204:8080/geoserver/");//내자리
//		request.getServletContext().setAttribute("myURL", "http://192.168.0.14:8080/geoserver/");//14층 로컬
//		request.getServletContext().setAttribute("myURL", "http://192.168.0.5:8080/geoserver/");//우리집
		
//		System.out.println(tt.testCount());
		Date date = new Date();
		List<String> emdList= service.emdList();
		List<Map<String, String>> yearList=service.yearList();
		System.out.println(emdList.size());
		model.addAttribute("emdList", emdList);
		model.addAttribute("yearList", yearList);
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		model.addAttribute("aa", "사랑해요" );
		model.addAttribute("bb", "avbc" );
		
		return "index2";
	}
	
}
