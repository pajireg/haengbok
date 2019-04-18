package org.csm.haengbok;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.csm.domain.Criteria;
import org.csm.domain.EbookAttachVO;
import org.csm.domain.EbookVO;
import org.csm.domain.MemberVO;
import org.csm.domain.PageDTO;
import org.csm.service.EbookService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/ebook/*")
@AllArgsConstructor
public class EbookController {

	private EbookService service;
	
	@GetMapping("/list")
	public void list(Model model, Criteria cri, @RequestParam("sort") String sort) throws Exception{

		log.info("sort : " + sort);
		model.addAttribute("sort", sort);
		model.addAttribute("list", service.getList(cri, sort));
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register() {}
	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String registerPost(EbookVO ebook, RedirectAttributes rttr) throws Exception {
		log.info("register : " + ebook);
		
		if(ebook.getAttachList() != null) {
			ebook.getAttachList().forEach(attach -> log.info(attach));
		}
		
		service.register(ebook);
		rttr.addAttribute("ebookNo", ebook.getEbookNo());
		rttr.addFlashAttribute("register", ebook.getEbookNo());
		rttr.addAttribute("sort", "recent");
		return "redirect:/ebook/details";
	}
	@GetMapping({"/details", "/modify"})
	public void details(Model model, @RequestParam("sort") String sort, @RequestParam("ebookNo") Long ebookNo, @ModelAttribute("cri") Criteria cri) throws Exception{
		log.info("ebook/details " + ebookNo);
		model.addAttribute("ebook", service.get(ebookNo));
		model.addAttribute("sort", sort);
	}
	@PreAuthorize("principal.username == #ebook.ebookAuthor")
	@PostMapping("/modify")
	public String modify(EbookVO ebook, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) throws Exception {
		log.info("modify: " + ebook);
		if(service.modify(ebook)) {
			rttr.addAttribute("ebookNo", ebook.getEbookNo());
			rttr.addFlashAttribute("modify", ebook.getEbookNo());
			rttr.addAttribute("sort", "recent");
		}
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
//		rttr.addAttribute("pageNum", cri.getPageNum());
		
		return "redirect:/ebook/details";
	}
	@PreAuthorize("principal.username == #ebookAuthor")
	@PostMapping("/remove")
	public String remove(@RequestParam("ebookNo") Long ebookNo, RedirectAttributes rttr, String ebookAuthor) throws Exception{
		log.info("remove..."+ebookNo);
		List<EbookAttachVO> attachList = service.getAttachList(ebookNo);
		if(service.remove(ebookNo)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", ebookNo);
			rttr.addAttribute("sort", "recent");
		}
		return "redirect:/ebook/list";
	}
	private void deleteFiles(List<EbookAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		log.info("delete attach files.........");
		log.info(attachList);
		
		attachList.forEach(attach -> {
			try {
				Path file  = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\" + attach.getUuid()+"_"+ attach.getFileName());
		        Files.deleteIfExists(file);
		        
		        if(Files.probeContentType(file).startsWith("image")) {
		        	Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_" + attach.getUuid()+"_"+ attach.getFileName());
		        	Files.delete(thumbNail);
		        }
			}catch(Exception e) {
				log.error("delete file error : " + e.getMessage());
			}
		});
	}
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<EbookAttachVO>> getAttachList(Long ebookNo) throws Exception{
		log.info("getAttachList : " + ebookNo);
		return new ResponseEntity<>(service.getAttachList(ebookNo), HttpStatus.OK);
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/borrow")
	public String ebookBorrow(EbookVO ebook, RedirectAttributes rttr) throws Exception {
		log.info("ebook borrows......" + ebook);
		rttr.addAttribute("ebookNo", ebook.getEbookNo());
		rttr.addAttribute("sort", "recent");
		if(service.borrow(ebook) == 0) {
			rttr.addFlashAttribute("borrow", "대출성공");
		}else if(service.borrow(ebook) == 1){
			rttr.addFlashAttribute("borrow", "이미 대출 중인 책 입니다.");
		}else if(service.borrow(ebook) == 2){
			rttr.addFlashAttribute("borrow", "대출가능 잔여 권수가 남아있지 않습니다.");
		}else {
			rttr.addFlashAttribute("borrow", "일시적 오류");
		}
		return "redirect:/ebook/details";
	}
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/like")
	public String ebooklike(EbookVO ebook, RedirectAttributes rttr) throws Exception{
		log.info("ebook like......." + ebook);
		rttr.addAttribute("ebookNo", ebook.getEbookNo());
		rttr.addAttribute("sort", "recent");
		if(service.like(ebook) == 0) {
			rttr.addFlashAttribute("borrow", "좋아요~@");
		}else if(service.like(ebook) == 1){
			service.deletelike(ebook);
			rttr.addFlashAttribute("borrow", "좋아요를 취소하였습니다.");
		}else {
			rttr.addFlashAttribute("borrow", "일시적 오류");
		}
		return "redirect:/ebook/details";
	}
}
