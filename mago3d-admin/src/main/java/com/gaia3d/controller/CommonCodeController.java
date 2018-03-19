package com.gaia3d.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.config.CacheConfig;
import com.gaia3d.domain.CommonCode;
import com.gaia3d.service.CommonCodeService;

import lombok.extern.slf4j.Slf4j;

/**
 * 공통 코드
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/code/")
public class CommonCodeController {
	
	@Autowired
	private CacheConfig cacheConfig;
	@Autowired
	private CommonCodeService commonCodeService;
	
	/**
	 * 공통 코드 목록
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list-code.do")
	public String listCode(HttpServletRequest request, Model model) {
		List<CommonCode> commonCodeList = commonCodeService.getListCommonCode();

		model.addAttribute("commonCodeList", commonCodeList);
		model.addAttribute("commonCodeListSize", commonCodeList.size());
		return "/code/list-code";
	}
	
	/**
	 * 공콩 코드 등록
	 * @param model
	 * @return
	 */
	@GetMapping(value = "input-code.do")
	public String inputCode(Model model) {
		CommonCode commonCode = new CommonCode();
		
		model.addAttribute("commonCode", commonCode);
		return "/code/input-code";
	}
	
	/**
	 * 공통 코드 등록
	 * @param request
	 * @param commonCode
	 * @return
	 */
	@PostMapping(value = "ajax-insert-code.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String, String> ajaxInsertCode(HttpServletRequest request, CommonCode commonCode) {
		Map<String, String> jSONObject = new HashMap<>();
		String result = "success";
		try {
			log.info("@@@@@@ commonCode = {}", commonCode);
			String errorcode = commonCode.validate();
			if(errorcode != null) {
				result = errorcode;
				jSONObject.put("result", result);
				log.info("validate error 발생: {} " ,jSONObject.toString());
				return jSONObject;
			}			
			commonCodeService.insertCommonCode(commonCode);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		
		return jSONObject;
	}
	
	/**
	 * 공통 코드 수정
	 * @param request
	 * @param commonCode
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "modify-code.do")
	public String modifyCode(HttpServletRequest request, CommonCode commonCode, Model model) {
		commonCode = commonCodeService.getCommonCode(commonCode.getCode_key());
		commonCode.setDb_code_value(commonCode.getCode_value());
		model.addAttribute(commonCode);
		return "/code/modify-code";
	}
	
	/**
	 * 공통 코드 정보 수정
	 * @param request
	 * @param commonCode
	 * @return
	 */
	@PostMapping(value = "ajax-update-code.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String, String> ajaxUpdateCode(HttpServletRequest request, CommonCode commonCode) {
		
		Map<String, String> jSONObject = new HashMap<>();
		String result = "success";
		try {
			log.info("@@@@@@ commonCode = {}", commonCode);
			String errorcode = commonCode.validate();
			if(errorcode != null) {
				result = errorcode;
				jSONObject.put("result", result);
				log.info("validate error 발생: {} " ,jSONObject.toString());
				return jSONObject;
			}
			commonCodeService.updateCommonCode(commonCode);
			
//			configCacheController.reloadCommonCodeCache();
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		
		return jSONObject;
	}
	
	/**
	 * 공통 코드 정보 삭제
	 * @param request
	 * @param commonCode
	 * @return
	 */
	@PostMapping(value = "ajax-delete-code.do", produces ="application/json; charset=utf8")
	@ResponseBody
	public Map<String, String> ajaxDeleteCode(HttpServletRequest request, CommonCode commonCode) {
		Map<String, String> jSONObject = new HashMap<>();
		String result = "success";
		try {
			log.info("@@@@@@ code_key = {}, view_order = {}", commonCode.getCode_key(), commonCode.getView_order());
			if(commonCode.getCode_key() == null || "".equals(commonCode.getCode_key())
					|| commonCode.getView_order() == null || commonCode.getView_order().intValue() <= 0) {
				jSONObject.put("result", "common_code.code_key.required");
				log.info("validate error 발생: {} " ,jSONObject.toString());
				return jSONObject;
			}
			commonCodeService.deleteCommonCode(commonCode.getCode_key());
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		
		return jSONObject;
	}
	
	/**
	 * 공통 코드 정보
	 * @param request
	 * @param commonCode
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "detail-code.do")
	public String detailCode(HttpServletRequest request, CommonCode commonCode, Model model) {
		commonCode = commonCodeService.getCommonCode(commonCode.getCode_key());
		model.addAttribute("commonCode", commonCode);
		return "/code/detail-code";
	}
}
