package com.group.sharegram.board.service;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.group.sharegram.board.domain.DeptHrBoardDTO;
import com.group.sharegram.board.mapper.DeptHrBoardMapper;
import com.group.sharegram.board.util.BPageUtil;
import com.group.sharegram.user.domain.DepartmentsDTO;
import com.group.sharegram.user.domain.EmployeesDTO;

@Service
public class DeptHrBoardServiceImpl implements DeptHrBoardService {
	
	@Autowired
	private DeptHrBoardMapper deptHrBoardMapper;
	
	/*
	 * @Autowired private MyFileUtil myFileUtil;
	 */
	
	@Autowired
	private BPageUtil pageUtil;
	
	
	@Override
	public void findAllDeptHrList(HttpServletRequest request, Model model) {
		
		Optional<String> opt1 = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt1.orElse("1"));
		
		Optional<String> opt2 = Optional.ofNullable(request.getParameter("recordPerPage"));
		int recordPerPage = Integer.parseInt(opt2.orElse("5"));

		// 전체 게시글 개수
		int totalRecord = deptHrBoardMapper.selectAllDeptHrListCount();
		
		// 페이징에 필요한 모든 계산 완료
		pageUtil.setPageUtil(page, recordPerPage, totalRecord);
		
		// DB로 보낼 Map(begin + end)
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin() - 1);
		map.put("recordPerPage", pageUtil.getRecordPerPage());
		
		// DB에서 목록 가져오기 
		List<DeptHrBoardDTO> deptHrBoardList = deptHrBoardMapper.selectDeptHrList(map);
		
//			for(DeptHrBoardDTO deptHt : deptHrBoardList) {
//				System.out.println(deptHt.toString());
//			}

		// 뷰로 보낼 데이터
		model.addAttribute("deptHrBoardList", deptHrBoardList);
		model.addAttribute("paging", pageUtil.getPaging(request.getContextPath() + "/board/deptHrList?recordPerPage=" + recordPerPage));
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
		model.addAttribute("recordPerPage", recordPerPage);
	}
	
	//@Transactional
	@Override
	public void save(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		int empNo = ((EmployeesDTO)multipartRequest.getSession().getAttribute("loginEmp")).getEmpNo();
		int deptNo = ((EmployeesDTO)multipartRequest.getSession().getAttribute("loginEmp")).getDeptNo();
		
		//System.out.println(deptNo);
		
		DepartmentsDTO dept = deptHrBoardMapper.selectDeptName(deptNo);
		String deptName = dept.getDeptName();
		// 파라미터
		String title = multipartRequest.getParameter("boardTitle");
		String content = multipartRequest.getParameter("boardContent");
		
		// DB로 보낼 UploadDTO
		DeptHrBoardDTO deptHr = DeptHrBoardDTO.builder()
				.empNo(empNo) // 로그인 만들면 수정해야함 
				.deptName(deptName) // 로그인 만들면 수정해야함 
				.boardTitle(title)
				.boardContent(content)
				.hit(1)
				.build();
		
		// DB에 UploadDTO 저장
		int deptHrResult = deptHrBoardMapper.insertDeptHr(deptHr);  // <selectKey>에 의해서 인수 upload에 uploadNo값이 저장된다.
		
		
		// 응답
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			 if(deptHrResult > 0) {
				 
				 out.println("alert('게시글이 등록 되었습니다.');");
				 out.println("location.href='" + multipartRequest.getContextPath() + "/board/deptHrList';");
					
				} else {
					//out.println("<script>");
					out.println("alert('게시글 등록에 실패했습니다.');");
					out.println("history.back();");
					}
				out.println("</script>");
				out.close();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
	
	/*
	 * @Override public void getUploadByNo(int uploadNo, Model model) {
	 * model.addAttribute("upload", uploadBoardMapper.selectUploadByNo(uploadNo));
	 * model.addAttribute("attachList",
	 * uploadBoardMapper.selectAttachList(uploadNo)); }
	 */
	
	@Override
	public DeptHrBoardDTO getBoardByNo(int boardNo) {
		
		DeptHrBoardDTO deptHrBoard= deptHrBoardMapper.selectBoardByNo(boardNo);
//		System.out.println(deptHrBoardMapper.selectBoardByNo(boardNo));
//		System.out.println("service"+ boardNo);
		return deptHrBoard;
	}
	
	// @Transactional
	@Override
	public void modifyDeptHr(HttpServletRequest request, HttpServletResponse response) {
		
		/*  자료실 수정 */
		// 파라미터
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		
		// int boardNo = ((DeptHrBoardDTO)request.getSession().getAttribute("boardNo")).getBoardNo();
				
		// int empNo = Integer.parseInt(request.getParameter("empNo"));
		String title = request.getParameter("boardTitle");
		String content = request.getParameter("boardContent");
		
		// DB로 보낼 DTO
		DeptHrBoardDTO deptHr = DeptHrBoardDTO.builder()
				.boardNo(boardNo)
				//.empNo(empNo)
				.boardTitle(title)
				.boardContent(content)
				.build();
		
		// DB 수정
		int deptHrResult = deptHrBoardMapper.updateDeptHr(deptHr);
		
		//System.out.println(" deptHrResult : " + deptHrResult) ;
		
		
		// 응답(jsp 확인)
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
	
			out.println("<script>");
			if(deptHrResult > 0) {
				out.println("alert('수정 되었습니다.');");
				out.println("location.href='" + request.getContextPath() + "/board/deptHr/detail?boardNo=" + boardNo + "'");
			} else {
				out.println("alert('수정 실패했습니다.');");
				out.println("history.back();");
				}
			out.println("</script>");
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void removeDeptHr(HttpServletRequest multipartRequest, HttpServletResponse response) {
		
		// 파라미터
		int boardNo = Integer.parseInt(multipartRequest.getParameter("boardNo"));
		
		// DB에서 해당게시판 정보 삭제
		int deptHrResult = deptHrBoardMapper.deleteDeptHr(boardNo);
		
		// 응답
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(deptHrResult > 0) {
				
				out.println("<script>");
				out.println("alert('삭제 되었습니다.');");
				out.println("location.href='" + multipartRequest.getContextPath() + "/board/deptHrList'");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('삭제 실패했습니다.');");
				out.println("history.back();");
				out.println("</script>");
			}
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
	
	@Override
	public int increaseHit(int boardNo) {
		return deptHrBoardMapper.updateHit(boardNo);
	}
	
	
	

	
	
	
	
	
}
