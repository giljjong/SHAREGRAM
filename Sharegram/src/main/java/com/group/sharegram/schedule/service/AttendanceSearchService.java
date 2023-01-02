package com.group.sharegram.schedule.service;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;

import com.group.sharegram.schedule.domain.AttendanceDTO;
import com.group.sharegram.schedule.domain.SearchDTO;

public interface AttendanceSearchService {
	public ResponseEntity<Object> searchAttendance(@RequestBody SearchDTO search);
}
