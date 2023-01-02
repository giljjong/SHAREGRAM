package com.group.sharegram.board.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.group.sharegram.board.domain.AnonyBoardDTO;
import com.group.sharegram.board.domain.NoticBoardDTO;

@Mapper
public interface AnonyBoardMapper {
	public int selectAllAnonyListCount();
	public List<AnonyBoardDTO> selectAnonyList(Map<String, Object> map);
	
	public int insertAnony(AnonyBoardDTO anony);
	
	public AnonyBoardDTO selectAnonyByNo(int anonyNo);
	
	public int updateAnony(AnonyBoardDTO anony);
	public int deleteAnony(int anonyNo);
	
	// public int insertContent(AnonyBoardDTO anonyBoard);
	
	// public void findAnony(HttpServletRequest request, Model model);
	
	// public int updateHit(int anonyNo);
}
