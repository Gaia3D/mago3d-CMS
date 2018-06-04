package com.gaia3d.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.Issue;
import com.gaia3d.domain.Pagination;
import com.gaia3d.domain.SessionKey;
import com.gaia3d.domain.UserSession;
import com.gaia3d.service.DataService;
import com.gaia3d.service.FileUploadService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.FormatUtil;
import com.gaia3d.util.StringUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * Data Upload
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/fileupload/")
public class FileUploadController {
	
	@Autowired
	private FileUploadService fileUploadService;
	
	/**
	 * data upload
	 * @param model
	 * @return
	 */
	@GetMapping(value = "input-fileupload.do")
	public String uploadData(HttpServletRequest request, Model model) {
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
		
		
		model.addAttribute("dataInfo", new DataInfo());
		return "/fileupload/input-fileupload";
	}
	
//	/**
//	 * 검색 조건
//	 * @param dataInfo
//	 * @return
//	 */
//	private String getSearchParameters(DataInfo dataInfo) {
//		StringBuilder builder = new StringBuilder(100);
//		builder.append("&");
//		builder.append("search_word=" + StringUtil.getDefaultValue(dataInfo.getSearch_word()));
//		builder.append("&");
//		builder.append("search_option=" + StringUtil.getDefaultValue(dataInfo.getSearch_option()));
//		builder.append("&");
//		try {
//			builder.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(dataInfo.getSearch_value()), "UTF-8"));
//		} catch(Exception e) {
//			e.printStackTrace();
//			builder.append("search_value=");
//		}
//		builder.append("&");
//		builder.append("start_date=" + StringUtil.getDefaultValue(dataInfo.getStart_date()));
//		builder.append("&");
//		builder.append("end_date=" + StringUtil.getDefaultValue(dataInfo.getEnd_date()));
//		builder.append("&");
//		builder.append("order_word=" + StringUtil.getDefaultValue(dataInfo.getOrder_word()));
//		builder.append("&");
//		builder.append("order_value=" + StringUtil.getDefaultValue(dataInfo.getOrder_value()));
//		return builder.toString();
//	}
}