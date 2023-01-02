package com.group.sharegram.board.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder

public class DeptHrCommentDTO {
	private int rn;
	private int cmtNo;
	private int boardNo;
	private int empNo;

	private Date createDate;
	private String content;

	private int state;
	private int depth;
	private int groupNo;
	
	// user 반영 시
	// private UserDTO user 


}
