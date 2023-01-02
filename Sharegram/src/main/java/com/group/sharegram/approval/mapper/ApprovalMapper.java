package com.group.sharegram.approval.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.group.sharegram.approval.ApprovalDTO;

@Mapper
public interface ApprovalMapper {
	public void listCount();
	public List<ApprovalDTO> selectList(int startPage, int limit, String empNo);
	public void insertApproval(ApprovalDTO dto);
	public void stateupdate(ApprovalDTO dto);
	public void updateaprejection(ApprovalDTO dto);
	public ApprovalDTO selectOne(String apNo);
}
