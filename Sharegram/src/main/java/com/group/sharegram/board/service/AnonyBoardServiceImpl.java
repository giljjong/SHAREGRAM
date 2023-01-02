package com.group.sharegram.board.service;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.group.sharegram.board.domain.AnonyBoardDTO;
import com.group.sharegram.board.domain.NoticBoardDTO;
import com.group.sharegram.board.mapper.AnonyBoardMapper;
import com.group.sharegram.board.util.BPageUtil;
import com.group.sharegram.board.util.BSecurityUtil;
import com.group.sharegram.board.util.MyFileUtil;
import com.group.sharegram.user.domain.EmployeesDTO;

@Service
public class AnonyBoardServiceImpl implements AnonyBoardService {

	@Autowired
	private AnonyBoardMapper anonyBoardMapper;

	@Autowired
	private MyFileUtil myFileUtil;

	@Autowired
	private BPageUtil pageUtil;

	/*
	 * @Autowired private BSecurityUtil securityUtil;
	 */

	@Override
	public void findAllAnonyList(HttpServletRequest request, Model model) {

		Optional<String> opt1 = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt1.orElse("1"));

		Optional<String> opt2 = Optional.ofNullable(request.getParameter("recordPerPage"));
		int recordPerPage = Integer.parseInt(opt2.orElse("5"));

		// 전체 게시글 개수
		int totalRecord = anonyBoardMapper.selectAllAnonyListCount();

		// 페이징에 필요한 모든 계산 완료
		pageUtil.setPageUtil(page, recordPerPage, totalRecord);

		// DB로 보낼 Map(begin + end)
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin() - 1);
		map.put("recordPerPage", pageUtil.getRecordPerPage());

		// DB에서 목록 가져오기
		List<AnonyBoardDTO> anonyBoardList = anonyBoardMapper.selectAnonyList(map);

		// 뷰로 보낼 데이터
		model.addAttribute("anonyBoardList", anonyBoardList);
		model.addAttribute("paging",
				pageUtil.getPaging(request.getContextPath() + "/board/anonyList?recordPerPage=" + recordPerPage));
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
		model.addAttribute("recordPerPage", recordPerPage);

	}

	@Override
	public Map<String, Object> saveSummernoteImage(MultipartHttpServletRequest multipartRequest) {

		// 파라미터 files
		MultipartFile multipartFile = multipartRequest.getFile("file");

		// 저장 경로
		String path = "C:" + File.separator + "summernoteImage";

		// 저장할 파일명
		String filesystem = myFileUtil.getFilename(multipartFile.getOriginalFilename());

		// 저장 경로가 없으면 만들기
		File dir = new File(path);
		if (dir.exists() == false) {
			dir.mkdirs();
		}

		// 저장할 File 객체
		File file = new File(path, filesystem);

		// HDD에 File 객체 저장하기
		try {
			multipartFile.transferTo(file);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 저장된 파일을 확인할 수 있는 매핑을 반환
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("src", multipartRequest.getContextPath() + "/board/anonyImage" + filesystem);
		map.put("filesystem", filesystem);
		return map;
	}

	@Override
	public void save(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		int empNo = ((EmployeesDTO) multipartRequest.getSession().getAttribute("loginEmp")).getEmpNo();

		// 파라미터
		String title = multipartRequest.getParameter("anonyTitle"); // 코드 타입 chk(board내 통일 유무)
		String content = multipartRequest.getParameter("anonyContent");

		AnonyBoardDTO anony = AnonyBoardDTO.builder()
				.empNo(empNo)
				.anonyTitle(title)
				.anonyContent(content)
				.build();

		// DB 저장
		int anonyResult = anonyBoardMapper.insertAnony(anony);

		// 응답
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script>");
			if (anonyResult > 0) {

				out.println("alert('게시글이 등록 되었습니다.');");
				out.println("location.href='" + multipartRequest.getContextPath() + "/board/anonyList';");

			} else {
				// out.println("<script>");
				out.println("alert('게시글 등록에 실패했습니다.');");
				out.println("history.back();");
			}
			out.println("</script>");
			out.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public AnonyBoardDTO getAnonyByNo(int anonyNo) {

		AnonyBoardDTO anonyBoard = anonyBoardMapper.selectAnonyByNo(anonyNo);

		return anonyBoard;
	}

	@Override
	public void modifyAnony(HttpServletRequest request, HttpServletResponse response) {
		
		/* 수정 */
		// 파라미터
		int anonyNo = Integer.parseInt(request.getParameter("anonyNo"));
		// int empNo = Integer.parseInt(multipartRequest.getParameter("empNo"));
		String title = request.getParameter("anonyTitle");
		String content = request.getParameter("anonyContent");

		// DB로 보낼 DTO
		AnonyBoardDTO anony = AnonyBoardDTO.builder()
				.anonyNo(anonyNo)
				// .empNo(empNo)
				.anonyTitle(title)
				.anonyTitle(content)
				.build();


		// DB 수정
		int anonyResult = anonyBoardMapper.updateAnony(anony);
		
		//System.out.println(" anonyResult : " + anonyResult) ;
		
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			if(anonyResult > 0) {
				
				out.println("alert('게시글 수정이 완료 되었습니다.');");
				out.println("location.href='" + request.getContextPath() + "/board/anony/detail?anonyNo=" + anonyNo + "'");
			} else {
				out.println("alert('게시글 수정에 실패했습니다.');");
				out.println("history.back();");
				}
			out.println("</script>");
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void removeAnony(HttpServletRequest request, HttpServletResponse response) {
		int anonyNo = Integer.parseInt(request.getParameter("anonyNo"));
		int result = anonyBoardMapper.deleteAnony(anonyNo);

		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script>");
			if (result > 0) {

				out.println("alert('게시글이 삭제 되었습니다.');");
				out.println("location.href='" + request.getContextPath() + "/board/anonyList'");
			} else {
				out.println("alert('게시글 삭제에 실패했습니다.');");
				out.println("history.back();");
			}
			out.println("</script>");
			out.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * @Override public void findAnony(HttpServletRequest request, Model model) {
	 * Optional<String> opt = Optional.ofNullable(request.getParameter("anonyNo"));
	 * int anonyNo = Integer.parseInt(opt.orElse("0"));
	 * 
	 * AnonyBoardDTO anony = anonyBoardMapper.selectAnonyByNo(anonyNo);
	 * model.addAttribute("AnonyBoard", anony); }
	 */

	/*
	 * @Override public int increaseHit(int anonyNo) { return
	 * anonyBoardMapper.updateHit(anonyNo); }
	 */

}