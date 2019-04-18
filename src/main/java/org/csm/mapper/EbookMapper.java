package org.csm.mapper;

import java.util.List;

import org.csm.domain.Criteria;
import org.csm.domain.EbookVO;

public interface EbookMapper {

	public List<EbookVO> getList() throws Exception;
	public void insert(EbookVO ebook) throws Exception;
	public EbookVO read(Long ebookNo) throws Exception;
	public int delete(Long ebookNo) throws Exception;
	public int update(EbookVO ebook) throws Exception;
	public List<EbookVO> getListWithPaging(Criteria cri) throws Exception;
	public List<EbookVO> getListPopular(Criteria cri) throws Exception;
	public List<EbookVO> getListLiked(Criteria cri) throws Exception;
	public int getTotalCount(Criteria cri) throws Exception;
	
	public int borrow(Long ebookNo) throws Exception;
	public void insertborrow(EbookVO ebook) throws Exception;
	
	public int like(Long ebookNo) throws Exception;
	public void insertlike(EbookVO ebook) throws Exception;
	public int unlike(Long ebookNo) throws Exception;
	public void deletelike(EbookVO ebook) throws Exception;
}
