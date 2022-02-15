package com.spring.cjs2108_kjy;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.cjs2108_kjy.service.BookService;
import com.spring.cjs2108_kjy.vo.BookVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	BookService bookService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		List<BookVO> vos = bookService.getBookIdx();
		List<BookVO> vos2 = bookService.getBookIdx2();
		List<BookVO> vos3 = bookService.getBookIdx3();
		
		System.out.println(vos);
		model.addAttribute("vos", vos);
		model.addAttribute("vos2", vos2);
		model.addAttribute("vos3", vos3);
		model.addAttribute("serverTime", formattedDate );
		
		return "main/main";
	}
}
