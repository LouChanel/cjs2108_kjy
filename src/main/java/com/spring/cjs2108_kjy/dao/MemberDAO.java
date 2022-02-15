package com.spring.cjs2108_kjy.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2108_kjy.vo.MemberVO;

public interface MemberDAO {
	public MemberVO getMemberVO(@Param("mid") String mid);

	public MemberVO getIdCheck(@Param("mid") String mid);

	public MemberVO getNickNameCheck(@Param("nickName") String nickName);

	public void setMemInput(@Param("vo") MemberVO vo);

	public void setLastDateUpdate(@Param("mid") String mid, @Param("todayCnt") int todayCnt);

	public ArrayList<MemberVO> getIdConfirm(@Param("toMail") String toMail);

	public ArrayList<MemberVO> getPwdConfirm(@Param("mid") String mid, @Param("toMail") String toMail);

	public void setPwdChange(@Param("mid") String mid, @Param("pwd") String pwd);

}
