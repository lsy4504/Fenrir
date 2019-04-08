package kr.or.forcewave.emd.service;

import java.util.List;
import java.util.Map;

public interface IEmdService {
	public List<String> emdList();

	public List<Map<String, String>> yearList();
	public List<Map<String, String>> sgg();
}
