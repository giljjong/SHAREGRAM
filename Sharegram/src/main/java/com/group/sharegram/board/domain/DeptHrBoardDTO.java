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
public class DeptHrBoardDTO {
	
	private int rn;
	private int boardNo;			// 게시글 번호
	private int empNo;				// 작성자 사원번호(id)
	private String boardTitle;		// 게시글 제목
	private String boardContent;	// 게시글 내용
	private Date createDate;		// 게시글 작성일
	private Date modifyDate;		// 게시글 작성일
	private String state;
	private int hit;				// 조회수
	private String deptName;
	private int deptNo;				// 부서
	
	
	/*
	 * private String deptCode; // 부서코드 private String jobPosition; // 직급명
	 * 
	 * private int brdCateory; // 게시판 카테고리(1: 전사공지, 2: 부서별, 3: 익명)
	 * 
	 * private String brdTop; // 공지여부(Y/N)
	 */
	
}
