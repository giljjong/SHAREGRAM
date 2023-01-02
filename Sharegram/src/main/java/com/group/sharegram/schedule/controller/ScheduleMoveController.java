package com.group.sharegram.schedule.controller;

import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.group.sharegram.user.domain.EmployeesDTO;

@Controller
public class ScheduleMoveController {

	@GetMapping(value = "/schedule/list" , produces = "application/json")
	public String Calander(HttpServletRequest request,Model model) {
		EmployeesDTO employeesDTO =(EmployeesDTO) request.getSession().getAttribute("loginEmp");
		Optional<Integer> opt = Optional.ofNullable(employeesDTO).map(EmployeesDTO::getEmpNo);
		model.addAttribute("empNo",opt.orElse(1));
		return "schedule/calander";
	}
	
	@GetMapping(value = "/schedule/write" , produces = "application/json")
	public String writeCalendar(HttpServletRequest request, Model model) {
		String start =  request.getParameter("start");
		String end = request.getParameter("end");
		String allday = request.getParameter("allday");
		String empNo = request.getParameter("empNo");
		model.addAttribute("start" , start);
		model.addAttribute("end" , end);
		model.addAttribute("allday" , allday);
		model.addAttribute("empNo" , empNo);
	return "schedule/calendarWrite";
	}
	
	@GetMapping(value = "/attendance/list" , produces = "application/json")
	public String getAttendaceList(HttpServletRequest request,Model model) {
		EmployeesDTO emp =(EmployeesDTO) request.getSession().getAttribute("loginEmp");
//		System.out.println("===");
//		System.out.println(emp);
//		System.out.println("===");
		model.addAttribute("emp",emp);
		return "schedule/attendance";
	}
}
