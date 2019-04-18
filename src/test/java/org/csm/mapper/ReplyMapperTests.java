package org.csm.mapper;

import java.util.List;
import java.util.stream.IntStream;

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
public class ReplyMapperTests {
	
	private Long[] bnoArr = { 100001L, 100002L, 100003L, 100004L, 100005L };
	
	@Setter(onMethod_ = @Autowired)
	private EbookReplyMapper mapper;
	
	@Test @Ignore
	public void testMapper() {
		log.info(mapper);
	}
	@Test @Ignore
	public void testCreate() {
		IntStream.rangeClosed(1,10).forEach(i -> {
			EbookReplyVO reply = new EbookReplyVO();
			
			reply.setEbookNo(bnoArr[i%5]);
			reply.setReplytext("댓글테스트"+i);
			reply.setReplyer("replyer"+i);
			try {
				mapper.insert(reply);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		});
	}
	@Test @Ignore
	public void testRead() throws Exception {
		Long targetReplyNo = 5L;
		EbookReplyVO reply = mapper.read(targetReplyNo);
		log.info(reply);
	}
	@Test @Ignore
	public void testDelete() throws Exception {
		Long targetReplyNo = 5L;
		mapper.delete(targetReplyNo);
		log.info(targetReplyNo);
	}
	@Test
	public void testUpdate() throws Exception {
		Long targetReplyNo = 4L;
		EbookReplyVO reply = mapper.read(targetReplyNo);
		reply.setReplytext("abc");
		int count = mapper.update(reply);
		log.info("UPDATE COUNT: "+count);
	}
	@Test @Ignore
	public void testList() throws Exception {
		Criteria cri = new Criteria();
		List<EbookReplyVO> replies = mapper.getListWithPaging(cri, 4L);
		replies.forEach(reply -> log.info(reply));
	}
}
