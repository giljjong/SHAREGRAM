package com.group.sharegram.board.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.group.sharegram.board.domain.AnonyCommentDTO;
import com.group.sharegram.board.mapper.AnonyCommentMapper;
import com.group.sharegram.board.util.BPageUtil;
import com.group.sharegram.user.domain.EmployeesDTO;

@Service
public class AnonyCommentServiceImpl implements AnonyCommentService {
	
	@Autowired
	private AnonyCommentMapper commentMapper;
	
	@Autowired
	private BPageUtil pageUtil;
	
	@Override
	public Map<String, Object> getCommentCount(int anonyNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("commentCount", commentMapper.selectCommentCount(anonyNo));
		
		//System.out.println("commentCount");
		return result;
	}
	
	@Transactional
	@Override
	public Map<String, Object> addComment(AnonyCommentDTO comment, HttpServletRequest request) {
		EmployeesDTO emp = ((EmployeesDTO)request.getSession().getAttribute("loginEmp"));
		comment.setEmpNo(emp.getEmpNo());
		
		//System.out.println("사원번호확인" + emp.getEmpNo()); 
		//System.out.println("comment" + comment);
		
		Map<String, Object> result=new HashMap<String, Object>();
		int insertResult = commentMapper.insertComment(comment);
		if(insertResult == 1) {
			insertResult += commentMapper.updateGroupNo(comment);
			if(insertResult == 2) {
				result.put("isSuccess", true);
			}
		}
		
		return result;
		
	}
	
	@Override
	public Map<String, Object> getCommentList(HttpServletRequest request) {
		
		int anonyNo = Integer.parseInt(request.getParameter("anonyNo"));
		int page = Integer.parseInt(request.getParameter("page"));
		int recordPerPage = 10;
		
		int commentCount = commentMapper.selectCommentCount(anonyNo);
		
		pageUtil.setPageUtil(page, recordPerPage, commentCount);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("anonyNo", anonyNo);
		map.put("begin", pageUtil.getBegin() - 1);
		map.put("recordPerPage", pageUtil.getRecordPerPage());
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("commentList", commentMapper.selectCommentList(map));
		result.put("pageUtil", pageUtil);
		
		return result;
		
	}
	
	@Override
	public Map<String, Object> removeComment(int commentNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isRemove", commentMapper.deleteComment(commentNo) == 1);
		return result;
	}
	
	@Override
	public Map<String, Object> addReply(AnonyCommentDTO reply, HttpServletRequest request) {
		int empNo = Integer.parseInt(request.getParameter("empNo"));  
        reply.setEmpNo(empNo);
		Map<String, Object> result= new HashMap<String, Object>();
		result.put("isAdd", commentMapper.insertReply(reply)==1);
		return result;
	}
	
	
}