package com.group.sharegram.board.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.group.sharegram.board.domain.NoticBoardDTO;

public interface NoticBoardService {
	
	public void findAllNoticList(HttpServletRequest request, Model model);
	public int addNoticList(HttpServletRequest request);
	public int removeNoticList(int noticBoardNo);
	public NoticBoardDTO getNoticBoardByNo(int noticBoardNo);
	public void findNoticList(HttpServletRequest request, Model model);
	public int modifyNoticList(HttpServletRequest request);
	public int increaseHit(int noticBoardNo);
	
}
