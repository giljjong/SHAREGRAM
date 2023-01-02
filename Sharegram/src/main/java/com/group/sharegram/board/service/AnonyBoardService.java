package com.group.sharegram.board.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.group.sharegram.board.domain.AnonyBoardDTO;

public interface AnonyBoardService {
	
	public void findAllAnonyList(HttpServletRequest request, Model model);
	
	public Map<String, Object> saveSummernoteImage(MultipartHttpServletRequest multipartRequest);
	public void save(MultipartHttpServletRequest multipartRequest, HttpServletResponse response);
	
	public AnonyBoardDTO getAnonyByNo(int anonyNo);
	
	public void modifyAnony(HttpServletRequest request, HttpServletResponse response);
	public void removeAnony(HttpServletRequest request, HttpServletResponse response);
	
	// public void findAnony(HttpServletRequest request, Model modle);
	
	// public int increaseHit(int anonyNo);
	
	// public void findAnonyList(HttpServletRequest request, Model model);
}
