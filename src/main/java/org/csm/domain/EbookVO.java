package org.csm.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class EbookVO {

	private Long ebookNo;
	private String ebookTitle;
	private String ebookAuthor;
	private String ebookDetails;
	private Date ebookRegdate;
	private Date ebookUpdatedate;
	private List<EbookAttachVO> attachList;
	private Long rownum;
	
	private int numofborrow;
	private int quantity;
	private int liked;
	private String userid;
	private Date regdate;
	private Date deadline;
}
