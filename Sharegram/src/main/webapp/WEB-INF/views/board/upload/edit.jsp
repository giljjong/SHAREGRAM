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
		
	.uploadEdit {
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
	
	.uploadEdit {
		/* padding: 60px 0; */
		background: #FFFFFF;
	}
	
	.uploadEdit {
		margin-bottom: 60px;
	}
	
	.uploadEdit h3 {
		font-size: 20px;
	 	color: #324b96;
	 	font-weight: 800;
	 	text-align: center;
	}
	
	.uploadEdit_title {
		font-size: 15px;
	 	color: #324b96;
	 	font-weight: 700;
	}
	
	.uploadEdit_content {
		font-size: 15px;
	 	color: #324b96;
	 	font-weight: 500;
	}
	
	.uploadEdit_files {
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
		width: 720px;
		background: #d3dcf5;
		font-size: 14px;
		font-weight: 500;
	}	
	
	.boardContent {
		border-radius:8px;
		font-size: 14px;
		font-weight: 500;
		background: #d3dcf5;
		width: 720px;
		height: 440px;
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


</head>
<body>
	
		<div class="uploadEdit">
			<h3>수정페이지</h3>
			
			<form action="${contextPath}/board/upload/modify" method="post" enctype="multipart/form-data">
						
				<input type="hidden" name="uploadNo" value="${ uploadBoard.uploadNo }">
				
				<div class="uploadEdit_title">
					<label for="boardTitle"><strong>글제목</strong></label>
				</div>
				<div>
					<input type="text" id="boardTitle" name="boardTitle" class="inputBox" size=98 required="required" value="${ uploadBoard.boardTitle }">
				</div>
				
				<br>
				
				<div>
					<div class="uploadEdit_content">
						<label for="boardContent"><strong>내용</strong></label>&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
					<div class="boardContent">
						<textarea name="boardContent" id="boardContent" required="required">${ uploadBoard.boardContent }</textarea>
					</div>
				</div>
				
				<br>
				<br>
				
				<div class="uploadEdit_files">
					<label for="files"><strong>첨부 추가</strong></label>
					<div>
						<input type="file" id="files" name="files" multiple="multiple" class="btn_primary">
					</div>
				</div>
			
			
				<%-- <div>
					<h3>첨부삭제</h3>	
					<c:forEach items="${attachList}" var="attach">
						<div>
							${attach.origin}<a class="lnk_remove_attach" href="${contextPath}/board/upload/attach/remove?uploadNo=${ u.uploadNo }&attachNo=${attach.attachNo}"><i class="fa-regular fa-trash-can"></i></a>
						</div>
					</c:forEach>
				</div> --%>
				
				<br>
				<br>
				
				<div align="right">
					<button class="btn_primary" id="btn_edit">수정완료</button>
					<input type="reset" value="입력초기화" class="btn_primary">
					<input type="button" value="목록" onclick="location.href='${contextPath}/board/uploadList'" class="btn_primary">
				</div>
				
			</form>
		</div>
	



<script>
	$(function(){
		fn_upload_list();
		fn_upload_edit();
		fn_swtichDownloadList();
		// fn_editList();
		// fn_uploadRemove();
		// fn_download();
		$('#attachList').hide();
		$('#allDownload').hide();
		fn_fileCheck();
		fn_removeAttach();
	})
	
	
	function fn_editList(){
		$.ajax({
			type : 'GET',
			url : '${contextPath}/board/upload/detail?uploadBoardNo=${uploadBoardNo}' ,
			dataType : 'json',
			success : function(resData){
				$('<ul>')
				 .append( $('<li>').text('사원번호 : ' + resData.u.uploadEmpNo) )
				 .append( $('<li>').text('제목 : ' + resData.u.uploadTitle) )
				 .append( $('<li>').text('내용 : ' + resData.u.uploadContent) )
				 .append( $('<li>').text('작성일 : ' + resData.u.createDate) )
				 .append( $('<li>').text('수정일 : ' + resData.u.modifyDate) )
				 .append( $('<li>').text('조회수 : ' + resData.u.hit) ) 
				 .appendTo('#uploadDetail'); 
				
				/* hidden처리 삭제예정 */
				if('${loginUser.empNo}' != resData.upload.empNo){
					$('#btn_upload_edit').hide();
					$('#btn_upload_remove').hide();
				} else {
					$('#btn_upload_edit').show();
					$('#btn_upload_remove').show();
				}
				if(resData.attachList.length == 0){
					$('#btn_download_list').hide();
				}
				
				 $.each(resData.attachList, function(i, attach){
					 $('<ul>')
					 .append( $('<li>').append( $('<a>').text(attach.origin).attr('href', '${contextPath}.board/upload/download?attachNo=' + attach.attachNo)   ) )
					 .appendTo('#attachList');
				 })
				 
					 $('<a>')
					 .text('전체 다운로드').attr('href', '${contextPath}/upload/downloadAll?uploadBoardNo=' + resData.upload.uploadBoardNo)
					 .appendTo('#allDownload'); 					
				  
			},
			error : function(jqXHR){
				alert('상세보기 실패');
			}
			
		}) 
	}
	
	// 업로드 게시글 삭제 (alert 변경 고려중)
	/* function fn_uploadRemove(){
		$('#btn_upload_remove').click(function(){
			if(confirm('첨부된 모든 자료가 삭제됩니다. 삭제하시겠습니까?')){
				$.ajax({
					type : 'POST',
					url : '${contextPath}/upload/remove',
					data : 'uploadBoardNo=' + ${uploadBoardNo} ,
					success : function (resData){
						alert('삭제가 성공했습니다.');
						location.href="${contextPath}/board/uploadList";
					}, 
					error : function (jqXHR){
						alert('삭제가 실패했습니다.');
						history.back();
					}
				})
			}
	   	}); 
	} 
	*/
	function fn_swtichDownloadList(){
		$('#btn_download_list').click(function(){
				$('#download_area').toggleClass('blind');				
		});
	}
	
	function fn_upload_edit(){
		$('#btn_upload_edit').click(function(){
			$('#frm_upload').attr('action', '${contextPath}/upload/edit?uploadBoardNo=${uploadBoardNo}');
			$('#frm_upload').submit();
		});
	}
	
	function fn_upload_list(){
		$('#btn_upload_list').click(function(){
			location.href='${contextPath}/board/uploadList';
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
	
	function fn_removeAttach(){
		// 첨부 삭제
		$('.lnk_remove_attach').click(function(event){
			if(confirm('첨부한 파일을 삭제할까요?') == false){
				event.preventDefault();
				return;
			}
		});
	}
		
</script>

<%@ include file="../../layout/footer.jsp" %>