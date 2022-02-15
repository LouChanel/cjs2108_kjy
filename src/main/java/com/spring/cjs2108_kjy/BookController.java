package com.spring.cjs2108_kjy;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_kjy.service.BookService;
import com.spring.cjs2108_kjy.vo.BookVO;
import com.spring.cjs2108_kjy.vo.PartSubVO;

@Controller
@RequestMapping("/book")
public class BookController {
	String msgFlag = "";
	
	@Autowired
	BookService bookService;
	
	@RequestMapping(value = "/bookList", method = RequestMethod.GET)
	public String bookListGet(
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize,
			@RequestParam(name="lately", defaultValue = "0", required = false) int lately,
			Model model) {
		
		int totRecCnt = bookService.totRecCnt();
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (int) (totRecCnt/pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStrarNo = totRecCnt - startIndexNo;
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
		
		List<BookVO> vos = bookService.getBookList(startIndexNo, pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStrarNo", curScrStrarNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		model.addAttribute("lately", lately);
		
		return "book/bookList";
	}
	
	@RequestMapping(value = "/bookPart", method = RequestMethod.GET)
	public String bookPartGet(Model model) {
		List<PartSubVO> mainVos = bookService.getPartMain();
		List<PartSubVO> subVos = bookService.getPartSub();
		
		model.addAttribute("mainVos", mainVos);
		model.addAttribute("subVos", subVos);
		
		return "admin/book/bookPart";
	}
	
	@ResponseBody
	@RequestMapping(value = "/partSubName", method = RequestMethod.POST)
	public List<PartSubVO> partSubNamePost(String partMainCode) {
		return bookService.getPartSubName(partMainCode);
	}
	
	@ResponseBody
	@RequestMapping(value = "/partMainInput", method = RequestMethod.POST)
	public String partMainInputPost(PartSubVO vo) {
		PartSubVO subVo = bookService.getPartMainOne(vo.getPartMainCode(), vo.getPartMainName());
		if(subVo != null) return "0";
		bookService.partMainInput(vo);
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value = "/partSubInput", method = RequestMethod.POST)
	public String partSubInputPost(PartSubVO vo) {
		List<PartSubVO> vos = bookService.getPartSubOne(vo);
		if(vos.size() != 0) return "0";
		bookService.partSubInput(vo);
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value = "/delPartMain", method = RequestMethod.POST)
	public String delPartMainPost(PartSubVO vo) {
		List<PartSubVO> vos = bookService.getPartSubOne(vo);
		if(vos.size() != 0) return "0";
		bookService.delPartMain(vo.getPartMainCode());
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value = "/delPartSub", method = RequestMethod.POST)
	public String delPartSubPost(PartSubVO vo) {
		List<BookVO> vos = bookService.getPartOne(vo.getPartSubCode());
		if(vos.size() != 0) return "0";
		bookService.delPartSub(vo.getPartSubCode());
		return "1";
	}
	
	@ResponseBody
	@RequestMapping("/imageUpload")
	public void imageUploadGet(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) throws Exception {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String originalFilename = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		originalFilename = sdf.format(date) + "_" + originalFilename;
		
		byte[] bytes = upload.getBytes();
		
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/book/");
		OutputStream outStr = new FileOutputStream(new File(uploadPath + originalFilename));
		outStr.write(bytes);
		
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/book/" + originalFilename;
		out.println("{\"originalFilename\":\""+originalFilename+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		out.flush();
		outStr.close();
	}
	
	@RequestMapping(value = "/bookInput", method = RequestMethod.GET)
	public String bookInputGet(Model model) {
		List<PartSubVO> mainVos = bookService.getPartMain();
		model.addAttribute("mainVos", mainVos);
		return "admin/book/bookInput";
	}
	
	@RequestMapping(value = "/bookInput", method = RequestMethod.POST)
	public String bookInputPost(MultipartFile file, BookVO vo) {
		bookService.imgCheckBookInput(file, vo);
		
		int maxIdx = 0;
		BookVO maxVo = bookService.getBookMaxIdx();
		if(maxVo != null) maxIdx = maxVo.getIdx();
		vo.setBookCode(vo.getPartMainCode()+vo.getPartSubCode()+maxIdx);
		bookService.setBookInput(vo);
		
		msgFlag = "bookInputOk";
		return "redirect:/msg/" + msgFlag;
	}
	
	@RequestMapping(value = "/bookContent", method = RequestMethod.GET)
	public String bookContentGet(int idx, Model model) {
		BookVO vo = bookService.getBookContent(idx);
		
		model.addAttribute("vo", vo);
		
		return "book/bookContent";
		
	}
}
