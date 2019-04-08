/**
 * 
 */
package kr.or.forcewave.jiga.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * @author NewForce01
 *
 */
@Repository
public interface IJigaDao {

	public List<Map<String, String>> jigaList(@Param("start") String startYear, @Param("end")String endYear);

	public List<Map<String, String>> jigaGrapData(Map<String, Object> emdMap);

	public List<Map<String, String>> analGetData(@Param("start") String startYear, @Param("end")String endYear);

	public List<Map<String, String>> analSelData(Map<String, Object> paramMap);

}
