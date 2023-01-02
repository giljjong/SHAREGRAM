package com.group.sharegram.board.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface DeptHrLoveService {
	public Map<String, Object> getLoveCheck(HttpServletRequest request);
	public Map<String, Object> getLoveCount(int boardNo);
	public Map<String, Object> mark(HttpServletRequest request);
	   
}