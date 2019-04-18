package org.csm.service;

import java.util.List;

import org.csm.domain.Criteria;
import org.csm.domain.EbookReplyVO;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class ReplyServiceTests {

	@Setter(onMethod_ = @Autowired)
	private EbookReplyService service;
	
	@Test @Ignore
	public void testCreate() throws Exception{
		EbookReplyVO reply = new EbookReplyVO();
		reply.setEbookNo(100001L);
		reply.setReplytext("service test");
		reply.setReplyer("service tester");
		service.register(reply);
	}

	@Test @Ignore
	public void testRead() throws Exception {
		Long targetReplyNo = 4L;
		EbookReplyVO reply = service.get(targetReplyNo);
		log.info(reply);
	}
	@Test @Ignore
	public void testList() throws Exception {
		Criteria cri = new Criteria();
		List<EbookReplyVO> replies = service.getList(cri, 4L);
		replies.forEach(reply -> log.info(reply));
	}
	@Test @Ignore
	public void testDelete() throws Exception {
		Long targetReplyNo = 5L;
		service.remove(targetReplyNo);
		log.info(targetReplyNo);
	}
	@Test @Ignore
	public void testUpdate() throws Exception {
		Long targetReplyNo = 4L;
		EbookReplyVO reply = service.get(targetReplyNo);
		reply.setReplytext("abc");
		int count = service.modify(reply);
		log.info("UPDATE COUNT: "+count);
	}
}
