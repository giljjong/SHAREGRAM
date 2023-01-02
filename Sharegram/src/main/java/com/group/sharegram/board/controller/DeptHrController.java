package com.group.sharegram.board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.group.sharegram.board.service.DeptHrBoardService;
import com.group.sharegram.user.domain.EmployeesDTO;

@Controller
public class DeptHrController {

	@Autowired
	private DeptHrBoardService deptHrBoardService;
	
	// 자료실 목록
	@GetMapping("/board/deptHrList")
	public String list(HttpServletRequest request, Model model) {
		deptHrBoardService.findAllDeptHrList(request, model);
//		model.addAttribute("uploadList", uploadBoardService.findAllUploadList(  HttpServletRequest request, Model model) );
		return "board/deptHr/list";
	}
	
	// 게시글 작성
	@GetMapping("/board/deptHr/write")
	public String write(HttpServletRequest request, Model model) {
		EmployeesDTO emp  = (EmployeesDTO) request.getSession().getAttribute("loginEmp");
		model.addAttribute("emp", emp);
		return "board/deptHr/write";
	}
	
	/*
	 * // 써머노트 이미지
	 * 
	 * @ResponseBody
	 * 
	 * @PostMapping(value="/board/uploadImage", produces="application/json") public
	 * Map<String, Object> uploadImage(MultipartHttpServletRequest multipartRequest)
	 * { return uploadBoardService.saveSummernoteImage(multipartRequest); }
	 */
	
	
	// 게시글 추가
	@PostMapping("/board/deptHr/add")
	public void add(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		deptHrBoardService.save(multipartRequest, response);
	}
	
	// 게시글 상세화면
	@GetMapping("/board/deptHr/detail")
	public String detail(@RequestParam(value="boardNo", required=false, defaultValue="0") int boardNo, Model model) {
		model.addAttribute("deptHrBoard", deptHrBoardService.getBoardByNo(boardNo));
		return "board/deptHr/detail";
	}
	
	/*
	 * @ResponseBody
	 * 
	 * @GetMapping("/board/upload/display") public ResponseEntity<byte[]>
	 * display(@RequestParam int attachNo){ return
	 * uploadBoardService.display(attachNo); }
	 */
	
	/*
	 * // 첨부자료 다움로드
	 * 
	 * @ResponseBody
	 * 
	 * @GetMapping("/board/upload/download") public ResponseEntity<Resource>
	 * download(@RequestHeader("User-Agent") String
	 * userAgent, @RequestParam("attachNo") int attachNo) { return
	 * uploadBoardService.download(userAgent, attachNo); }
	 * 
	 * // 첨부자료 일괄 다운로드
	 * 
	 * @ResponseBody
	 * 
	 * @GetMapping("/board/upload/downloadAll") public ResponseEntity<Resource>
	 * downloadAll(@RequestHeader("User-Agent") String
	 * userAgent, @RequestParam("uploadNo") int uploadNo) { return
	 * uploadBoardService.downloadAll(userAgent, uploadNo); }
	 */
	
	// 수정
	@PostMapping("/board/deptHr/edit")
	public String edit(@RequestParam("boardNo") int boardNo, Model model) {
		model.addAttribute("deptHrBoard", deptHrBoardService.getBoardByNo(boardNo));
		//ploadBoardService.getUploadByNo(uploadNo, model);
		return "board/deptHr/edit";
	}
	
	@PostMapping("/board/deptHr/modify")
	public void modify(HttpServletRequest request, HttpServletResponse response) {
		deptHrBoardService.modifyDeptHr(request, response);
	}
	
	/*
	 * // 첨부 삭제
	 * 
	 * @GetMapping("/baord/upload/attach/remove") public String
	 * uploadAttachRemove(@RequestParam("uploadNo") int
	 * uploadNo, @RequestParam("attachNo") int attachNo) {
	 * uploadBoardService.removeAttachByAttachNo(attachNo); return
	 * "redirect:/upload/detail?uploadNo=" + uploadNo; }
	 */

	// 게시글 삭제
	@PostMapping("/board/deptHr/remove")
	public void remove(HttpServletRequest request, HttpServletResponse response) {
		deptHrBoardService.removeDeptHr(request, response);
	}
	
	// 조회수
	@GetMapping("/board/deptHr/incrase/hit")
	public String incraseHit(@RequestParam(value = "boardNo", required = false, defaultValue = "0")int boardNo) {
		int result = deptHrBoardService.increaseHit(boardNo);
		if(result > 0 ) {	// 증가 성공 시 상세보기
			return "redirect:/board/deptHr/detail?boardNo=" + boardNo;
		} else {			// 증가 실패 시 목록
			return "redirect:/board/deptHr/list";
		}
	}
	
}
