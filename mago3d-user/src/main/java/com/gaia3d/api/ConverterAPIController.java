package com.gaia3d.api;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gaia3d.domain.ConverterJob;
import com.gaia3d.service.ConverterService;

import lombok.extern.slf4j.Slf4j;

/**
 * TODO 시간이 없어서 임시로 해 둠. http status code, message등은 추후 설계
 * @author Cheon JeongDae
 *
 */
@Slf4j
@RequestMapping("/converter/")
@RestController
public class ConverterAPIController {

	@Autowired
	private ConverterService converterService;
	
	/**
	 * 프로젝트별 데이터 건수에 대한 통계
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-converter-job-by-converter-job-id.do")
	public Map<String, Object> ajaxConverterJobByConverterJobId(HttpServletRequest request, @RequestParam("jobId") Long jobId) {
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			
//			ConverterJob converterJob = converterService.getConverterJobByJobId(jobId);
//			List<ConverterJobFile> converterLogList = converterService.getAllListConverterLog(jobId);
//			
//			map.put("converterJob", converterJob);
//			map.put("converterLogList", converterLogList);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * 프로젝트별 데이터 건수에 대한 통계
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-update-converter-job.do")
	public Map<String, Object> ajaxUpdateConverterJob(HttpServletRequest request, ConverterJob converterJob) {
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			converterService.updateConverterJob(converterJob);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
}
