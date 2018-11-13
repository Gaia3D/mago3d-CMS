package com.gaia3d.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gaia3d.config.PropertiesConfig;
import com.gaia3d.domain.ConverterUploadLog;
import com.gaia3d.domain.Pagination;
import com.gaia3d.domain.UserSession;
import com.gaia3d.service.ConverterUploadService;
import com.gaia3d.service.ProjectService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.StringUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * Data Upload
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/converter/")
public class ConverterUploadController {
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	@Autowired
	private ConverterUploadService converterUploadService;
	@Autowired
	private ProjectService projectService;
	
	/**
	 * 사용자가 uploading 한 파일 목록
	 * @param request
	 * @param issue
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "input-converter-job.do")
	public String inputConverterJob(HttpServletRequest request, ConverterUploadLog converterUploadLog, @RequestParam(defaultValue="1") String pageNo, Model model) {
		log.info("@@ converterUploadLog = {}", converterUploadLog);
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
		converterUploadLog.setUser_id(userSession.getUser_id());
		
		if(StringUtil.isNotEmpty(converterUploadLog.getStart_date())) {
			converterUploadLog.setStart_date(converterUploadLog.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isNotEmpty(converterUploadLog.getEnd_date())) {
			converterUploadLog.setEnd_date(converterUploadLog.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}
		long totalCount = converterUploadService.getListConverterUploadLogTotalCount(converterUploadLog);
		
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(converterUploadLog), totalCount, Long.valueOf(pageNo).longValue());
		log.info("@@ pagination = {}", pagination);
		
		converterUploadLog.setOffset(pagination.getOffset());
		converterUploadLog.setLimit(pagination.getPageRows());
		List<ConverterUploadLog> converterUploadLogList = new ArrayList<>();
		if(totalCount > 0l) {
			converterUploadLogList = converterUploadService.getListConverterUploadLog(converterUploadLog);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("converterUploadLogList", converterUploadLogList);
		
		return "/converter/input-converter-job";
	}
	
	/**
	 * 검색 조건
	 * @param dataInfo
	 * @return
	 */
	private String getSearchParameters(ConverterUploadLog converterUploadLog) {
		StringBuffer buffer = new StringBuffer();
		buffer.append("&");
		buffer.append("search_word=" + StringUtil.getDefaultValue(converterUploadLog.getSearch_word()));
		buffer.append("&");
		buffer.append("search_option=" + StringUtil.getDefaultValue(converterUploadLog.getSearch_option()));
		buffer.append("&");
		try {
			buffer.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(converterUploadLog.getSearch_value()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			buffer.append("search_value=");
		}
		buffer.append("&");
		buffer.append("start_date=" + StringUtil.getDefaultValue(converterUploadLog.getStart_date()));
		buffer.append("&");
		buffer.append("end_date=" + StringUtil.getDefaultValue(converterUploadLog.getEnd_date()));
		buffer.append("&");
		buffer.append("order_word=" + StringUtil.getDefaultValue(converterUploadLog.getOrder_word()));
		buffer.append("&");
		buffer.append("order_value=" + StringUtil.getDefaultValue(converterUploadLog.getOrder_value()));
		return buffer.toString();
	}
}