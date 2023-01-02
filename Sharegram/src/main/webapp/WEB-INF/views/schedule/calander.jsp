<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

 <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SHAREGRAM</title> 

<script src="${contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<script src="${contextPath}/resources/js/moment-with-locales.min.js"></script>

<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script> -->

<%-- <link rel='stylesheet'  href="${contextPath}/resources/fullcalendar/lib/main.css" />
<script src="${contextPath}/resources/fullcalendar/lib/main.js"></script>
<script src='${contextPath}/resources/fullcalendar/lib/locales-all.js'></script> --%>
<script src='${contextPath}/resources/fullcalendar-6.0.2/fullcalendar-6.0.2/dist/index.global.js'></script>
<script src='${contextPath}/resources/fullcalendar-6.0.2/fullcalendar-6.0.2/packages/core/locales-all.global.js'></script>
<link rel='stylesheet'  href="${contextPath}/resources/css/fullcalendar.css" >   
 <!-- <script src='fullcalendar/dist/index.global.js'></script> -->
 <!-- <script src='fullcalendar/core/locales-all.global.js'></script> -->
 
 <style>
 #modal {
         position:fixed;
         top:300px;
         left: 0;
         width:100%;
         height:100%;
         z-index:1;
         display: none;
         }

         #modal h2 {
         margin:0;   
         }
                                 
         #modal button {
         display:inline-block;
         width:100px;
          margin-left:calc(100% - 100px - 10px);
         }
                                 
         #modal .modal_content {
          width:280px;
         margin:50px auto;
         padding:20px 10px;
         background:#fff;
         border:2px solid #666;
         }
                                 
         #modal .modal_layer {
         position:fixed;
         top:0;
         left:0;
         width:100%;
         height:100%;
         background:rgba(0, 0, 0, 0.8);
         z-index:-1;
         }  
 
 </style>
 
<script>

   $(function () {
      
      fn_fullcalendar();
      /* fn_write(); */ 
      fn_close();
   });
   
   
   
   function fn_fullcalendar(){
      var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
           /* themeSystem: 'standard', */
          googleCalendarApiKey: 'AIzaSyCwPYapKCl7z89E7azAvNTr4IsfP4uo4YQ',
          initialView: 'dayGridMonth',
          firstDay: 1, //월요일부터 달력시작
          locale: 'ko',
          selectMirror: true,
         selectable: true, // 사용자가 클릭하고 드래그하여 여러  날짜 또는 시간 슬롯을 강조 표시할 수 있습니다.          
          expandRows: true, // 화면에 맞게 높이 재설정
          nowIndicator: true, // 지금 시간 빨간색으로 마크
          businessHours: true,
          editable: true,
          navLinks: true, 
          dayMaxEvents: true,
          displayEventTime: true,
          displayEventEnd:  true,
          
          height: 900,
          weight: 400,
          aspectRatio: 0.01,
          headerToolbar: {
            start: 'title',
            center: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek',
            end: 'today prevYear,prev,next,nextYear',
          },
          
          footerToolbar: {
             start : 'write',
          },
   
          //업무시간
          businessHours: {
            daysOfWeek: [1, 2, 3, 4, 5],
            startTime: '09:00',
            endTime: '18:00',
          },
   
         
          navLinkDayClick: function (date, jsEvent) {
           // console.log('day', date.toISOString());
           // console.log('coords', jsEvent.pageX, jsEvent.pageY);
          },
          
          events :
        	  {
        	 	 googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com' , 
                 className: '대한민국 공유일',
                 color: 'red',
               },
          
   
          
          //리스트 반환
         events : function(fetchInfo, successCallback, failureCallback) {
             if(${empNo} === ${empNo}){
                 $.ajax({
                   type:"get",
                   url:"${contextPath}/schedule",
                   dataType:"json",
                   success : function(resData){
                      let events = [];
                      $.each(resData ,function (index, data){
                         events.push({
                            extendedProps: {
                               scheduleNo : data.scheduleNo,
                               empNo : data.empNo,
                            },
                            title : data.scheduleTitle,
                            start : moment(data.scheduleStart).format(),
                            end     : moment(data.scheduleEnd).format(),
                            allDay : data.scheduleAllday,
                         })
                               
                      })
                      successCallback(events);
                   }
                   
                }) 
             } 
          },
        	
       
        //추가
          select : function (addInfo) { // 캘린더에서 이벤트를 생성할 수 있다.

            const begin = moment(addInfo.start).format('YYYY-MM-DD HH:mm') ;
            const finish = moment(addInfo.end).format('YYYY-MM-DD HH:mm') ;
            const allDay = addInfo.allDay;
            $('#modal').css('display', 'block');
            $('#start').attr('value', begin);
            $('#end').attr('value', finish);
            
            $('#btn_write').click(function() {
               let schedule = JSON.stringify({
                  'scheduleTitle' : $('#title').val(),
                  'scheduleStart' : begin,
                  'scheduleEnd' : finish,
                  'scheduleAllday' : allDay,
                  'empNo' : $('#empNo').val(),
               });
               
               $.ajax({
                  type : 'post',
                  url : '${contextPath}/schedule',
                  data : schedule,
                  contentType : 'application/json',
                  dataType: 'json',
                  success : function(resData) {
                     if(resData.insertResult > 0 ){
                        alert('일정이 등록되었습니다');
                        calendar.addEvent({
                        	   title: $('#title').val(),
                               start: addInfo.start,
                               end: addInfo.end,
                               allDay: addInfo.allDay,
                          })
                          $('#modal').css('display', 'none');
                          calendar.unselect();
                          $('#modal').empty();
                          fn_init();
                          fn_fullcalendar();
                     } else {
                        alert('일정이 등록되지 않았습니다');
                     }
                  },
                  error : function(jqXHR) {
                     alert('에러코드(' + jqXHR.status + ') ' + jqXHR.responseText);
                  }
               })
                
            });
            calendar.unselect();
          },
          
          //수정
           eventDrop: function (editInfo){
              const obj = new Object();
              if (
                confirm("'" + editInfo.event.title + "' 매니저의 일정을 수정하시겠습니까 ?")
              ) {
                obj.scheduleNo = editInfo.event.extendedProps.scheduleNo;
                obj.scheduleTitle = editInfo.event._def.title;
                obj.scheduleStart = moment(editInfo.event._instance.range.start)
                  .subtract(9, 'hour')
                  .format('YYYY-MM-DD HH:mm');
                obj.scheduleEnd = moment(editInfo.event._instance.range.end)
                  .subtract(9, 'hour')
                  .format('YYYY-MM-DD HH:mm');
                obj.scheduleAllday = editInfo.event.allDay;
                obj.empNo = editInfo.event.extendedProps.empNo
                
                
                  $.ajax({
                    type: 'put',
                    url: '${contextPath}/schedule',
                    dataType: 'json',
                    data: JSON.stringify(obj),
                    contentType: 'application/json',
                    success: function (resData) {
                      if (resData.updateResult) {
                        alert('수정 성공');
                      } else {
                        alert('수정 실패');
                      }
                    },
                  });
              } else {
                info.revert(); // 돌리기
              }
           }, 
          
           
          
          eventClick : function (removeInfo){   
             const obj = new Object();
             if (confirm("'" + removeInfo.event.title + "' 매니저의 일정을 삭제하시겠습니까 ?")) {
               $(function deleteData() {
                    obj.scheduleNo = removeInfo.event.extendedProps.scheduleNo;
                    obj.scheduleTitle = removeInfo.event._def.title;
                    obj.scheduleStart = removeInfo.event._instance.range.start;
                    obj.scheduleEnd = removeInfo.event._instance.range.end;
                    obj.empNo = removeInfo.event.extendedProps.empNo ;
                 $.ajax({
                   type: 'delete',
                   url: '${contextPath}/schedule',
                   dataType: 'json',
                   data: JSON.stringify(obj),
                   contentType: 'application/json',
                   success: function (resData) {
                     if (resData.deleteResult > 0) {
                       alert('삭제 성공');
                       removeInfo.event.remove();
                     } else {
                       alert('삭제 실패');
                     }
                   },
                 });
               });
             } else {
               removeInfo.jsEvent.preventDefault();
             } 
             },
             
             customButtons: {
                
                write :{
                  text : '일정입력',
                  click: function(){
                     let schedule = JSON.stringify({
                        'scheduleTitle' : $('#title').val(),
                        'scheduleStart' : $('#start').val(),
                        'scheduleEnd' : $('#end').val(),
                        'scheduleAllday' : $('#allday').val(),
                     });
                     $.ajax({
                        type : 'post',
                        url : '${contextPath}/schedule',
                        data : schedule,
                        contentType : 'application/json',
                        
                        dataType: 'json',
                        success : function(resData) {
                           if(resData.insertResult > 0 ){
                              alert('일정이 등록되었습니다');
                           } else {
                              alert('일정이 등록되지 않았습니다');
                           }
                           
                        },
                        error : function(jqXHR) {
                           alert('에러코드(' + jqXHR.status + ') ' + jqXHR.responseText);
                           window.close();
                        }
                     }) 
                  }
                },
             },
             
          
               
           
          
        });
        calendar.render();
   }
   

   
   function fn_close(){
	  $(document).on('click', '#modal_close_btn' , function() {
         $('#modal').css('display', 'none');   
    	  fn_init();
      });
   }
   
   function fn_init(){
	   $('#modal').empty();
       let tr = '<div class="modal_content">';
       tr += '<div>';
       tr += ' <input type="hidden" id="empNo" value="${empNo}">';
       tr += '<input type="hidden" id="allday" value="${allday}">';
       tr += '<h1>일정 입력</h1>';
       tr += '<div>';
       tr += '<label for="title">제목</label> <input type="text" id="title">';
       tr += '</div>';
       tr += '<div>';
       tr += '<label for="start">시작일</label> <input type="text" id="start" value="${start}">';
       tr += '<div>';
       tr += '<label for="end">종료일</label> <input type="text" id="end" value="${end}">';
       tr += '</div>';
       tr += '<button id="btn_write">일정 등록</button>';
       tr += '<button  id="modal_close_btn">일정 닫기</button>';
       tr += '</div>';
       tr += '</div>';
       tr += '<div class="modal_layer"></div>';
       $('#modal').append(tr);
   }
   
   
   
  

   
</script>


</head>
<body>
<div id='calendar'></div>

<div id="modal">
      <div class="modal_content">
      <div>
         <input type="hidden" id="empNo" value="${empNo}">
         <input type="hidden" id="allday" value="${allday}">
         <h1>일정 입력</h1>
         <div>
            <label for="title">제목</label> <input type="text" id="title">
         </div>
         <div>
            <label for="start">시작일</label> <input type="text" id="start" value="${start}">
         </div>
         <div>
            <label for="end">종료일</label> <input type="text" id="end" value="${end}">
         </div>
         <button id="btn_write">일정 등록</button>
         <button  id="modal_close_btn">일정 닫기</button>
      </div>
      </div>
      <div class="modal_layer"></div>
</div>
      
      
</body>
</html>