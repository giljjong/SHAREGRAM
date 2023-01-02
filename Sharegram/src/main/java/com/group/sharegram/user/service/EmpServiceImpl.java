package com.group.sharegram.user.service;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.group.sharegram.addr.domain.EmpAddrDTO;
import com.group.sharegram.addr.mapper.AddressMapper;
import com.group.sharegram.mail.mapper.MailMapper;
import com.group.sharegram.user.domain.EmployeesDTO;
import com.group.sharegram.user.domain.ProfImgDTO;
import com.group.sharegram.user.domain.RetiredDTO;
import com.group.sharegram.user.mapper.EmpMapper;
import com.group.sharegram.user.util.ProfFileUtil;
import com.group.sharegram.user.util.UserPageUtil;
import com.group.sharegram.user.util.UserSecurityUtil;



@Service
public class EmpServiceImpl implements EmpService {
	
	@Autowired
	private EmpMapper empMapper;
	
	@Autowired
	private UserSecurityUtil securityUtil;
	
	@Autowired
	private UserPageUtil pageUtil;
	
	@Autowired
	private ProfFileUtil profFileUtil;
	
	@Autowired
	private AddressMapper addrMapper;
	
	@Autowired
	private MailMapper mailMapper;
	
	
	@Override
	public Map<String, Object> isReduceEmpNo(int empNo) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empNo", empNo);
		
		Map<String, Object> result =new HashMap<String, Object>();
		
		result.put("isEmp", empMapper.selectEmpByMap(map) != null);
		result.put("isRetireEmp", empMapper.selectRetireEmpByNo(empNo) != null );
		
		return result;
		
	}
	
	
	@Override
	public List<EmployeesDTO> getProfImgList() {
	
		return empMapper.selectProfImgList();
	
	}
	
	@Transactional  // insert가 두번 (upload와 attach 모두 insert가 있으므로)
	@Override
	public void join(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		
		// 파라미터
		String password=multipartRequest.getParameter("empPw");
		String name=multipartRequest.getParameter("name");
		String phone=multipartRequest.getParameter("phone");
		String birthyear=multipartRequest.getParameter("birthyear");
		String birthmonth = multipartRequest.getParameter("birthmonth");
		String birthdate = multipartRequest.getParameter("birthdate");
//		String profImg=request.getParameter("profImg");
		int salary=Integer.parseInt(multipartRequest.getParameter("salary"));
		int jobNo=Integer.parseInt(multipartRequest.getParameter("jobNo"));
		int deptNo=Integer.parseInt(multipartRequest.getParameter("deptNo"));	
		
		String empPw=securityUtil.sha256(password);
		String birthday= birthmonth + birthdate;
		
		// DB로 보낼 EmployeesDTO
		EmployeesDTO emp = EmployeesDTO.builder()
						
						.empPw(empPw)
						.name(name)
						.phone(phone)
						.birthyear(birthyear)
						.birthday(birthday)
						.salary(salary)
						.jobNo(jobNo)
						.deptNo(deptNo)
						.build();
		
		// // DB에 EmployeesDTO 저장. 유저 등록 처리
		int result=empMapper.insertEmp(emp);
		empMapper.insertNoTable();
		
		List<MultipartFile> files = multipartRequest.getFiles("files");
		int attachResult;
		
		if(files.get(0).getSize() == 0) {
			attachResult = 1;
		} else {
			attachResult = 0;
		}
		
		for(MultipartFile multipartFile : files) {
				
			try {
				
				if(multipartFile != null && multipartFile.isEmpty() == false) {
					
					// 원래 이름
					String profOrigin = multipartFile.getOriginalFilename();
					profOrigin = profOrigin.substring(profOrigin.lastIndexOf("\\") + 1);
					
					// 저장할 이름
					String profFilesystem=profFileUtil.getFilename(profOrigin);
					
					// 저장할 경로
					String profPath=profFileUtil.getTodayPath();
					
					// 저장할 경로 만들기
					File dir = new File(profPath);
					if(dir.exists() == false) {
							dir.mkdirs();
					}
					
					// 첨부할 File 객체
					File file= new File(dir,profFilesystem);
					
					// 첨부파일 서버에 저장(업로드 진행)
					multipartFile.transferTo(file);
					
					// ProfImgDTO 생성
					ProfImgDTO prof= ProfImgDTO.builder()
							.profPath(profPath)
							.profOrigin(profOrigin)
							.profFilesystem(profFilesystem)
							.empNo(emp.getEmpNo())
							.build();
					
					// DB에 ProfImgDTO 저장
					attachResult += empMapper.insertProfImg(prof);
				}
			}catch(Exception e) {
				
			}
				
		} // for
			
		
		// 응답
		
		try {
			response.setContentType("text/html; charset=UTF-8");	// 전체 수정
			PrintWriter out = response.getWriter();
			
			if(result > 0) {
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("name", name);
				map.put("empPw", empPw);
				
				int empNo = emp.getEmpNo();
//				System.out.println(empNo);
				String email = empNo + "@sharegram.com";
//				System.out.println(email);
//				System.out.println(password);
				
				EmpAddrDTO empInfo = EmpAddrDTO.builder()
						.empNo(empNo)
						.name(name)
						.email(email)
						.password(password)
						.phone(phone)
						.deptNo(emp.getDeptNo())
						.jobNo(emp.getJobNo())
						.build();
				
				
				  int mailResult = mailMapper.insertJamesUser(empInfo);
				  mailResult += addrMapper.insertEmpAddr(empInfo);
				  mailResult += addrMapper.insertUnspecifiedGroup(empNo);
				 
				
				out.println("<script>");
				out.println("alert('등록 되었습니다.');");
				out.println("location.href='"+ multipartRequest.getContextPath() +"/user/list';");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('등록 되지않았습니다.');");
				out.println("histroy.back();");
				out.println("</script>");
				
			}
			
			out.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	
	
	  @Transactional
	  @Override
	  public void retire(HttpServletRequest request,  HttpServletResponse response) {
		  
	  int empNo=Integer.parseInt(request.getParameter("empNo"));
	 
	  int insertResult = empMapper.insertRetireEmp(empNo);
	  int deleteResult = 0;
	  
	  if(insertResult > 0 ) {
		  deleteResult =empMapper.deleteEmp(empNo);
	  }
	  
	  if(deleteResult > 0 && insertResult > 0) { 
		  try {
	            
	            response.setContentType("text/html; charset=UTF-8");
	            PrintWriter out = response.getWriter();
	            
	            if(deleteResult > 0 && insertResult > 0) {
					
					
					out.println("<script>");
					out.println("alert('퇴사 처리되었습니다.');");
					out.println("location.href='" + request.getContextPath() + "/user/retirelist';");
					out.println("</script>");
					
				}else {
					out.println("<script>");
					out.println("alert('퇴사 처리에 실패했습니다.');");
					out.println("location.href='" + request.getContextPath() + "/user/retirelist';");
					out.println("</script>");
					
				}
				out.close();	
	            
	         } catch(Exception e) {
	            e.printStackTrace();
	         }
	  } 
	  
 }
	 
	

	  @Override
	   public void login(HttpServletRequest request, HttpServletResponse response) {
	      
	      // 파라미터
	      int empNo=Integer.parseInt(request.getParameter("empNo"));
	      String empPw=request.getParameter("empPw");
	      
	      empPw=securityUtil.sha256(empPw);
	      
	      // 조회 조건으로 사용할 Map
	      Map<String, Object> map= new HashMap<String, Object>();
	      map.put("empNo", empNo);
	      map.put("empPw", empPw);
	      
	      // No,Pw가 일치하는 회원 DB에서 조회
	      EmployeesDTO loginEmp= empMapper.selectEmpByMap(map);
	      
	      EmpAddrDTO mailUser = addrMapper.selectEmpAddrByNo(empNo);
	      
	      if(mailUser != null) {
				mailUser.setPassword("");
				request.getSession().setAttribute("mailUser", mailUser);
			}
	      
	      // No, pw가 일치하는 회원이 있다 : session에 loginUser 저장하기 + 로그인 기록 남기기 
	      if(loginEmp != null) {
	         
	         keepLogin(request, response);
	         
	         // 로그인 처리를 위해서 session에 로그인 된 사용자 정보를 올려둠
	         request.getSession().setAttribute("loginEmp", loginEmp);
	         //System.out.println("loginEmp 동작 세션에" + loginEmp);
	         
	         int updateResult = empMapper.updateAccessLog(empNo);
	         if(updateResult == 0) {
	            empMapper.insertAccessLog(empNo);
	         }
	         
	         // 이동
	         try {
	            response.sendRedirect(request.getContextPath()+ "/main");
	         } catch(IOException e) {
	            e.printStackTrace();
	         }
	         
	      } else {
	         
	         // 응답
	         try {
	            
	            response.setContentType("text/html; charset=UTF-8");
	            PrintWriter out = response.getWriter();
	            
	            out.println("<script>");
	            out.println("alert('일치하는 회원 정보가 없습니다.');");
	            out.println("location.href='" + request.getContextPath() + "';");
	            out.println("</script>");
	            out.close();
	            
	         } catch(Exception e) {
	            e.printStackTrace();
	         }
	         
	      }
	      
	   }


	@Override
	public void logout(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session =request.getSession();
		if(session.getAttribute("loginEmp")!= null) {
			session.invalidate();
		}
		
	}


	// 직원: 마이페이지 들어가기 전 비밀번호 확인
	@Override
	public Map<String, Object> confirmPw(HttpServletRequest request) {
		
		String empPw=securityUtil.sha256(request.getParameter("empPw"));
		
		HttpSession session=request.getSession();
		int empNo= ((EmployeesDTO) session.getAttribute("loginEmp")).getEmpNo();

		
		// 조회 조건으로 사용할 Map
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empNo", empNo);
		map.put("empPw", empPw);
		
		
		// No,Pw가 일치하는 직원을 찾는다
		EmployeesDTO emp = empMapper.selectEmpByMap(map);
		
		// 결과 반환
		Map<String, Object>result =new HashMap<String, Object>();
		result.put("isEmp", emp != null);
		
		return result;
	}
	
	
	
	
	
	
	
	
	@Override
	public void modifyMyPassword(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session =request.getSession();
		EmployeesDTO loginEmp= (EmployeesDTO)session.getAttribute("loginEmp");
//		System.out.println("loginEmp");
//		System.out.println(loginEmp);
		
		// 파라미터
		String empPw=securityUtil.sha256(request.getParameter("empPw"));
//		System.out.println("----");
//		System.out.println(empPw);
		// 동일한 비밀번호로 변경 금지
		if(empPw.equals(loginEmp.getEmpPw())) {
			
			// 응답
			try {
				
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				
				out.println("<script>");
				out.println("alert('현재 비밀번호와 동일한 비밀번호로 변경할 수 없습니다.');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
				
			} catch(Exception e) {
				e.printStackTrace();
			}

		}
		
		
		// 사용자 아이디
		int empNo =loginEmp.getEmpNo();
//		System.out.println("empNo");
//		System.out.println(empNo);
		EmployeesDTO emp = EmployeesDTO.builder()
				.empNo(empNo)
				.empPw(empPw)
				.build();
		
		
		// 비밀번호 수정
		int result = empMapper.updateMyPassword(emp);
		
		
		// 응답
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out =response.getWriter();
			
			if(result > 0) {
				
				loginEmp.setEmpPw(empPw);
				
				out.println("<script>");
				out.println("alert('비밀번호가 수정되었습니다.');");
				out.println("location.href='" + request.getContextPath() +"/main';");
				out.println("</script>");
				
			}else {
				out.println("<script>");
				out.println("alert('비밀번호가 수정되지 않았습니다.');");
				out.println("history.back();");
				out.println("</script>");
				
			}
			out.close();			
			}catch(Exception e) {
				e.printStackTrace();
			}
		
	}
	
	
	// 널값 떨어짐 물어보자
	@Override
	public void modifyMyinfo(HttpServletRequest request, HttpServletResponse response) {
		
		
		HttpSession session = request.getSession();
		EmployeesDTO loginEmp=(EmployeesDTO)session.getAttribute("loginEmp");
		
		
		// 파라미터
		
		String empPw =securityUtil.sha256(request.getParameter("empPw"));
		String phone=request.getParameter("phone");
//		String profImg=request.getParameter("profImg");
		
		
		// 사용자 번호
		int empNo= loginEmp.getEmpNo();
		
		EmployeesDTO emp = EmployeesDTO.builder()
				.empNo(empNo)
				.empPw(empPw)
				.phone(phone)
//				.profImg(profImg)
				.build();
		
		

		
	 // 정보 변경 안됨 ㅡㅡ
		int result = empMapper.updateMyinfo(emp);

	
	
	
	// 응답
	try {
		
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out =response.getWriter();
		
		
		if(result > 0) {
			loginEmp.setPhone(phone);
//			loginEmp.setProfImg(profImg);
			
			out.println("<script>");
			out.println("alert('회원정보가 수정되었습니다.');");
			out.println("location.href='" + request.getContextPath() + "';");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('회원정보가 수정되지 않았습니다.');");
			out.println("history.back();");
			out.println("</script>");
			
		}
		out.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
		
		
	}
	
	
	@Override
	public void findAllEmp(HttpServletRequest request, Model model) {
		Optional<String> opt=Optional.ofNullable(request.getParameter("page"));
		int page=Integer.parseInt(opt.orElse("1"));
		
		int totalRecord=empMapper.selectAllEmpListCnt();
		
		// 페이지 계산
		pageUtil.setPageUtil(page, totalRecord);
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin() - 1);
		map.put("recordPerPage", pageUtil.getRecordPerPage());
		
		
		// begin end 목록 가져오기
		List<EmployeesDTO> emp= empMapper.selectEmpByPage(map);
		
		
		model.addAttribute("emp", emp); // "emp"라는 이름으로 list.jsp로 넘어감
		model.addAttribute("paging",pageUtil.getPaging(request.getContextPath()+ "/user/list"));
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
		
		//System.out.println("----------emp:"+emp);
		
		
		
	}
	
	@Override
	public void findEmp(HttpServletRequest request, Model model) {
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		String column = request.getParameter("column");
		String query = request.getParameter("query");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("column", column);
		map.put("query", query);
		
		
		int totalRecord = empMapper.selectFindEmpCount(map);
		
		pageUtil.setPageUtil(page, totalRecord);
		
		map.put("begin", pageUtil.getBegin() - 1);
		map.put("recordPerPage", pageUtil.getRecordPerPage());
		
		List<EmployeesDTO> emp = empMapper.selectFindEmp(map);
		
		model.addAttribute("emp", emp);
		model.addAttribute("beginNo", totalRecord - (page - 1 ) * pageUtil.getRecordPerPage());
		
		String path = null;
		switch(column) {
		case "NAME" :
		case "PHONE":
		case "EMP_NO":
		case "DEPT_NAME":
		case "JOB_NAME":
		case "JOIN_DATE":
		path = request.getContextPath() + "/user/search?column=" + column + "&query=" + query;
		break;
	}
	  model.addAttribute("paging", pageUtil.getPaging(path));
	  
	}
	
	
	@Override
	public void findAllRetire(HttpServletRequest request, Model model) {
		
		Optional<String> opt=Optional.ofNullable(request.getParameter("page"));
		int page=Integer.parseInt(opt.orElse("1"));
		
		int totalRecord=empMapper.selectAllRetireListCnt();
		
		// 페이지 계산
		pageUtil.setPageUtil(page, totalRecord);
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin() - 1);
		map.put("recordPerPage", pageUtil.getRecordPerPage());
		
		
		
		List<RetiredDTO> retire= empMapper.selectRetireByPage(map);
		
		
		
		model.addAttribute("retire", retire); // "retire"라는 이름으로 list.jsp로 넘어감
		model.addAttribute("paging",pageUtil.getPaging(request.getContextPath()+ "/user/retirelist"));
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
		
		
		//System.out.println(retire);
		
		
	}
	
	@Override
	public void findRetire(HttpServletRequest request, Model model) {
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		String column = request.getParameter("column");
		String query = request.getParameter("query");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("column", column);
		map.put("query", query);
		
		
		int totalRecord = empMapper.selectFindRetireCount(map);
		
		pageUtil.setPageUtil(page, totalRecord);
		
		map.put("begin", pageUtil.getBegin() - 1);
		map.put("recordPerPage", pageUtil.getRecordPerPage());
		
	
		List<RetiredDTO> retire = empMapper.selectFindRetire(map);
		
		model.addAttribute("retire", retire);
		model.addAttribute("beginNo", totalRecord - (page - 1 ) * pageUtil.getRecordPerPage());
		
		String path = null;
		switch(column) {
		case "NAME" :
		case "PHONE":
		case "EMP_NO":
		case "DEPT_NAME":
		case "JOB_NAME":
		path = request.getContextPath() + "/user/retiresearch?column=" + column + "&query=" + query;
		break;
	}
	  model.addAttribute("paging", pageUtil.getPaging(path));
	  
		
	}
	
	
	
	@Override
	   public void keepLogin(HttpServletRequest request, HttpServletResponse response) {
	   
	      //파라미터
	      int empNo=Integer.parseInt(request.getParameter("empNo"));
	      String keepLogin = request.getParameter("keepLogin");
	      
	      if(keepLogin != null) {
	         
	         String sessionId = request.getSession().getId();
	         
	         Cookie cookie = new Cookie("keepLogin", sessionId);
	         cookie.setMaxAge(60 * 60 * 24 * 7);  // 7일
	         cookie.setPath(request.getContextPath());
	         response.addCookie(cookie);
	         
	         EmployeesDTO emp = EmployeesDTO.builder()
	               .empNo(empNo)
	               .sessionId(sessionId)
	               .sessionLimitDate(new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 24 * 7))
	               .build();
	         
	         empMapper.updateSessionInfo(emp);
	         
	      } else {
	         
	         Cookie cookie = new Cookie("keepLogin", "");
	         cookie.setMaxAge(0);
	         cookie.setPath(request.getContextPath());
	         response.addCookie(cookie);
	      }
	      
	   }
	   
	   @Override
	   public EmployeesDTO getEmpBySessionId(Map<String, Object> map) {
	      return empMapper.selectEmpByMap(map);
	   }
	
	
	
	
	
	
	
	
	
	

		
	}
	
	
	
	
	
	

	
	

	
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	


