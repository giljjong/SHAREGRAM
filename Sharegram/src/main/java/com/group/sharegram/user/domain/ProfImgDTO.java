package com.group.sharegram.user.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProfImgDTO {
	
	private int profNo;
	private int empNo;
	private String profPath;
	private String profOrigin;
	private String profFilesystem;
}
