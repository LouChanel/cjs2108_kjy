package com.spring.cjs2108_kjy.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.cjs2108_kjy.dao.AdminDAO;
import com.spring.cjs2108_kjy.vo.MemberVO;

@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	AdminDAO adminDAO;
	
	@Override
	public int getNewMember() {
		return adminDAO.getNewMember();
	}
	
	@Override
	public int totRecCnt(int level) {
		return adminDAO.totRecCnt(level);
	}
	
	@Override
	public int totRecCntMid(String mid) {
		return adminDAO.totRecCntMid(mid);
	}
	
	@Override
	public ArrayList<MemberVO> getMemberList(int startIndexNo, int pageSize, int level) {
		return adminDAO.getMemberList(startIndexNo, pageSize, level);
	}
	
	@Override
	public ArrayList<MemberVO> getMemberListMid(int startIndexNo, int pageSize, String mid) {
		return adminDAO.getMemberListMid(startIndexNo, pageSize, mid);
	}
	
	@Override
	public int getBookCount() {
		return adminDAO.getBookCount();
	}
	
	@Override
	public void setLevelUpdate(int idx, int level) {
		adminDAO.setLevelUpdate(idx, level);
	}
}
