package org.csm.mapper;

import java.util.List;

import org.csm.domain.EbookAttachVO;

public interface EbookAttachMapper {

	public void insert(EbookAttachVO attach) throws Exception;
	public void delete(String uuid) throws Exception;
	public List<EbookAttachVO> findByEbookNo(Long ebookNo) throws Exception;
	public void deleteAll(Long ebookNo) throws Exception;
	public List<EbookAttachVO> getOldFiles() throws Exception;
	
}
