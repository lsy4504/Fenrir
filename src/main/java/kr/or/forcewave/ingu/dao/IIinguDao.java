package kr.or.forcewave.ingu.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface IIinguDao {

	public List<Map<String, Object>> inguList(@Param("start") String startYear, @Param("end")String endYear);

	public List<Map<String, String>> inguGrapData(Map<String, Object> inguMap);

}
