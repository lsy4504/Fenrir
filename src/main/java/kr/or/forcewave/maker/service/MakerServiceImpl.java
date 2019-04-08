package kr.or.forcewave.maker.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.forcewave.maker.dao.IMakerDao;

@Service
public class MakerServiceImpl implements IMakerService{
	@Inject IMakerDao dao;
	
	@Transactional
	@Override
	public int insertMaker(List<Map<String, Object>> jsonData) {
		int result =dao.insertMaker(jsonData);
		if(result<jsonData.size()){
			result=0;
		}
		return result;
	}
	@Transactional
	@Override
	public boolean deleteMaker(String id,String content) {
		boolean flag=false;
		int result=dao.deleteMaker(id,content);
		if(result>0){
			flag=true;
		}
		return flag;
	}
}
