package org.csm.mapper;

import java.util.List;

import org.csm.domain.AuthVO;
import org.csm.domain.EbookVO;
import org.csm.domain.MemberVO;

public interface MemberMapper {

	public MemberVO read(String userid);
	public void insert(MemberVO member);
	public void insertAuth(AuthVO auth);
	
	public int checkid(String userid);
	public int checkemail(String useremail) throws Exception;
	public int checkforfindpw(MemberVO member) throws Exception;
	public String findid(String useremail) throws Exception;
	public int updatepw(MemberVO member) throws Exception;
	
	public List<EbookVO> borrowedAll(String userid) throws Exception;
	
	public void delete(String userid) throws Exception;
}
