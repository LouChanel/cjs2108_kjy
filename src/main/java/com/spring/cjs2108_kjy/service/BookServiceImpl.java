package com.spring.cjs2108_kjy.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_kjy.dao.BookDAO;
import com.spring.cjs2108_kjy.vo.BookVO;
import com.spring.cjs2108_kjy.vo.PartSubVO;

@Service
public class BookServiceImpl implements BookService {
	@Autowired
	BookDAO bookDAO;
	
	@Override
	public int totRecCnt() {
		return bookDAO.totRecCnt();
	}
	
	@Override
	public List<BookVO> getBookList(int startIndexNo, int pageSize) {
		return bookDAO.getBookList(startIndexNo, pageSize);
	}
	
	@Override
	public List<PartSubVO> getPartMain() {
		return bookDAO.getPartMain();
	}
	
	@Override
	public List<PartSubVO> getPartSub() {
		return bookDAO.getPartSub();
	}
	
	@Override
	public List<PartSubVO> getPartSubName(String partMainCode) {
		return bookDAO.getPartSubName(partMainCode);
	}
	
	@Override
	public PartSubVO getPartMainOne(String partMainCode, String partMainName) {
		return bookDAO.getPartMainOne(partMainCode, partMainName);
	}
	
	@Override
	public void partMainInput(PartSubVO vo) {
		bookDAO.partMainInput(vo);
	}
	
	@Override
	public List<PartSubVO> getPartSubOne(PartSubVO vo) {
		return bookDAO.getPartSubOne(vo);
	}
	
	@Override
	public void partSubInput(PartSubVO vo) {
		bookDAO.partSubInput(vo);
	}
	
	@Override
	public void delPartMain(String partMainCode) {
		bookDAO.delPartMain(partMainCode);
	}
	
	@Override
	public List<BookVO> getPartOne(String partSubCode) {
		return bookDAO.getPartOne(partSubCode);
	}
	
	@Override
	public void delPartSub(String partSubCode) {
		bookDAO.delPartSub(partSubCode);
	}
	
	@Override
	public BookVO getBookMaxIdx() {
		return bookDAO.getBookMaxIdx();
	}
	
	@Override
	public void setBookInput(BookVO vo) {
		bookDAO.setBookInput(vo);
	}
	
	@Override
	public BookVO getBookContent(int idx) {
		return bookDAO.getBookContent(idx);
	}
	
	@Override
	public List<BookVO> getBookIdx() {
		return bookDAO.getBookIdx();
	}
	
	@Override
	public List<BookVO> getBookIdx2() {
		return bookDAO.getBookIdx2();
	}
	
	@Override
	public List<BookVO> getBookIdx3() {
		return bookDAO.getBookIdx3();
	}
		
	@SuppressWarnings("deprecation")
	@Override
	public void imgCheckBookInput(MultipartFile file, BookVO vo) {
		try {
			String originalFilename = file.getOriginalFilename();
			if(originalFilename != "" && originalFilename != null) {
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
				String saveFileName = sdf.format(date) + "_" + originalFilename;
				writeFile(file, saveFileName);
				vo.setBname(originalFilename);
				vo.setBsname(saveFileName);
			}
			else {
				return;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		String content = vo.getContent();
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getRealPath("/resources/data/book/");
		
		int position = 26;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String copyFilePath = "";
			String oriFilePath = uploadPath + imgFile;
			
			copyFilePath = uploadPath + "book/" + imgFile;
			
			fileCopyCheck(oriFilePath, copyFilePath);
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
		
		vo.setContent(vo.getContent().replace("/data/book/", "/data/book/bookImg/"));
	}
	
	private void fileCopyCheck(String oriFilePath, String copyFilePath) {
		File oriFile = new File(oriFilePath);
		File copyFile = new File(copyFilePath);
		
		try {
			FileInputStream fis = new FileInputStream(oriFile);
			FileOutputStream fos = new FileOutputStream(copyFile);
			
			byte[] buffer = new byte[2048];
			int count = 0;
			while((count = fis.read(buffer)) != -1) {
				fos.write(buffer, 0, count);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	private void writeFile(MultipartFile fName, String saveFileName) throws IOException {
		byte[] data = fName.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/book/bookImg/");
		
		FileOutputStream fos = new FileOutputStream(uploadPath + saveFileName);
		fos.write(data);
		fos.close();
	}
}
