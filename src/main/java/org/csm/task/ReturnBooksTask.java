package org.csm.task;

import java.util.List;

import org.csm.domain.EbookVO;
import org.csm.mapper.BorrowMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Component
@Log4j
public class ReturnBooksTask {

	@Setter(onMethod_= {@Autowired})
	private BorrowMapper mapper;
	
	@Scheduled(cron="0 0 * * * *")	// 매 0분마다 (한시간에 한번)
	public void checkTask() throws Exception{
		log.warn("Check Task run...............");
		log.warn("==================================");
		
		List<EbookVO> returnBooks = mapper.getDeadline();
		returnBooks.forEach(i -> log.info(i));
		
		for(int i=0; i<returnBooks.size(); i++) {
			
			if(mapper.deleteborrow(returnBooks.get(i))) {
				mapper.returnborrow(returnBooks.get(i));
			}
			
		}
		
		
	}
	
}
