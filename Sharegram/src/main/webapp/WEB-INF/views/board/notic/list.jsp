<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%-- <jsp:include page="../layout/header.jsp">
	<jsp:param value="그룹웨어메인" name="title" />
</jsp:include> --%>

<script>
$(function(){
	fn_searchList();
	// 자료실용 fn_uploadList();
	fn_allList();
	fn_write();
})
	/* 자료실용
		function fn_uploadList(){	
			$.ajax({	
				type : 'get',
				url : '${contextPath}/upload/ulist',
				dataType: 'json',
				data : 'pageNo=' + ${pageNo} ,
				success: function(resData){
					$('#paging').empty();
					$('#result').empty();
					$.each(resData.uploadList, function( i , uploadList){
						$('<tr>')
						.append( $('<td class="content_line center_font">').text(uploadList.uploadBoardNo) )
						.append( $('<td class="content_line">').append( $('<a>').text(uploadList.uploadTitle).attr('href' ,'${contextPath}/upload/incrase/hit?uploadBoardNo=' + uploadList.uploadBoardNo ) ) )
						.append( $('<td class="content_line center_font">').text(uploadList.createDate) )
						.append( $('<td class="content_line center_font">').text(uploadList.attachCnt) )
						.append( $('<td class="content_line center_font">').text(uploadList.ip) )
						.append( $('<td class="content_line center_font">').text(uploadList.hit) )
						.appendTo('#result');	
					
					})	
					
					var str = '' ;	
			 	    if(resData.beginPage != 1){
						str += '<a href=${contextPath}/upload/list?pageNo=' + Number(resData.beginPage -1) + '>' + '◀' + '</a>';
					}  
				 	for(let p = resData.beginPage; p <= resData.endPage; p++){
					 	if(p == resData.page){
					 		str += '<strong>' + p + '</strong>' ;
						}  
						else {
							str += '<a href=${contextPath}/upload/list?pageNo=' + p +'>'+ p + '</a>';
						} 
					} 
					if(resData.endPage != resData.totalPage) {
						str += '<a href=${contextPath}/upload/list?pageNo=' + Number(resData.endPage + 1) + '>' + '▶' + '</a>';
						console.log(str);
					}     
					 
					   
					 $('#paging').append(str);   	
				},
				error: function(jqXHR){
					alert('리스트 불러오기가 실패했습니다.');
				}
		})
	} */
	
	function fn_searchList(){
		$('#btn_search').click(function (){
			$.ajax({
				type : 'get',
				url : '${contextPath}/board/notic/list',
				data : 'pageNo=' + ${pageNo} + '&column=' + $('#column').val() + '&query=' + $('#query').val(),
				dataType : 'json',
				success : function (resData){
					console.log(resData)
					$('#paging').empty();
					$('#result').empty();
					
					$.each(resData.noticList, function( i , noticList){
						$('<tr>')
						.append( $('<td class="content_line center_font">').text(noticList.noticNo) )
						.append( $('<td class="content_line center_font">').text(noticList.noticEmpNo) )
						.append( $('<td class="content_line">').append( $('<a>').text(noticList.noticTitle).attr('href' ,'${contextPath}/board/notic/incrase/hit?noticBoardNo=' + noticList.noticBoardNo ) ) )
						.append( $('<td class="content_line center_font">').text(noticList.noticCreateDate) )
						
						.append( $('<td class="content_line center_font">').text(noticList.hit) )
						.appendTo('#result');	
					
					})	
					
					/* 	pageutil 통해 페이징 처리 예정			
					var str = '' ;	
			 	    if(resData.beginPage != 1){
						str += '<a href=${contextPath}/board/notic/list?pageNo=' + Number(resData.beginPage -1) + '>' + '◀' + '</a>';
					}  
				 	for(let p = resData.beginPage; p <= resData.endPage; p++){
					 	if(p == resData.page){
					 		str += '<strong>' + p + '</strong>' ;
						}  
						else {
							 str += '<a href=${contextPath}/board/notic/search?pageNo=' + p + '&column=' + resData.column + '&query=' + resData.query  + '>'+ p + '</a>'; 
						} 
					} 
					if(resData.endPage != resData.totalPage) {
						str += '<a href=${contextPath}/board/notic/list?pageNo=' + Number(resData.endPage + 1) + '>' + '▶' + '</a>';
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
	
	function fn_allList(){
		$('#btn_all').click(function (){
			fn_noticList();	
		})
	}
	
	function fn_write(){
		$('#btn_write').click(function (){
			location.href = '${contextPath}/board/notic/write';
		})
	}
	
	// 페이징 처리
	$(function(){
		$('#btn_write').click(function (){
			location.href = '${contextPath}/board/notic/write';
		})
		
		$('#btn_first').click(function (){
			location.href = '${contextPath}/board/notic/list';
		})
		// 5개 목록씩 보기
		if('${recordPerPage}' != ''){
			$('#recordPerPage').val(${recordPerPage});			
		} else {
			$('#recordPerPage').val(5);
		}
		
		$('#recordPerPage').change(function(){
			location.href = '${contextPath}/board/notic/list?recordPerPage=' + $(this).val();
		});
		
	});
	
	
	// 게시글 전체 선택
   	$("#noticeList").on("click", "#checkAll", function(){
   		$("input[id^=checkNo]").attr("selected", true);
   		if($("#checkAll").is(":checked")){
   			$("input[name=chkNoticNo]").prop("checked", true);
   		}else{
   			$("input[name=chkNoticNo]").prop("checked", false);
   		}
   	})
   	
   	// -----------체크박스 선택하면 값 가져오기-----------
   	$("input[name=chkNoticNo]").click(function(){
        var count = $("input[name='chkNoticNo']").length;
        var checked = $("input[name='chkNoticNo']:checked").length;
        
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
   		$("input:checkbox[name=chkNoticNo]:checked").each(function(){
   			checkList += ($(this).val()) + ",";
   		})
			//console.log(checkList);
			checkList = checkList.substring(0,checkList.lastIndexOf(",")); // 맨 뒤 콤마 불요
   	})
   	
   	// 공지 설정 ajax처리
	function goTop(isYN){
   		//console.log(checkList);
   		// isYN : 1 -> 공지 등록, 2-> 공지 해제
			$.ajax({
				url:"noticTop.no",
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
</script>

	<div class="noticbrd">
		<div class="brd_notic">
			<div class="noticHeader">
				<div>
				<h2>전사 공지</h2>
					<div class="board_notic">
						<!-- (하단으로 이동 예정) -->
						<div>
							<button id="btn_write" class="btn_primary">게시글작성<i class="fa-regular fa-pen-to-square"></i></button>
							<button id="btn_first" class="btn_primary">첫페이지로<i class="fa-solid fa-rotate-left"></i></button>
						</div>
						<div class="board_notic_auth">
			                <div class="btn_auth">
			                	<!--직급권한만(대표이사, 이사, 부장) 보여지는 공지 등록/해제 버튼 -->
			                	<c:if test="${ loginUser.position eq '1' || loginUser.position eq '2' || loginUser.position eq '3'}">
				                    <button type="button" onclick="noticTop(1);">공지등록</button><i class="fas fa-flag"></i>
				                    <button type="button" onclick="noticTop(2);">공지해제</button><i class="fas fa-font-awesome"></i>
			                    </c:if>
			                </div>
			            </div>
						
						
						<div>
							<form id="frm_search" action="${contextPath}/board/notic/search">
								<select id="column" name="column" class="select">
									<option value="">::선택::</option>
									<option value="BOARD_TITLE">제목</option>
									<option value="EMP_NO">사원번호</option>
								</select>
								<span id="area1">
									<input type="text" id="query" name="query" class="input searchBox">
								</span>
								<span>
									<input type="button" value="검색" id="btn_search" class="btn_primary">
									<input type="button" value="전체조회" id="btn_all" class="btn_primary"> 
								</span>
							</form>
							
							<select id="recordPerPage">
								<option value="5">5</option>
								<option value="10">10</option>
								<option value="15">15</option>
								<option value="20">20</option>
								<option value="25">25</option>
								<option value="30">30</option>
							</select>
					
						</div>
						
						<hr>
				
				<div class="noticList">
					<table class="noticBoard">
						<thead class="brd_thead">
							<tr class="brd_thead_name">
								<th width="2%"><input type="checkbox" id="checkAll"></th>
								<th width="5%">번호</th>
								<th width="30%">글제목</th>
								<th width="8%">작성자</th>
								<th width="8%">작성일</th>
								<th width="5%">조회수</th>
							</tr>
						</thead>
						<tbody class ="notic-tbody">
							<c:if test="${ empty list }">
	                        		<tr>
	                        			<td colspan="6">등록된 게시글이 없습니다.</td>
	                        		</tr>
	                        	</c:if>
	                        	<c:forEach var="n" items="${list}">
		                        	<c:if test="${ n.boardTop eq 'Y'}">
				                        <tr style="background:rgb(250, 232, 232)">
				                            <td onclick="event.stopPropagation()"><input type="checkbox" id="checkNo${n.noticNo}" name="chkNoticNo" value="${n.noticNo}"></td>
				                            <td class="no">${ n.noticNo }</td>
				                            <td>${ n.noticTitle }</td>
				                            <td>${ n.noticEmpNo }</td>
				                            <td>${ n.noticCreateDate }</td>
				                            <td>${ n.noticHit }</td>
				                        </tr>
		                        	</c:if>
				                </c:forEach>
	                        	<c:forEach var="n" items="${list}">
			                        <c:if test="${ n.boardTop eq 'N'}">
				                        <tr>
				                            <td onclick="event.stopPropagation()"><input type="checkbox" id="checkNo${n.noticNo}" name="chkNoticNo" value="${n.noticNo}"></td>
				                            <td class="no">${ n.boardNo }</td>
				                            <td>${ n.noticTitle }</td>
				                            <td>${ n.noticEmpNo }</td>
				                            <td>${ n.noticCreateDate }</td>
				                            <td>${ n.noticHit }</td>
				                        </tr>
			                        </c:if>
			                    </c:forEach>
	                    </tbody>
						<tfoot>
							<tr>
								<td colspan="6" id="paging" >
								
								</td>
							</tr>
						</tfoot>
					</table>
				</div>
				
			</div>
		</div>
	</div>
	</div>
</div>
</body>
</html>