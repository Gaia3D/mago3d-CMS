//package com.gaia3d.controller;
//
//import javax.annotation.Resource;
//import javax.servlet.http.HttpServletRequest;
//
//import org.apache.commons.lang.StringUtils;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.validation.BindingResult;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import kr.co.gt1000.domain.License;
//import kr.co.gt1000.service.LicenseService;
//import kr.co.gt1000.validator.LicenseValidator;
//import lombok.extern.slf4j.Slf4j;
//import net.sf.json.map;
//
///**
// * 라이센스
// * @author jeongdae
// *
// */
//@Slf4j
//@Controller
//@RequestMapping("/config/")
//public class LicenseController {
//	
//	@Autowired
//	private ConfigCacheController configCacheController;
//	@Resource(name="licenseValidator")
//	private LicenseValidator licenseValidator;
//	@Autowired
//	private LicenseService licenseService;
//	
//	/**
//	 * 라이센스 수정 화면
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value = "modify-license.do", method = RequestMethod.GET)
//	public String modifyLicense(HttpServletRequest request, Model model) {
//		
//		License license = licenseService.getLicense();
//		
//		log.info("@@@@@@@@@@@@@ license = {}", license);
//		model.addAttribute("licenseForm", license);
//		
//		return "/config/modify-license";
//	}
//	
//	/**
//	 * 라이선스 수정
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value = "update-license.do", method = RequestMethod.POST)
//	public String updateLicense(@ModelAttribute("licenseForm") License license, BindingResult bindingResult, Model model) {
//		
//		// 등록, 수정 화면의 validation 항목이 다를 경우를 위한 변수
//		license.setMethod_mode("update");
//		this.licenseValidator.validate(license, bindingResult);
//		if(bindingResult.hasErrors()) {
//			log.info("@@ validation error!");
//			return "/config/modify-license";
//		}
//		
//		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ license = {}", license);
//		license = licenseService.updateLicense(license);
//		if(StringUtils.isNotEmpty(license.getError_code())) {
//			log.info("@@ License update error! error = {}", license.getError_code());
//			return "/config/modify-license";
//		}
//		
//		return "redirect:/config/result-license.do?method_mode=update";
//	}
//	
//	/**
//	 * 라이선스 수정
//	 * @param request
//	 * @param policy
//	 * @return
//	 */
//	@RequestMapping(value = "ajax-update-license.do", method = RequestMethod.POST)
//	@ResponseBody
//	public String ajaxUpdatePolicyContent(HttpServletRequest request, License license) {
//		map map = new map();
//		String result = "success";
//		try {
//			log.info("@@ license = {} ", license);
//			if( StringUtils.isEmpty(license.getCompany_name())
//					|| license.getServer_count() <= 0
//					|| license.getOtp_user_count() <= 0
//					|| StringUtils.isEmpty(license.getLicense())) {
//				result = "license.input.invalid";
//				map.put("result", result);
//				
//				return map.toString();
//			}
//			
//			log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ license = {}", license);
//			license = licenseService.updateLicense(license);
//			if(StringUtils.isNotEmpty(license.getError_code())) {
//				result = "license.checker.invalid";
//				map.put("result", result);
//				
//				return map.toString();
//			}
//			
//			configCacheController.reloadCheckLicense();
//		} catch(Exception e) {
//			e.printStackTrace();
//			result = "db.exception";
//		}
//	
//		map.put("result", result);
//		return map.toString();
//	}
//	
//	/**
//	 * 라이선스 수정 처리 결과 페이지
//	 * @param request
//	 * @param method_mode
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value = "result-license.do", method = RequestMethod.GET)
//	public String resultLicense(HttpServletRequest request, @RequestParam("method_mode") String method_mode, Model model) {
//		
//		model.addAttribute("method_mode", method_mode);
//		
//		return "/config/result-license";
//	}
//}
