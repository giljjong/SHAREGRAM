package com.group.sharegram.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.group.sharegram.board.domain.NoticBoardDTO;

@Mapper
public interface NoticBoardMapper {
	public int selectAllNoticListCount();
	public List<NoticBoardDTO> selectNoticList(Map<String, Object> map);
	public int insertNotic(NoticBoardDTO notic);
	public int deleteNotic(int noticBoardNo);
	public int insertContent(NoticBoardDTO uploadBoard);
	public NoticBoardDTO selectBoardByNo(int noticBoardNo);
	public int modifyNotic(NoticBoardDTO noticBoard);
	public int updateHit(int noticBoardNo);
}
