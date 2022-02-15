package com.spring.cjs2108_kjy;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MessageController {

		@RequestMapping(value="/msg/{msgFlag}", method = RequestMethod.GET)
		public String msgGet(@PathVariable String msgFlag, Model model, HttpSession session) {
			String nickName = session.getAttribute("sNickName")==null ? "" : (String) session.getAttribute("sNickName");
			String strLevel = session.getAttribute("sStrLevel")==null ? "" : (String) session.getAttribute("sStrLevel");
			
			if(msgFlag.equals("memLoginOk")) {
				model.addAttribute("msg", nickName+"님("+strLevel+") 로그인 되었습니다.");
				model.addAttribute("url", "member/memMain");
			}
			else if(msgFlag.equals("memLoginNo")) {
				model.addAttribute("msg", "로그인 실패");
				model.addAttribute("url", "member/memLogin");
			}
			else if(msgFlag.equals("memInputOk")) {
				model.addAttribute("msg", "회원 가입되엇습니다.");
				model.addAttribute("url", "member/memLogin");
			}
			else if(msgFlag.equals("memInputNo")) {
				model.addAttribute("msg", "회원 가입실패");
				model.addAttribute("url", "member/memInput");
			}
			else if(msgFlag.equals("memLogout")) {
				session.invalidate();
				model.addAttribute("msg", nickName + "님 로그아웃 되었습니다.");
				model.addAttribute("url", "member/memLogin");
			}
			else if(msgFlag.equals("memberNo")) {
				model.addAttribute("msg", nickName + "님 접근불가입니다.");
				model.addAttribute("url", "/");
			}
			else if(msgFlag.equals("bookInputOk")) {
				model.addAttribute("msg", "등록 되었습니다.");
				model.addAttribute("url", "book/bookInput");
			}
			else if(msgFlag.equals("idConfirmNo")) {
				model.addAttribute("msg", "사용자 정보를 확인하세요.");
				model.addAttribute("url", "member/memLogin");
			}
			else if(msgFlag.equals("pwdConfirmNo")) {
				model.addAttribute("msg", "사용자 정보를 확인하세요.");
				model.addAttribute("url", "member/memLogin");
			}
			
			return "include/message";
		}
}
