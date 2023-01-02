package com.group.sharegram.board.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.group.sharegram.board.service.AnonyBoardService;
import com.group.sharegram.user.domain.EmployeesDTO;

@Controller
public class AnonyController {

	@Autowired
	private AnonyBoardService anonyBoardService;
	
	@GetMapping("/board/anonyList")
	public String list(HttpServletRequest request, Model model) {
		anonyBoardService.findAllAnonyList(request, model);
		return "board/anony/list";
	}
	
	@GetMapping("/board/anony/write")
	public String write(HttpServletRequest request, Model model) {
		EmployeesDTO emp  = (EmployeesDTO) request.getSession().getAttribute("loginEmp");
		model.addAttribute("emp", emp);
		return "board/anony/write";
	}
	

	 @ResponseBody 
	 @PostMapping(value="/board/anonyImage", produces="application/json") 
	 public Map<String, Object> anony(MultipartHttpServletRequest multipartRequest) {
		 return anonyBoardService.saveSummernoteImage(multipartRequest); 
	}
	
	@PostMapping("/board/anony/add")
	public void add(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		anonyBoardService.save(multipartRequest, response);
	}
	
	@GetMapping("/board/anony/detail")
	public String detail(@RequestParam(value="anonyNo", required=false, defaultValue="0") int anonyNo, Model model) {
		model.addAttribute("anonyBoard", anonyBoardService.getAnonyByNo(anonyNo));
		return "board/anony/detail";
	}
	
	/*
	 * @GetMapping("/board/anony/edit") public String
	 * content(@RequestParam("anonyNo") int anonyNo, Model model) {
	 * model.addAttribute("anonyBoard", anonyBoardService.getAnonyByNo(anonyNo));
	 * return "board/anony/edit"; }
	 * 
	 * @PostMapping("/board/anony/modify") public void
	 * modify(MultipartHttpServletRequest multipartRequest, HttpServletResponse
	 * response) { anonyBoardService.modifyAnony(multipartRequest, response); }
	 */
	
	@PostMapping("/board/anony/remove")
	public void remove(HttpServletRequest request, HttpServletResponse response) {
		anonyBoardService.removeAnony(request, response);
	}
	
	/*
	 * @GetMapping("/board/anony/incrase/hit") public String
	 * incraseHit(@RequestParam(value = "anonyNo", required = false, defaultValue =
	 * "0")int anonyNo) { int result = anonyBoardService.increaseHit(anonyNo);
	 * if(result > 0 ) { return "redirect:/board/anony/detail?anonyNo=" + anonyNo; }
	 * else { return "redirect:/board/anony/list"; } }
	 */
	
	
}
