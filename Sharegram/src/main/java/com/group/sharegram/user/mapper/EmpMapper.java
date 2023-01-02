package com.group.sharegram.user.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.group.sharegram.user.domain.EmployeesDTO;
import com.group.sharegram.user.domain.ProfImgDTO;
import com.group.sharegram.user.domain.RetiredDTO;



@Mapper
public interface EmpMapper {
	
	
	
	// 아이디 중복체크, 로그인, 마이페이지 가기 전 비밀번호 확인
	public EmployeesDTO selectEmpByMap(Map<String, Object>map); // 직원
	public RetiredDTO selectRetireEmpByNo(int empNo); // 퇴사자
	
	
	// 직원 리스트
	public int selectAllEmpListCnt();
	public List<EmployeesDTO> selectEmpByPage(Map<String, Object>map);
	
	// 직원 검색
	public int selectFindEmpCount(Map<String, Object> map);
	public List<EmployeesDTO>selectFindEmp(Map<String, Object>map);
	
	// 퇴사자 리스트 
	public int selectAllRetireListCnt();
	public List<RetiredDTO> selectRetireByPage(Map<String, Object>map);
	
	// 퇴사자 검색
	public int selectFindRetireCount(Map<String, Object> map);
	public List<RetiredDTO> selectFindRetire(Map<String, Object>map);
	
	
	
	
	// 직원 프로필 이미지
	public List<EmployeesDTO> selectProfImgList(); 
	
	
	   public int updateAccessLog(int empNo);
	   public int insertAccessLog(int empNo);
	   public int updateSessionInfo(EmployeesDTO emp);
	
	
	public int insertNoTable();
	

	
	
	
	
	// 관리자용
	public int insertEmp(EmployeesDTO emp); // 직원 등록(인사부 부장 권한)
	public int insertProfImg(ProfImgDTO prof); // 직원 프로필 이미지 등록
	public int updateEmp(EmployeesDTO emp); // 직원 수정(인사 부 부장 권한)
	/* public int insertRetireEmp (RetiredDTO retire); */
	public int insertRetireEmp(int empNo);
	public int deleteEmp(int empNo);

	
	

	
	
	// 직원용
	public int updateMyPassword(EmployeesDTO emp); // 마이페이지: 비밀번호 수정
	public int updateMyinfo(EmployeesDTO emp); // 마이페이지:내 정보 수정 ** 해야됨 **
	
	
	
	
	
	
}
