package com.spring.cjs2108_kjy.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_kjy.vo.MemberVO;

public interface MemberService {
	public MemberVO getMemberVO(String mid);

	public MemberVO getIdCheck(String mid);

	public MemberVO getNickNameCheck(String nickName);

	public int setMemInput(MultipartFile fName, MemberVO vo);

	public void getMemberTodayProcess(int todayCnt);

	public ArrayList<MemberVO> getIdConfirm(String toMail);

	public ArrayList<MemberVO> getPwdConfirm(String mid, String toMail);

	public void setPwdChange(String mid, String pwd);

}
