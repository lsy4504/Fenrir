package kr.or.forcewave.emd.service;

import java.util.List;
import java.util.Map;
import java.util.concurrent.SynchronousQueue;

import javax.inject.Inject;

import org.geojson.GeoJsonObject;
import org.geojson.GeometryCollection;
import org.postgresql.hostchooser.GlobalHostStatusTracker;
import org.springframework.stereotype.Service;

import kr.or.forcewave.emd.dao.IEmdDAO;

@Service
public class EmdServiceImpl implements IEmdService{
	@Inject IEmdDAO dao;
	@Override
	public List<String> emdList() {
		
		return dao.emdList();
	}
	@Override
	public List<Map<String, String>> yearList() {
	
		return dao.yearList();
	}
	@Override
	public List<Map<String, String>> sgg() {
		List<Map<String, String>> listMap=dao.sgg();
		for (Map<String, String> map : listMap) {
			
			
		}
		return dao.sgg();
	}
}
