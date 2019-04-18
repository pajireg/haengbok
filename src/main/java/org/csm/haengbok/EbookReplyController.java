package org.csm.haengbok;

import java.util.List;

import org.csm.domain.Criteria;
import org.csm.domain.EbookReplyVO;
import org.csm.service.EbookReplyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/replies/")
@AllArgsConstructor
@Log4j
public class EbookReplyController {

	private EbookReplyService service;
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value="/new", consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody EbookReplyVO reply) throws Exception{
		log.info("EbookReplyVO: " + reply);
		int insertCount = service.register(reply);
		log.info("Reply Insert Count: " + insertCount);
		return insertCount == 1 ?
				new ResponseEntity<>("SUCCESS", HttpStatus.OK) :
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	@GetMapping(value="/pages/{ebookNo}/{page}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
			})
	public ResponseEntity<List<EbookReplyVO>> getList(
			@PathVariable("page") int page,
			@PathVariable("ebookNo") Long ebookNo) throws Exception {
		log.info("getList.......");
		Criteria cri = new Criteria(page, 10);
		log.info(cri);
		return new ResponseEntity<>(service.getList(cri, ebookNo), HttpStatus.OK);
	}
	@GetMapping(value = "/{replyNo}",
			produces = {MediaType.APPLICATION_XML_VALUE,
						MediaType.APPLICATION_JSON_UTF8_VALUE
			})
	public ResponseEntity<EbookReplyVO> get(@PathVariable("replyNo") Long replyNo) throws Exception{
		log.info("get: "+replyNo);
		return new ResponseEntity<>(service.get(replyNo), HttpStatus.OK);
	}
//	@PreAuthorize("principal.username == #reply.replyer")
	@DeleteMapping(value="/{replyNo}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(/* @RequestBody EbookReplyVO reply, */ @PathVariable("replyNo") Long replyNo) throws Exception{
		log.info("remove: "+replyNo);
		return service.remove(replyNo) == 1 ?
				new ResponseEntity<>("SUCCESS", HttpStatus.OK) :
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
//	@PreAuthorize("principal.username == #reply.replyer")
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
			value = "/{replyNo}",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(
			@RequestBody EbookReplyVO reply,
			@PathVariable("replyNo") Long replyNo) throws Exception {
		reply.setReplyNo(replyNo);
		log.info("replyNo: "+replyNo);
		log.info("modify: "+reply);
		return service.modify(reply) == 1 ?
				new ResponseEntity<>("SUCCESS", HttpStatus.OK) :
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
