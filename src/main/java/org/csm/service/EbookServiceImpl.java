package org.csm.service;

import java.util.List;

import org.csm.domain.Criteria;
import org.csm.domain.EbookAttachVO;
import org.csm.domain.EbookVO;
import org.csm.mapper.BorrowMapper;
import org.csm.mapper.EbookAttachMapper;
import org.csm.mapper.EbookMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class EbookServiceImpl implements EbookService {

	@Setter(onMethod_= @Autowired)
	private EbookMapper mapper;
	
	@Setter(onMethod_= @Autowired)
	private EbookAttachMapper attachMapper;
	
	@Setter(onMethod_= @Autowired)
	private BorrowMapper borrow;
	
	@Override
	public List<EbookVO> getList(Criteria cri, String sort) throws Exception {
		log.info("eBook list........" + sort);
		if(sort.equals("popular")) {
			return mapper.getListPopular(cri);
		}else if(sort.equals("liked")) {
			return mapper.getListLiked(cri);
		}else {
			return mapper.getListWithPaging(cri);
		}
		
	}

	@Transactional
	@Override
	public void register(EbookVO ebook) throws Exception {
		log.info("register....." + ebook);
		mapper.insert(ebook);
		if(ebook.getAttachList() == null || ebook.getAttachList().size() <= 0) {
			return;
		}
		ebook.getAttachList().forEach(attach -> {
			attach.setEbookNo(ebook.getEbookNo());
			try {
				attachMapper.insert(attach);
			} catch (Exception e) {
				e.printStackTrace();
			}
		});
	}

	@Override
	public EbookVO get(Long ebookNo) throws Exception {
		log.info("get....." + ebookNo);
		return mapper.read(ebookNo);
	}

	@Transactional
	@Override
	public boolean remove(Long ebookNo) throws Exception {
		attachMapper.deleteAll(ebookNo);
		return mapper.delete(ebookNo) == 1;
	}

	@Transactional
	@Override
	public boolean modify(EbookVO ebook) throws Exception {
		log.info("modify....." + ebook);
		attachMapper.deleteAll(ebook.getEbookNo());
		boolean modifyResult = mapper.update(ebook) == 1;
		if(ebook.getAttachList() == null || ebook.getAttachList().size() <= 0) {
			return modifyResult;
		}
		if(modifyResult && ebook.getAttachList() != null & ebook.getAttachList().size() > 0) {
			ebook.getAttachList().forEach(attach -> {
				attach.setEbookNo(ebook.getEbookNo());
				try {
					attachMapper.insert(attach);
				} catch (Exception e) {
					e.printStackTrace();
				}
			});
		}
		return modifyResult;
	}

	@Override
	public List<EbookAttachVO> getAttachList(Long ebookNo) throws Exception {
		log.info("get Attach list by ebookNo : " + ebookNo);
		return attachMapper.findByEbookNo(ebookNo);
	}

	@Override
	public int getTotal(Criteria cri) throws Exception {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

	@Transactional
	@Override
	public int borrow(EbookVO ebook) throws Exception {
		log.info("borrow.......");
		
		try {
			mapper.insertborrow(ebook);
		}catch(Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return 1;
		}try {
			mapper.borrow(ebook.getEbookNo());
		}catch(Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return 2;
		}

		return 0;
	}

	@Transactional
	@Override
	public int like(EbookVO ebook) throws Exception {
		log.info("ebook like........");
		
		try {
			mapper.insertlike(ebook);
		}catch(Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return 1;
		}
		mapper.like(ebook.getEbookNo());

		return 0;
	}

	@Transactional
	@Override
	public int deletelike(EbookVO ebook) throws Exception {
		mapper.unlike(ebook.getEbookNo());
		mapper.deletelike(ebook);
		return 0;
	}

}
