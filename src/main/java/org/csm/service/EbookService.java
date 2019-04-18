package org.csm.service;

import java.util.List;

import org.csm.domain.Criteria;
import org.csm.domain.EbookAttachVO;
import org.csm.domain.EbookVO;

public interface EbookService {

	public List<EbookVO> getList(Criteria cri, String sort) throws Exception;
	public void register(EbookVO ebook) throws Exception;
	public EbookVO get(Long ebookNo) throws Exception;
	public boolean remove(Long ebookNo) throws Exception;
	public boolean modify(EbookVO ebook) throws Exception;
	public List<EbookAttachVO> getAttachList(Long ebookNo) throws Exception;
	public int getTotal(Criteria cri) throws Exception;
	public int borrow(EbookVO ebook) throws Exception;
	
	public int like(EbookVO ebook) throws Exception;
	public int deletelike(EbookVO ebook) throws Exception;
}
