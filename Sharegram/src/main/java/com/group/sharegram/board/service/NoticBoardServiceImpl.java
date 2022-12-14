package com.group.sharegram.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.group.sharegram.board.domain.NoticBoardDTO;
import com.group.sharegram.board.util.PageUtil;
import com.group.sharegram.board.util.SecurityUtil;
import com.group.sharegram.mapper.NoticBoardMapper;

@Service
public class NoticBoardServiceImpl implements NoticBoardService {
	
	@Autowired
	private NoticBoardMapper noticBoardMapper;
	
	@Autowired
	private PageUtil pageUtil;
	
	@Autowired
	private SecurityUtil securityUtil;
	
	@Override
	public void findAllNoticList(HttpServletRequest request, Model model) {
		
		Optional<String> opt1 = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt1.orElse("1"));
		
		Optional<String> opt2 = Optional.ofNullable(request.getParameter("recordPerPage"));
		int recordPerPage = Integer.parseInt(opt2.orElse("5"));

		// 전체 게시글 개수
		int totalRecord = noticBoardMapper.selectAllNoticListCount();
		
		// 페이징에 필요한 모든 계산 완료
		pageUtil.setPageUtil(page, recordPerPage, totalRecord);
		
		// DB로 보낼 Map(begin + end)
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		
		// DB에서 목록 가져오기
		List<NoticBoardDTO> freeBoardList = noticBoardMapper.selectNoticList(map);
		
		// 뷰로 보낼 데이터
		model.addAttribute("freeBoardList", freeBoardList);
		model.addAttribute("paging", pageUtil.getPaging(request.getContextPath() + "/free/list?recordPerPage=" + recordPerPage));
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
		model.addAttribute("recordPerPage", recordPerPage);
		
	}
	
	@Override
	public int addNoticList(HttpServletRequest request) {
		
		int empNo = Integer.parseInt(request.getParameter("empNo"));
		String boardTitle = securityUtil.preventXSS(request.getParameter("boardTitle"));
		String boardContent = securityUtil.preventXSS(request.getParameter("boardContent"));

		NoticBoardDTO noticBoard = new NoticBoardDTO();
		noticBoard.setEmpNo(empNo);
		noticBoard.setBoardTitle(boardTitle);
		noticBoard.setBoardContent(boardContent);
		
		return noticBoardMapper.insertNotic(noticBoard);
		
	}
	
	@Override
	public int removeNoticList(int noticBoardNo) {
		return noticBoardMapper.deleteNotic(noticBoardNo);
	}
	
	@Override
	public NoticBoardDTO getNoticBoardByNo(int noticBoardNo) {
		return noticBoardMapper.selectBoardByNo(noticBoardNo);
	}
	
	@Override
	public void findNoticList(HttpServletRequest request, Model model) {
		Optional<String> opt = Optional.ofNullable(request.getParameter("noticBoardNo"));
		int noticBoardNo = Integer.parseInt(opt.orElse("0"));
		
		NoticBoardDTO noticBoard = noticBoardMapper.selectBoardByNo(noticBoardNo);
		model.addAttribute("NoticBoard", noticBoard);
	}
	
	@Override
	public int modifyNoticList(HttpServletRequest request) {
		int empNo = Integer.parseInt(request.getParameter("empNo"));
		String boardContent = securityUtil.preventXSS(request.getParameter("boardContent"));
		int noticBoardNo = Integer.parseInt(request.getParameter("noticBoardNo"));
		
		NoticBoardDTO noticBoard = new NoticBoardDTO();
		noticBoard.setEmpNo(empNo);
		noticBoard.setBoardContent(boardContent);
		noticBoard.setBoardNo(noticBoardNo);
		
		System.out.println(noticBoard);
		
		int result = noticBoardMapper.modifyNotic(noticBoard);
		
		if(result > 0) {
			System.out.println("수정 성공");
		} else {
			System.out.println("수정 실패");
		}
		
		return result;
	}
	
	@Override
	public int increaseHit(int noticBoardNo) {
		return noticBoardMapper.updateHit(noticBoardNo);
	}
}