package com.group.sharegram.schedule.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.group.sharegram.schedule.domain.AttendanceDTO;


@Mapper
public interface AttendanceSearchMapper {
	public int selectSearchCount(Map<String, Object> map);
	public List<AttendanceDTO> selectSearchAttendanceList(Map<String, Object> map);
}
