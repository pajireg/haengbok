package org.csm.haengbok;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.csm.domain.MemberVO;
import org.csm.service.MemberService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {

	private MemberService service;
	
	
	@GetMapping("/login")
	public void loginGET(String error, Model model, HttpServletRequest request, RedirectAttributes rttr) {
		
		log.info("error : " + error);

		String referrer = request.getHeader("Referer");
		log.info("referrer : " + referrer);
		if(error != null) {
			model.addAttribute("error", "아이디 또는 비밀번호가 틀렸습니다.");
		}else if(!(referrer.contains("member"))){
			request.getSession().setAttribute("prevPage", referrer);
		}
		
	}
	
	@GetMapping("/logout")
	public void logoutGET() {
		log.info("logoutGET.....");
	}
	@PostMapping("/logout")
	public void logoutPOST() {
		log.info("logoutPOST.....");
	}
	
	@GetMapping("/signup")
	public void signupGET() {
		log.info("sign up get......");
	}
	@PostMapping("/signup")
	public String signupPOST(MemberVO member, RedirectAttributes rttr) throws Exception {
		log.info("sign up post......" + member);
		service.signup(member);
		return "redirect:/member/login";
	}
	
	@PostMapping("/checkid")
	@ResponseBody
	public Map<Object, Object> idcheck(@RequestBody String userid) {
        
        int count = 0;
        Map<Object, Object> map = new HashMap<Object, Object>();
 
        count = service.checkid(userid);
        
        log.info(count);
        map.put("count", count);
 
        return map;
    }
	@PostMapping("/checkemail")
	@ResponseBody
	public Map<Object, Object> emailcheck(@RequestBody String useremail) throws Exception{
        
        int count = 0;
        Map<Object, Object> map = new HashMap<Object, Object>();
 
        count = service.checkemail(useremail);
        
        log.info(count);
        map.put("count", count);
 
        return map;
    }
	@PostMapping("/checkforfindpw")
	@ResponseBody
	public Map<Object, Object> checkforfindpw(@RequestBody MemberVO member) throws Exception{
        log.info("checkforfindpw" + member);
        int count = 0;
        Map<Object, Object> map = new HashMap<Object, Object>();
 
        count = service.checkforfindpw(member);
        
        log.info(count);
        map.put("count", count);
 
        return map;
    }
	@PostMapping("/sendcode")
	@ResponseBody
	public Map<Object, Object> sendcode(@RequestBody String useremail) throws Exception{
        
        String authcode;
        Map<Object, Object> map = new HashMap<Object, Object>();
 
        authcode = service.sendcode(useremail);
        
        log.info(authcode);
        map.put("authcode", authcode);
 
        return map;
    }
	@GetMapping({"/findid","/findpw"})
	public void findidpw() throws Exception {	}
	
	@GetMapping("/changepw")
	@PreAuthorize("isAuthenticated()")
	public void changepw() throws Exception {	}
	
	@PostMapping("/findid")
	public String findidPOST(String useremail) throws Exception {
		log.info("find id post......" + useremail);
		service.findid(useremail);
		
		return "redirect:/member/login";
	}

	@PostMapping("/findpw")
	public String findpwPOST(MemberVO member) throws Exception {
		log.info("find pw post......" + member);
		service.findpw(member);
		
		return "redirect:/member/login";
	}
	@PreAuthorize("principal.username == #member.userid")
	@PostMapping("/changepw")
	public String changepw(MemberVO member) throws Exception {
		log.info("change pw post...." + member);
		service.changepw(member);
		return "redirect:/";
	}
	@PreAuthorize("principal.username == #userid")
	@GetMapping("/mybooks")
	public void borrowedAll(Model model, @RequestParam("userid") String userid) throws Exception {
		model.addAttribute("list", service.borrowedAll(userid));
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/leavemember")
	public void leavemember() throws Exception {
		
	}
	
	@PreAuthorize("principal.username == #userid")
	@PostMapping("/leavemember")
	public String leavememberPost(String userid, HttpServletRequest request) throws Exception {
		log.info("leavemember : " + userid);
		service.leavemember(userid);
		
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/";
	}
}
