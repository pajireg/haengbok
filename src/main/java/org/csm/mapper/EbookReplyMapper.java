package org.csm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.csm.domain.Criteria;
import org.csm.domain.EbookReplyVO;

public interface EbookReplyMapper {

	public int insert(EbookReplyVO reply) throws Exception;
	public int update(EbookReplyVO reply) throws Exception;
	public int delete(Long replyNo) throws Exception;
	public EbookReplyVO read(Long replyNo) throws Exception;
	
	public List<EbookReplyVO> getListWithPaging(
			@Param("Cri") Criteria cri,
			@Param("ebookNo") Long ebookNo)
	throws Exception;
}
