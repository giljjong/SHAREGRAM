<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

	<jsp:include page="../../layout/header.jsp">
		<jsp:param value="SHAREGRAM" name="title" />
	</jsp:include>
<style>
	.blind {
		display: none;
	}
</style>
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
	
	.uploadDetail {
		position: absolute;
		top: 50%;
		left: 50%;
		height : 750px;
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
	
	.uploadDetail {
		/* padding: 60px 0; */
		background: #FFFFFF;
	}
	
	.uploadDetail {
		margin-bottom: 60px;
	}
	
	.uploadDetail h3 {
	 	color: #324b96;
		font-size: 20px;
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
	
	.uploadEdit_title_box {
		font-size: 14px;
		font-weight: 500;
		background: #d3dcf5;
		border-radius:8px;
		width: 720px;
	 	height: 30px;
	}
	
	.uploadEdit_content_box {
		font-size: 14px;
		font-weight: 500;
		background: #d3dcf5;
		border-radius:8px;
		width: 720px;
		height: 320px;
	}
	
	.uploadEdit_files {
		font-size: 15px;
	 	color: #324b96;
	 	font-weight: 700;
	}
	
	.uploadEdit_attach_box {
		font-size: 14px;
		font-weight: 500;
		background: #d3dcf5;
		border-radius:8px;
		width: 720;
		height: 100;
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
	
	.date {
		font-size: 13px;
	 	ccolor: #324b96;
	 	font-weight: 600;
	 	text-align: right;
	}
	
	.uploadDetail a:link {
		color : #324b96;
	}
	.uploadDetail a:hover {
		color : #141e30;
	}
	.uploadDetail a:visited {
		color : #324b96;
	}
	
	.date {
		font-size: 13px;
	 	color: #324b96;
	 	font-weight: 600;
	 	text-align: right;
	}
</style>

<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>

</head>
<body>

	<div class="uploadDetail">
		<h3>자료실 정보</h3>
			<form>
				<div class="uploadEdit_title">
					<label for="boardTitle"><strong>제목</strong></label>
				</div>	<!-- cntr값 chk -->
					<div class="uploadEdit_title_box">
						${ uploadBoard.boardTitle }
					</div>
				<br>
				<div class="uploadEdit_content">
					<label for="boardContent"><strong>본문</strong></label>
				</div>
					<div class="uploadEdit_content_box">
						${ uploadBoard.boardContent }
					</div>
				<br>
				<div class="uploadEdit_files"> 
					<label for="filesTitle"><strong>첨부자료</strong>&nbsp;&nbsp;<a href="${contextPath}/board/upload/downloadAll?uploadNo=${uploadBoard.uploadNo }">일괄 다운로드</a></label>
				</div>
				<div class="uploadEdit_attach_box">
					<c:forEach items="${attachList}" var="attach">
						<a href="${contextPath}/board/upload/download?attachNo=${attach.attachNo }">
							<c:if test="${attach.hasThumbnail == 1}">
								${attach.origin}<img src="${contextPath}/board/upload/display?attachNo=${attach.attachNo}" class="attach_files" title="${attach.origin}">
							</c:if>
							<c:if test="${attach.hasThumbnail == 0}">
								${attach.origin}<img src="${contextPath}/resources/images/attach.png" width="50px" class="attach_files" title="${attach.origin}">
							</c:if>
						</a>
					</c:forEach>
				</div>
				
				<br>
				
				<div class="date">작성일 : ${ uploadBoard.createDate }</div>
				<div class="date">수정일 : ${ uploadBoard.modifyDate }</div>
				
			</form>
			
		<br>
		
		
<%-- 		<ul>
			<li>제목 : ${ u.boardTitle }</li>
			<li>내용 : ${ u.boardContent }</li>
			<li>작성일 : ${ u.createDate }</li>
			<li>수정일 : ${ u.modifyDate }</li>
		</ul> --%>
		
		<div align="right">
			<form id="frm_upload" method="post">
				<input type="hidden" name="uploadNo" value="${ uploadBoard.uploadNo }">
				<input type="button" value="게시글편집" id="btn_edit" class="btn_primary"> 			
				<input type="button" value="게시글삭제" id="btn_remove" class="btn_primary"> 			
				<input type="button" value="목록" onclick="location.href='${contextPath}/board/uploadList'" class="btn_primary"> 			
			</form>
		</div>
	</div>
	
	<%-- <div>
	
		
		<h3>첨부자료 목록 및 다운로드</h3>
		<div>
			<c:forEach items="${attachList}" var="attach">
				<a href="${contextPath}/board/upload/download?attachNo=${ a.attachNo }">
					<c:if test="${a.hasThumbnail == 1}">
						<img src="${contextPath}/board/upload/display?attachNo=${a.attachNo}" class="attach_files" title="${attach.origin}">
					</c:if>
					<c:if test="${attach.hasThumbnail == 0}">
						<img src="${contextPath}/resources/images/attach.png" width="50px" class="attach_files" title="${attach.origin}">
					</c:if>
				</a>
			</c:forEach>
		</div>
		<br><br>
		<div>
			<a href="${contextPath}/board/upload/downloadAll?uploadNo=${ u.uploadNo }">일괄 다운로드</a>
		</div>
	</div> --%>
	
	
<script>
	$(function(){
		
		// 게시글 수정화면으로 이동
		$('#btn_edit').click(function(event){
			$('#frm_upload').attr('action', '${contextPath}/board/upload/edit');
			$('#frm_upload').submit();
		});
		
		// 게시글 삭제
		$('#btn_remove').click(function(event){
			if(confirm('첨부된 모든 파일이 함께 삭제됩니다. 삭제할까요?')){
				$('#frm_upload').attr('action', '${contextPath}/board/upload/remove');
				$('#frm_upload').submit();
			}
		});
		
		/* // 게시글 목록
		$('#btn_upload_list').click(function(event){
			location.href = '${contextPath}/board/uploadList';
		}); */
		
		// 첨부 이미지에 툴팁 적용
		// 태그의 title 속성 값이 툴팁으로 나타남

		
	});
		
</script>	
<%@ include file="../../layout/footer.jsp" %>