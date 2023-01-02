package com.group.sharegram.board.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.group.sharegram.board.service.DeptHrLoveService;

@Controller
public class DeptHrLoveController {
	
	@Autowired
	private DeptHrLoveService deptHrLoveService;
	
	@ResponseBody
	@GetMapping(value="/love/getLoveCheck", produces="application/json")
	public Map<String, Object> getGoodCheck(HttpServletRequest request) {
		Map<String, Object> map = deptHrLoveService.getLoveCheck(request);
		return deptHrLoveService.getLoveCheck(request);
	}
	
	@ResponseBody
	@GetMapping(value="/love/getLoveCount", produces="application/json")
	public Map<String, Object> getLoveCount(int boardNo) {
		return deptHrLoveService.getLoveCount(boardNo);
	}
	
	@ResponseBody
	@GetMapping(value="/love/mark", produces="application/json")
	public Map<String, Object> mark(HttpServletRequest request) {
		return deptHrLoveService.mark(request);
	}
	
}
