package com.spring.cjs2108_kjy;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.cjs2108_kjy.service.AdminService;
import com.spring.cjs2108_kjy.service.BookService;
import com.spring.cjs2108_kjy.vo.BookVO;
import com.spring.cjs2108_kjy.vo.MemberVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	String msgFlag = "";
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	BookService bookService;
	
	@RequestMapping(value = "/adMenu", method = RequestMethod.GET)
	public String adMenuGet() {
		return "admin/adMenu";
	}
	
	@RequestMapping(value = "/adLeft", method = RequestMethod.GET)
	public String adLeftGet() {
		return "admin/adLeft";
	}
	
	@RequestMapping(value = "/adContent", method = RequestMethod.GET)
	public String adContentGet(Model model) {
		int newMember = adminService.getNewMember();
		int bookCount = adminService.getBookCount();
		model.addAttribute("newMember", newMember);
		model.addAttribute("bookCount", bookCount);
		return "admin/adContent";
	}
	
	@RequestMapping(value = "/adMemberList", method = RequestMethod.GET)
	public String adMemberListGet(
			@RequestParam(name="pag", defaultValue="1", required = false) int pag,
			@RequestParam(name="level", defaultValue = "99", required = false) int level,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid,
			Model model) {
		
		int pageSize = 5;
		int totRecCnt = 0;
		if(mid.equals("")) {
			totRecCnt = adminService.totRecCnt(level);
		}
		else {
			totRecCnt = adminService.totRecCntMid(mid);
		}
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStrarNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
		
		ArrayList<MemberVO> vos = new ArrayList<MemberVO>();
		if(mid.equals("")) {
			vos = adminService.getMemberList(startIndexNo, pageSize, level);
		}
		else {
			vos = adminService.getMemberListMid(startIndexNo, pageSize, mid);
		}
		
		model.addAttribute("vos", vos);
		model.addAttribute("pag", pag);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStrarNo", curScrStrarNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		
		model.addAttribute("level", level);
		model.addAttribute("mid", mid);
		model.addAttribute("totRecCnt", totRecCnt);
		
		return "admin/member/adMemberList";
	}
	
	@RequestMapping(value = "/adBookList", method = RequestMethod.GET)
	public String adBookListGet(
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			Model model) {
		
		int pageSize = 5;
		int totRecCnt = bookService.totRecCnt();
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStrarNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
		
		List<BookVO> vos = bookService.getBookList(startIndexNo, pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pag", pag);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStrarNo", curScrStrarNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		model.addAttribute("totRecCnt", totRecCnt);
		
		return "admin/book/adBookList";
	}
	
	@ResponseBody
	@RequestMapping()
	public String adMemberLevelPost(int idx, int level) {
		adminService.setLevelUpdate(idx, level);
		return "";
	}
}
