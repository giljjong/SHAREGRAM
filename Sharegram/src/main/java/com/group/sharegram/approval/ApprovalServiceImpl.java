package com.group.sharegram.approval;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.group.sharegram.user.domain.DepartmentsDTO;
import com.group.sharegram.user.domain.EmployeesDTO;


@Service("ApproService")
@Repository
public class ApprovalServiceImpl implements ApprovalService {
	
	@Autowired
	private ApprovalDAO apDao;
	
	@Override
	public int totalCount() {
		return apDao.listCount();
	}
	
	@Override
	public void insertApproval(ApprovalDTO dto) throws Exception{
		apDao.insertApproval(dto);
	}
	
	@Override
	public List<ApprovalDTO> selectList(int startPage, int limit, String empNo) {
		return apDao.selectList(startPage,limit,empNo);
	}

	@Override
	public int listCount() {
		return apDao.listCount();
	}

	@Override
	public ApprovalDTO selectOne(int chk, int apNo) {
		return apDao.selectOne(apNo);
	}

	@Override
	public ApprovalDTO stateupdate(ApprovalDTO dto) {
		int result = apDao.stateupdate(dto);
		if (result > 0) {
			dto = apDao.selectOne(dto.getApNo());
		} else {
			dto = null;
		}
			
		return dto;
	}

	@Override
	public ApprovalDTO updateaprejection(ApprovalDTO dto) {
		int result = apDao.updateaprejection(dto);
		if(result > 0 ) {
			dto = apDao.selectOne(dto.getApNo());
		} else {
			dto = null;
		}
		
		return dto;
		
	}
		
	@Override
	public List<EmployeesDTO> selectCeoList() {

		List<EmployeesDTO> empList = apDao.selectCeoList();
	
		return empList;
	}
	
	@Override
	public List<DepartmentsDTO> selectDeptList() {
		
		List<DepartmentsDTO> deptList = apDao.selectDeptList();
		
		return deptList;
	}
	
	@Override
	public EmployeesDTO selectUserNameByNo(String apperson) {
		EmployeesDTO emp = apDao.selectUserNameByNo(apperson);
		return emp;
	}
	
}
