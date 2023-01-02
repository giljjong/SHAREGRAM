package com.group.sharegram.schedule.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.group.sharegram.schedule.domain.SearchDTO;
import com.group.sharegram.schedule.service.AttendanceSearchService;

import oracle.jdbc.proxy.annotation.Post;

@RestController
public class SearchController {

	@Autowired
	private AttendanceSearchService attendanceSearchService;

	
	@GetMapping(value="/attendance/search", produces="application/json; charset=utf-8")
	public ResponseEntity<Object> searchAttendance(SearchDTO search) {
		//System.out.println(attendanceSearchService.searchAttendance(search));
		return null;
//		return attendanceSearchService.searchAttendance(search);
	}
}
