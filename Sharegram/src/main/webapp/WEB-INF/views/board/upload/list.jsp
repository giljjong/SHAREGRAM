<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

	<jsp:include page="../../layout/header.jsp">
		<jsp:param value="SHAREGRAM" name="title" />
	</jsp:include>

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
	
	.uploadbrd {
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
	.uploadbrd {
		padding: 80px 0;
		background: #FFFFFF;
	}
	
	.upload_title {
		margin-bottom: 60px;
	}
	
	.upload_title h2 {
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
	
	.board_upload {
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
	
	.uploadList a:link {
		color : #324b96;
	}
	.uploadList a:hover {
		color : #141e30;
	}
	.uploadList a:visited {
		color : #8694c0;
	}
	
	.paging {
	    font-size:14px;
	    color: #324b96;
	}
     
</style>
<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>

	<div class="uploadbrd">
		<div class="brd_upload">
			<div class="uploadHeader">
				<div class="upload_title">
					<h2><strong>자료실</strong></h2>
					<!-- <div class="board_upload"> -->
				</div>
					<div class="board_upload">
							
							<%-- 
							<a href="${contextPath}/board/upload/write">게시글작성</a>
							<a href="${contextPath}/board/uploadList">첫페이지로</a> --%>
						
						<%-- 공지게시판용 	
						<div class="board_upload_auth">
			                <div class="btn_auth">
			                	<!-- 직급권한만(대표이사, 이사, 부장) 보여지는 공지 등록/해제 버튼 -->
			                	<c:if test="${ loginUser.position eq '1' || loginUser.position eq '2' || loginUser.position eq '3'}">
				                    <button type="button" onclick="uploadTop(1);">공지등록</button><i class="fas fa-flag"></i>
				                    <button type="button" onclick="uploadTop(2);">공지해제</button><i class="fas fa-font-awesome"></i>
			                    </c:if>
			                </div>
			            </div> 
			            --%>
						
						<div class="selectBox">	
							<select id="recordPerPage">
								<option value="5">5</option>
								<option value="10">10</option>
								<option value="15">15</option>
								<option value="20">20</option>
								<option value="25">25</option>
								<option value="30">30</option>
							</select>
							
							<button id="btn_write" class="btn_primary" style='float:right;' onclick="location.href='${contextPath}/board/upload/write'">게시글작성</button>
							&nbsp;&nbsp;
							<button id="btn_first" class="btn_primary" style='float:right;' onclick="location.href='${contextPath}/board/uploadList'">첫페이지로</button>
							
						</div>
						
						<hr>
				
						<div class="uploadList">
							<table class="uploadBoard" align="center" id="uploadBoardList">
								<thead class="brd_thead">
									<tr class="brd_thead_name">
										<!-- <th width="3%"><input type="checkbox" id="checkAll"></th> -->  <!-- 상단 고정 기능 미구현 시, checkbox 삭제(행 확인) -->
										<th width="7%">번호</th>
										<th width="40%">글제목</th>
										<th width="13%">아이디</th>	<!-- 순서 확인 -->
										<th width="13%">작성일</th>
										<th width="7%">조회수</th>
									</tr>
								</thead>
								<tbody class ="brd_tbody" id="result">
									<c:if test="${ empty uploadBoardList }">
			                        		<tr>
			                        			<td colspan="6">등록된 게시글이 없습니다.</td>
			                        		</tr>
			                        	</c:if>
			                        	<c:forEach var="u" items="${uploadBoardList}" >
			                        		<%-- <c:if test="${ u.boardTop eq 'Y'}">	 --%>	<!-- 상단 고정 기능 미구현 시, checkbox 삭제(행 확인) -->
						                        <tr>	<!-- style="background:rgb(212, 244, 250)"  background 수정 예정(게시판 별로 다른 색상)  -->
						                            <%-- <td onclick="event.stopPropagation()"><input type="checkbox" id="checkNo${u.uploadNo}" name="chkuploadNo" value="${u.uploadNo}"></td> --%>
						                            <td class="uploadNo">${ u.uploadNo }</td>
						                            <td height="5%">
						                            	<a href="${contextPath}/board/upload/detail?uploadNo=${ u.uploadNo }">${ u.boardTitle }</a>
						                            </td>
						                            <td height="5%">${ u.empNo }</td>
						                            <td height="5%">${ u.createDate }</td>
						                            <td height="5%">${ u.hit }</td>
						                        </tr>
						                	<%-- </c:if>    --%>
						                </c:forEach>
			                        	<%-- <c:forEach var="n" items="${list}">
					                        <c:if test="${ u.boardTop eq 'N'}">
						                        <tr>
						                            <td onclick="event.stopPropagation()"><input type="checkbox" id="checkNo${ u.uploadNo }" name="chkuploadNo" value="${u.uploadNo}"></td>
						                            <td class="no">${ n.boardNo }</td>
						                            <td>${ u.uploadEmpNo }</td>
						                            <td>${ u.boardTitle }</td>
						                            <td>${ u.uploadCreateDate }</td>
						                            <td>${ u.uploadHit }</td>
						                        </tr>
					                        </c:if>
					                    </c:forEach> --%>
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
							<form style="display:inline-block;" id="frm_search" action="${contextPath}/board/upload/search">
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
		fn_searchList();
	})
	
			/* 상단에 작성 -> 전부 수정 필요 */
			function fn_uploadList(){	
				var page;
				if($('#pageNo').val() == 0) {
					page = 1;
				} else {
					page = $('#pageNo').val();
				}
			
				$.ajax({	
					type : 'get',
					url : '${contextPath}/board/uploadList',
					dataType: 'json',
					data : 'pageNo=' + page ,
					success: function(resData){
						
						var str = '' ;	
				 	    if(resData.beginPage != 1){
							str += '<a href=${contextPath}/board/uploadList?pageNo=' + Number(resData.beginPage -1) + '>' + '◀' + '</a>';
						}  
					 	for(let p = resData.beginPage; p <= resData.endPage; p++){
						 	if(p == resData.page){
						 		str += '<strong>' + p + '</strong>' ;
							}  
							else {
								str += '<a href=${contextPath}/board/uploadList?pageNo=' + p +'>'+ p + '</a>';
							} 
						} 
						if(resData.endPage != resData.totalPage) {
							str += '<a href=${contextPath}/board/uploadList?pageNo=' + 

							//console.log(str);
						}     
						 
						   
						 $('#paging').append(str);   	
					},
					error: function(jqXHR){
						alert('리스트 불러오기에 실패했습니다.');
					}
			})
		} 
		
		function fn_searchList(){
			$('#btn_search').click(function (){
				$.ajax({
					type : 'get',
					url : '${contextPath}/board/upload/search',
					data : 'pageNo=' + ${pageNo} + '&column=' + $('#column').val() + '&query=' + $('#query').val(),
					dataType : 'json',
					success : function (resData){
						//console.log(resData)
						$('#paging').empty();
						$('#result').empty();
						
						$.each(resData.uploadList, function( i , uploadList){
							$('<tr>')
							.append( $('<td class="content_line center_font">').text(uploadList.uploadNo) )
							.append( $('<td class="content_line center_font">').text(uploadList.uploadEmpNo) )
							.append( $('<td class="content_line">').append( $('<a>').text(uploadList.boardTitle).attr('href' ,'${contextPath}/board/upload/incrase/hit?uploadBoardNo=' + uploadList.uploadBoardNo ) ) )
							.append( $('<td class="content_line center_font">').text(uploadList.uploadCreateDate) )
							
							.append( $('<td class="content_line center_font">').text(uploadList.hit) )
							.appendTo('#result');	
						
						})	
						
						/* 	pageutil 통해 페이징 처리 예정			
						var str = '' ;	
				 	    if(resData.beginPage != 1){
							str += '<a href=${contextPath}/board/uploadList?pageNo=' + Number(resData.beginPage -1) + '>' + '◀' + '</a>';
						}  
					 	for(let p = resData.beginPage; p <= resData.endPage; p++){
						 	if(p == resData.page){
						 		str += '<strong>' + p + '</strong>' ;
							}  
							else {
								 str += '<a href=${contextPath}/board/upload/search?pageNo=' + p + '&column=' + resData.column + '&query=' + resData.query  + '>'+ p + '</a>'; 
							} 
						} 
						if(resData.endPage != resData.totalPage) {
							str += '<a href=${contextPath}/board/uploadList?pageNo=' + Number(resData.endPage + 1) + '>' + '▶' + '</a>';
							console.log(str);
						}    */  
						 
						   
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
				fn_uploadList();	
			})
		} */
		
		// 작성
		function fn_write(){
			$('#btn_write').click(function (){
				location.href = '${contextPath}/board/upload/write';
			})
		}
		
		// 페이징 처리
		$(function(){
			$('#btn_write').click(function (){
				location.href = '${contextPath}/board/upload/write';
			})
			
			$('#btn_first').click(function (){
				location.href = '${contextPath}/board/uploadList';
			});
		})
			
		$(function(){	
			// 5개 목록씩 보기
			if('${recordPerPage}' != ''){
				$('#recordPerPage').val(${recordPerPage});			
			} else {
				$('#recordPerPage').val(5);
			}
			
			$('#recordPerPage').change(function(){
				location.href = '${contextPath}/board/uploadList?recordPerPage=' + $(this).val();
			});
			
		});
		
		/* 
		// 게시글 전체 선택
	   	$("#uploadeList").on("click", "#checkAll", function(){
	   		$("input[id^=checkNo]").attr("selected", true);
	   		if($("#checkAll").is(":checked")){
	   			$("input[name=chkuploadNo]").prop("checked", true);
	   		}else{
	   			$("input[name=chkuploadNo]").prop("checked", false);
	   		}
	   	})
	   	
	   	// -----------체크박스 선택하면 값 가져오기-----------
	   	$("input[name=chkuploadNo]").click(function(){
	        var count = $("input[name='chkuploadNo']").length;
	        var checked = $("input[name='chkuploadNo']:checked").length;
	        
	        // 체크한 체크박스의 개수와 전체 체크박스 개수가 같으면 전체 선택 체크박스가 체크된다.
	        if(count != checked){
	            $("#checkAll").prop("checked", false);
	        } else{
	            $("#checkAll").prop("checked", true);
	        }
	        
	    });
	   	
	   	let checkList = "";
	   	// 체크박스 선택시 값 가져오기
	   	$("input[type=checkbox]").change(function(){
	   		checkList = ""; // 여기서 한번 비워서 중복요소 제거
	   		$("input:checkbox[name=chkuploadNo]:checked").each(function(){
	   			checkList += ($(this).val()) + ",";
	   		})
				//console.log(checkList);
				checkList = checkList.substring(0,checkList.lastIndexOf(",")); // 맨 뒤 콤마 불요
	   	}) */
	   	
	   	/* 전사공지용(타게시판에 해당 기능 추가 여부 고민중)
	   	// 공지 설정 ajax처리
		function goTop(isYN){
	   		//console.log(checkList);
	   		// isYN : 1 -> 공지 등록, 2-> 공지 해제
				$.ajax({
					url:"uploadTop.no",
					data:{
						checkList:checkList,
						isYN:isYN
					},
					success(result){
						alert("공지 등록/해제 처리 되었습니다");
						location.reload();
					},error(){
						console.log("ajax통신 실패");
					}
				})
	   	} 
	   	*/
	</script>
	</div>

<%@ include file="../../layout/footer.jsp" %>