package org.csm.service;

import java.util.List;

import org.csm.domain.EbookVO;
import org.csm.domain.MemberVO;
import org.csm.mapper.AdminMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class AdminServiceImpl implements AdminService {

	private AdminMapper mapper;
	
	@Override
	public List<MemberVO> userList() throws Exception {
		log.info("user list......");
		return mapper.userList();
	}

	@Override
	public List<EbookVO> borrowList() throws Exception {
		return mapper.borrowList();
	}

}
