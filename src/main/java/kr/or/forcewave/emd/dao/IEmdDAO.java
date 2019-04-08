package kr.or.forcewave.emd.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
@Repository
public interface IEmdDAO {

	public List<String> emdList();

	public List<Map<String, String>> yearList();
	
	public List<Map<String, String>> sgg();

}
