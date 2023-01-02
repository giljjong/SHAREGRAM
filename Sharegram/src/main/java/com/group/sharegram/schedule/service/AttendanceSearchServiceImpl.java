package com.group.sharegram.schedule.service;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.LongStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.group.sharegram.schedule.domain.AttendanceDTO;
import com.group.sharegram.schedule.domain.SearchDTO;
import com.group.sharegram.schedule.mapper.AttendanceMapper;
import com.group.sharegram.schedule.mapper.AttendanceSearchMapper;
import com.group.sharegram.schedule.util.SchedulePageUtil;
import com.group.sharegram.util.PageUtil;

@Service
public class AttendanceSearchServiceImpl implements AttendanceSearchService {

	@Autowired
	AttendanceSearchMapper attendanceSearchMapper;
	
	@Autowired
	private SchedulePageUtil pageUtil;

	public ResponseEntity<Object> searchAttendance(SearchDTO search) {

		int page = Integer.parseInt(search.getPage());

		// 검색 대상
		String column = search.getColumn();

		// 검색어
		String query = search.getQuery();
//		String start = request.getParameter("start");
//		String stop = request.getParameter("stop");

		// 조회와 검색된 사원수를 알아낼 때 사용하는 Map
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("column", column);
		map.put("query", query);
//		map.put("start", start);
//		map.put("stop", stop);
		int totalRecord = attendanceSearchMapper.selectSearchCount(map);
		pageUtil.setPageUtil(page, totalRecord);

		map.put("begin", pageUtil.getBegin() - 1);
		map.put("recordPerPage", pageUtil.getRecordPerPage());


		List<AttendanceDTO> attendancesSearch = attendanceSearchMapper.selectSearchAttendanceList(map).stream()
				.sorted(Comparator.comparing(AttendanceDTO::getAttStart).reversed()).collect(Collectors.toList());
		
		
		
		List<LocalDateTime> startTime = attendancesSearch.stream().filter(a -> a.getAttEnd() != null)
				.map(AttendanceDTO::getAttStart)
				.map(AttStart -> LocalDateTime.parse(AttStart, DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분")))
				.collect(Collectors.toList());
		List<LocalDateTime> endTime = attendancesSearch.stream().map(AttendanceDTO::getAttEnd).filter(Objects::nonNull)
				.map(AttEnd -> LocalDateTime.parse(AttEnd, DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분")))
				.collect(Collectors.toList());

		List<String> working = new ArrayList<>();
		List<String> overWorking = new ArrayList<>();
		
		if (attendancesSearch.size() != startTime.size()) {
			working.add("퇴근 후 정산");
			overWorking.add("퇴근 후 정산");
		}

		List<String> status = attendancesSearch.stream().filter(a -> a.getAttEnd() != null).map(AttendanceDTO::getAttStatus)
				.collect(Collectors.toList());
		List<String> early = attendancesSearch.stream().filter(a -> a.getAttEnd() != null).map(AttendanceDTO::getEarlyStatus)
				.map(nullCheck -> nullCheck == null ? "" : nullCheck).collect(Collectors.toList());
		/*
		 * System.out.println("-----"); startTime.stream().forEach(System.out::println);
		 * System.out.println("-----"); endTime.stream().forEach(System.out::println);
		 * System.out.println("-----"); status.stream().forEach(System.out::println);
		 * System.out.println("-----"); early.stream().forEach(System.out::println);
		 * System.out.println("-----");
		 */
		
		LocalTime startRegular = LocalTime.parse("09:00:00");
		LocalTime endRegular = LocalTime.parse("18:00:00");
		Long totalMinutes = null;
		Long hour = null;
		Long minute = null;

		
		
		for (int i = 0; i < endTime.size(); i++) {

			if (status.get(i).equals("정상 출근") && early.get(i).equals("")) {
				totalMinutes = Duration.between(startRegular, endRegular).toMinutes();
				if (totalMinutes >= 480) {
					hour = (totalMinutes - 60) / 60;
					minute = totalMinutes % 60;
				} else if (totalMinutes >= 240) {
					hour = (totalMinutes - 30) / 60;
					minute = totalMinutes % 60;
				}
				working.add(Long.toString(hour) + "시 " + Long.toString(minute) + "분");

			} else if (status.get(i).equals("정상 출근") && early.get(i).equals("조퇴")) {
				totalMinutes = Duration.between(startRegular, endTime.get(i).toLocalTime()).toMinutes();
				if (totalMinutes > 480) {
					hour = (totalMinutes - 60) / 60;
					minute = totalMinutes % 60;
				} else if (totalMinutes >= 240) {
					hour = (totalMinutes - 30) / 60;
					minute = totalMinutes % 60;
				}
				working.add(Long.toString(hour) + "시 " + Long.toString(minute) + "분");

			} else if (status.get(i).equals("지각") && early.get(i).equals("")) {
				totalMinutes = Duration.between(startTime.get(i).toLocalTime(), endRegular).toMinutes();
					
				if (totalMinutes >= 480) {
					hour = (totalMinutes - 60) / 60;
					minute = totalMinutes % 60;
				} else if (totalMinutes >= 240) {
					hour = (totalMinutes - 30) / 60;
					minute = totalMinutes % 60;
				}
				working.add(Long.toString(hour) + "시 " + Long.toString(minute) + "분");

			} else if (status.get(i).equals("지각") && early.get(i).equals("조퇴")) {
				totalMinutes = Duration.between(startTime.get(i).toLocalTime(), endTime.get(i).toLocalTime())
						.toMinutes();

				if (totalMinutes >= 480) {
					hour = (totalMinutes - 60) / 60;
					minute = totalMinutes % 60;
				} else if (totalMinutes >= 240) {
					hour = (totalMinutes - 30) / 60;
					minute = totalMinutes % 60;
				}

				working.add(Long.toString(hour) + "시 " + Long.toString(minute) + "분");

			}
		}
		
		long totalOverWork = 0;
		for (int j = 0; j < endTime.size(); j++) {
			if (status.get(j).equals("정상 출근") && early.get(j).equals("")) {
				totalOverWork = Duration.between(endRegular, endTime.get(j).toLocalTime()).toMinutes();
				if (totalOverWork >= 10) {
					long OverWorkhour = totalOverWork / 60;
					long OverWorkminute = totalOverWork % 60;
					overWorking.add(Long.toString(OverWorkhour) + "시 " + Long.toString(OverWorkminute) + "분");
				} else {
					overWorking.add("0분");
				}
			} else if (status.get(j).equals("지각") && early.get(j).equals("")) {
				totalOverWork = Duration.between(endRegular, endTime.get(j).toLocalTime()).toMinutes();
				if (totalOverWork >= 10) {
					long OverWorkhour = totalOverWork / 60;
					long OverWorkminute = totalOverWork % 60;
					overWorking.add(Long.toString(OverWorkhour) + "시 " + Long.toString(OverWorkminute) + "분");
				} else {
					overWorking.add("0분");
				}
			} else {
				overWorking.add("0분");
			}

		}

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("attendanceList", attendancesSearch);
		result.put("working", working);
		result.put("overWorking", overWorking);
		result.put("PageUtil", pageUtil);

		
		return new ResponseEntity<Object>(result, HttpStatus.OK);

	}

}
