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
		
		body {
		  	margin:0;
		  	padding:0;
		  	font-family: sans-serif;
		  	background: linear-gradient(#4e73df, #f8f9fc);
		}
	
	.noticDetail {
		position: absolute;
		top: 50%;
		left: 50%;
		width: 800px;
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
	
	.noticDetail {
		/* padding: 60px 0; */
		background: #FFFFFF;
	}
	
	.noticDetail {
		margin-bottom: 60px;
	}
	
	.noticDetail h3 {
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
	
	.noticEdit_title_box {
		font-size: 14px;
		font-weight: 500;
		background: #d3dcf5;
		border-radius:8px;
		width: 720px;
	 	height: 30px;
	}
	
	.noticEdit_content_box{
		font-size: 14px;
		font-weight: 500;
		background: #d3dcf5;
		border-radius:8px;
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
	
	.date {
		font-size: 13px;
	 	color: #324b96;
	 	font-weight: 600;
	 	text-align: right;
	}
</style>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<!-- <script>
	$(function(){
		
		$('#edit_area').hide();  // 편집영역 숨기기
		
		$('#btn_edit').click(function(){
			$('#edit_area').show();    // 편집영역 보여주기
			$('#detail_area').hide();  // 상세영역 숨기기
		});
		
	});
</script>
 -->
</head>
<body>

	<div class="noticDetail">
		<h3>전사공지 정보</h3>
		
			<form>
				<div class="noticEdit_title">
					<label for="boardTitle"><strong>제목</strong></label>
				</div>	<!-- cntr값 chk -->
					<div class="noticEdit_title_box">
						${ noticBoard.boardTitle }
					</div>
				<br>
				<div  class="noticEdit_content">
					<label for="boardContent"><strong>본문</strong></label>
				</div>
					<div class="noticEdit_content_box">
						${ noticBoard.boardContent }
					</div>
				<br>
				<div class="date">작성일 : ${ noticBoard.createDate }</div>
				<div class="date">수정일 : ${ noticBoard.modifyDate }</div>
				<br>
			</form>
		<div align="right">
			<form id="frm_notic" method="post">
			<%-- <c:if></c:if> 작성자 혹은 관리자만 삭제할 수 있도록 수정필요 --%>
				<input type="hidden" name="noticNo" value="${ noticBoard.noticNo }"><!-- onclick get 방식처리 됨으로 수정 -->
				<input type="button" value="게시글편집" id="btn_edit" class="btn_primary"> 			
				<input type="button" value="게시글삭제" id="btn_remove" class="btn_primary"> 			
				<input type="button" value="목록" onclick="location.href='${contextPath}/board/noticList'" class="btn_primary"> 			
			</form>
				
			<script>
			$(document).ready(function(){
				
				var frm = $('#frm_notic');
				// 편집화면으로 이동
				$('#btn_edit').click(function(){
					frm.attr('action', '${contextPath}/board/notic/edit');
					frm.submit();
				})
				
				// 삭제
				$('#btn_remove').click(function(){
					if(confirm('해당 글을 삭제하시겠습니까? 데이터 삭제시 복구가 불가능합니다.')){
						frm.attr('action', '${contextPath}/board/notic/remove');
						frm.submit();
						return;
					}
				});
				
			});
				
			</script>
		
			
			<!-- <script>
				// 게시글 수정화면으로 이동
				$('#btn_edit').click(function(){
					$('#frm_notic').attr('action', '${contextPath}/board/notic/edit');
					$('#frm_notic').submit();
				});
				
				// 게시글 삭제
				$('#btn_remove').click(function(){
					if(confirm('게시글 삭제 후 복구는 불가능합니다. 삭제할까요?')){
						$('#frm_notic').attr('action', '${contextPath}/board/notic/remove');
						$('#frm_notic').submit();
						return;
					}
				});
			</script> -->
		</div>
	</div>
	
<%-- 	<div id="edit_area">
		<form action="${contextPath}/board/notic/modify" method="post">
			<div>
				<label for="boardTitle">제목</label>
				<input type="text" id="boardTitle" name="boardTitle" value="$ noticBoard.boardTitle }">
			</div>
			<div>
				<label for="boardContent">내용</label><br>
				<textarea id="boardContent" name="boardContent" rows="5" cols="30">${ noticBoard.boardContent }</textarea>
			</div>
			<div>
				<input type="hidden" name="noticNo" value="${ noticBoard.noticNo }">
				<button>게시글편집</button>
				<input type="reset" value="입력초기화">
				<input type="button" value="목록" onclick="${contextPath}/board/noticList'">
			</div>
		</form>
	</div> --%>
	
<%@ include file="../../layout/footer.jsp" %>