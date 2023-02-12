# SHAREGRAM📊📁
> 쉬운 그룹웨어 시스템 SHAREGRAM
<p align="center"><img width="300px" src="https://user-images.githubusercontent.com/109578796/218303504-bc9c8b64-e59e-4638-8bf3-c4c6532ca497.png"/></p>

 **구디 아카데미 FINAL PROJECT**
- 개발기간 : 2022.12.5~2022.1.2
- 참여인원 : 5명
- 주제 : 사내 그룹웨어 웹 애플리케이션
- 개요 : 배운 것을 활용하는 것을 첫째로 하고, 팀원들 각자 다양한 직종에서 근무하며 그룹웨어를 사용했던 경험을 토대로 도메인에 관계 없이 가볍고 기본적인 형태의 그룹웨어(GRAM)를 만드는 것을 목표로 하였습니다. 더 나아가 도메인에 맞게 추가 구현 커스텀(SHARE)이 가능하게 하자는 의미에서 SHAREGRAM이라는 이름을 붙였습니다.

## 사용 기술
**Environment**
<br>
<img src="https://img.shields.io/badge/apache tomcat-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=white"> <img src="https://img.shields.io/badge/Cafe24-0861FF?style=for-the-badge&logo=Cafe24&logoColor=white"> <img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white">  <img src="https://img.shields.io/badge/git-F05032?style=for-the-badge&logo=git&logoColor=white"> <img src="https://img.shields.io/badge/apache james-E6861F?style=for-the-badge&logo=apache james&logoColor=white">

**Front-End**
<br>
 <img src="https://img.shields.io/badge/html5-E34F26?style=for-the-badge&logo=html5&logoColor=white">  <img src="https://img.shields.io/badge/css-1572B6?style=for-the-badge&logo=css3&logoColor=white">  <img src="https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black">  <img src="https://img.shields.io/badge/jquery-0769AD?style=for-the-badge&logo=jquery&logoColor=white">

**Back-End**
<br>
<img src="https://img.shields.io/badge/spring-6DB33F?style=for-the-badge&logo=spring&logoColor=white"> <img src="https://img.shields.io/badge/Oracle-F80000?style=for-the-badge&logo=Oracle&logoColor=white"> <img src="https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=MySQL&logoColor=white"> <img src="https://img.shields.io/badge/JSP-E56F1F?style=for-the-badge&logo=JSP&logoColor=white">  <img src="https://img.shields.io/badge/MyBatis-271F1F?style=for-the-badge&logo=MyBatis&logoColor=white">

**Tools**
<br>
<img src="https://img.shields.io/badge/eclipse ide-2C2255?style=for-the-badge&logo=eclipse ide&logoColor=white"> <img src="https://img.shields.io/badge/thunderbird-0A84FF?style=for-the-badge&logo=thunderbird&logoColor=white"> 

**Communication**
<br>
<img src="https://img.shields.io/badge/Google Meet-00897B?style=for-the-badge&logo=Google Meet&logoColor=white"> <img src="https://img.shields.io/badge/ERD Cloud-4B4D97?style=for-the-badge&logo=ERD Cloud&logoColor=white"> 
## 담당 역할 및 구현기능

**🙋‍♂️임장욱**
- Project Leader - 프로젝트 일정 관리
- 전자결재 기능 구현
	- 기안서 등록, 자신의 내역 확인
	- 권한에 따른 결재 관리
	- 결재 서명 및 결재 반려. 반려 시 사유 작성

**🙋‍♀️신주희**
- 사원관리 기능 구현
	- 로그인, 로그아웃
	- 사원생성/수정/삭제
	- 퇴사자 확인

**🙋‍♂️임경묵**
- 일정관리, 근태관리​ 기능 구현
	- 근태 정보 확인, 수정, 삭제
	- 스케쥴 API
	- 드래그 및 클릭을 이용한 일정 추가/수정

**🙋‍♂️정종길**
- DB 설계
- 사내메일 구현
	- 받은메일함, 보낸메일함, 휴지통, 메일쓰기, 메일상세
	- 본문에 이미지 첨부
	- Drag&Drop을 통한 파일 첨부
	- AJAX 페이징
- 주소록 구현
	- 사원 목록과 사내주소록 연동, 사원 추가/삭제/수정 시 자동 반영
	- 개인주소록 그룹, 주소록 추가/수정/삭제
	- 상세 내역 확인 블록

**🙋‍♀️한다혜**
- 사내게시판​ 기능 구현
	- 권한에 따른 공지 설정
	-  게시글 CRUD
	- 댓글, 대댓글 CRUD
	- 익명 게시판
- 자료실 기능 구현
	- 다중 파일첨부
  
## 주요기능 예시
**메인페이지**
<img src="https://user-images.githubusercontent.com/109578796/218317653-359f0d41-42f2-4e1c-a536-0d9eb5a849ed.png"/>

**로그인/사원관리**
- 로그인/로그아웃 기능과 비밀번호 찾기 기능을 구현하였습니다.
- 사원의 정보를 입력해 사원 등록이 가능합니다.<br>
<img width="47%" src="https://user-images.githubusercontent.com/109578796/218316674-85ea7542-9a10-448d-aa25-e1caa2710847.png"/><img width="48%" src="https://user-images.githubusercontent.com/109578796/218317740-93f7e1a2-1a4f-4a88-97e8-0401afe52437.png"/>

**전자결재**
- 자신의 결재 내역을 확인할 수 있습니다.
- 반려된 문서의 경우 사유 확인이 가능합니다.
<img src="https://user-images.githubusercontent.com/109578796/218317865-eb828b59-79a1-4f51-b2fe-9108c9316111.png"/><br><br>
- 전결 권한이 있는 참조/열람자만 결재 및 반려가 가능합니다.
- 결재가 완료될 경우 결재란에 자동으로 서명(결재자의 이름)이 작성됩니다.
<img src="https://user-images.githubusercontent.com/109578796/218317954-2356b292-be77-4a3c-b78e-3b51321135fb.png"/>

**일정/근태 관리**
- 드래그를 통해 일정 생성/수정이 가능합니다.
- 클릭 시 상세 일정을 확인할 수 있습니다.
<img src="https://user-images.githubusercontent.com/109578796/218318039-b11521f2-207c-44f9-8bf6-f46834c63cdd.png"/><br><br>
- 직원들의 근태 내역이 확인 가능합니다.
- 수정, 삭제가 가능합니다.
- 출근/퇴근 버튼을 통해 출/퇴근 기록이 가능합니다.
<img src="https://user-images.githubusercontent.com/109578796/218318078-b2babccc-2ab8-4efc-b250-13b0cbe505c4.png"/>

**메일**
- 받은 메일 내역을 확인할 수 있습니다.
- 해당 일, 해당 년도 기준으로 날짜 표기 방식 변화가 있습니다.
- 아이콘 및 텍스트 블록 클릭을 통해 읽음, 삭제, 답장, 전달이 가능합니다.
- 메일 송수신자의 대표  이름이 메일함 종류에 맞추어 표기됩니다.
<img src="https://user-images.githubusercontent.com/109578796/218318827-78bb4c78-a21f-4ca1-b5d4-a855fb974573.png"/><br><br>
- 내게쓰기 기능
- 버튼 클릭, Drag & Drop으로 파일 다중 첨부, 삭제가 가능합니다.
- Summernote 편집기를 통해 본문에 이미지 첨부, 글꼴 수정이 가능합니다.
- 파일의 경우 전체 파일, 단독 파일 다운을 지원합니다. 전체 파일 다운 시 zip파일로 자동 압축하여 다운로드합니다.
<img src="https://user-images.githubusercontent.com/109578796/218318850-bf2974d9-f01d-49fa-96e9-ccc1db801722.png"/>

**주소록**
- 사내주소록/개인주소록을 확인할 수 있습니다.
- 개인주소록 추가, 수정, 삭제가 가능합니다.
- 주소록 클릭 시 오른 쪽 블록을 통해 상세내역이 표시됩니다.
<img src="https://user-images.githubusercontent.com/109578796/218320707-bcf1f21d-c144-4f1f-8a75-ce3a20e8444a.png"/>

**게시판**
- 권한에 따른 공지 등록/해제가 가능합니다.
- 검색과 페이징 처리가 가능합니다.
- 페이지 당 보여지는 게시글 수 조정이 가능합니다.
- 부서 게시판의 경우 글쓴이의 부서 명이 표시 됩니다.
<img src="https://user-images.githubusercontent.com/109578796/218318897-de8b9abf-1751-4da9-bda2-173f4c4dbfec.png"/><br><br>
- Summernote 편집기를 통해 본문에 이미지 첨부, 글꼴 수정이 가능합니다.
- 댓글, 대댓글, 좋아요가 가능합니다.
- 입력초기화 버튼을 통해 작성한 내용 및 자료를 ​초기화 시킬 수 있습니다.
<img src="https://user-images.githubusercontent.com/109578796/218318946-df07decd-460c-46b5-bf29-185d99695cfa.png"/>
