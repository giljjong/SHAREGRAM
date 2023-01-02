package com.group.sharegram.schedule.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.group.sharegram.schedule.domain.ScheduleDTO;
import com.group.sharegram.schedule.mapper.ScheduleMapper;
import com.group.sharegram.user.domain.EmployeesDTO;

@Service
public class ScheduleServiceImpl implements ScheduleService {

	@Autowired
	ScheduleMapper scheduleMapper;

	@Override
	public ResponseEntity<Object> getScheduleList(HttpServletRequest request) {
		
		EmployeesDTO employeesDTO =(EmployeesDTO) request.getSession().getAttribute("loginEmp");
		Optional<Integer> opt = Optional.ofNullable(employeesDTO).map(EmployeesDTO::getEmpNo);
		int empNo = opt.orElse(1);
		
		List<ScheduleDTO> list = scheduleMapper.selectScheduleList();
		List<ScheduleDTO> reuslt= list.stream().filter(a -> a.getEmpNo() == empNo ).collect(Collectors.toList());
		
		return new ResponseEntity<Object>(reuslt, HttpStatus.OK);
	}

	@Override
	public ResponseEntity<Object> addSchedule(ScheduleDTO schedule) {
		
		if(schedule.getScheduleTitle().isEmpty() ) {
			schedule.setScheduleTitle("제목없음");
		} 
		//System.out.println("schedule : " + schedule);
		Map<String, Object> result = new HashMap<String, Object>();
		int insertResult = scheduleMapper.insertSchedule(schedule);
		result.put("insertResult", insertResult);

		if (insertResult > 0) {
			//System.out.println("추가성공");
			HttpHeaders headers = new HttpHeaders();
			return new ResponseEntity<Object>(result, HttpStatus.OK);
		} else {
			return new ResponseEntity<Object>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@Override
	public ResponseEntity<Object> modifySchedule(ScheduleDTO schedule) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		int updateResult = scheduleMapper.updateSchedule(schedule);
		result.put("updateResult", updateResult );
		if(updateResult > 0) {
			//System.out.println("수정성공");
			return new ResponseEntity<Object>(result, HttpStatus.OK);
		} else {
			return new ResponseEntity<Object>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
	}
	
	@Override
	public ResponseEntity<Object> removeSchedule(ScheduleDTO schedule) {
		Map<String, Object> result = new HashMap<String, Object>();
		int deleteResult = scheduleMapper.deleteSchedule(schedule);
		result.put("deleteResult", deleteResult );
//		System.out.println("삭제 스케줄");
//		System.out.println(schedule);
		if(deleteResult > 0) {
			//System.out.println("삭제성공");
			return new ResponseEntity<Object>(result, HttpStatus.OK);
		} else {
			return new ResponseEntity<Object>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
}
