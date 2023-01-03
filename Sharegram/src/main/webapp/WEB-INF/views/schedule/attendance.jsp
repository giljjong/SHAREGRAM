<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

	<jsp:include page="../layout/header.jsp">
		<jsp:param value="근태내역" name="title" />
	</jsp:include> 
	
<link rel="stylesheet" href="${contextPath}/resources/css/jquery-ui.min.css" title="Default Style">
<link rel="stylesheet" href="${contextPath}/resources/css/datepicker.css" title="Default Style">
<link rel="stylesheet" href="${contextPath}/resources/css/jquery.datetimepicker.min.css" title="Default Style">
<script src="${contextPath}/resources/js/jquery-ui.min.js"></script>
<script src="${contextPath}/resources/js/jquery.datetimepicker.full.min.js"></script>
<script src="${contextPath}/resources/js/moment-with-locales.js"></script>

<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>  -->
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

<script>
$(function(){
	fn_checkAll();
	fn_checkOne(); 
	/* fn_add();  */
	fn_init(); 
	fn_changePage(); 
	fn_list(); 
	fn_remove(); 
	fn_modify();
	fn_detail();
	fn_datepicker(); 
	fn_search();
	fn_att();
	fn_leave();
});




function fn_checkAll(){
	$('#check_all').click(function(){
		$('.check_one').prop('checked', $('#check_all').prop('checked'));
	});
}

function fn_checkOne(){
	$(document).on('click', '.check_one', function(){
		let checkCount = 0;
		for(let i = 0; i < $('.check_one').length; i++){
			checkCount += $($('.check_one')[i]).prop('checked');				
		}
		$('#check_all').prop('checked', checkCount == $('.check_one').length);
	});
}



function fn_init(){
	$('#id').val('').prop('readonly', false);
	$('#name').val('');
	$(':radio[name=gender]').prop('checked', false);
	$('#address').val('');
}

// 전역변수
var page = 1;

function fn_list(){
	
	$.ajax({
		type: 'get',
		url: '${contextPath}/attendance/page/' + page,
		dataType: 'json',
		success: function(resData){
			
			// 근태목록
			$('#attendace_list').empty();
			$.each(resData.attendanceList , function(i, list){
				let tr = '<tr>';
			   	tr += '<td><input type="checkbox" class="check_one" value="'+ list.attNo +'"></td>';   
				tr += '<td>' + list.empDTO.empNo + '</td>';  
				tr += '<td>' + list.empDTO.name + '</td>';
				tr += '<td>' + list.empDTO.departmentsDTO.deptName + '</td>';
				tr += '<td>' + list.empDTO.positionDTO.jobName + '</td>';
				tr += '<td>' + list.attStart + '</td>';
				const end = list.attEnd ?? ''
				tr += '<td>' + end + '</td>';
				tr += '<td>' + list.attStatus + '</td>';
				$.each(resData.working , function(j, list){
					if(i === j)
					tr += '<td>' + list + '</td>'; 
				})
				
				$.each(resData.overWorking , function(K, list){
					if(i === K)
						tr += '<td>' + list + '</td>';
					
				})  
				const status = list.earlyStatus ?? ''
				tr += '<td>' + status + '</td>'; 
				
				// 수정은 인사총무부만  그리고 대표 부장 차장 과장만
				if(${emp.deptNo} === 10 && ${emp.jobNo} <= 4 ){
					tr += '<td><input type="button" value="수정" class="btn_detail btn btn-primary" data-attendance_no="'+ list.attNo +'"></td>'; 
				}
				$('#attendace_list').append(tr);
				
				$('#paging').empty();
				
				var PageUtil = resData.PageUtil;
				var paging = '<div>';
				if(page != 1) {
					paging += '<span class="lnk" data-page="' + (page - 1) + '">&lt;이전</span>';
				}
				for(let p = PageUtil.beginPage; p <= PageUtil.endPage; p++) {
					if(p == page){
						paging += '<strong>' + p + '</strong>';
					} else {
						paging += '<span class="lnk" data-page="'+ p +'">' + p + '</span>';
					}
				}
				if(page != PageUtil.totalPage){
					paging += '<span class="lnk" data-page="'+ (page + 1) +'">다음&gt;</span>';
				}
				paging += '</div>';
				$('#paging').append(paging);
				
				
			});
			
			
		
		} 
	});
}

function fn_changePage(){
	$(document).on('click', '.lnk', function(){
		page = $(this).data('page');
		fn_list();
	});
}

function fn_modify(){
	$('#btn_modify').click(function(){
		let attendances = JSON.stringify({
			attStart : $('#attStart').val(),
			attEnd : $('#attEnd').val(),
		    attStatus : $('#attStatus').val(),
		    attNo : $('#attNo').val(),
		    empNo : $('#empNo').val(),
		});
		$.ajax({
			type: 'put',
			url: '${contextPath}/attendance',
			data: attendances,
			contentType: 'application/json',
			dataType: 'json',
			success: function(resData){
				//console.log(resData)
				if(resData.updateResult > 0){
					fn_list();
				} else {
					alert('회원 정보가 수정되지 않았습니다.');
				} 
			},
			error: function(jqXHR){
				alert('에러코드(' + jqXHR.status + ') ' + jqXHR.responseText);
			}
		});
	});
}




function fn_detail(){
	$(document).on('click', '.btn_detail', function(){
		$('#exampleModal').modal('toggle');
		$.ajax({
			type: 'get',
			url: '${contextPath}/attendance/' + $(this).data('attendance_no'),
			dataType: 'json',
			success: function(resData){
			
				let attendance = resData.attendance;
				if(attendance == null){
					alert('해당 회원을 찾을 수 없습니다.');
				} else {
					$('#empNo').val(attendance.empDTO.empNo);
					$('#name').val(attendance.empDTO.name);
					$('#attStart').val(attendance.attStart);
					$('#attEnd').val(attendance.attEnd);
					$('#attStatus').val(attendance.attStatus);
					$('#attNo').val(attendance.attNo);
				} 
			}
		});
	});
}

function fn_remove(){
	
	$('#btn_remove').click(function(){
		if(confirm('선택한 회원을 모두 삭제할까요?')){
			let attendacneNoList = '';
			for(let i = 0; i < $('.check_one').length; i++){
				if( $($('.check_one')[i]).is(':checked') ) {
					attendacneNoList += $($('.check_one')[i]).val() + ',';  // 3,1,  (마지막 콤마 있음을 주의)
				}
			}
			attendacneNoList = attendacneNoList.substr(0, attendacneNoList.length - 1);  // 3,1  (마지막 콤마 자르기)
			$.ajax({
				type: 'delete',
				url: '${contextPath}/attendance/' + attendacneNoList,
				dataType: 'json',
				success: function(resData){
					if(resData.deleteResult > 0){
						alert('선택된 회원 정보가 삭제되었습니다.');
						fn_list();
					} else {
						alert('선택된 회원 정보가 삭제되지 않았습니다.');
					}
				}
			});
		}
	});
}



function fn_datepicker(){
	$('#attStart').datetimepicker({
		format: "Y년 m월 d일 H시 i분",
		yearStart : '2000',
		yearEnd : '2050',
		locale: 'ko',
		step: '30',
		allowTimes : [ '09:00', '09:30', '10:00', '10:30', '11:00', '11:30', '12:00', '12:30', '13:00', '13:30', '14:00', '14:30', 
			'15:00', '15:30', '16:00', '16:30', '17:00', '17:30', '18:00', '18:30', '19:00', '19:30', '20:00', '20:30', '21:00', '21:30', 
			'22:00', '22:30', '00:00', '00:30', '01:00', '01:30', '02:00', '02:30', '03:00', '03:30', '04:00', '04:30', '05:00', '05:30', 
			'06:00', '06:30', '07:00', '07:30', '08:00', '08:30']  ,
	});
	
	$('#attEnd').datetimepicker({
		format: "Y년 m월 d일 H시 i분",
		yearStart : '2000',
		yearEnd : '2050',
		locale: 'ko',
		step: '30',
		allowTimes : [ '09:00', '09:30', '10:00', '10:30', '11:00', '11:30', '12:00', '12:30', '13:00', '13:30', '14:00', '14:30', 
			'15:00', '15:30', '16:00', '16:30', '17:00', '17:30', '18:00', '18:30', '19:00', '19:30', '20:00', '20:30', '21:00', '21:30', 
			'22:00', '22:30', '00:00', '00:30', '01:00', '01:30', '02:00', '02:30', '03:00', '03:30', '04:00', '04:30', '05:00', '05:30', 
			'06:00', '06:30', '07:00', '07:30', '08:00', '08:30']  
	});
}

var searchPage = 1;
function fn_search(){
	$('#btn_search').click(function(){
        /* let search = JSON.stringify({
	        column : $('#column').val(),
	        query : $('#query').val(),
	        page : searchPage,
		}); */
		let search = {
	        column : $('#column').val(),
	        query : $('#query').val(),
	        page : searchPage,
		};
        alert(search)
		$.ajax({
			type: 'get',
			url: '${contextPath}/attendance/search',
			data: search,
			dataType: 'json',
			success : function(resData){
				alert(resData);
				alert('성공');
				//console.log('검색');
				//console.log(resData);
			},
			error : function(jqXHR){
				//console.log('에러동작');
			}
		})
		
		
	})
}

function fn_att(){
	$('#btn_att').click(function(){
		if(${emp.empNo} < 1000 ){
			alert('로그인이 필요합니다');
		} else {
			$.ajax({
	        	type: 'post',
				url: '${contextPath}/attendance',
				data: 'attendance=' + 1 +'&empNo=' + ${emp.empNo}, 
				dataType: 'json',
				success: function(resData){
					//console.log(resData)
					if(resData.insertAttendacne > 0) {
						alert('출근하셨습니다');
						fn_list(); 
					} else if (resData.alreadyAttendace === 0 ) {
						alert('이미 출근하셨습니다');
					}
				},
				error: function(jqXHR){
					 alert('에러코드(' + jqXHR.status + ') ' + jqXHR.responseText); 
				}
	        })
		}
	});
}
function fn_leave(){
	$('#btn_leave').click(function(){
		if(${emp.empNo} < 1000 ){
			alert('로그인이 필요합니다');
		} else {
			
			$.ajax({
		        	type: 'post',
					url: '${contextPath}/attendance',
					data: 'attendance=' + 2 +'&empNo=' + ${emp.empNo}, 
					dataType: 'json',
					success: function(resData){
						//console.log(resData)
						if (resData.earlyLeave === 1 && resData.updateLeaveWork === 1 ) {
							if(confirm('퇴근 시간 전입니다 조퇴 하시겠습니까?')){
	 						alert('조퇴입니다');
	 						fn_list(); 
							}
						}else if(resData.updateLeaveWork > 0) {
							alert('퇴근하셧습니다.');
							fn_list(); 
						}else if (resData.notAttendance === 0){
							alert('출근을 눌러주세요');
						}else if (resData.alreadyLeaveWork === 0){
							alert('이미 퇴근을 누르셨습니다.');
						} 
						
					},
					error: function(jqXHR){
						alert('에러코드(' + jqXHR.status + ') ' + jqXHR.responseText); 
					}
			});
		}
	});
}




</script>

</head>
<body>


<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" >
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">수정 페이지</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div>
			<input type="hidden" id="attNo" >
			<div class="grid text-center">
			    <div class="g-col-1">
					<label for="empNo">사원번호 </label>
					<input type="text" id="empNo"  readonly size="30"> 
				</div>
				<div class="g-col-2">
					<label for="name">&nbsp;&nbsp;이름 </label >
					<input type="text" id="name"  readonly size="30">
				</div> 
				<div lass="g-col-3">
					<label for="attStart"> 출근시간 </label>
					<input type="text" id="attStart" size="30">
				</div>
				<div lass="g-col-4">
					<label for="attEnd"> 퇴근시간 </label>
					<input type="text" id="attEnd" size="30">
				</div>
				<div lass="g-col-5">
					<label for="attStatus">
						근무상태 <select id="attStatus">
							<option value="">선택</option>
							<option value="정상 출근">정상 출근</option>
							<option value="지각">지각</option>
							<option value="결근">결근</option>
							<option value="조퇴">조퇴</option>
						</select>
					</label>
				</div> 
			</div>
		</div>
		<!-- <div>
			<input type="button" value="초기화" onclick="fn_init()">
			<input type="button" value="수정하기" id="btn_modify">
		</div> -->
      </div>
      <div class="modal-footer">
     
        <!-- <button type="button" onclick="fn_init()"> 초기화 </button> -->
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal" id="btn_modify">수정 완료</button>
      </div>
    </div>
  </div>
</div> 
	<div class="body_div" style="padding: 25px 0 0 65px;">

		<!-- <h1>근태 페이지</h1>
		<div>
			<input type="hidden" id="attNo" >
			<div>
				<label for="empNo">
					사원번호 <input type="text" id="empNo" readonly>
				</label>
			</div>
			<div>
				<label for="name">
					이름 <input type="text" id="name" readonly>
				</label>
			</div>
			<div>
				<label for="attStart">
					출근시간 <input type="text" id="attStart">
				</label>
			</div>
			<div>
				<label for="attEnd">
					퇴근시간 <input type="text" id="attEnd">
				</label>
			</div>
			<div>
				<label for="attStatus">
					근무상태 <select id="attStatus">
						<option value="">선택</option>
						<option value="정상 출근">정상 출근</option>
						<option value="지각">지각</option>
						<option value="결근">결근</option>
						<option value="조퇴">조퇴</option>
					</select>
				</label>
			</div> 
		</div>
		<div>
			<input type="button" value="초기화" onclick="fn_init()">
			<input type="button" value="수정하기" id="btn_modify">
		</div> -->
		
		<!-- <div>
			<form id="frm_search" >
				<select name="column" id="column">
					<option value="">:::선택:::</option>
					<option value="EMP_NO">사원번호</option>
					<option value="NAME">이름</option>
					<option value="DEPT_NAME">부서명</option>
					<option value="JOB_NAME">직급</option>
					<option value="ATT_STATUS">근무상태</option>
				</select>
				<input type="text" name="query" id="query" >
				<button id="btn_search">조회</button>
			</form>
		</div>
		
		<div>
			<form id="frm_search2" >
				<select name="column" id="column2">
					<option value="">:::선택:::</option>
					<option value="attStart">출근 날짜</option>
					<option value="attEnd">퇴근 날짜</option>
				</select>
				<input type="text" name="start" id="start">
				~
				<input type="text" name="stop" id="stop">
				<span>
					<button id="btn_search2">조회</button>
				</span>
			</form>
		</div> -->
		
		<div>
			<c:if test="${emp.deptNo == 10 && emp.jobNo <= 4}">
				<input type="button" value="선택삭제" id="btn_remove" class="btn btn-danger">
			</c:if> 
			<table border="1">
				<thead>
					<tr>
						<td><input type="checkbox" id="check_all"></td> 
						<td>사원번호</td>
						<td>이름</td>
						<td>부서명</td>
						<td>직급명</td>
						<td>출근시간</td>
						<td>퇴근시간</td>
						<td>근무상태</td>
						<td>근무시간</td>
						<td>연장근무시간</td>
						<td>조퇴 여부</td>
					</tr>
				</thead>
				<tbody id="attendace_list"></tbody>
				<tfoot>
					<tr>
						<td colspan="11">
							<div id="paging"></div>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
		<div>
			<button id="btn_att" class="btn btn-primary">출근</button>
			<button id="btn_leave" class="btn btn-primary">퇴근</button>
		</div>
	</div>
	

</body>
</html>
