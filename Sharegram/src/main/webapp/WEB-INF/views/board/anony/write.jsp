<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

	<jsp:include page="../../layout/header.jsp">
		<jsp:param value="SHAREGRAM" name="title" />
	</jsp:include>
	
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<link rel="stylesheet" href="${contextPath}/resources/summernote-0.8.18-dist/summernote-lite.min.css">
<script src="${contextPath}/resources/summernote-0.8.18-dist/summernote-lite.min.js"></script>
<script src="${contextPath}/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>


<script>
function getContextPath() {
	var begin = location.href.indexOf(location.origin) + location.origin.length;
	var end = location.href.indexOf("/", begin + 1);
	return location.href.substring(begin, end);
}
	
$(document).ready(function(){
	
	// 써머노트
	$('#anonyContent').summernote({
		placeholder: '도배글, 음란성 글, 욕설, 지나친 인신공격성 글, 지역감정을 조장하는 글은 <br> 사내 게시판 규정 운영원칙에 의거하여 삭제 될 수 있습니다. <br> <br> ※ 주민번호, 핸드폰번호, 이메일 등 개인정보가 포함된 내용의 글은 등록을 삼가 주세요.',
		tabsize: 2,
		width: 720,
		height: 355,
		lang: 'ko-KR',
		fontsize: 12,
		toolbar: [
			// [groupName, [list of button]]
		    ['fontname', ['fontname']],
		    ['fontsize', ['fontsize']],
		    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
		    ['color', ['forecolor','color']],
		    ['table', ['table']],
		    ['para', ['ul', 'ol', 'paragraph']],
		    ['height', ['height']],
		   	/*  ['insert',['picture','link','video']], */
		    /* ['view', ['fullscreen', 'help']] */
		],
		callbacks: {
			onImageUpload: function(files){
				// 동시에 복수 이미지 업로드 가능
				for(let i = 0; i < files.length; i++) {
				var formData = new FormData();
				formData.append('file', files[i]);  
				}
				$.ajax({
					type: 'post',
					url: getContextPath() + '/board/anonyImage',
					data: formData,
					contentType: false, 
					processData: false,  
					dataType: 'json',    
					success: function(resData){
						//console.log('-----');
						//console.log(resData);
						$('#anonyContent').summernote('insertImage', resData.src);
						
						$('#summernote_image_list').append($('<input type="hidden" name="summernoteImageNames" value="' + resData.filesystem + '">'))
					}
				}); // ajax
				} //for
			}  
		})  
	});
</script>

<style>
        @import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css');
</style>
<style>
	html {
	  height: 100%;
	}
	body {
	  	margin:0;
	  	padding:0;
	  	font-family: sans-serif;
	  	background: linear-gradient(#4e73df, #f8f9fc);
	}
	
	.anonyWrite {
		position: absolute;
		top: 50%;
		left: 50%;
		width: 800px;
		padding: 40px;
		transform: translate(-50%, -50%);
		background: rgba(0,0,0,.5);
		box-sizing: border-box;
		box-shadow: 0 15px 25px rgba(0,0,0,.6);
		border-radius: 10px;	
	}

	table {
	  	border-collapse: collapse;
	  	border-spacing: 0;
	}
	
	.anonyWrite {
		/* padding: 60px 0; */
		background: #FFFFFF;
	}
	
	.anonyWrite {
		margin-bottom: 60px;
	}
	
	.anonyWrite h3 {
		font-size: 20px;
	 	color: #324b96;
	 	font-weight: 800;
	 	text-align: center;
	}
	
	.anonyWrite_title {
		font-size: 15px;
	 	color: #324b96;
	 	font-weight: 700;
	}
	
	.anonyWrite_content {
		font-size: 15px;
	 	color: #324b96;
	 	font-weight: 500;
	}
	
	.inputBox {
		font-family: 'Montserrat', sans-serif;  /* 폰트 상속 */
		border-radius: 8px;  
		-webkit-appearance: none;  /* 브라우저별 기본 스타일링 제거 */
		-moz-appearance: none;
		appearance: none;
		height:30px;
		width: 720;
		background: #d3dcf5;
		font-size: 14px;
		font-weight: 500;
	}	
	
	.anonyContent {
		border-radius:8px;
		font-size: 14px;
		font-weight: 500;
		background: #d3dcf5;
		width: 720;
		height: 400;
	}
	
	.btn_primary {
		 background:#4e73df;
	     color:white;
	     height:25px;	/* 버튼 높이(크기) 조정 */
	     border-radius:8px;
	     /* margin:0 auto; 버튼 가운데 정렬*/
	     margin-right: 5px;   /* 버튼 사이 간격 조정 */
	     border:none;
	     cursor:pointer;
	     font-size:13px;
	     font-weight: 600;
	     font-family: 'Montserrat', sans-serif;
	     box-shadow:0 15px 30px rgba(#ffffff,.36);
	     transition:.2s linear;
	}
	
	.btn_primary:hover {
		background:#324b96;  /* RGB 70 115 163 */
	}
	
</style>

<body>
		<div class="anonyWrite">
			<h3>익명글 작성</h3>
			
				<form action="${contextPath}/board/anony/add" method="post" enctype="multipart/form-data">
						<input type="hidden" name="empNo" value="${ emp.empNo }" > <!--나중에 처리  -->
					<div class="anonyWrite_title">
						<label for="anonyTitle"><strong>글제목</strong></label>
					</div>
					<div>
						<input type="text" name="anonyTitle" placeholder="제목은 필수입니다." class="inputBox" size=99 required="required">
					</div>
					<br>
					<div>
						<div class="anonyWrite_content">
							<label for="anonyContent"><strong>내용</strong></label>&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
						<div class="anonyContent">
							<textarea name="anonyContent" id="anonyContent" required="required">${ anonyBoard.anonyContent }</textarea>
						</div>
					</div>

					<br>
					<br>
					
					<div align="right">
						<button class="btn_primary">작성완료</button>
						<input type="reset" value="입력초기화" class="btn_primary">
						<input type="button" value="목록" onclick="location.href='${contextPath}/board/anonyList'" class="btn_primary">
					</div>
				</form>
		</div>
<%@ include file="../../layout/footer.jsp" %>