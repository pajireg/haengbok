package org.csm.mapper;

import java.util.List;

import org.csm.domain.Criteria;
import org.csm.domain.EbookVO;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class EbookMapperTests {

	@Setter(onMethod_= @Autowired)
	private EbookMapper mapper;
	
	@Test @Ignore
	public void testInsert() throws Exception{
		EbookVO ebook = new EbookVO();
		for(int i=0; i<100; i++) {
			ebook.setEbookTitle("title Auto "+i);
			ebook.setEbookAuthor("admin");
			ebook.setEbookDetails("details Auto " + i);
			mapper.insert(ebook);
		}
	}
	@Test @Ignore
	public void testGetList() throws Exception{
		mapper.getList().forEach(ebook -> log.info(ebook));
	}
	
	@Test @Ignore
	public void testPaging() throws Exception{
		Criteria cri = new Criteria();
//		cri.setPageNum(2);
//		cri.setAmount(10);
		List<EbookVO> list = mapper.getListWithPaging(cri);
		list.forEach(ebook -> log.info(ebook));
	}
	
	@Test @Ignore
	public void testSearch() throws Exception {
		Criteria cri = new Criteria();
		cri.setKeyword("ㅇㄹ");
		cri.setType("TD");
		
		List<EbookVO> list = mapper.getListWithPaging(cri);
		list.forEach(ebook -> log.info(ebook));
	}
}
