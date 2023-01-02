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
	
	#btn_anonycomment_list {
		color:  #324b96;
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
	
	.anonyDetail {
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
	
	.anonyDetail {
		/* padding: 60px 0; */
		background: #FFFFFF;
	}
	
	.anonyDetail {
		margin-bottom: 60px;
	}
	
	.anonyDetail h3 {
		font-size: 20px;
	 	color: #324b96;
	 	font-weight: 800;
	 	text-align: center;
	}
	
	.anonyEdit_title {
		font-size: 15px;
	 	color: #324b96;
	 	font-weight: 700;
	}
	
	.anonyEdit_content {
		font-size: 15px;
	 	color: #324b96;
	 	font-weight: 500;
	}
	
	.anonycomment_font {
		font-size: 16px;
	 	color: #324b96;
	 	font-weight: 700;
	}
	
	.anonycomment_count {
		font-size: 16px;
	 	color: #324b96;
	 	font-weight: 400;
	}
	
	.anonyEdit_title_box {
		font-size: 14px;
		font-weight: 500;
		background: #d3dcf5;
		border-radius:8px;
		width: 720px;
	 	height: 30px;
	}
	
	.anonyEdit_content_box{
		font-size: 14px;
		font-weight: 500;
		background: #d3dcf5;
		border-radius:8px;
		width: 720px;
		height: 280px;
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
	
	.inputBox {
		ffont-family: 'Montserrat', sans-serif;  /* 폰트 상속 */
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
</style>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>

</head>
<body>

	<div class="anonyDetail">
		<h3>익명게시글 정보</h3>
		
			<form>
				<div class="anonyEdit_title">
					<label for="anonyTitle"><strong>제목</strong></label>
				</div>	<!-- cntr값 chk -->
					<div class="anonyEdit_title_box">
						${ anonyBoard.anonyTitle }
					</div>
				<br>
				<div  class="anonyEdit_content">
					<label for="anonyContent"><strong>본문</strong></label>
				</div>
					<div class="anonyEdit_content_box">
						${ anonyBoard.anonyContent }
					</div>
				<br>
				<div class="date">작성일 : ${ anonyBoard.createDate }</div>
				<br>
			</form>
			
			<br>
			
		<div align="right">
			<form id="frm_edit" method="post">
				<input type="hidden" name="anonyNo" value="${ anonyBoard.anonyNo }"><!-- onclick get 방식처리 됨으로 수정 -->
				<input type="button" value="게시글삭제" id="btn_remove" class="btn_primary"> 			
				<input type="button" value="목록" onclick="location.href='${contextPath}/board/anonyList'" class="btn_primary"> 			
			</form>
				
			<input type="hidden" id="anonyEmpNo" value="${anonyBoard.empNo}">
				
			<script>
			$(document).ready(function(){
				
				var frm = $('#frm_edit');
				
				// 삭제
				$('#btn_remove').click(function(){
					if(confirm('해당 글을 삭제하시겠습니까? 데이터 삭제시 복구가 불가능합니다.')){
						frm.attr('action', '${contextPath}/board/anony/remove');
						frm.submit();
						return;
					}
				});
			});	
			</script>
		</div>	
		
		<hr>
		
		<span id="btn_anonycomment_list" class="anonycomment_font">
			댓글
			<span id="anonycomment_count" class="anonycomment_count"></span>
		</span>
		
		<hr>
	
		<div id="anonycomment_area" class="text">
			<div id="anonycomment_list"></div>
			<div id="paging"></div>
		</div>
		
		<hr>
		
		<br>
		<div style="margin-top : -25px;">
			<form id="frm_add_anonycomment">
				<div class="add_anonycomment">
					<div class="add_anonycomment_input">
							<input type="text" name="content" id="content" class="inputBox" size=85 placeholder=" 댓글 작성 후 수정 및 삭제가 불가합니다.">
<!-- 						<div class="add_anonycomment_btn"> -->
							<%-- <c:if test="${loginUser != null}"> 합치고 수정--%>
								&nbsp; <input type="button" value="댓글작성" id="btn_add_anonycomment" class="btn_primary">
							<%-- </c:if> --%>
						<!-- </div> -->
					</div>
				</div>
				<input type="hidden" name="anonyNo" value="${anonyBoard.anonyNo}">
				<%-- <input type="hidden" name="userNo" value="${loginUser.userNo}"> 합치고 수정 --%>
			</form>
				<input type="hidden" id="empNo" name="empNo" value="${loginEmp.empNo}">
		</div>
		
		<script>
			fn_anonyCommentCount();
			fn_switchAnonycommentList();
			fn_addAnonyComment();
			fn_anonyCommentList();
			fn_changePage();
			fn_removeAnonycomment();
			
			function fn_anonyCommentCount(){
				$.ajax({
					type: 'get',
					url: '${contextPath}/anonycomment/getCount',
					data: 'anonyNo=' + $('#anonyNo').val(),
					dataType: 'json',
					success: function(resData){  // resData = {"commentCount": 개수}
						$('#anonycomment_count').text(resData.commentCount);
					}
				});
			}
			
			
			function fn_switchAnonycommentList(){
				$('#btn_anonycomment_list').click(function(){
					$('#anonycomment_area').toggleClass('blind');
				});
			}
			

			function fn_addAnonyComment(){
				$('#btn_add_anonycomment').click(function(){

					$.ajax({
						type: 'post',
						url: '${contextPath}/anonycomment/add',
						data: $('#frm_add_anonycomment').serialize(),
						dataType: 'json',
						success: function(resData){  // resData = {"isAdd", true}
							if(resData.isSuccess){
								alert('댓글이 등록되었습니다.');
								$('#content').val('');
								fn_anonyCommentList();   // 댓글 목록 가져와서 뿌리는 함수
								fn_anonyCommentCount();  // 댓글 목록 개수 갱신하는 함수
							}
						}
					});
				});
			}
			

			function fn_anonyCommentList(){
				console.log ('댓글동작')
				$.ajax({
					type: 'get',
					url: '${contextPath}/anonycomment/list',
					data: 'anonyNo=' + $('#anonyNo').val() + '&page=' + $('#page').val(),
					dataType: 'json',
					success: function(resData){
						console.log (resData)
					
						// 화면에 댓글 목록 뿌리기
						$('#anonycomment_list').empty();
						// moment.locale('ko-KR');  function(i, anonycomment)
						$.each(resData.commentList, function(i, comment){
							//console.log(comment)
							var div = '';
							if(comment.state == -1) {
								if(comment.depth == 0) {
									div += '<div>삭제된 댓글입니다.</div>';
								} else {
									div += '<div style="margin-left: 40px;">삭제된 답글입니다.</div>';
								}
							} else {
								if(comment.depth == 0) {
									div += '<div>';
								} else {
									div += '<div style="margin-left:40px;">';
								}
									div += '<span class="anonycomment_empNo" style="margin-left: 10px;"> 사원번호 : ' + comment.empNo + '</span>';
									div += '<div class="anonycomment_content" style="margin-left: 30px;"> <i class="fa-regular fa-comment-dots"></i> &nbsp;' + anonycomment.content + '</div>';
								/* if('${loginUser.userNo}' != '') {
									if('${loginUser.userNo}' == comment.user.userNo && comment.state == 1) {
										div += '<input type="button" value="삭제" class="btn_anonycomment_remove" data-comment_no="' + comment.commentNo + '">';
									} else if('${loginUser.userNo}' != comment.user.userNo && comment.depth == 0) {
										div += '<input type="button" value="답글" class="btn_reply_area">';
									}
								} 합치고 나서 수정 */
								div += '</div>';
							}
							div += '<div style="margin-left: 40px;" class="reply_area blind">';
							div += '<form class="frm_reply">';
							div += '<input type="hidden" name="commentNo" value="' + comment.commentNo + '">';
							div += '<input type="hidden" name="groupNo" value="' + comment.groupNo + '">';
							/* div += '<input type="hidden" name="userNo" value="${loginUser.userNo}">';
							div += '<input type="text" name="content" placeholder="답글을 작성하려면 로그인을 해주세요">';
							if('${loginUser.userNo}' != '') {
								div += '<input type="button" value="답글작성완료" class="btn_reply_add">';
							}
							div += '</form>'; 합치고 수정*/
							div += '</div>';
							$('#anonycomment_list').append(div);
							$('#anonycomment_list').append('<div style="border-bottom: 1px dotted gray;"></div>');
						});
						// 페이징
						$('#paging').empty();
						var pageUtil = resData.pageUtil;
						var paging = '<div>';
						// 이전 블록
						if(pageUtil.beginPage != 1) {
							paging += '<span class="lnk_enable" data-page="' + (pageUtil.beginPage - 1) + '">◀</span>';
						}
						
						// 페이지번호
						// for(let p = pageUtil.beginPage; p <= pageUtil.endPage; p++) {
						//	if(p == $('#page').val()){
						//		paging += '<strong>' + p + '</strong>';
						//	} else {
						// 		paging += '<span class="lnk_enable" data-page="'+ p +'">' + p + '</span>';
						//	}
						// }
						
						// 다음 블록
						if(pageUtil.endPage != pageUtil.totalPage){
							paging += '<span class="lnk_enable" data-page="'+ (pageUtil.endPage + 1) +'">▶</span>';
						}
						paging += '</div>';
						// 페이징 표시
						$('#paging').append(paging);
					}
				});
			}  // fn_anonycommentList
			

			
			function fn_changePage(){
				$(document).on('click', '.lnk_enable', function(){
					$('#page').val( $(this).data('page') );
					fn_anonycommentList();
				});
			}
			

			function fn_removeAnonycomment(){
				$(document).on('click', '.btn_anonycomment_remove', function(){
					if(confirm('삭제된 댓글은 복구할 수 없습니다. 댓글을 삭제할까요?')){
						$.ajax({
							type: 'post',
							url: '${contextPath}/anonycomment/remove',
							data: 'commentNo=' + $(this).data('anonycomment_no'),
							dataType: 'json',
							success: function(resData){  // resData = {"isRemove": true}
								if(resData.isRemove){
									alert('댓글이 삭제되었습니다.');
									fn_anonycommentList();
									fn_anonycommentCount();
								}
							}
						});
					}
				});
			}
			
			
		</script>
		
		<script>
	
			// 함수 호출
			
			fn_switchReplyArea();
			fn_addReply();
	
			function fn_switchReplyArea(){
				$(document).on('click', '.btn_reply_area', function(){
					$(this).parent().next().toggleClass('blind');
				});
			}
			
			function fn_addReply(){
				$(document).on('click', '.btn_reply_add', function(){
					if($(this).prev().val() == ''){
						alert('답글 내용을 입력하세요.');
						return;
					}
					$.ajax({
						type: 'post',
						url: '${contextPath}/anonycomment/reply/add',
						data: $(this).closest('.frm_reply').serialize(), 
						dataType: 'json',
						success: function(resData){  // resData = {"isAdd", true}
							if(resData.isAdd){
								alert('답글이 등록되었습니다.');
								fn_anonycommentList();
								fn_anonycommentCount();
							}
						}
					});
				});
			}
			
		</script>
		
	</div>
	

	
<%@ include file="../../layout/footer.jsp" %>
