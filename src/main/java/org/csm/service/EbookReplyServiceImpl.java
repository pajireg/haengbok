package org.csm.service;

import java.util.List;

import org.csm.domain.Criteria;
import org.csm.domain.EbookReplyVO;
import org.csm.mapper.EbookReplyMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Service
@Log4j
@AllArgsConstructor
public class EbookReplyServiceImpl implements EbookReplyService {

	private EbookReplyMapper mapper;
	
	
	@Override
	public int register(EbookReplyVO reply) throws Exception {
		log.info("get........" + reply);
		return mapper.insert(reply);
	}

	@Override
	public int modify(EbookReplyVO reply) throws Exception {
		log.info("modify......" + reply);
		return mapper.update(reply);
	}

	@Override
	public int remove(Long replyNo) throws Exception {
		log.info("remove......" + replyNo);
		return mapper.delete(replyNo);
	}

	@Override
	public EbookReplyVO get(Long replyNo) throws Exception {
		log.info("get........" + replyNo);
		return mapper.read(replyNo);
	}

	@Override
	public List<EbookReplyVO> getList(Criteria cri, Long ebookNo) throws Exception {
		log.info("get Reply List of a Board " + ebookNo);
		return mapper.getListWithPaging(cri, ebookNo);
	}

}
