package kr.or.forcewave.jiga.service;

import java.util.List;
import java.util.Map;

public interface IJigaService {

	/**
	 * 시작년도와 끝 년도를 받아서 데이터를 반환 해줌.
	 * @param startYear
	 * @param endYear
	 * @return
	 */
	public List<Map<String, String>> jigaList(String startYear, String endYear);

	public List<Map<String, String>> jigaGrapData(Map<String, Object> emdMap);

	public List<Map<String, String>> analGetData(String startYear, String endYear);

	public List<Map<String, String>> analSelData(Map<String, Object> paramMap);
	
}
