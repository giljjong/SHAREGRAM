<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

	<jsp:include page="../layout/header.jsp">
		<jsp:param value="SHAREGRAM" name="title" />
	</jsp:include>
	
<script src="${contextPath}/resources/js/moment-with-locales.js"></script>
<script src="${contextPath}/resources/summernote-0.8.18-dist/summernote-lite.js"></script>
<script src="${contextPath}/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>
<link rel="stylesheet" href="${contextPath}/resources/summernote-0.8.18-dist/summernote-lite.css">
</head>
<style>
}

span {

 height: 40px;
 width: 400px;
 border: 1px solid #1b5ac2;
 background: #ffffff;

}
 
body {
  margin:0;
  padding:0;
  font-family: sans-serif;
  background-color: #fff;
}

table {
  border: 1px #fff solid;
  font-size: .9em;
  box-shadow: 0 2px 5px rgba(0,0,0,.25);
  width: 97%;
  border-collapse: collapse;
  border-radius: 5px;
  overflow: hidden;
  margin-left:auto; 
  margin-right:auto;

}

th {
  text-align: left;
}
  
thead {
  font-weight: bold;
  color: #4e73df;
  background: #4e73df;
}
  
 td, th {
  padding: 1em .5em;
  vertical-align: middle;
  text-align: center;
}
  
 td {
  border-bottom: 1px solid rgba(0,0,0,.1);
  background: #fff;
}

a {
  color: #73685d;
}
  
 @media all and (max-width: 768px) {
    
  table, thead, tbody, th, td, tr {
    display: block;
    min-width: 300px;
  }
  
  th {
    text-align: right;
  }
  
  table {
    position: relative; 
    padding-bottom: 0;
    border: none;
    box-shadow: 0 0 10px rgba(0,0,0,.2);
    
  }
  
  thead {
    float: left;
    white-space: nowrap;
    color:fff;
  }
  
  tbody {
    overflow-x: auto;
    overflow-y: hidden;
    position: relative;
  }
  
  tr {
    display: inline-block;
    vertical-align: top;
  }
  
  th {
    border-bottom: 1px solid #4e73df;
  }
  
  td {
    border-bottom: 1px solid #4e73df;
  }
 

</style>
<body>
<script>
	$(document).ready(function(){
		// area1, area2 표시
		// 초기 상태 : area1, area2 둘 다 숨김
		$('#area1, #area2').css('display', 'none');
		// column 선택에 따른 area1, area2 표시
		$('#column').change(function() {     // #column == this
			let combo = $(this);
			if(combo.val() == '') {
				$('#area1, #area2').css('display', 'hidden');
			} else if(combo.val() == 'HIRE_DATE' || combo.val() == 'SALARY') {
				$('#area1').css('display', 'none');
				$('#area2').css('display', 'inline');
			} else {
				$('#area1').css('display', 'inline');
				$('#area2').css('display', 'none');
			}
		})
		

		
		$('#btn_all').click(function() {
			location.href = '${contextPath}/user/retirelist';
		})
	})
	
	
</script>
</head>
<body>

	<div>
	<!-- 
		<selcet name="column">
		<input name="query">     -> 이 두개의 데이터가 DB로 전달 될 것
		
		 /emp/search로 보내는 파라미터 4개 = column, query, start, stop
	-->
		<form id="frm_search" action="${contextPath}/user/retiresearch">
			<select id="column" name="column">  <!-- submit할 때 넘어가는 값은 name값! -->
				<option value="">:::선택:::</option>   <!-- 칼럼이름을 value값으로 -->
				<!-- area1 : 완벽 일치해야 검색 -->
				<option value="EMP_NO">사원번호</option>     
				<option value="DEPT_NAME">부서명</option> 
				<option value="JOB_NAME">직책</option>
				<option value="NAME">이름</option>   	
				<option value="PHONE">연락처</option> 
				<option value="JOIN_DATE">입사일</option>
				<option value="RETIRED_DATE">퇴사일</option>
			</select>
			<span id="area1">
				<input type="text" id="query" name="query">
			</span>
			
			<span id="">
				<input type="submit" value="검색">
				<input type="button" value="전체사원 조회" id="btn_all">
			</span>
		</form>
		
		<!-- /emp/search로 보내는 파라미터 4개 = column, query, start, stop -->
	</div>
	
	<hr>

	<div>
		<table border="1">
			<thead>
				<tr>
					<td>No.</td>
					<td>사원번호</td>
					<td>사원명</td>
					<td>전화번호</td>
					<td>부서명</td>
					<td>직위</td>
					<td>입사일자</td>
					<td>퇴사일자</td>
					<!-- 부서명(departmentName) 때문에 조인이 필요함. 조인: pk와 조인 대상의 fk인 departmentId로 한다~ -->
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${retire}" var="retire" varStatus="vs">  <!-- varStatus : 0부터 시작하는 index 갖고 오는 방법! 변수vs에서 index 가져오기 -->
					<tr>
						<td>${beginNo - vs.index}</td>  <!-- 107, 106, 105 ... 순번 표시하기 -->
						<td>${retire.empNo}</td>
						<td>${retire.name}</td>
						<td>${retire.phone}</td>
						<td>${retire.departmentsDTO.deptName}</td>	
						<td>${retire.positionDTO.jobName}</td>	
						<td>${retire.joinDate}</td>
						<td>${retire.retiredDate}</td>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="10">
					${paging}
					
					
	
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
	
<%@ include file="../layout/footer.jsp" %>