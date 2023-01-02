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

public class DeptHrLoveDTO {
	// private int empNo;  합치고 수정
	private int boardNo;
	private Date markDate;

}
