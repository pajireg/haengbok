package org.csm.service;

import java.util.List;

import javax.mail.internet.MimeMessage;

import org.csm.domain.AuthVO;
import org.csm.domain.EbookVO;
import org.csm.domain.MemberVO;
import org.csm.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class MemberServiceImpl implements MemberService{

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	@Setter(onMethod_ = @Autowired)
	private JavaMailSenderImpl mailSender;
	
	@Transactional
	@Override
	public void signup(MemberVO member) {
	
		AuthVO auth = new AuthVO();
		
		log.info("sign up service......" + member);
		member.setUserpw(pwencoder.encode(member.getUserpw()));
		log.info("pwencode......" + member);
		mapper.insert(member);
		
		auth.setUserid(member.getUserid());
		auth.setAuth("ROLE_USER");
		log.info("authVO......." + auth);
		mapper.insertAuth(auth);
	}


	@Override
	public int checkid(String userid) {
		return mapper.checkid(userid);
	}


	@Override
	public int checkemail(String useremail) throws Exception {
		return mapper.checkemail(useremail);
	}

	@Transactional
	@Override
	public void findid(String useremail) throws Exception {
		log.info(useremail);
		
		String userid = mapper.findid(useremail);
		log.info(userid);
		String substring = userid.substring(0, userid.length()-2);
		String str = "";
		str += 	"<body>\r\n" + 
				"  <div style=\"background-color:#ffe2e7\">\r\n" + 
				"    <div>행복도서관</div>\r\n" + 
				"      <div>\r\n" + 
				"        <h4>아이디는 <b style=\"background-color:yellow\">"+substring+"**</b> 입니다.</h4>\r\n" + 
				"        <p>감사합니다.</p>\r\n" + 
				"      </div>\r\n" + 
				"    </div>\r\n" + 
				"  </div>\r\n" + 
				"</body>\r\n";
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom("javasumin@naver.com");
			messageHelper.setTo(useremail);
			messageHelper.setSubject("행복도서관 아이디 찾기");
			messageHelper.setText(str, true);

			mailSender.send(message);

		}catch(Exception e) {
			e.printStackTrace();
		}

	}


	@Override
	public void findpw(MemberVO member) throws Exception {
		log.info(member);
		
//		String newpw = Integer.toString((int)(Math.random()*900000)+100000);
		
		String a, b, c, r, newpw = "";
		
		for(int i=0; i<6; i++) {
			a = Integer.toString((int)(Math.random()*9)+1);
			b = String.valueOf((char)((Math.random()*26)+65));
			c = String.valueOf((char)((Math.random()*26)+97));
			r = String.valueOf((char)((Math.random()*3)+97));

			if(r.equals("b")) {
				r = b;
			}else if(r.equals("c")) {
				r = c;
			}else {
				r = a;
			}
			newpw += r;
		}
		log.info("random newpw ......." + newpw);
		
//		MemberVO member = new MemberVO();
//		member.setUseremail(useremail);
		member.setUserpw(pwencoder.encode(newpw));
		mapper.updatepw(member);
		
		String str = "";
		str += "\r\n" + 
				"<body class=\"bg-dark\">\r\n" + 
				"\r\n" + 
				"<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css\">" +
				"<script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js\"></script>" +
				"  <div class=\"container\">\r\n" + 
				"    <div class=\"card card-login mx-auto mt-5\">\r\n" + 
				"      <div class=\"card-header\">새로운 비밀번호</div>\r\n" + 
				"      <div class=\"card-body\">\r\n" + 
				"        <div class=\"text-center mb-4\">\r\n" + 
				"          <h4>새로운 임시 비밀번호는 <b style=\"background-color:yellow\">"+newpw+"</b> 입니다.</h4>\r\n" + 
				"          <p>로그인후 비밀번호를 변경해 주세요.</p>\r\n" + 
				"        </div>\r\n" + 
				"          <a class=\"btn btn-primary btn-block\" href=\"#\">홈으로 돌아가기</a>\r\n" +  
				"      </div>\r\n" + 
				"    </div>\r\n" + 
				"  </div>\r\n" + 
				"\r\n" + 
				"</body>\r\n" + 
				"";
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom("javasumin@naver.com");
			messageHelper.setTo(member.getUseremail());
			messageHelper.setSubject("새로운 비밀번호");
			messageHelper.setText(str, true);

			mailSender.send(message);

		}catch(Exception e) {
			e.printStackTrace();
		}
	}


	@Override
	public String sendcode(String useremail) throws Exception {

		String authcode = Integer.toString((int)(Math.random()*900000)+100000);
		String str = "";
		str += 	"<body>\r\n" + 
				"  <div style=\"background-color:#ffe2e7\">\r\n" + 
				"    <div>행복도서관</div>\r\n" + 
				"      <div>\r\n" + 
				"        <h4>이메일 인증번호는 <b style=\"background-color:yellow\">"+authcode+"</b> 입니다.</h4>\r\n" + 
				"        <p>인증번호를 입력해 주세요.</p>\r\n" + 
				"      </div>\r\n" + 
				"    </div>\r\n" + 
				"  </div>\r\n" + 
				"</body>\r\n";
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom("javasumin@naver.com");
			messageHelper.setTo(useremail);
			messageHelper.setSubject("행복도서관 이메일 인증 번호");
			messageHelper.setText(str, true);

			mailSender.send(message);

		}catch(Exception e) {
			e.printStackTrace();
		}
		return authcode;
	}


	@Override
	public int checkforfindpw(MemberVO member) throws Exception {
		return mapper.checkforfindpw(member);
	}


	@Override
	public void changepw(MemberVO member) throws Exception {
		log.info(member);
		member.setUserpw(pwencoder.encode(member.getUserpw()));
		mapper.updatepw(member);
	}


	@Override
	public List<EbookVO> borrowedAll(String userid) throws Exception {
		log.info("borrowed all.....");
		return mapper.borrowedAll(userid);
	}


	@Override
	public void leavemember(String userid) throws Exception {
		log.info("leavemember......");
		mapper.delete(userid);
	}

}
