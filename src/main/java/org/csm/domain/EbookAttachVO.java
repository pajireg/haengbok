package org.csm.domain;

import lombok.Data;

@Data
public class EbookAttachVO {

	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	private Long ebookNo;
}
