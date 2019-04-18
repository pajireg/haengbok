package org.csm.service;

import java.util.List;

import org.csm.domain.EbookVO;
import org.csm.domain.MemberVO;

public interface MemberService {

	public void signup(MemberVO member);

	public int checkid(String userid);
	public int checkemail(String useremail) throws Exception;
	public int checkforfindpw(MemberVO member) throws Exception;
	public String sendcode(String useremail) throws Exception;
	
	public void findid(String useremail) throws Exception;
	public void findpw(MemberVO member) throws Exception;
	public void changepw(MemberVO member) throws Exception;
	
	public List<EbookVO> borrowedAll(String userid) throws Exception;
}
