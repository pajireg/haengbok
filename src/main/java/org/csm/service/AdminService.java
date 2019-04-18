package org.csm.service;

import java.util.List;

import org.csm.domain.EbookVO;
import org.csm.domain.MemberVO;

public interface AdminService {

	public List<MemberVO> userList() throws Exception;
	public List<EbookVO> borrowList() throws Exception;
}
