<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

	<jsp:include page="../../layout/header.jsp">
		<jsp:param value="SHAREGRAM" name="title" />
	</jsp:include>

<%-- <jsp:include page="../layout/header.jsp">
	<jsp:param value="블로그목록" name="title" />
</jsp:include> --%>
<style>
	.blind {
		display: none;
	}
	
	#lnk_love:hover span {
		cursor: pointer;
		color:  #324b96;
	}
	
	#lnk_love, #btn_cmt_list {
		color:  #324b96;
	}
	
	#heart {
		width: 16px;
		margin-right: 5px;
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
	  	background: linear-gradient(#141e30, #243b55);
	}
	
	.deptDetail {
		position: absolute;
		top: 50%;
		left: 50%;
		width: 800px;
		height : 875px;
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
	
	.deptDetail {
		/* padding: 60px 0; */
		background: #FFFFFF;
	}
	
	.deptDetail {
		margin-bottom: 60px;
	}
	
	.deptDetail h3 {
		font-size: 20px;
	 	color: #324b96;
	 	font-weight: 700;
	 	text-align: center;
	}
	
	.deptEdit_title {
		font-size: 16px;
	 	color: #324b96;
	 	font-weight: 700;
	}
	
	.deptEdit_content {
		font-size: 16px;
	 	color: #324b96;
	 	font-weight: 700;
	}
	
	.cmt_font {
		font-size: 16px;
	 	color: #324b96;
	 	font-weight: 700;
	}
	
	.cmt_count {
		font-size: 16px;
	 	color: #324b96;
	 	font-weight: 400;
	}
	
	
	.cmt_empNo {
		font-size: 14px;
	 	color: #324b96;
	}
	
	.cmt_content {
		font-size: 14px;
	 	color: black;
	}
	
	.cmt_love {
	    font-size: 16px;
	 	color: #324b96;
	 	font-weight: 700;
	}
	
	.#love_count {
		font-size: 16px;
	 	color: #324b96;
	 	font-weight: 700;
	}
 	
	.deptEdit_title_box {
		background: #d3dcf5;
		border-radius:8px;
		width: 720px;
	 	height: 30px;
	}
	
	.deptEdit_content_box{
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

	<div class="deptDetail">
		<h3>게시글 정보</h3>
		
			<form>
				<div class="deptEdit_title">
					<label for="boardTitle"><strong>제목</strong></label>
				</div>	<!-- cntr값 chk -->
					<div class="deptEdit_title_box">
						${ deptHrBoard.boardTitle }
					</div>
				<br>
				<div  class="deptEdit_content">
					<label for="boardContent"><strong>본문</strong></label>
				</div>
					<div class="deptEdit_content_box">
						${ deptHrBoard.boardContent }
					</div>
				<br>
				<div class="date">작성일 : ${ deptHrBoard.createDate }</div>
				<div class="date">수정일 : ${ deptHrBoard.modifyDate }</div>
			</form>
			
			<br>
			
		<div align="right">
			<form id="frm_dept" method="post">
			<%-- <c:if test="${loginUser.empNo == board.user.empNo}"> 작성자 혹은 관리자만 삭제할 수 있도록 수정필요 --%>
				<input type="hidden" id="boardNo" name="boardNo" value="${ deptHrBoard.boardNo }"><!-- onclick get 방식처리 됨으로 수정 -->
				<input type="button" value="게시글편집" id="btn_edit" class="btn_primary"> 			
				<input type="button" value="게시글삭제" id="btn_remove" class="btn_primary"> 			
				<input type="button" value="목록" onclick="location.href='${contextPath}/board/deptHrList'" class="btn_primary"> 			
			</form>
			
			<input type="hidden" id="boardEmpNo" value="${deptHrBoard.empNo}">
			
			<script>
			$(document).ready(function(){
				
				var frm = $('#frm_dept');
				
				// 편집화면으로 이동
				$('#btn_edit').click(function(){
					frm.attr('action', '${contextPath}/board/deptHr/edit');
					frm.submit();
				})
				
				// 삭제
				$('#btn_remove').click(function(){
					if(confirm('해당 글을 삭제하시겠습니까? 데이터 삭제시 복구가 불가능합니다.')){
						frm.attr('action', '${contextPath}/board/deptHr/remove');
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
		
		<hr>
		
		<span id="btn_cmt_list" class="cmt_font">
			댓글
			<span id="cmt_count" class="cmt_count"></span>
		</span>
		&nbsp; &nbsp;
		<a id="lnk_love">
			<span id="heart"></span><span id="love" class="cmt_love">좋아요 </span><span id="love_count"></span>
		</a>
		
		<hr>
	
		<div id="cmt_area" class="text">
			<div id="cmt_list"></div>
			<div id="paging"></div>
		</div>
		
		<hr>
		
		<br>
		<div style="margin-top : -25px;">
			<form id="frm_add_cmt">
				<div class="add_cmt">
					<div class="add_cmt_input">
							<input type="text" name="content" id="content" class="inputBox" size=85 placeholder=" 댓글 작성 후 수정 및 삭제가 불가합니다.">
<!-- 						<div class="add_cmt_btn"> -->
							<%-- <c:if test="${loginUser != null}"> 합치고 수정--%>
								&nbsp; <input type="button" value="댓글작성" id="btn_add_cmt" class="btn_primary">
							<%-- </c:if> --%>
						<!-- </div> -->
					</div>
				</div>
				<input type="hidden" name="boardNo" value="${deptHrBoard.boardNo}">
				<%-- <input type="hidden" name="userNo" value="${loginUser.userNo}"> 합치고 수정 --%>
			</form>
				<input type="hidden" id="empNo" name="empNo" value="${loginEmp.empNo}">
		</div>
		
		<!-- 현재 페이지 번호를 저장하고 있는 hidden -->
		<input type="hidden" id="page" value="1">
		
		<script>
			fn_cmtCount();
			fn_switchCmtList();
			fn_addCmt();
			fn_cmtList();
			fn_changePage();
			fn_removeCmt();
			
			function fn_cmtCount(){
				$.ajax({
					type: 'get',
					url: '${contextPath}/cmt/getCount',
					data: 'boardNo=' + $('#boardNo').val(),
					dataType: 'json',
					success: function(resData){  // resData = {"commentCount": 개수}
						$('#cmt_count').text(resData.commentCount);
					}
				});
			}
			
			
			function fn_switchCmtList(){
				$('#btn_cmt_list').click(function(){
					$('#cmt_area').toggleClass('blind');
				});
			}
			

			function fn_addCmt(){
				$('#btn_add_cmt').click(function(){

					$.ajax({
						type: 'post',
						url: '${contextPath}/cmt/add',
						data: $('#frm_add_cmt').serialize(),
						dataType: 'json',
						success: function(resData){  // resData = {"isAdd", true}
							if(resData.isSuccess){
								alert('댓글이 등록되었습니다.');
								$('#content').val('');
								fn_cmtList();   // 댓글 목록 가져와서 뿌리는 함수
								fn_cmtCount();  // 댓글 목록 개수 갱신하는 함수
							}
						}
					});
				});
			}
			

			function fn_cmtList(){
				console.log ('댓글동작')
				$.ajax({
					type: 'get',
					url: '${contextPath}/cmt/list',
					data: 'boardNo=' + $('#boardNo').val() + '&page=' + $('#page').val(),
					dataType: 'json',
					success: function(resData){
						console.log (resData)
						/*
							resData = {
								"commentList": [
									{댓글하나},
									{댓글하나},
									...
								],
								"pageUtil": {
									page: x,
									...
								}
							}
						*/
						// 화면에 댓글 목록 뿌리기
						$('#cmt_list').empty();
						// moment.locale('ko-KR');
						$.each(resData.commentList, function(i, cmt){
							//console.log(cmt)
							var div = '';
							if(cmt.state == -1) {
								if(cmt.depth == 0) {
									div += '<div>삭제된 댓글입니다.</div>';
								} else {
									div += '<div style="margin-left: 40px;">삭제된 답글입니다.</div>';
								}
							} else {
								if(cmt.depth == 0) {
									div += '<div>';
								} else {
									div += '<div style="margin-left:40px;">';
								}
									div += '<span class="cmt_empNo" style="margin-left: 10px;"> 사원번호 : ' + cmt.empNo + '</span>';
									div += '<div class="cmt_content" style="margin-left: 30px;"> <i class="fa-regular fa-comment-dots"></i> &nbsp;' + cmt.content + '</div>';
								/* if('${loginUser.userNo}' != '') {
									if('${loginUser.userNo}' == comment.user.userNo && comment.state == 1) {
										div += '<input type="button" value="삭제" class="btn_cmt_remove" data-comment_no="' + comment.commentNo + '">';
									} else if('${loginUser.userNo}' != comment.user.userNo && comment.depth == 0) {
										div += '<input type="button" value="답글" class="btn_reply_area">';
									}
								} 합치고 나서 수정 */
								div += '</div>';
							}
							div += '<div style="margin-left: 40px;" class="reply_area blind">';
							div += '<form class="frm_reply">';
							div += '<input type="hidden" name="cmtNo" value="' + cmt.cmtNo + '">';
							div += '<input type="hidden" name="groupNo" value="' + cmt.groupNo + '">';
							/* div += '<input type="hidden" name="userNo" value="${loginUser.userNo}">';
							div += '<input type="text" name="content" placeholder="답글을 작성하려면 로그인을 해주세요">';
							if('${loginUser.userNo}' != '') {
								div += '<input type="button" value="답글작성완료" class="btn_reply_add">';
							}
							div += '</form>'; 합치고 수정*/
							div += '</div>';
							$('#cmt_list').append(div);
							$('#cmt_list').append('<div style="border-bottom: 1px dotted gray;"></div>');
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
			}  // fn_cmtList
			

			
			function fn_changePage(){
				$(document).on('click', '.lnk_enable', function(){
					$('#page').val( $(this).data('page') );
					fn_cmtList();
				});
			}
			

			function fn_removeCmt(){
				$(document).on('click', '.btn_cmt_remove', function(){
					if(confirm('삭제된 댓글은 복구할 수 없습니다. 댓글을 삭제할까요?')){
						$.ajax({
							type: 'post',
							url: '${contextPath}/cmt/remove',
							data: 'cmtNo=' + $(this).data('cmt_no'),
							dataType: 'json',
							success: function(resData){  // resData = {"isRemove": true}
								if(resData.isRemove){
									alert('댓글이 삭제되었습니다.');
									fn_cmtList();
									fn_cmtCount();
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
			
			fn_loveCheck();
			fn_lovedCount();
			fn_pressLove();

			
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
						url: '${contextPath}/cmt/reply/add',
						data: $(this).closest('.frm_reply').serialize(), 
						dataType: 'json',
						success: function(resData){  // resData = {"isAdd", true}
							if(resData.isAdd){
								alert('답글이 등록되었습니다.');
								fn_cmtList();
								fn_cmtCount();
							}
						}
					});
				});
			}
			
			//////////////////////////////////////////////////
			
			// 내가 "좋아요"를 누른 게시글인가?(좋아요 테이블에 사용자와 게시글 정보가 있는지 확인, 눌렀으면 빨간하트, 안 눌렀으면 빈하트)
			function fn_loveCheck() { 
				$.ajax({
					url: '${contextPath}/love/getLoveCheck',
					type: 'get',
					data: 'boardNo=' + $('#boardNo').val() + '&empNo=' + $('#empNo').val(),
					dataType: 'json',
					success: function(resData){
						
						if(resData.count == 0) {
							$('#heart').html('<img src="${contextPath}/resources/images/dislike.png" width="15px">');
							$('#love').removeClass("love_checked");
						} else {
							$('#heart').html('<img src="${contextPath}/resources/images/like.png" width="15px">');
							$('#love').addClass("love_checked");
						}
					}
				});
			}
			
			// "좋아요" 개수 표시하기
			function fn_lovedCount(){
				$.ajax({
					url: '${contextPath}/love/getLoveCount',
					type: 'get',
					data: 'boardNo=' + $('#boardNo').val(),
					dataType: 'json',
					success: function(resData){
						$('#love_count').empty();
						$('#love_count').text(resData.count ); // '+ 개'
					}
				});
			}
			
			// "좋아요" 누른 경우
			function fn_pressLove(){
				$('#lnk_love').click(function(){
					/* // 로그인을 해야 "좋아요" 가능  // 합친후 수정
					if('${loginUser.userNo}' == ''){
						alert('해당 기능은 로그인이 필요합니다.');
						return;
					} */
					
					// 셀프 좋아요 방지
					if('${employees.empNo}' == $('#boardEmpNo').val()){
						alert('본인의 게시글에서는 "좋아요"를 누를 수 없습니다.');
						return;
					}
					// "좋아요" 선택/해제 상태에 따른 하트 변경
					$('#love').toggleClass("love_checked");
					if ($('#love').hasClass("love_checked")) {
						$('#heart').html('<img src="${contextPath}/resources/images/like.png" width="15px">');
					} else {
						$('#heart').html('<img src="${contextPath}/resources/images/dislike.png" width="15px">');
					}
					// "좋아요" 처리
					$.ajax({
						url: '${contextPath}/love/mark',
						type: 'get',
						data: 'boardNo=' + $('#boardNo').val() + '&empNo=' + $('#empNo').val(),
						dataType: 'json',
						success: function(resData){
							if(resData.isSuccess) {
								fn_lovedCount();							
							}
						}
					});
				});
			}
			
		</script>
		
	</div>
	

	
<%@ include file="../../layout/footer.jsp" %>