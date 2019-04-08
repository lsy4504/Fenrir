package kr.or.forcewave.maker.service;

import java.util.List;
import java.util.Map;

public interface IMakerService {

	public int insertMaker(List<Map<String, Object>> jsonData);

	public boolean deleteMaker(String id, String content);

}
