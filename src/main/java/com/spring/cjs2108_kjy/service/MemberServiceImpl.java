package com.spring.cjs2108_kjy.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_kjy.dao.MemberDAO;
import com.spring.cjs2108_kjy.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	MemberDAO memberDAO;
	
	@Override
	public MemberVO getMemberVO(String mid) {
		return memberDAO.getMemberVO(mid);
	}
	
	@Override
	public MemberVO getIdCheck(String mid) {
		return memberDAO.getIdCheck(mid);
	}
	
	@Override
	public MemberVO getNickNameCheck(String nickName) {
		return memberDAO.getNickNameCheck(nickName);
	}
	
	@Override
	public int setMemInput(MultipartFile fName, MemberVO vo) {
		int res = 0;
		try {
			String oFileName = fName.getOriginalFilename();
			if(oFileName != "" && oFileName != null) {
				UUID uid = UUID.randomUUID();
				String saveFileName = uid + "_" + oFileName;
				writeFile(fName, saveFileName);
				vo.setPhoto(saveFileName);
			}
			else {
				vo.setPhoto("noimage.jpg");
			}
			memberDAO.setMemInput(vo);
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}
	
	private void writeFile(MultipartFile fName, String saveFileName) throws IOException {
		byte[] data = fName.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/member/");
		
		FileOutputStream fos = new FileOutputStream(uploadPath + saveFileName);
		fos.write(data);
		fos.close();
	}
	
	@Override
	public void getMemberTodayProcess(int todayCnt) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		String lastDate = (String) session.getAttribute("sLastDate");
		
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String strToday = sdf.format(today);
		
		if(lastDate.substring(0, 10).equals(strToday)) {
			todayCnt += 1;
		}
		else {
			todayCnt = 1;
		}
		
		memberDAO.setLastDateUpdate(mid, todayCnt);
	}
	
	@Override
	public ArrayList<MemberVO> getIdConfirm(String toMail) {
		return memberDAO.getIdConfirm(toMail);
	}
	
	@Override
	public ArrayList<MemberVO> getPwdConfirm(String mid, String toMail) {
		return memberDAO.getPwdConfirm(mid, toMail);
	}
	
	@Override
	public void setPwdChange(String mid, String pwd) {
		memberDAO.setPwdChange(mid, pwd);
	}
}
