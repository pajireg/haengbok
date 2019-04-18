package org.csm.aop;


import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect
@Log4j
@Component
public class LogAdvice {

	@Before("execution(* org.csm.service*.*(..))")
	public void before() {
		log.info("====Before======================<Service>==========================");
	}
	@After("execution(* org.csm.service*.*(..))")
	public void after() {
		log.info("====After======================<Service>==========================");
	}
	
	@Before("execution(* org.csm.service.EbookService*.*(..))")
	public void beforeService() {
		log.info("====Before=========<EbookService>=============");
	}
	@After("execution(* org.csm.service.EbookService*.*(..))")
	public void afterService() {
		log.info("====After=========</EbookService>=============");
	}
	
	@Before("execution(* org.csm.service.EbookReplyService*.*(..))")
	public void beforeReplyService() {
		log.info("====Before=========<EbookReplyService>=============");
	}
	@After("execution(* org.csm.service.EbookService*.*(..))")
	public void afterReplySercice() {
		log.info("====After=========</EbookReplyService>=============");
	}
	
	@Before("execution(* org.csm.service.MemberService*.*(..))")
	public void beforeMemberService() {
		log.info("====Before=========<MemberService>=============");
	}
	@After("execution(* org.csm.service.MemberService*.*(..))")
	public void afterMemberSercice() {
		log.info("====After=========</MemberService>=============");
	}
	
	@Before("execution(* org.csm.service.AdminService*.*(..))")
	public void beforeAdminService() {
		log.info("====Before=========<AdminService>=============");
	}
	@After("execution(* org.csm.service.AdminService*.*(..))")
	public void afterAdminSercice() {
		log.info("====After=========</AdminService>=============");
	}
}
