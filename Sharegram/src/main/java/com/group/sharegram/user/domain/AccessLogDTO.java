package com.group.sharegram.user.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AccessLogDTO {
	private int accessLogNo;
	private int empNo;
	private Date lastLoginDate;
}
