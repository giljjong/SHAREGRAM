package com.group.sharegram.board.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.group.sharegram.board.domain.DeptHrCommentDTO;
import com.group.sharegram.board.service.DeptHrCommentService;

@Controller
public class DeptHrCommentController {
	
	@Autowired
	private DeptHrCommentService deptHrCommentService;
	
	@ResponseBody
	@GetMapping(value="/cmt/getCount", produces="application/json")
	public Map<String, Object> getCount(@RequestParam("boardNo") int boardNo) {
		return deptHrCommentService.getDeptHrCommentCount(boardNo);
	}
	
	@ResponseBody
	@PostMapping(value="/cmt/add", produces="application/json")
	public Map<String, Object> add(DeptHrCommentDTO comment, HttpServletRequest request) {
		return deptHrCommentService.addDeptHrComment(comment,request);
	}
	
	@ResponseBody
	@GetMapping(value="/cmt/list", produces="application/json")
	public Map<String, Object> list(HttpServletRequest request) {
		return deptHrCommentService.getDeptHrCommentList(request);
	}
	
	@ResponseBody
	@PostMapping(value="/cmt/remove", produces="application/json")
	public Map<String, Object> remove(@RequestParam("cmtNo") int cmtNo){
		return deptHrCommentService.removeDeptHrComment(cmtNo);
	}
	
	@ResponseBody
	@PostMapping(value="/cmt/reply/add", produces="application/json")
	public Map<String, Object> replyAdd(DeptHrCommentDTO reply, HttpServletRequest request){
		return deptHrCommentService.addDeptHrReply(reply, request);
	}
	
}
