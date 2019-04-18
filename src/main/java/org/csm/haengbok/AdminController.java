package org.csm.haengbok;

import org.csm.service.AdminService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/admin/*")
@AllArgsConstructor
@Log4j
public class AdminController {
	
	private AdminService service;

	@GetMapping("/userinfo")
	public void userinfo(Model model) throws Exception {
		log.info("user info.....");
		model.addAttribute("list", service.userList());
	}
	@GetMapping("/borrowinfo")
	public void borrowinfo(Model model) throws Exception {
		log.info("borrow info.....");
		model.addAttribute("list", service.borrowList());
	}
}
