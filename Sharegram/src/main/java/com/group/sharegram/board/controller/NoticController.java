package com.group.sharegram.board.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.group.sharegram.board.service.NoticBoardService;

@Controller
public class NoticController {

	@Autowired
	private NoticBoardService noticBoardService;
	
	@GetMapping("/board/noticList")
	public String list(@RequestParam(value = "pageNo", required = false, defaultValue = "1") int pageNo, Model model) {
		model.addAttribute("pageNo", pageNo);
		return "board/notic/list";
	}
	
	@GetMapping("/board/notic/write")
	public String write() {
		return "board/notic/write";
	}
	
	@PostMapping("/board/notic/add")
	public String add(HttpServletRequest request) {
		noticBoardService.addNoticList(request);
		return "redirect:/board/notic/list";
	}
	
	@PostMapping("/board/notic/remove")
	public String remove(@RequestParam("noticNo") int noticNo) {
		noticBoardService.removeNoticList(noticNo);
		return "redirect:/board/notic/list";
	}
	
	@GetMapping("/board/notic/edit")
	public String content(@RequestParam("noticNo") int noticNo, Model model) {
		model.addAttribute("free", noticBoardService.getNoticBoardByNo(noticNo));
		return "board/notic/edit";
	}
	
	@PostMapping("/board/notic/modify")
	public String modify(HttpServletRequest request) {
		System.out.println("modify:" + request.getParameter("noticNo") );
		noticBoardService.modifyNoticList(request);
		return "redirect:/board/notic/list";
	}
	
}
