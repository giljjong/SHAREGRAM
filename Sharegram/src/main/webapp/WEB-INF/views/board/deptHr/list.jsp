<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

	<jsp:include page="../../layout/header.jsp">
		<jsp:param value="SHAREGRAM" name="title" />
	</jsp:include>
	
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
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
	  	background: linear-gradient(#141e30, #243b55);
	}
	
	.deptbrd {
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
	.deptbrd {
		padding: 80px 0;
		background: #FFFFFF;
	}
	
	.dept_title {
		margin-bottom: 60px;
	}
	
	.dept_title h2 {
		 font-size: 28px;
	 	 color: #324b96;
	 	 font-weight: 800;
	 	 text-align: center;
	}
	
	.brd_thead th {
	 	 background: #324b96;
		 font-size: 15px;
	 	 color: #FFFFFF;
	 	 font-weight: 700; /* 글자 굵기 */
	 	 text-align: center;
	 	 line-height: 2;
	}
	
	.brd_tbody td {
		 font-size: 14px;
	 	 color: #4e73df;
	 	 font-weight: 400;
	 	 text-align: center;
	 	 line-height: 2;
	}
	
	.brd_tbody tr:hover {
		background:#d3dcf5; 	/* 색상값은 조정 예정 */
	}
	
	
	#frm_search .search_area {
		padding: 15px 0;
 		background-color: #f9f7f9;
	}
	
	.board_dept {
	  	position: relative;
	  	margin: 0 auto;
	 	width: 80%;
	 	max-width: 900px;
	}
	
	.search_area input {
		height: 40px;
 		width: 100%;
  		font-size: 14px;
 		padding: 7px 14px;
  		border: 1px solid #ccc;
	}
	
	.search_area input:focus {
		border-color: #333;
	 	outline: 0;
	  	border-width: 1px;
	}
	
	.btn_primary {
		 background:#4e73df;
	     color:white;
	  /*   display:block; */
	     
	     /*width:92.5%;
	     max-width:680px; */
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
	
	.searchBox {
		/* width: 50%;  /* 원하는 너비 설정 */  */
		/* height: auto;  /* 높이값 초기화 */ */
		/* line-height : normal;  /* line-height 초기화 */ */
		/* padding: .8em .5em; /* 원하는 여백 설정, 상하단 여백으로 높이를 조절 */  */
		font-family: 'Montserrat', sans-serif;  /* 폰트 상속 */
		/* border: 1px solid #4673a3; */
		border-radius: 8px;  
		/* outline-style: none;  /* 포커스시 발생하는 효과 제거 필요시*/ */
		-webkit-appearance: none;  /* 브라우저별 기본 스타일링 제거 */
		-moz-appearance: none;
		appearance: none;
	}
	
	.selectBox {
		font-family: 'Montserrat', sans-serif;
		border-radius: 8px; 
		/* border-bottom: 1px dashed rgb(70, 115, 163) */;
		transition: .1s;
		
	}
	
	.recordPerPage {
		color: =#141e30;
		font-size:12px;
	
	}
	
	.deptHrBoardList a:link {
		color : #324b96;
	}
	.deptHrBoardList a:hover {
		color : #141e30;
	}
	.deptHrBoardList a:visited {
		color : #8694c0;
	}
	
	.paging {
	    font-size:14px;
	    color: #324b96;
	}
</style>

<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>

	<div class="deptbrd">
		<div class="brd_dept">
			<div class="deptHeader">
				<div class="dept_title">
					<h2><strong>부서 게시판</strong></h2>
				</div>
					<div class="board_dept">
						<%-- <div class="board_dept_auth">
			                <div class="btn_auth">
			                	<!-- 직급권한만(대표이사, 이사, 부장) 보여지는 공지 등록/해제 버튼 상단 고정 기능 삭제 시, 해당 코드 불요 -->
			                	<c:if test="${ loginUser.position eq '1' || loginUser.position eq '2' || loginUser.position eq '3'}">   합친 후 수정
				                    <button type="button" class="btn_primary" style='float:right;'onclick="boardTop(1);">공지등록&nbsp;<i class="fas fa-flag"></i></button>
				                    <button type="button" class="btn_primary" style='float:right;'onclick="boardTop(2);">공지해제&nbsp;<i class="fas fa-font-awesome"></i></button>
			                    </c:if>
			                </div>
			            </div> --%>
						
						<div class="selectBox">							
							<select id="recordPerPage">
								<option value="5">5</option>
								<option value="10">10</option>
								<option value="15">15</option>
								<option value="20">20</option>
								<option value="25">25</option>
								<option value="30">30</option>
							</select>


<%-- 미로그인 시, 작성      <c:if test="${loginUser != null }">     합친 후 수정--%>
								<button id="btn_write" class="btn_primary" style='float:right;' onclick="location.href='${contextPath}/board/deptHr/write'">게시글작성</button>
<%--                        </c:if> --%>
								&nbsp;&nbsp;
								<button id="btn_first" class="btn_primary" style='float:right;' onclick="location.href='${contextPath}/board/deptHrList'">첫페이지로</button>

						</div>
						
						<hr>
						
				
						<div class="deptList">
							<table class="deptBoard" align="center" id="deptHrBoardList">
								<thead class="brd_thead">
									<tr class="brd_thead_name">
										<!-- <th width="3%"><input type="checkbox" id="checkAll" name="chk" value="checkall" onclick="checkAll(this)"></th> -->
										<th width="7%">번호</th>
										<th width="40%">글제목</th>
										<th width="13%">아이디</th>
										<th width="13%">부서명</th>
										<th width="13%">작성일</th>
										<th width="7%">조회수</th>
									</tr>
								</thead>
								<tbody class ="brd_tbody" id="result">
									<c:if test="${ empty deptHrBoardList }">
			                        		<tr>
			                        			<td colspan="6">등록된 게시글이 없습니다.</td>
			                        		</tr>
			                        	</c:if>
			                        	<c:forEach var="d" items="${deptHrBoardList}">
			                        		<c:if test="${d.state != 0}">
			                        		
				                        	<%-- <c:if test="${ d.boardTop eq 'Y'}">  <!-- 기능 사용시, DB추가 필요 --> --%>
							                        <tr>	<!-- background 수정 예정  -->
							                          <%--   <td onclick="event.stopPropagation()"><input type="checkbox" id="checkNo${ d.boardNo }" name="chkuploadNo" value="${ d.boardNo }"></td> --%>
							                            <td class="boardNo">${ d.boardNo }</td>
							                            <td height="5%">
							                            	<%-- <c:if test="${loginUser.empNo != n.empNo}"> 합친 후 수정--%>
							                            		<a href="${contextPath}/board/deptHr/detail?boardNo=${ d.boardNo }"> ${ d.boardTitle }</a> <!-- 작성자는 조회수 증가x -->
							                            	<%-- <a href="${contextPath}/board/upload/incrase/hit?uploadNo=${ n.uploadNo }">${ n.boardTitle }</a> --%>
							                            	<%-- </c:if>
							                            	<c:if test="${loginUser.empNo != n.empNo}">
																<a href="${contextPath}//board/upload/incrase/hit?uploadNo=${ n.uploadNo }">${ n.boardTitle }(작성회원번호 ${ n.empNo })</a>
															</c:if> 합친 후 수정--%>
							                            </td>
							                            <td height="5%">${ d.empNo }</td>
							                            <td height="5%">${ d.deptName }</td>							                            
							                            <td height="5%">${ d.createDate }</td>
							                            <td height="5%">${ d.hit }</td>
							                        </tr>
					                        <%-- 	</c:if> --%>
			                        		</c:if>
						               </c:forEach>
			                        	
			                    </tbody>
		  
								<tfoot>
									<tr>
										<td colspan="5" id="paging" align="center">
											<hr>
											<div class="paging">${paging}</div>
										</td>
									</tr>
								</tfoot>
								
							</table>
						</div>
				
				<div style="margin:auto;text-align:center;" class="searchArea">
					<form style="display:inline-block;" id="frm_search" action="${contextPath}/board/deptHr/search">
						<select id="column" name="column" class="select">
							<option value="" align="center">::선택::</option>
							<option value="BOARD_TITLE">제목</option>
							<option value="EMP_NO">사원번호</option>
						</select>
						<span id="search_area">
							<input type="text" id="search_area" name="search_area" class="searchBox" placeholder="검색어를 입력해주세요." size=30>
						</span>
						<span>
							<input type="button" value="검색" id="btn_search" class="btn_primary">
							<input type="button" value="전체조회" id="btn_all" class="btn_primary"> 
						</span>
					</form>
				</div>
				
			</div>
		</div>
	</div>
	
<script>
	$(function(){
		fn_write();
	})
	
		function fn_deptHrBoardList(){	
			var page;
			if($('#pageNo').val() == 0) {
				page = 1;
			} else {
				page = $('#pageNo').val();
			}
			
			$.ajax({	
				type : 'get',
				url : '${contextPath}/board/deptHrBoardList',
				dataType: 'json',
				data : 'pageNo=' + page ,
				success: function(resData){
					
					var str = '' ;	
			 	    if(resData.pageUtil.beginPage != 1){
						str += '<a href=${contextPath}/board/deptHrBoardList?pageNo=' + Number(resData.beginPage -1) + '>' + '◀' + '</a>';
					}  
				 	for(let p = resData.beginPage; p <= resData.endPage; p++){
					 	if(p == resData.page){
					 		str += '<strong>' + p + '</strong>' ;
						}  
						else {
							str += '<a href=${contextPath}/board/deptHrBoardList?pageNo=' + p +'>'+ p + '</a>';
						} 
					} 
				 	if(resData.endPage != resData.totalPage) {
						str += '<a href=${contextPath}/board/deptHrBoardList?pageNo=' + Number(resData.endPage + 1) + '>' + '▶' + '</a>';
						//console.log(str);
					}     
					   
					 $('#paging').append(str);   	
				},
				error: function(jqXHR){
					alert('리스트 불러오기가 실패했습니다.');
				}
			})
		} 
	
	function fn_searchList(){
		$('#search_area').click(function (){
			$.ajax({
				type : 'get',
				url : '${contextPath}/board/deptHr/search',
				data : 'pageNo=' + ${pageNo} + '&column=' + $('#column').val() + '&query=' + $('#query').val(),
				dataType : 'json',
				success : function (resData){
					//console.log(resData)
					$('#paging').empty();
					$('#result').empty();
					
/* 					$.each(resData.deptHrBoardList, function( i , deptHrBoardList){
						$('<tr>')
						.append( $('<td class="content_line center_font">').text(deptHrBoardList.uploadNo) )
						.append( $('<td class="content_line center_font">').text(deptHrBoardList.empNo) )
						.append( $('<td class="content_line">').append( $('<a>').text(deptHrBoardList.boardTitle).attr('href' ,'${contextPath}/board/upload/incrase/hit?uploadNo=' + deptHrBoardList.uploadNo ) ) )
						.append( $('<td class="content_line center_font">').text(deptHrBoardList.createDate) )
						
						.append( $('<td class="content_line center_font">').text(deptHrBoardList.hit) )
						.appendTo('#result');	
					
					})	 */
							
					var str = '' ;	
			 	    if(resData.beginPage != 1){
						str += '<a href=${contextPath}/board/deptHrBoardList?pageNo=' + Number(resData.beginPage -1) + '>' + '◀' + '</a>';
					}  
				 	for(let p = resData.beginPage; p <= resData.endPage; p++){
					 	if(p == resData.page){
					 		str += '<strong>' + p + '</strong>' ;
						}  
						else {
							 str += '<a href=${contextPath}/board/deptHr/search?pageNo=' + p + '&column=' + resData.column + '&query=' + resData.query  + '>'+ p + '</a>'; 
						} 
					} 
					if(resData.endPage != resData.totalPage) {
						str += '<a href=${contextPath}/board/deptHrBoardList?pageNo=' + Number(resData.endPage + 1) + '>' + '▶' + '</a>';
						//console.log(str);
					}    
					 
					   
					 $('#paging').append(str);   	
				},
				error: function(jqXHR){
					alert('리스트 불러오기에 실패했습니다.');
				
				} 
			})
		})		
	}
	
	/* function fn_allList(){
		$('#btn_all').click(function (){
			fn_deptHrBoardList();	
		})
	}
	 */
	 
	function fn_write(){
		$('#btn_write').click(function (){
			location.href = '${contextPath}/board/deptHr/write';
		})
	}
	
	// 페이징 처리
	$(function(){
		$('#btn_write').click(function (){
			location.href = '${contextPath}/board/deptHr/write';
		})
		
		$('#btn_first').click(function (){
			location.href = '${contextPath}/board/deptHrList';
		});
		
	});
		
	$(function(){	
		// 5개 목록씩 보기
		if('${recordPerPage}' != ''){
			$('#recordPerPage').val(${recordPerPage});			
		} else {
			$('#recordPerPage').val(5);
		}
		
		$('#recordPerPage').change(function(){
			location.href = '${contextPath}/board/deptHrList?recordPerPage=' + $(this).val();
		});
		
	});
   	
   	
   	$(function(){
   	 var placeholderTarget = $('.searchArea input[type="text"]');
  	  
  	  //포커스시
  	  placeholderTarget.on('focus', function(){
  	    $(this).siblings('label').fadeOut('fast');
  	  });

  	  //포커스아웃시
  	  placeholderTarget.on('focusout', function(){
  	    if($(this).val() == ''){
  	      $(this).siblings('label').fadeIn('fast');
  	    }
  	  });
   	});
</script>
	
</div>
<%@ include file="../../layout/footer.jsp" %>