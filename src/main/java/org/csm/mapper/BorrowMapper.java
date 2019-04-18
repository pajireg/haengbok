package org.csm.mapper;

import java.util.List;

import org.csm.domain.EbookVO;

public interface BorrowMapper {
	public void insertborrow(EbookVO ebook) throws Exception;
	public List<EbookVO> getDeadline() throws Exception;
	public boolean deleteborrow(EbookVO ebook) throws Exception;
	public void returnborrow(EbookVO ebook) throws Exception;
}
