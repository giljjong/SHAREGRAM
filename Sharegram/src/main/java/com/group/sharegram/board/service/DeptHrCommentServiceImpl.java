package com.group.sharegram.board.service;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.group.sharegram.board.domain.DeptHrCommentDTO;
import com.group.sharegram.board.mapper.DeptHrCommentMapper;
import com.group.sharegram.board.util.BPageUtil;
import com.group.sharegram.user.domain.EmployeesDTO;


@Service
public class DeptHrCommentServiceImpl implements DeptHrCommentService {
	
	
	 
	@Autowired
	private DeptHrCommentMapper deptHrCommentMapper;
	
	@Autowired
	private BPageUtil pageUtil;
	
	@Override
	public Map<String, Object> getDeptHrCommentCount(int boardNo){
		Map<String, Object> result=new HashMap<String, Object>();
		result.put("commentCount", deptHrCommentMapper.selectCommentCount(boardNo));
		return result;
	}

	@Transactional
	@Override
	public Map<String, Object> addDeptHrComment(DeptHrCommentDTO comment, HttpServletRequest request) {
		EmployeesDTO emp = ((EmployeesDTO)request.getSession().getAttribute("loginEmp"));
		comment.setEmpNo(emp.getEmpNo());
		
		//System.out.println("사원번호번호번호" + emp.getEmpNo());
		
		Map<String, Object> result=new HashMap<String, Object>();
		int insertResult = deptHrCommentMapper.insertComment(comment);
		if(insertResult == 1) {
			insertResult += deptHrCommentMapper.updateGroupNo(comment);
			if(insertResult == 2) {
				result.put("isSuccess", true);
			}
		}
		
		return result;
		
	}
	
	
	@Override
	public Map<String, Object> getDeptHrCommentList(HttpServletRequest request) {
		
		int boardNo =Integer.parseInt(request.getParameter("boardNo"));
		int page=Integer.parseInt(request.getParameter("page"));
		int recordPerPage = 10;
		
		int commentCount = deptHrCommentMapper.selectCommentCount(boardNo);

		pageUtil.setPageUtil(page, recordPerPage, commentCount);
		
		Map<String, Object> map= new HashMap<String, Object>();
		map.put("boardNo", boardNo);
		map.put("begin", pageUtil.getBegin() - 1);
		map.put("recordPerPage", pageUtil.getRecordPerPage());
		
		Map<String, Object> result= new HashMap<String, Object>();
		result.put("commentList", deptHrCommentMapper.selectCommentList(map));
		//System.out.println("commentList : " + deptHrCommentMapper.selectCommentList(map));
		result.put("pageUtil", pageUtil);
		
		return result;
	}
	
	
	@Override
	public Map<String, Object> removeDeptHrComment(int cmtNo) {
		Map<String, Object> result= new HashMap<String, Object>();
		result.put("isRemove", deptHrCommentMapper.deleteComment(cmtNo)==1);
		return result;
	}
	
	
	@Override
	public Map<String, Object> addDeptHrReply(DeptHrCommentDTO reply, HttpServletRequest request) {
		int empNo = Integer.parseInt(request.getParameter("empNo"));  
        reply.setEmpNo(empNo);
		Map<String, Object> result= new HashMap<String, Object>();
		result.put("isAdd", deptHrCommentMapper.insertReply(reply)==1);
		return result;
	}
	
	
}
	
	
