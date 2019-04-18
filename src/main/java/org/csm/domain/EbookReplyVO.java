package org.csm.domain;

import java.util.Date;

import lombok.Data;

@Data
public class EbookReplyVO {

	private Long replyNo;
	private Long ebookNo;
	
	private String replytext;
	private String replyer;
	private Date regdate;
	private Date updatedate;
}
