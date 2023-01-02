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


.mypage {

  position: absolute;
  top: 50%;
  left: 55%;
  width: 400px;
  padding: 50px;
  transform: translate(-50%, -50%);
  background: #fff;
  box-sizing: border-box;
  box-shadow: 0 15px 25px rgba(0,0,0,.6);
  border-radius: 10px;
  margin-left:auto; 
  margin-right:auto;
}


hr {
  background-color: #fff;
  padding: 0;
  margin: 30px;
  
  }



th {
  text-align: left;
}

 td, th {
  padding: 1em .5em;
  vertical-align: middle;
  text-align: center;
}
  
  
}



</style>

<script>

$(function(){
	fn_init();
	fn_pwCheck();
	fn_pwCheckAgain();
	fn_pwSubmit();
	fn_leave();
	fn_mobileCheck();
	fn_emailCheck();
	fn_modify();
});

var empPwPass = false;
var reempPwPass = false;

/* function fn_showHide(){
	
	$('#modify_pw_area').hide();
	
	$('#btn_edit_pw').click(function(){
		fn_init();
		$('#modify_pw_area').show();
	});
	
	$('#btn_edit_pw_cancel').click(function(){
		fn_init();
		$('#modify_pw_area').hide();
	});
	
} */


function fn_init(){
	$('#empPw').val('');
	$('#re_empPw').val('');
	$('#msg_pw').text('');
	$('#msg_re_pw').text('');
}

function fn_pwCheck(){
	
	$('#empPw').keyup(function(){
		
		let pwValue = $(this).val();
		
		let regPw = /^[0-9a-zA-Z!@#$%^&*]{8,20}$/;
		
		let validatePw = /[0-9]/.test(pwValue)        // 숫자가 있으면 true, 없으면 false
		               + /[a-z]/.test(pwValue)        // 소문자가 있으면 true, 없으면 false
		               + /[A-Z]/.test(pwValue)        // 대문자가 있으면 true, 없으면 false
		               + /[!@#$%^&*]/.test(pwValue);  // 특수문자8종이 있으면 true, 없으면 false
		
		if(regPw.test(pwValue) == false || validatePw < 3){
			$('#msg_pw').text('8~20자의 소문자, 대문자, 숫자, 특수문자(!@#$%^&*)를 3개 이상 조합해야 합니다.');
			empPwPass = false;
		} else {
			$('#msg_pw').text('사용 가능한 비밀번호입니다.');
			empPwPass = true;
		}
		               
	});
	
}

function fn_pwCheckAgain(){
	
	$('#re_empPw').keyup(function(){
		
		let rePwValue = $(this).val();
		
		if(rePwValue != '' && rePwValue != $('#empPw').val()){
			$('#msg_re_pw').text('비밀번호를 확인하세요.');
			reempPwPass = false;
		} else {
			$('#msg_re_pw').text('');
			reempPwPass = true;
		}
		
	});
	
}

function fn_pwSubmit(){
	
	$('#frm_edit_pw').submit(function(event){
		
		if(empPwPass == false || reempPwPass == false){
			alert('비밀번호 입력을 확인하세요.');
			event.preventDefault();
			return;
		}
		
	});
	
}

function fn_leave(){
	
	$('#btn_retire').click(function() {
		if(confirm('탈퇴하시겠습니까?')){
			$('#lnk_retire').submit();
					
		}
	});
		
	
}

function fn_mobileCheck(){
	
	$('#phone').keyup(function(){
		
		let phoneValue = $(this).val();
		
		// 휴대전화 정규식(010으로 시작, 하이픈 없이 전체 10~11자)
		let regPhone = /^010[0-9]{7,8}$/;
		
		if(regPhone.test(phoneValue) == false){
			$('#msg_mobile').text('휴대전화를 확인하세요.');
			phonePass = false;
		} else {
			$('#msg_mobile').text('');
			phonePass = true;
		}
		
	}); 
	
}  

function fn_emailCheck(){
	
	$('#email').keyup(function(){
		
		let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+(\.[a-zA-Z]{2,}){1,2}$/;
		
		let emailValue = $('#email').val();
		
		if(regEmail.test(emailValue) == false){
			$('#msg_email').text('이메일 형식이 올바르지 않습니다.');
			emailPass = false;
			return;     
		}
		
		// 이메일 중복 체크
		$.ajax({
			/* 요청 */
			type: 'get',
			url: '${contextPath}/user/checkReduceEmail',
			data: 'email=' + $('#email').val(),
			/* 응답 */
			dataType: 'json',
			success: function(resData){
				if(resData.isUser){
					$('#msg_email').text('이미 사용중인 이메일입니다.');
					emailPass = false;
				} else {
					$('#msg_email').text('사용 가능한 이메일입니다.');
					emailPass = true;
				}
			}
		});  
		
	});  
	
}  

function fn_modify(){
	$('#btn_modify').on('click', function(){
		$('#frm_pw_modify').submit();
	});
}	


function fn_dormantUser(){
	$(document).on('click', '.btn_retire', function(){
	/* 	id = $(this).parent().parent().children().first().next().text();
		 */
		if(confirm('회원을 휴면 회원으로 전환 하시겠습니까?')){
			
		/* 	if($(this).parent().prev().hasClass('sleepUser')) {
				alert('이미 휴면 회원입니다.');
				event.preventDefault();
				return;
				
			} else { */
				
				$.ajax({
					type : 'post',
					url : '${contextPath}/user/empNo',
					data : 'empNo=' +  $(this).data('emp_no'),
					dataType : 'json',
					success : function(resData){
						alert(resData.message);

					}
				});
			//};
		};
	});
};

	let employeesNo = 0;
	function fn_detail(){
	$(document).on('click', '.btn_detail', function(){
		//console.log($('#exampleModal').modal('toggle'));
		employeesNo = $(this).data('emp_no'); 
	});
}

</script>




</head>
<body>
<!-- Button trigger modal -->
<!-- Button trigger modal -->

<!-- Modal -->
<div class="modal fade exampleModal" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" >
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">비밀번호 변경</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form action="${contextPath}/user/modify/pw" id="frm_pw_modify" method="post">
      <div class="modal-body">
	      <div>
			<label for="empPw">비밀번호</label>
			<input type="password" name="empPw" id="empPw">
			<span id="msg_pw"></span>
		</div>
		
		<!-- 비밀번호 재확인 -->
		<div>
			<label for="re_empPw">비밀번호 확인</label>
			<input type="password" id="re_empPw">
			<span id="msg_re_pw"></span>
		</div>
	    
	      </div>
	      <div class="modal-footer">
	     
	        <!-- <button type="button" onclick="fn_init()"> 초기화 </button> -->
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	        <button type="button" class="btn btn-primary" data-dismiss="modal" id="btn_modify">수정 완료</button>
	      </div>
      </form>
    </div>
  </div>
</div> 
      


<div class="mypage">
	<h3>마이 페이지</h3>
	 <hr>
	<form id="frm_edit" action="${contextPath}/user/modify/info" method="post">
		<table id="myInfo">
	<tr>
		<td>
			<div class="img">
				<img src="${contextPath}/resources/images/defaultProfile.png" width="150px">		
			</div>
		</td>
	<tr>		
		<tr>
			<th style="width:20%;">이름</th>
			<td>${loginEmp.name}</td>
		</tr>
		
		<tr>
			<th>아이디</th>
			<td>${loginEmp.empNo}</td>
		</tr>
		
		<tr>
			<th>비밀번호</th>
			<td>
			<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
			  수정
			</button>
		<%-- 	<input type="button" value="또로롱" class="btn_detail" data-emp_no="${emp.empNo}"></td> --%>
		</tr>
		
		<tr>
			<th style="width:30%;">휴대전화</th>
			<td>${loginEmp.phone}</td>
		</tr>
		
		<tr>
			<th style="width:30%;">부서</th>
			<td>
				<c:if test="${loginEmp.deptNo == 10}">
					인사총무부
				</c:if>
				<c:if test="${loginEmp.deptNo == 11}">
					재무회계부
				</c:if>
				<c:if test="${loginEmp.deptNo == 12}">
					영업부
				</c:if>
			</td>
		</tr>
		
		<tr>
			<th style="width:30%;">직위</th>
			<td>
				<c:if test="${loginEmp.jobNo == 1}">
					대표
				</c:if>
				<c:if test="${loginEmp.jobNo == 2}">
					부장
				</c:if>
				<c:if test="${loginEmp.jobNo == 3}">
					차장
				</c:if>
				<c:if test="${loginEmp.jobNo == 4}">
					과장
				</c:if>
				<c:if test="${loginEmp.jobNo == 5}">
					대리
				</c:if>
				<c:if test="${loginEmp.jobNo == 6}">
					사원
				</c:if>
			</td>
		</tr>
		
		<tr>
			<th>입사일</th>
			<td>${loginEmp.joinDate}</td>
		</tr>
		
	</table>
	
	<div id="prof-body">
		<table id="profiletbale">
		
		
		
		</table>
	
	
	</div>
	
	
	
	
	

</form>

 </div>







	<%-- <div id="modify_pw_area">
		<form id="frm_edit_pw" action="${contextPath}/user/modify/pw" method="post">
			<!-- 비밀번호 -->
			<div>
				<label for="empPw">비밀번호</label>
				<input type="password" name="empPw" id="empPw">
				<span id="msg_pw"></span>
			</div>
			
			<!-- 비밀번호 재확인 -->
			<div>
				<label for="re_empPw">비밀번호 확인</label>
				<input type="password" id="re_empPw">
				<span id="msg_re_pw"></span>
			</div>
			
			<div>
				<button>비밀번호변경하기</button>
				<input type="button" value="취소하기" id="btn_edit_pw_cancel">
			</div>
		</form>
	</div>
		<form id="frm_edit" action="${contextPath}/user/modify/info" method="post">
			<div>
				<label for="phone">휴대전화</label>
				<input type="text" name="phone" id="phone" value="${loginEmp.phone}">
				<span id="msg_mobile"></span>
			</div>
			
			 <div>
				<label for="email">이메일</label>
				<input type="text" name="email" id="email" value="${loginUser.email}">
				<span id="msg_email"></span>
			</div>
			 
			<hr>
			
			<div>
				<input type="button" value="변경하기" id="btn_modify">
				<input type="button" value="취소하기" onclick="history.go(-2)">
			</div>
		</form>
</div>
 --%>
<%@ include file="../layout/footer.jsp" %>