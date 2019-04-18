package org.csm.service;

import java.util.List;

import org.csm.domain.Criteria;
import org.csm.domain.EbookReplyVO;


public interface EbookReplyService {

	public int register(EbookReplyVO reply) throws Exception;
	public int modify(EbookReplyVO reply) throws Exception;
	public int remove(Long replyNo) throws Exception;
	public EbookReplyVO get(Long replyNo) throws Exception;
	
	public List<EbookReplyVO> getList(Criteria cri, Long ebookNo) throws Exception;
}
