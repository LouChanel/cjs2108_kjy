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
				model.addAttribute("msg", nickName+"��("+strLevel+") �α��� �Ǿ����ϴ�.");
				model.addAttribute("url", "member/memMain");
			}
			else if(msgFlag.equals("memLoginNo")) {
				model.addAttribute("msg", "�α��� ����");
				model.addAttribute("url", "member/memLogin");
			}
			else if(msgFlag.equals("memInputOk")) {
				model.addAttribute("msg", "ȸ�� ���ԵǾ����ϴ�.");
				model.addAttribute("url", "member/memLogin");
			}
			else if(msgFlag.equals("memInputNo")) {
				model.addAttribute("msg", "ȸ�� ���Խ���");
				model.addAttribute("url", "member/memInput");
			}
			else if(msgFlag.equals("memLogout")) {
				session.invalidate();
				model.addAttribute("msg", nickName + "�� �α׾ƿ� �Ǿ����ϴ�.");
				model.addAttribute("url", "member/memLogin");
			}
			else if(msgFlag.equals("memberNo")) {
				model.addAttribute("msg", nickName + "�� ���ٺҰ��Դϴ�.");
				model.addAttribute("url", "/");
			}
			else if(msgFlag.equals("bookInputOk")) {
				model.addAttribute("msg", "��� �Ǿ����ϴ�.");
				model.addAttribute("url", "book/bookInput");
			}
			else if(msgFlag.equals("idConfirmNo")) {
				model.addAttribute("msg", "����� ������ Ȯ���ϼ���.");
				model.addAttribute("url", "member/memLogin");
			}
			else if(msgFlag.equals("pwdConfirmNo")) {
				model.addAttribute("msg", "����� ������ Ȯ���ϼ���.");
				model.addAttribute("url", "member/memLogin");
			}
			
			return "include/message";
		}
}
