package com.gaia3d.controller;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.domain.APILog;
import com.gaia3d.domain.ExternalService;
import com.gaia3d.security.Crypt;
import com.gaia3d.service.APIService;
import com.gaia3d.service.RoleService;
import com.gaia3d.util.StringUtil;
import com.google.gson.Gson;

import lombok.extern.slf4j.Slf4j;

/**
 * API
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/api/")
public class APIController {
	
	@Autowired
	private MessageSource messageSource;
	
	@Autowired
	private APIService aPIService;
	@Autowired
	private RoleService roleService;
	
	/**
	 * Private API 목록
	 * @param model
	 * @return
	 */
	@GetMapping(value = "list-external-service.do")
	public String listExternalService(HttpServletRequest request, ExternalService externalService, Model model) {
		
		log.info("@@ externalService = {}", externalService);
		
		List<ExternalService> externalServiceList = aPIService.getListExternalService(externalService);
		long totalCount = externalServiceList.size();
		
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("externalServiceList", externalServiceList);
		return "/api/list-external-service";
	}
	
	/**
	 * Private API 수정 화면
	 * @param user_id
	 * @param model
	 * @return
	 */
	@GetMapping(value = "modify-external-service.do")
	public String modifyExternalService(@RequestParam("external_service_id") String external_service_id, Model model) {
		
		ExternalService externalService = aPIService.getExternalService(Long.valueOf(external_service_id));
		externalService.setApi_key(Crypt.decrypt(externalService.getApi_key()));

//		Server server = new Server();
//		List<Server> serverList = serverService.getListServer(server);
		
		model.addAttribute(externalService);
//		model.addAttribute("serverList", serverList);
		
		return "/api/modify-external-service";
	}
	
	/**
	 * Private API 수정
	 * @param request
	 * @param userInfo
	 * @return
	 */
	@PostMapping(value = "ajax-update-external-service.do")
	@ResponseBody
	public String ajaxUpdateExternalService(HttpServletRequest request, ExternalService externalService) {
		Gson gson = new Gson();
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
			externalService.setMethod_mode("update");
			String errorcode = externalService.validate();
			if(errorcode != null) {
				result = errorcode;
				jSONObject.put("result", result);
				return gson.toJson(jSONObject);
			}
						
			externalService.setApi_key(Crypt.encrypt(externalService.getApi_key()));
			aPIService.updateExternalService(externalService);
			
//			configCacheController.reloadExternalServiceCache();
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		
		return gson.toJson(jSONObject);
	}
	
	private String getSearchParameters(APILog aPILog) {
		StringBuilder builder = new StringBuilder(100);
		builder.append("&");
		builder.append("search_word=" + StringUtil.getDefaultValue(aPILog.getSearch_word()));
		builder.append("&");
		builder.append("search_option=" + StringUtil.getDefaultValue(aPILog.getSearch_option()));
		builder.append("&");
		try {
			builder.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(aPILog.getSearch_value()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			builder.append("search_value=");
		}
		builder.append("&");
		builder.append("success_yn=" + StringUtil.getDefaultValue(aPILog.getSuccess_yn()));
		builder.append("&");
		builder.append("start_date=" + StringUtil.getDefaultValue(aPILog.getStart_date()));
		builder.append("&");
		builder.append("end_date=" + StringUtil.getDefaultValue(aPILog.getEnd_date()));
		builder.append("&");
		builder.append("order_word=" + StringUtil.getDefaultValue(aPILog.getOrder_word()));
		builder.append("&");
		builder.append("order_value=" + StringUtil.getDefaultValue(aPILog.getOrder_value()));
		return builder.toString();
	}
}
