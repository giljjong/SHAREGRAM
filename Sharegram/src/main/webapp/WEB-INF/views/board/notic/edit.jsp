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
	$('#boardContent').summernote({
		placeholder: '내용을 입력하세요.',
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
					url: getContextPath() + '/board/noticImage',
					data: formData,
					contentType: false, 
					processData: false,  
					dataType: 'json',    
					success: function(resData){
						//console.log('-----');
						//console.log(resData);
						$('#boardContent').summernote('insertImage', resData.src);
						
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
	.blind {
		display: none;
	}
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
		
	.noticEdit {
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
	
	.noticEdit {
		/* padding: 60px 0; */
		background: #FFFFFF;
	}
	
	.noticEdit {
		margin-bottom: 60px;
	}
	
	.noticEdit h3 {
		font-size: 20px;
	 	color: #324b96;
	 	font-weight: 800;
	 	text-align: center;
	}
	
	.noticEdit_title {
		font-size: 15px;
	 	color: #324b96;
	 	font-weight: 700;
	}
	
	.noticEdit_content {
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
	
	.boardContent {
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

	<div class="noticEdit">
		<h3>수정페이지</h3>
		
		<form id="frm_notic" action="${contextPath}/board/notic/modify" method="post">
			<input type="hidden" name="noticNo" value="${noticBoard.noticNo}">
				<%-- <div>
					<label for="id"><strong>사원번호</strong></label>
				</div>
				<div>
					<input type="text" name="id" value="${noticBoard.empNo}" size=104 required readonly>
				</div> --%>
			<div class="noticEdit_title">
				<label for="boardTitle"><strong>글제목</strong></label>
			</div>
			<div>
				<input type="text" name="boardTitle"  class="inputBox" size=98 required="required" value="${noticBoard.boardTitle}">
			</div>
			
			<br>
			
			<div>
				<div class="noticEdit_content">
					<label for="boardContent"><strong>내용</strong></label>&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
				<div class="boardContent">
					<textarea name="boardContent" id="boardContent" required="required">${noticBoard.boardContent}</textarea>
				</div>
			</div>
			
			<br>
			<br>
			
			<div align="right">
				<button class="btn_primary" id="btn_edit">수정완료</button>
				<input type="reset" value="입력초기화" class="btn_primary">
				<input type="button" value="목록" onclick="location.href='${contextPath}/board/noticList'" class="btn_primary">
			</div>
		</form>
	</div>

<%@ include file="../../layout/footer.jsp" %>