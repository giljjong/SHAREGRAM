package com.group.sharegram.board.service;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.group.sharegram.board.mapper.DeptHrLoveMapper;


@Service
public class DeptHrLoveServiceImpl implements DeptHrLoveService {
	
	@Autowired
	private DeptHrLoveMapper deptHrLoveMapper;
	
	@Override
	public Map<String, Object> getLoveCheck(HttpServletRequest request) {
		Optional<String> opt1 = Optional.ofNullable(request.getParameter("boardNo"));
		int boardNo = Integer.parseInt(opt1.orElse("0"));
		Optional<String> opt2 = Optional.ofNullable(request.getParameter("empNo"));
		int empNo = Integer.parseInt(opt2.orElse("0"));
		
		Map<String, Object> map = new HashMap<>();
		map.put("boardNo", boardNo);
		map.put("empNo", empNo);
		Map<String, Object> result = new HashMap<>();
		result.put("count", deptHrLoveMapper.selectUserLoveCount(map));
		return result;
	}
	
	@Override
	public Map<String, Object> getLoveCount(int boardNo) {
		Map<String, Object> result = new HashMap<>();
		result.put("count", deptHrLoveMapper.selectBoardLoveCount(boardNo));
		return result;
	}
	
	@Override
	public Map<String, Object> mark(HttpServletRequest request) {
		Optional<String> opt1 = Optional.ofNullable(request.getParameter("boardNo"));
		int boardNo = Integer.parseInt(opt1.orElse("0"));
		Optional<String> opt2 = Optional.ofNullable(request.getParameter("empNo"));
		int empNo = Integer.parseInt(opt2.orElse("0"));
		Map<String, Object> map = new HashMap<>();
		map.put("boardNo", boardNo);
		 map.put("empNo", empNo);
		Map<String, Object> result = new HashMap<>();
		if (deptHrLoveMapper.selectUserLoveCount(map) == 0) {  // 해당 게시물의 "좋아요"를 처음 누른 상태
			result.put("isSuccess",deptHrLoveMapper.insertLove(map) == 1);  // 신규 삽입			
		} else {
			result.put("isSuccess", deptHrLoveMapper.deleteLove(map) == 1);  // 기존 정보 삭제		
		}
		return result;
	}
	
	
}
	
	
