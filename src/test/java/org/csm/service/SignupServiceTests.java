package org.csm.service;

import org.csm.domain.AuthVO;
import org.csm.domain.MemberVO;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
  "file:src/main/webapp/WEB-INF/spring/root-context.xml",
  "file:src/main/webapp/WEB-INF/spring/security-context.xml"
  })
public class SignupServiceTests {

	@Setter(onMethod_ = @Autowired)
	private MemberService service;
	
	@Test @Ignore
	public void testInsertMember() {
		
		MemberVO member = new MemberVO();
		
		member.setUserid("admin");
		member.setUserpw("admin");
		member.setUseremail("admin");
		
		service.signup(member);
		
	}
	
//	@Test @Ignore
//	public void testInsertAuth() {
//		
//		AuthVO auth = new AuthVO();
//		
//		auth.setUserid("testid111");
//		auth.setAuth("ROLE_USER");
//		
//		service.insertAuth(auth);
//	}
	
	@Test @Ignore
	public void testCheckid() {
		String userid = "qqq123";
		service.checkid(userid);
	}
}
