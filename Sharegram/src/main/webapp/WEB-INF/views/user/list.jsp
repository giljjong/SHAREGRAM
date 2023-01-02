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
  color: #fff;
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

<script>
$(function(){
	fn_leave();
});


	$(document).ready(function(){
		// area1, area2 표시
		// 초기 상태 : area1, area2 둘 다 숨김
		$('#area1, #area2').css('display', 'none');
		
		// column 선택에 따른 area1, area2 표시
		$('#column').change(function() {     // #column == this
			let combo = $(this);
			if(combo.val() == '') {
				$('#area1, #area2').css('display', 'hidden');
			} else if(combo.val() == 'JOIN_DATE' || combo.val() == 'SALARY') {
				$('#area1').css('display', 'none');
				$('#area2').css('display', 'inline');
			} else {
				$('#area1').css('display', 'inline');
				$('#area2').css('display', 'none');
			}
		})
		

		$('#btn_all').click(function() {
			location.href = '${contextPath}/user/list';
		})
		
		fn_detail();
	})
	
	let employeesNo = 0;
	function fn_detail(){
	$(document).on('click', '.btn_detail', function(){
		//console.log($('#exampleModal').modal('toggle'));
		employeesNo = $(this).data('emp_no'); 
	});
}
	
	
function fn_leave(){
		$('#btn_retire').click(function() {
			if(confirm('퇴사 처리하시겠습니까?')){
				$('#frm_retire').attr('action', '${contextPath}/user/retire?empNo=' + employeesNo );
				$('#frm_retire').submit();
			}else {
				alert('퇴사 처리에 실패했습니다.');
			}
		});
	}	
	
</script>
<body>



<!-- Button trigger modal -->
<!-- Button trigger modal -->

<!-- Modal -->
<div class="modal fade exampleModal" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" >
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">수정 페이지</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<table id="myInfo">
      	
      	<tr>
      		<th>
      			<td>
      				<img src="${contextPath}/resources/images/defaultProfile.png" width="200px">
				</td>
		</tr>
					
		<tr>
		
		<tr>
			<th style="width:20%;">이름</th>
			<td>실험용3</td>
		</tr>
		
		<tr>
			<th>사원번호</th>
			<td>23010011</td>
		</tr>
		
		<tr>
			<th style="width:30%;">전화번호</th>
			<td>010-5548-7951</td>
		</tr>
		
		<tr>
			<th style="width:30%;">부서</th>
			<td>인사총무부</td>
		</tr>
		
		<tr>
			<th style="width:30%;">직위</th>
			<td>대리</td>
		</tr>
		
		<tr>
			<th>입사일</th>
			<td>2023-01-02</td>
		</tr> 
	
	</table>
      

		<div>
			<form id="frm_retire"  method="post">
				<button type="submit"  id="btn_retire" class="btn btn-danger">퇴사</button>
			</form>
		</div>

      </div>
      <div class="modal-footer">
     
        <!-- <button type="button" onclick="fn_init()"> 초기화 </button> -->
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal" id="btn_modify">수정 완료</button>
      </div>
    </div>
  </div>
</div> 

	<div>
		<h3>직원 목록</h3>
		<hr>
	<!-- 
		<selcet name="column">
		<input name="query">     -> 이 두개의 데이터가 DB로 전달 될 것
		
		 /emp/search로 보내는 파라미터 4개 = column, query, start, stop
	-->
		<form id="frm_search" action="${contextPath}/user/search">
			<select id="column" name="column">  <!-- submit할 때 넘어가는 값은 name값! -->
				<option value="">:::선택:::</option>   <!-- 칼럼이름을 value값으로 -->
				<option value="EMP_NO">사원번호</option>     
				<option value="DEPT_NAME">부서명</option> 
				<option value="JOB_NAME">직책</option>
				<option value="NAME">이름</option>   	
				<option value="PHONE">연락처</option> 
				<option value="JOIN_DATE">입사일</option>
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
					<th>No.</th>
					<th>사원번호</th>
					<th>사원명</th>
					<th>전화번호</th>
					<th>부서명</th>
					<th>직위</th>
					<th>입사일자</th>
					<th>연봉</th>
					<th>조회</th>
					<!-- 부서명(departmentName) 때문에 조인이 필요함. 조인: pk와 조인 대상의 fk인 departmentId로 한다~ -->
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${emp}" var="emp" varStatus="vs">  <!-- varStatus : 0부터 시작하는 index 갖고 오는 방법! 변수vs에서 index 가져오기 -->
					<tr>
						<td>${beginNo - vs.index}</td>  <!-- 107, 106, 105 ... 순번 표시하기 -->
						<td>${emp.empNo}</td>
						<td>${emp.name}</td>
						<td>${emp.phone}</td>
						<td>${emp.departmentsDTO.deptName}</td>	
						<td>${emp.positionDTO.jobName}</td>	
						<td>${emp.joinDate}</td>
						<td>${emp.salary}</td>
					    <td><input type="button" value="수정" class="btn_detail" data-emp_no="${emp.empNo}"></td>
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