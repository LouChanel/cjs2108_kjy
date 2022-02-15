package com.spring.cjs2108_kjy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2108_kjy.vo.BookVO;
import com.spring.cjs2108_kjy.vo.PartSubVO;

public interface BookDAO {

	public int totRecCnt();

	public List<BookVO> getBookList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public List<PartSubVO> getPartMain();

	public List<PartSubVO> getPartSub();

	public List<PartSubVO> getPartSubName(@Param("partMainCode") String partMainCode);

	public PartSubVO getPartMainOne(@Param("partMainCode") String partMainCode, @Param("partMainName") String partMainName);

	public void partMainInput(@Param("vo") PartSubVO vo);

	public List<PartSubVO> getPartSubOne(@Param("vo") PartSubVO vo);

	public void partSubInput(@Param("vo") PartSubVO vo);

	public void delPartMain(@Param("partMainCode") String partMainCode);

	public List<BookVO> getPartOne(@Param("partSubCode") String partSubCode);

	public void delPartSub(@Param("partSubCode") String partSubCode);

	public BookVO getBookMaxIdx();

	public void setBookInput(@Param("vo") BookVO vo);

	public BookVO getBookContent(@Param("idx") int idx);

	public List<BookVO> getBookIdx();

	public List<BookVO> getBookIdx2();

	public List<BookVO> getBookIdx3();

}
