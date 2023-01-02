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

#empInfo th{
        height: 70px;
        width: 15%;
        font-size:16px;
    }

hr {
  background-color: #fff;
  padding: 0;
  margin: 30px;
}


.emp-addbox {

  position: absolute;
  top: 50%;
  left: 55%;
  width: 920px;
  padding: 50px;
  transform: translate(-50%, -50%);
  background: #fff;
  box-sizing: border-box;
  box-shadow: 0 15px 25px rgba(0,0,0,.6);
  border-radius: 10px;
  margin-left:auto; 
  margin-right:auto;

}


.addbtn {
 background:#4e73df;
     color:white;
     display:block;
     width:5.5%;
     max-width:680px;
     height:30px;
     border-radius:8px;
     margin:0 auto;
     border:none;
     cursor:pointer;
     font-size:14px;
     font-family: 'Montserrat', sans-serif;
     box-shadow:0 15px 30px rgba(#ffffff,.36);
    transition:.2s linear;
    text-align: center;
    display :inline-block;
  
}

.cancelbtn {
 background:#4e73df;
     color:white;
     display:block;
  	 width:5.5%;
     max-width:680px;
     height:30px;
     border-radius:8px;
     margin:0 auto;
     border:none;
     cursor:pointer;
     font-size:14px;
     font-family: 'Montserrat', sans-serif;
     box-shadow:0 15px 30px rgba(#ffffff,.36);
    transition:.2s linear;
      text-align: center;
    display :inline-block;

}

.addbtn:hover {

background:#324b96;


}

.cancelbtn:hover {

background:#324b96;


}


</style>

<body>
<script>
function choosefile() {
	$("input[name=upfile]").click();
}

function loadImg(inputFile) {
	//console.log(inputFile);
	if(inputFile.files.length == 1) {	// 파일이 선택된 경우
		const reader = new FileReader();
		reader.readAsDataURL(inputFile.files[0]);
		reader.onload = function(e) {
			$("#profileImg").attr("src", e.target.result);
		}
	}else {	// 파일 선택을 취소한 경우 ==> 기본 이미지가 뜨게 
		$("#profileImg").attr("src", "resources/profile_images/defaultProfile.png");
	}
}



	$(function(){
		fn_fileCheck();
		fn_pwCheck();
		fn_pwCheckAgain();
		fn_nameCheck();
		fn_phoneCheck();
		fn_birthyear();
		fn_birthmonth();
		fn_birthdate();
		fn_join();
	});
	
	var idPass = false;
	var pwPass = false;
	var rePwPass = false;
	var namePass = false;
	var phonePass = false;
	var authCodePass = false;
	

	// 2. 비밀번호
	function fn_pwCheck(){
		
		$('#empPw').keyup(function(){
			
			let pwValue = $(this).val();
			
			// 정규식(8~20자, 소문자+대문자+숫자+특수문자8종(!@#$%^&*) 3개 이상 조합)
			let regPw = /^[0-9a-zA-Z!@#$%^&*]{8,20}$/;
			
			// 3개 이상 조합 확인
			let validatePw = /[0-9]/.test(pwValue)        // 숫자가 있으면 true, 없으면 false
			               + /[a-z]/.test(pwValue)        // 소문자가 있으면 true, 없으면 false
			               + /[A-Z]/.test(pwValue)        // 대문자가 있으면 true, 없으면 false
			               + /[!@#$%^&*]/.test(pwValue);  // 특수문자8종이 있으면 true, 없으면 false
			
			// 정규식 및 3개 이상 조합 검사
			if(regPw.test(pwValue) == false || validatePw < 3){
				$('#msg_pw').text('');
				pwPass = false;
			} else {
				$('#msg_pw').text('사용 가능한 비밀번호입니다.');
				pwPass = true;
			}
			               
		});  
		
	}  
	
	// 3. 비밀번호 확인
	function fn_pwCheckAgain(){
		
		$('#re_pw').keyup(function(){
			
			let rePwValue = $(this).val();
			
			if(rePwValue != '' && rePwValue != $('#empPw').val()){
				$('#msg_re_pw').text('비밀번호를 확인하세요.');
				rePwPass = false;
			} else {
				$('#msg_re_pw').text('');
				rePwPass = true;
			}
			
		});  
		
	}  
	
	// 4. 이름
	 function fn_nameCheck(){
		
		$('#name').keyup(function(){
			
			let nameValue = $(this).val();
			
			namePass = (nameValue != '');
			
		}); 
		
	}   
	
	// 5. 휴대전화
	function fn_phoneCheck(){
		
		$('#phone').keyup(function(){
			
			let mobileValue = $(this).val();
			
			// 휴대전화 정규식(010으로 시작, 하이픈 없이 전체 10~11자)
			let regMobile = /^010[0-9]{7,8}$/;
			
			if(regMobile.test(mobileValue) == false){
				$('#msg_mobile').text('휴대전화를 확인하세요.');
				mobilePass = false;
			} else {
				$('#msg_mobile').text('');
				phonePass = true;
			}
			
		}); 
		
	}  
	
	// 6. 생년월일(년도)
	function fn_birthyear(){
		let year = new Date().getFullYear();
		let strYear = '<option value="">년도</option>';
		for(let y = year - 100; y <= year + 1; y++){
			strYear += '<option value="' + y + '">' + y + '</option>';
		}
		$('#birthyear').append(strYear);
	}  
	
	// 7. 생년월일(월)
	function fn_birthmonth(){
		let strMonth = '<option value="">월</option>';
		for(let m = 1; m <= 12; m++){
			if(m < 10){
				strMonth += '<option value="0' + m + '">' + m + '월</option>';
			} else {
				strMonth += '<option value="' + m + '">' + m + '월</option>';
			}
		}
		$('#birthmonth').append(strMonth);
	}  
	
	// 8. 생년월일(일)
	function fn_birthdate(){
		
		$('#birthdate').append('<option value="">일</option>');
		
		$('#birthmonth').change(function(){
			
			$('#birthdate').empty();
			$('#birthdate').append('<option value="">일</option>');
			let endDay = 0;
			let strDay = '';
			switch($(this).val()){
			case '02':
				endDay = 29; break;
			case '04':
			case '06':
			case '09':
			case '11':
				endDay = 30; break;
			default:
				endDay = 31; break;
			}
			for(let d = 1; d <= endDay; d++){
				if(d < 10){
					strDay += '<option value="0' + d + '">' + d + '일</option>';
				} else {
					strDay += '<option value="' + d + '">' + d + '일</option>';
				}
			}
			$('#birthdate').append(strDay);
			
		}); 
		
	}  
	
	
	// 10. 서브밋 (회원가입)
	function fn_join(){
		
		$('#frm_join').submit(function(event){
			
			/* if(idPass == false){
				alert('아이디를 확인하세요.');
				event.preventDefault();
				return;
			} else */ if(pwPass == false || rePwPass == false){
				alert('비밀번호를 확인하세요.');
				event.preventDefault();
				return;
			} else if(namePass == false){
				alert('이름을 확인하세요.');
				event.preventDefault();
				return;
			} else if(phonePass == false){
				alert('휴대전화번호를 확인하세요.');
				event.preventDefault();
				return;
			} else if($('#birthyear').val() == '' || $('#birthmonth').val() == '' || $('#birthdate').val() == ''){
				alert('생년월일을 확인하세요.');
				event.preventDefault();
				return;
			} /* else if(authCodePass == false){
				alert('이메일 인증을 받으세요.');
				event.preventDefault();
				return;
			} */
			
		});  
		
	}  
	function fn_fileCheck(){
		
		$('#files').change(function(){
			
			// 첨부 가능한 파일의 최대 크기
			let maxSize = 1024 * 1024 * 10;  // 10MB
			// 첨부된 파일 목록
			let files = this.files;
			// 첨부된 파일 순회
			$('#file_list').empty();
			$.each(files, function(i, file){
				// 크기 체크
				if(file.size > maxSize){
					alert('10MB 이하의 파일만 첨부할 수 있습니다.');
					$(this).val('');  // 첨부된 파일을 모두 없애줌
					return;
				}
				// 첨부 목록 표시
				$('#file_list').append('<div>' + file.name + '</div>');
			});
		});
	}
	
	
</script>

</head>
<body>
	 <div class="emp-addbox">
 		<h3>직원 등록</h3>
 		 <hr>
 		 
	     	<form id="frm_join" action="${contextPath}/user/join" method="post" enctype="multipart/form-data">
					<table id="empInfo">
						<tr>
							<th width="150px">이름<span style="color:red;">&nbsp;*</span></th>
							<td width="300px">
								<input type="text" class="inputBox" name="name" id="name" required>
							</td>
							
						</tr>
					
						<tr>
							<th>비밀번호<span style="color:red;">&nbsp;*</span></th>
							<td>
								<div>
									<input type="password" id="empPw" name="empPw">
								</div>
									<span id="msg_pw"></span>
							</td>
							

						</tr> 
						

						
						
						<tr>
							<th>비밀번호 확인<span style="color:red;">&nbsp;*</span></th>
							<td>
								<div>
								<input type="password" id="re_pw" name="re_pw">
								</div>
								<span id="msg_re_pw"></span>
							</td>
						
							<th width="150px">프로필 사진</th>
							<td>
								<input type="file" id="files" name="files" multiple="multiple">
							</td>	
							
						</tr>
						
						<tr>
							<th>생년월일</th>
							<td>
								<label for="birthyear"></label>
								<select name="birthyear" id="birthyear"></select>
								<select name="birthmonth" id="birthmonth"></select>
								<select name="birthdate" id="birthdate"></select>

							</td>
			
						<tr>
							<th>부서</th>
							<td>
								<select name="deptNo" id="deptNo" required>
								<option value="">:::부서:::</option>
								<option value="10">인사총무부</option>
								<option value="11">재무회계부</option>
								<option value="12">영업부</option>
								</select>
							</td>
							
							
							<th>직위</th>
							<td>
								<select name="jobNo" id="jobNo" required>
								<option value="">:::직위:::</option>
								<option value="1">대표</option>
								<option value="2">부장</option>
								<option value="3">차장</option>
								<option value="4">과장</option>
								<option value="5">대리</option>
								<option value="6">사원</option>
								</select>
							</td>
							
							</tr>
						<tr>
							<th>연봉</th>
								<td>
									<input type="text" class="inputBox" name="salary" id="salary">
								</td>
						</tr>
						
						<tr>
							<th>휴대전화<span style="color:red;">&nbsp;*</span></th>
							<td>
								<input type="text" id="phone" name="phone">
								<span id="msg_mobile"></span>
							</td>
						</tr>
										
					</table>
					
				<div id="createBtn">	
					<button class=addbtn>등록</button>
					<button class=cancelbtn onclick="history.go(-2)">취소</button>
				</div>
	        </form>
	    </div>
	    

		
		
			<!-- <div>
				<label for="name">이름*</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="text" class="inputBox" name="name" id="name">
			</div>
			
			<div>
				<label for="empPw">패스워드*</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="password" class="inputBox" name="empPw" id="empPw">
				<span id="msg_pw"></span>
			</div>
			
			<br>
			
			<div>
				<label for="re_pw">패스워드 확인*</label>&nbsp;&nbsp;
				<input type="password" class="inputBox" id="re_pw">
				<span id="msg_re_pw"></span>
			</div>
			
			<br>
					
			<div>
				<label for="phone">휴대전화*</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="text" class="inputBox" name="phone" id="phone">
				<span id="msg_mobile"></span>
			</div>
			
			<br>
			
			<div>
				<label for="birthyear">생년월일*</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<select name="birthyear" id="birthyear"></select>
				<select name="birthmonth" id="birthmonth"></select>
				<select name="birthdate" id="birthdate"></select>
			</div>
			
			<br>
				<div>
				<select name="jobNo" id="jobNo">
				<option value="">:::직위:::</option>
				<option value="1">대표</option>
				<option value="2">부장</option>
				<option value="3">차장</option>
				<option value="4">과장</option>
				<option value="5">대리</option>
				<option value="6">사원</option>
				</select>
				</div>

			<br>
				<div>
				<select name="deptNo" id="deptNo">
				<option value="">:::부서:::</option>
				<option value="10">인사총무부</option>
				<option value="11">재무회계부</option>
				<option value="12">영업부</option>
				</select>
				</div>
			<br>
	
			
			<div>
				<label for="salary">연봉</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="text" class="inputBox" name="salary" id="salary">
			</div>
			
			<br>
			
			<div>
				<label for="files">프로필</label>
				<input type="file" id="files" name="files" multiple="multiple">
			</div>
			
			<br>
			
			<div>
			
				<button>가입하기</button>
				<input type="button" value="취소하기" onclick="history.go(-2)">
			</div>
			
		</form>
		
	</div>
 -->

<%@ include file="../layout/footer.jsp" %>