package com.group.sharegram.board.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.group.sharegram.board.domain.DeptHrCommentDTO;

public interface DeptHrCommentService {
	   public Map<String, Object> getDeptHrCommentCount(int boardNo);
	   public Map<String, Object> addDeptHrComment(DeptHrCommentDTO comment, HttpServletRequest request);
	   public Map<String, Object> getDeptHrCommentList(HttpServletRequest request);
	   public Map<String, Object> removeDeptHrComment(int cmtNo);
	   public Map<String, Object> addDeptHrReply(DeptHrCommentDTO reply, HttpServletRequest request);
	   
}