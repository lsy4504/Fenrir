package kr.or.forcewave.maker.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface IMakerDao {

	public int insertMaker(List<Map<String, Object>> jsonData);

	public int deleteMaker(@Param("id")String id, @Param("content")String content);

}
