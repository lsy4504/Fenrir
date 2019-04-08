package kr.or.forcewave.ingu.service;

import java.util.List;
import java.util.Map;

public interface IinguService {

	public List<Map<String, Object>> inguList(String startYear, String endYear);

	public List<Map<String, String>> inguGrapData(Map<String, Object> inguMap);

}
