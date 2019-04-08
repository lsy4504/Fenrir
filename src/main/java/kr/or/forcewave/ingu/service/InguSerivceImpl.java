package kr.or.forcewave.ingu.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.forcewave.ingu.dao.IIinguDao;

@Service
public class InguSerivceImpl implements IinguService {
	@Inject IIinguDao dao;
	@Override
	public List<Map<String, Object>> inguList(String startYear, String endYear) {
	
		return dao.inguList(startYear,endYear);
	}
	@Override
	public List<Map<String, String>> inguGrapData(Map<String, Object> inguMap) {
		return dao.inguGrapData(inguMap);
	}
}
