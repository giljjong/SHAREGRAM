package com.group.sharegram.board.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.group.sharegram.board.domain.DeptHrBoardDTO;

public interface DeptHrBoardService {
	
	// 자료실 목록
	public void findAllDeptHrList(HttpServletRequest request, Model model);
	
	// public UploadBoardDTO getUplaodBoardByNo(int uploadBoardNo);
	
	/*
	 * // 써머노트 이미지 public Map<String, Object>
	 * saveSummernoteImage(MultipartHttpServletRequest multipartRequest);
	 */
	
	// 게시글 작성 완료
	public void save(MultipartHttpServletRequest multipartRequest, HttpServletResponse response);
	
	// 게시글 번호
	// public void getUploadByNo(int uploadNo, Model model);
	public DeptHrBoardDTO getBoardByNo(int boardNo);
	
	
	/*
	 * public ResponseEntity<byte[]> display(int attachNo);
	 * 
	 * // 자료 다운로드(String 타입 chk) public ResponseEntity<Resource> download(String
	 * empNo, int attachNo);
	 * 
	 * // 일괄 다운로드 public ResponseEntity<Resource> downloadAll(String empNo, int
	 * uploadNo);
	 */
	
	// 수정
	public void modifyDeptHr(HttpServletRequest request, HttpServletResponse response);
	
	/*
	 * // 자료 삭제 public void removeAttachByAttachNo(int attachNo);
	 */
	
	// 게시글 삭제
	public void removeDeptHr(HttpServletRequest multipartRequest, HttpServletResponse response);
	
	// 조회수
	public int increaseHit(int boardNo);
	
	// findUpload 추가
	
	
}
