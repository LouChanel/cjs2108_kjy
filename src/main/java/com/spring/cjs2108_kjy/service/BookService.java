package com.spring.cjs2108_kjy.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_kjy.vo.BookVO;
import com.spring.cjs2108_kjy.vo.PartSubVO;

public interface BookService {

	public int totRecCnt();

	public List<BookVO> getBookList(int startIndexNo, int pageSize);

	public List<PartSubVO> getPartMain();

	public List<PartSubVO> getPartSub();

	public List<PartSubVO> getPartSubName(String partMainCode);

	public PartSubVO getPartMainOne(String partMainCode, String partMainName);

	public void partMainInput(PartSubVO vo);

	public List<PartSubVO> getPartSubOne(PartSubVO vo);

	public void partSubInput(PartSubVO vo);

	public void delPartMain(String partMainCode);

	public List<BookVO> getPartOne(String partSubCode);

	public void delPartSub(String partSubCode);

	public void imgCheckBookInput(MultipartFile file, BookVO vo);

	public BookVO getBookMaxIdx();

	public void setBookInput(BookVO vo);

	public BookVO getBookContent(int idx);

	public List<BookVO> getBookIdx();

	public List<BookVO> getBookIdx2();

	public List<BookVO> getBookIdx3();

}
