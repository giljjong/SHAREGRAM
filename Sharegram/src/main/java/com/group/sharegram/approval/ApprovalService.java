package com.group.sharegram.approval;

import java.util.List;

import com.group.sharegram.user.domain.DepartmentsDTO;
import com.group.sharegram.user.domain.EmployeesDTO;

public interface ApprovalService {
	public int totalCount();
	public void insertApproval(ApprovalDTO dto) throws Exception;
	public List<ApprovalDTO> selectList(int startPage, int limit, String uno);
	public int listCount();
	public ApprovalDTO selectOne(int chk, int apno);
	
	public ApprovalDTO stateupdate(ApprovalDTO dto);
	public ApprovalDTO updateaprejection(ApprovalDTO dto);
	
	public List<EmployeesDTO> selectCeoList();
	public List<DepartmentsDTO> selectDeptList();
	public EmployeesDTO selectUserNameByNo(String apperson);
}