package kr.or.forcewave.jiga.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.forcewave.jiga.dao.IJigaDao;

@Service
public class JigaServiceImpl implements IJigaService{
	@Inject
	IJigaDao dao;
	@Override
	public List<Map<String, String>> jigaList(String startYear, String endYear) {
		
		return dao.jigaList(startYear, endYear);
	}
	@Override
	public List<Map<String, String>> jigaGrapData(Map<String, Object> emdMap) {
		return dao.jigaGrapData(emdMap);
	}
	@Override
	public List<Map<String, String>> analGetData(String startYear, String endYear) {
		return dao.analGetData(startYear,endYear);
	}
	@Override
	public List<Map<String, String>> analSelData(Map<String, Object> paramMap) {
		return dao.analSelData(paramMap);
	}
	
	
}
