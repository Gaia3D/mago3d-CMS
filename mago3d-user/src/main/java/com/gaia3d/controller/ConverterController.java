package com.gaia3d.controller;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.config.PropertiesConfig;
import com.gaia3d.domain.ConverterJob;
import com.gaia3d.domain.ConverterJobFile;
import com.gaia3d.domain.Pagination;
import com.gaia3d.domain.UserSession;
import com.gaia3d.service.ConverterService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.FormatUtil;
import com.gaia3d.util.StringUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * Data Converter
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/converter/")
public class ConverterController {
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	
	@Autowired
	private ConverterService converterService;
	
	/**
	 * TODO 우선은 여기서 적당히 구현해 두고... 나중에 좀 깊이 생각해 보자. converter에 어디까지 넘겨야 할지
	 * converter job insert
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "ajax-insert-converter-job.do")
	@ResponseBody
	public Map<String, Object> ajaxInsertConverterJob(HttpServletRequest request, ConverterJob converterJob, @RequestParam("check_ids") String check_ids) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			if(check_ids.length() <= 0) {
				map.put("result", "check.value.required");
				return map;
			}
			if(converterJob.getTitle() == null || converterJob.getTitle().isEmpty()) {
				map.put("result", "input.invalid");
				return map;
			}
			
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			converterService.insertConverter(userSession.getUser_id(), check_ids, converterJob);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
	
	/**
	 * converter job 목록
	 * @param request
	 * @param membership_id
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list-converter-job.do")
	public String listConverterJob(HttpServletRequest request, ConverterJob converterJob, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
		converterJob.setUser_id(userSession.getUser_id());		
		log.info("@@ converterJob = {}", converterJob);
		
		if(StringUtil.isNotEmpty(converterJob.getStart_date())) {
			converterJob.setStart_date(converterJob.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isNotEmpty(converterJob.getEnd_date())) {
			converterJob.setEnd_date(converterJob.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}
		long totalCount = converterService.getListConverterJobTotalCount(converterJob);
		
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(converterJob), totalCount, Long.valueOf(pageNo).longValue());
		log.info("@@ pagination = {}", pagination);
		
		converterJob.setOffset(pagination.getOffset());
		converterJob.setLimit(pagination.getPageRows());
		List<ConverterJob> converterJobList = new ArrayList<>();
		if(totalCount > 0l) {
			converterJobList = converterService.getListConverterJob(converterJob);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("converterJobList", converterJobList);
		return "/converter/list-converter-job";
	}
	
	/**
	 * converter job 파일 목록
	 * @param request
	 * @param membership_id
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list-converter-job-file.do")
	public String listConverterJobFile(HttpServletRequest request, ConverterJobFile converterJobFile, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
		converterJobFile.setUser_id(userSession.getUser_id());		
		log.info("@@ converterJobFile = {}", converterJobFile);
		
		if(StringUtil.isNotEmpty(converterJobFile.getStart_date())) {
			converterJobFile.setStart_date(converterJobFile.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isNotEmpty(converterJobFile.getEnd_date())) {
			converterJobFile.setEnd_date(converterJobFile.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}
		long totalCount = converterService.getListConverterJobFileTotalCount(converterJobFile);
		
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParametersConverterJobFile(converterJobFile), totalCount, Long.valueOf(pageNo).longValue());
		log.info("@@ pagination = {}", pagination);
		
		converterJobFile.setOffset(pagination.getOffset());
		converterJobFile.setLimit(pagination.getPageRows());
		List<ConverterJobFile> converterJobFileList = new ArrayList<>();
		if(totalCount > 0l) {
			converterJobFileList = converterService.getListConverterJobFile(converterJobFile);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("converterJobFileList", converterJobFileList);
		return "/converter/list-converter-job-file";
	}
	
	/**
	 * 최근 converter-job
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-converter-job-widget.do")
	@ResponseBody
	public Map<String, Object> converterJobWidget(HttpServletRequest request) {
		
		log.info(" >>>>>>>>>>>>>>>>>>>>>>>>>>>> converterJobWidget");
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			
			ConverterJob converterJob = new ConverterJob();
			converterJob.setUser_id(userSession.getUser_id());
			converterJob.setOffset(0l);
			converterJob.setLimit(10l);
			List<ConverterJob> converterJobList = converterService.getListConverterJob(converterJob);
			
			map.put("converterJobList", converterJobList);
			map.put("converterJobListSize", converterJobList.size());
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * 최근 converter-job-file
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-converter-job-file-widget.do")
	@ResponseBody
	public Map<String, Object> converterJobFileWidget(HttpServletRequest request) {
		
		log.info(" >>>>>>>>>>>>>>>>>>>>>>>>>>>> converterJobFileWidget");
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			String today = DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY);
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.DATE, -30);
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
			String searchDay = simpleDateFormat.format(calendar.getTime());
			String startDate = searchDay + DateUtil.START_TIME;
			String endDate = today + DateUtil.END_TIME;
			
			ConverterJobFile converterJobFile = new ConverterJobFile();
			converterJobFile.setUser_id(userSession.getUser_id());
			converterJobFile.setStart_date(startDate);
			converterJobFile.setEnd_date(endDate);
			converterJobFile.setOffset(0l);
			converterJobFile.setLimit(7l);
			List<ConverterJobFile> converterJobFileList = converterService.getListConverterJobFile(converterJobFile);
			
			map.put("converterJobFileList", converterJobFileList);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * 검색 조건
	 * @param dataInfo
	 * @return
	 */
	private String getSearchParameters(ConverterJob converterJob) {
		StringBuffer buffer = new StringBuffer();
		buffer.append("&");
		buffer.append("search_word=" + StringUtil.getDefaultValue(converterJob.getSearch_word()));
		buffer.append("&");
		buffer.append("search_option=" + StringUtil.getDefaultValue(converterJob.getSearch_option()));
		buffer.append("&");
		try {
			buffer.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(converterJob.getSearch_value()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			buffer.append("search_value=");
		}
		buffer.append("&");
		buffer.append("start_date=" + StringUtil.getDefaultValue(converterJob.getStart_date()));
		buffer.append("&");
		buffer.append("end_date=" + StringUtil.getDefaultValue(converterJob.getEnd_date()));
		buffer.append("&");
		buffer.append("order_word=" + StringUtil.getDefaultValue(converterJob.getOrder_word()));
		buffer.append("&");
		buffer.append("order_value=" + StringUtil.getDefaultValue(converterJob.getOrder_value()));
		return buffer.toString();
	}
	
	/**
	 * 파일 검색 조건
	 * @param dataInfo
	 * @return
	 */
	private String getSearchParametersConverterJobFile(ConverterJobFile converterJobFile) {
		StringBuffer buffer = new StringBuffer();
		buffer.append("&");
		buffer.append("search_word=" + StringUtil.getDefaultValue(converterJobFile.getSearch_word()));
		buffer.append("&");
		buffer.append("search_option=" + StringUtil.getDefaultValue(converterJobFile.getSearch_option()));
		buffer.append("&");
		try {
			buffer.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(converterJobFile.getSearch_value()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			buffer.append("search_value=");
		}
		buffer.append("&");
		buffer.append("start_date=" + StringUtil.getDefaultValue(converterJobFile.getStart_date()));
		buffer.append("&");
		buffer.append("end_date=" + StringUtil.getDefaultValue(converterJobFile.getEnd_date()));
		buffer.append("&");
		buffer.append("order_word=" + StringUtil.getDefaultValue(converterJobFile.getOrder_word()));
		buffer.append("&");
		buffer.append("order_value=" + StringUtil.getDefaultValue(converterJobFile.getOrder_value()));
		return buffer.toString();
	}
}