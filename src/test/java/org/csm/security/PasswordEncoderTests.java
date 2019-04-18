package org.csm.security;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@Log4j
public class PasswordEncoderTests {

	@Setter(onMethod_ = {@Autowired})
	private PasswordEncoder pwEncoder;
	
	@Test
	public void testEncode() {
		String str = "member";
		String enStr = pwEncoder.encode(str);
		String strencode = "$2a$10$hFZIeghRvsnjTmpaSTm0rO2RRkN80A5s1iu4LDd86uM2icAD8GnzO";
		String enStrencode = pwEncoder.encode(strencode);
		log.info("=================================");
		log.info("enStr : " + enStr);
		log.info("enStrEncode : " + enStrencode);
		log.info("=================================");
	}
}
