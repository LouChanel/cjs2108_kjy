package com.spring.cjs2108_kjy;

import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_kjy.service.MemberService;
import com.spring.cjs2108_kjy.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	String msgFlag = "";
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping(value = "/memLogin", method = RequestMethod.GET)
	public String memLoginGet(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		String mid = "";
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("cMid")) {
				mid = cookies[i].getValue();
				request.setAttribute("mid", mid);
				break;
			}
		}
		
		return "member/memLogin";
	}
	
	@RequestMapping(value = "/memLogin", method = RequestMethod.POST)
	public String memLoginPost(String mid, String pwd, HttpSession session, HttpServletResponse response, HttpServletRequest request, Model model) {
		MemberVO vo = memberService.getIdCheck(mid);
		
		if(vo != null && passwordEncoder.matches(pwd, vo.getPwd())) {
			String strLevel = "";
			if(vo.getLevel() == 0) strLevel = "관리자";
			else if(vo.getLevel() == 1) strLevel = "특별회원";
			else if(vo.getLevel() == 2) strLevel = "우수회원";
			else if(vo.getLevel() == 3) strLevel = "정회원";
			else if(vo.getLevel() == 4) strLevel = "준회원";
			
			session.setAttribute("sMid", mid);
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("sStrLevel", strLevel);
			
			session.setAttribute("sLastDate", vo.getLastDate().substring(0, vo.getLastDate().lastIndexOf(" ")));
			
			memberService.getMemberTodayProcess(vo.getTodayCnt());
			
			String idCheck = request.getParameter("idCheck")==null? "" : request.getParameter("idCheck");
			
			if(idCheck.equals("on")) {
				Cookie cookie = new Cookie("cMid", mid);
				cookie.setMaxAge(60*60*24*7);
				response.addCookie(cookie);
			}
			else {
				Cookie[] cookies = request.getCookies();
				for(int i=0; i<cookies.length; i++) {
					if(cookies[i].getName().equals("cMid")) {
						cookies[i].setMaxAge(0);
						response.addCookie(cookies[i]);
						break;
					}
				}
			}
			msgFlag = "memLoginOk";
		}
		else {
			msgFlag = "memLoginNo";
		}
		return "redirect:/msg/" + msgFlag;
	}
	
	@RequestMapping(value = "/memMain", method = RequestMethod.GET)
	public String memMainGet(HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getIdCheck(mid);
		model.addAttribute("vo", vo);
		
		return "member/memMain";
	}
	
	@RequestMapping(value = "/memLogout", method = RequestMethod.GET)
	public String memLogoutGet() {
		msgFlag = "memLogout";
		return "redirect:/msg/" + msgFlag;
	}
	
	@RequestMapping(value = "/memInput", method = RequestMethod.GET)
	public String memInputGet() {
		return "member/memInput";
	}
	
	@RequestMapping(value = "/memInput", method = RequestMethod.POST)
	public String memInputPost(MultipartFile fName, MemberVO vo) {
		if(memberService.getIdCheck(vo.getMid()) != null) {
			msgFlag = "memIdCheckNo";
			return "redirect:/msg/" + msgFlag;
		}
		if(memberService.getNickNameCheck(vo.getNickName()) != null) {
			msgFlag = "memNickNameCheckNo";
			return "redirect:/msg/" + msgFlag;
		}
		
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		int res = memberService.setMemInput(fName, vo);
		
		if(res == 1) msgFlag = "memInputOk";
		else msgFlag = "memInputNo";
		
		return "redirect:/msg/" + msgFlag;
	}
	
	@ResponseBody
	@RequestMapping(value = "/idCheck", method = RequestMethod.POST)
	public String idCheckPost(String mid) {
		String res = "1";
		MemberVO vo = memberService.getIdCheck(mid);
		if(vo != null) res = "0";
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value = "/nickNameCheck", method = RequestMethod.POST)
	public String nickNameCheckPost(String nickName) {
		String res = "1";
		MemberVO vo = memberService.getNickNameCheck(nickName);
		if(vo != null) res = "0";
		return res;
	}
	
	@RequestMapping(value = "/idConfirm", method = RequestMethod.GET)
	public String idConfirmGet() {
		return "member/idConfirm";
	}
	
	@RequestMapping(value = "/idConfirm", method = RequestMethod.POST)
	public String idConfirmPost(String toMail, Model model) {
		ArrayList<MemberVO> vos = memberService.getIdConfirm(toMail);
		if(vos.size() != 0) {
			model.addAttribute("vos", vos);
			return "member/idSearchList";
		}
		else {
			msgFlag = "idConfirmNo";
			return "redirect:/msg/" + msgFlag;
		}
	}
	
	@RequestMapping(value = "/pwdConfirm", method = RequestMethod.GET)
	public String pwdConfirmGet() {
		return "member/pwdConfirm";
	}
	
	@RequestMapping(value = "/pwdConfirm", method = RequestMethod.POST)
	public String pwdConfirmPost(String mid, String toMail, Model model) {
		ArrayList<MemberVO> vo = memberService.getPwdConfirm(mid, toMail);
		if(vo.size() != 0) {
			UUID uid = UUID.randomUUID();
			String pwd = uid.toString().substring(0,8);
			memberService.setPwdChange(mid, passwordEncoder.encode(pwd));
			
			model.addAttribute("pwd", pwd);
			
			return "member/pwdSearchList";
		}
		else {
			msgFlag = "pwdConfirmNo";
			return "redirect:/msg/" + msgFlag;
		}
	}
}
