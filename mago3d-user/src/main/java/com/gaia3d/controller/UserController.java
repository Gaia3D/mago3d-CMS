package com.gaia3d.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.gaia3d.config.PropertiesConfig;
import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.CommonCode;
import com.gaia3d.domain.FileInfo;
import com.gaia3d.domain.Pagination;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.UserDevice;
import com.gaia3d.domain.UserGroup;
import com.gaia3d.domain.UserInfo;
import com.gaia3d.domain.UserSession;
import com.gaia3d.helper.PasswordHelper;
import com.gaia3d.security.Crypt;
import com.gaia3d.service.UserGroupService;
import com.gaia3d.service.UserService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.FileUtil;
import com.gaia3d.util.StringUtil;
import com.gaia3d.validator.UserValidator;

import lombok.extern.slf4j.Slf4j;

/**
 * 사용자
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/user/")
public class UserController {
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	
	@Resource(name="userValidator")
	private UserValidator userValidator;
	
	@Autowired
	private UserGroupService userGroupService;
	@Autowired
	private UserService userService;
//	@Autowired
//	private FileService fileService;
//	@Autowired
//	private UserDeviceService userDeviceService;
	
	/**
	 * 사용자 정보
	 * @param user_id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "detail-user.do")
	public String detailUser(@RequestParam("user_id") String user_id, HttpServletRequest request, Model model) {
		
		String listParameters = getListParameters(request);
			
		UserInfo userInfo =  userService.getUser(user_id);
//		UserDevice userDevice = userDeviceService.getUserDeviceByUserId(userInfo.getUser_id());
		
		Policy policy = CacheManager.getPolicy();
		
		model.addAttribute("policy", policy);
		model.addAttribute("listParameters", listParameters);
		model.addAttribute("userInfo", userInfo);
//		model.addAttribute("userDevice", userDevice);
		
		return "/user/detail-user";
	}
	
	/**
	 * 사용자 정보 수정 화면
	 * @param user_id
	 * @param model
	 * @return
	 */
	@GetMapping(value = "modify-user.do")
	public String modifyUser(@RequestParam("user_id") String user_id, HttpServletRequest request, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		String listParameters = getListParameters(request);
		
		UserGroup userGroup = new UserGroup();
		userGroup.setUse_yn(UserGroup.IN_USE);
		List<UserGroup> userGroupList = userGroupService.getListUserGroup(userGroup);
		UserInfo userInfo =  userService.getUser(user_id);
		userInfo.setTelephone(userInfo.getViewTelePhone());
		userInfo.setMobile_phone(userInfo.getViewMobilePhone());
		userInfo.setEmail(userInfo.getViewEmail());
		userInfo.setAddress_etc(userInfo.getViewAddressEtc());
		
		// TODO 고민을 해 보자. user_info랑 조인을 해서 가져올지, 그냥 가져 올지
//		UserDevice userDevice = userDeviceService.getUserDeviceByUserId(userInfo.getUser_id());
		
		log.info("@@@@@@@@ userInfo = {}", userInfo);
		if(userInfo.getTelephone() != null && !"".equals(userInfo.getTelephone())) {
			String[] telephone = userInfo.getTelephone().split("-");
			userInfo.setTelephone1(telephone[0]);
			userInfo.setTelephone2(telephone[1]);
			userInfo.setTelephone3(telephone[2]);
		}
		if(userInfo.getMobile_phone() != null && !"".equals(userInfo.getMobile_phone())) {
			if(userInfo.getMobile_phone().indexOf("-") > 0) {
				String[] mobile_phone = userInfo.getMobile_phone().split("-");
				userInfo.setMobile_phone1(mobile_phone[0]);
				userInfo.setMobile_phone2(mobile_phone[1]);
				userInfo.setMobile_phone3(mobile_phone[2]);
			} else {
				userInfo.setMobile_phone1(userInfo.getMobile_phone().substring(0, 3));
				userInfo.setMobile_phone2(userInfo.getMobile_phone().substring(3, 7));
				userInfo.setMobile_phone3(userInfo.getMobile_phone().substring(7));
			}
		}
		if(userInfo.getEmail() != null && !"".equals(userInfo.getEmail())) {
			String[] email = userInfo.getEmail().split("@");
			userInfo.setEmail1(email[0]);
			userInfo.setEmail2(email[1]);
		}
		
		Policy policy = CacheManager.getPolicy();
		
		String passwordExceptionChar = "";
		if(policy.getPassword_exception_char() != null && !"".equals(policy.getPassword_exception_char())) {
			for(int i=0; i< policy.getPassword_exception_char().length() - 1; i++) {
				passwordExceptionChar = passwordExceptionChar + "\\" + policy.getPassword_exception_char().substring(i, i+1);
			}
		}
		
		@SuppressWarnings("unchecked")
		List<CommonCode> emailCommonCodeList = (List<CommonCode>)CacheManager.getCommonCode(CommonCode.USER_EMAIL);
		@SuppressWarnings("unchecked")
		List<CommonCode> userRegisterTypeList = (List<CommonCode>)CacheManager.getCommonCode(CommonCode.USER_REGISTER_TYPE);
		
		model.addAttribute("passwordExceptionChar", passwordExceptionChar);
		model.addAttribute("emailCommonCodeList", emailCommonCodeList);
		model.addAttribute("userRegisterTypeList", userRegisterTypeList);
		model.addAttribute("listParameters", listParameters);
		model.addAttribute("policy", policy);
		model.addAttribute("userGroupList", userGroupList);
		model.addAttribute(userInfo);
//		model.addAttribute("userDevice", userDevice);
		
		return "/user/modify-user";
	}
	
	/**
	 * ajax 용 사용자 validation 체크
	 * @param userInfo
	 * @return
	 */
	private String userValidate(Policy policy, UserInfo userInfo) {
		
		// 비밀번호 변경이 아닐경우
		if(!"updatePassword".equals(userInfo.getMethod_mode())) {
			if(userInfo.getUser_id() == null || "".equals(userInfo.getUser_id())) {
				return "user.input.invalid";
			}
			
			if(userInfo.getUser_group_id() == null || userInfo.getUser_group_id() <= 0
					|| userInfo.getUser_name() == null || "".equals(userInfo.getUser_name())) {
				return "user.input.invalid";
			}
		}
		
		if("insert".equals(userInfo.getMethod_mode())) {
			if(userInfo.getUser_id().length() < policy.getUser_id_min_length()) {
				return "user.id.min_length.invalid";
			}
			if(!"0".equals(userInfo.getDuplication_value())) {
				return "user.id.duplication";
			}
		}
		
		// 사용자 정보 수정화면에서는 Password가 있을 경우만 체크
		if("update".equals(userInfo.getMethod_mode())) {
			if(userInfo.getPassword() == null || "".equals(userInfo.getPassword())
				|| userInfo.getPassword_confirm() == null || "".equals(userInfo.getPassword_confirm())) {
				return null;
			}
		} 
		
		return PasswordHelper.validateUserPassword(CacheManager.getPolicy(), userInfo);
	}
	
	/**
	 * 사용자 정보 수정
	 * @param request
	 * @param userInfo
	 * @return
	 */
	@PostMapping(value = "ajax-update-user-info.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String, Object> ajaxUpdateUserInfo(HttpServletRequest request, UserInfo userInfo) {
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
			Policy policy = CacheManager.getPolicy();
			userInfo.setMethod_mode("update");
			String errorcode = userValidate(policy,userInfo);
			if(errorcode != null) {
				result = errorcode;
				jSONObject.put("result", result);
				return jSONObject;
			}
						
			UserInfo dbUserInfo = userService.getUser(userInfo.getUser_id());
			String encryptPassword = null;
			ShaPasswordEncoder shaPasswordEncoder = new ShaPasswordEncoder(512);
			shaPasswordEncoder.setIterations(1000);
			// 비밀번호의 경우 입력값이 있을때만 수정
			if(userInfo.getPassword() != null && !"".equals(userInfo.getPassword())
					&& userInfo.getPassword_confirm() != null && !"".equals(userInfo.getPassword_confirm())) {
				
				encryptPassword = shaPasswordEncoder.encodePassword(userInfo.getPassword(), dbUserInfo.getSalt()) ;
				if("".equals(encryptPassword)) {
					log.info("@@ password error!");
					result = "user.password.exception";
					jSONObject.put("result", result);
					return jSONObject;
				}
			}
			
			if(userInfo.getTelephone1() != null && !"".equals(userInfo.getTelephone1()) &&
					userInfo.getTelephone2() != null && !"".equals(userInfo.getTelephone2()) &&
							userInfo.getTelephone3() != null && !"".equals(userInfo.getTelephone3())) {
				userInfo.setTelephone(userInfo.getTelephone1()+"-"+userInfo.getTelephone2()+"-"+userInfo.getTelephone3());
			}
			if(userInfo.getMobile_phone1() != null && !"".equals(userInfo.getMobile_phone1()) &&
					userInfo.getMobile_phone2() != null && !"".equals(userInfo.getMobile_phone2()) &&
					userInfo.getMobile_phone3() != null && !"".equals(userInfo.getMobile_phone3())) {
				userInfo.setMobile_phone(userInfo.getMobile_phone1()+"-"+userInfo.getMobile_phone2()+"-"+userInfo.getMobile_phone3());
			}
			if(userInfo.getEmail1() != null && !"".equals(userInfo.getEmail1()) &&
					userInfo.getEmail2() != null && !"".equals(userInfo.getEmail2())) {
				userInfo.setEmail(userInfo.getEmail1()+"@"+userInfo.getEmail2());
			}
			
			userInfo.setPassword(encryptPassword);
			userInfo.setTelephone(Crypt.encrypt(userInfo.getTelephone()));
			userInfo.setMobile_phone(Crypt.encrypt(userInfo.getMobile_phone()));
			userInfo.setEmail(Crypt.encrypt(userInfo.getEmail()));
			userInfo.setAddress_etc(Crypt.encrypt(userInfo.getAddress_etc()));
			
			if(!UserInfo.STATUS_USE.equals(dbUserInfo.getStatus())) {
				log.info("@@ dbUserInfo.getStatus() = {}", dbUserInfo.getStatus());	
				if(UserInfo.STATUS_USE.equals(userInfo.getStatus())) {
					// 실패 횟수 잠금 이었던 경우는 실패 횟수를 초기화
					// 휴면 계정이었던 경우 마지막 로그인 시간을 갱신
					userInfo.setFail_login_count(0);
				} else if(UserInfo.STATUS_TEMP_PASSWORD.equals(userInfo.getStatus())) {
					userInfo.setFail_login_count(0);
					log.info("@@ userInfo.getStatus() = {}", userInfo.getStatus());	
					// 임시 비밀번호로 변경
					boolean isUserIdUse = false;
					String initPassword =  policy.getPassword_create_char();
					if(Policy.PASSWORD_CREATE_WITH_USER_ID.equals(policy.getPassword_create_type())) {
						isUserIdUse = true;
					}
					
					String password = null;
					if(isUserIdUse) {
						password = shaPasswordEncoder.encodePassword(userInfo.getUser_id() + initPassword, dbUserInfo.getSalt());
					} else {
						password = shaPasswordEncoder.encodePassword(initPassword, dbUserInfo.getSalt());
					}
					log.info("@@ password = {}", password);	
					userInfo.setPassword(password);
					
					// DB 처리
					if(UserInfo.STATUS_FAIL_LOGIN_COUNT_OVER.equals(dbUserInfo.getStatus())) {
						// status = 2. 비밀번호 실패 횟수 초과 잠금의 경우 실패 횟수 count = 0
					} else if(UserInfo.STATUS_SLEEP.equals(userInfo.getStatus())) {
						// status = 3. 휴면의 경우 last_login_date = 현재 시간으로 update 해줘야 함
					}
				}
				userInfo.setDb_status(dbUserInfo.getStatus());
			} else {
				if(UserInfo.STATUS_TEMP_PASSWORD.equals(userInfo.getStatus())) {
					log.info("@@ userInfo.getStatus() = {}", userInfo.getStatus());	
					// 임시 비밀번호로 변경
					boolean isUserIdUse = false;
					String initPassword =  policy.getPassword_create_char();
					if(Policy.PASSWORD_CREATE_WITH_USER_ID.equals(policy.getPassword_create_type())) {
						isUserIdUse = true;
					}
					
					String password = null;
					if(isUserIdUse) {
						password = shaPasswordEncoder.encodePassword(userInfo.getUser_id() + initPassword, dbUserInfo.getSalt());
					} else {
						password = shaPasswordEncoder.encodePassword(initPassword, dbUserInfo.getSalt());
					}
					log.info("@@ password = {}", password);	
					userInfo.setPassword(password);
				}
			}
			userService.updateUser(userInfo);
			
			userInfo.setMobile_phone(userInfo.getViewMobilePhone());
			userInfo.setEmail(userInfo.getViewEmail());
			jSONObject.put("maskingMobilePhone", userInfo.getMaskingMobilePhone());
			jSONObject.put("maskingEmail", userInfo.getMaskingEmail());
			jSONObject.put("messanger", userInfo.getMessanger());
			
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		
		return jSONObject;
	}
	
	/**
	 * 사용자 비밀번호 초기화
	 * @param request
	 * @param userInfo
	 * @return
	 */
	@PostMapping(value = "ajax-init-user-password.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String, Object> ajaxInitUserPassword(	HttpServletRequest request, 
										@RequestParam("check_ids") String check_ids) {
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
			if(check_ids.length() <= 0) {
				jSONObject.put("result", "check.value.required");
				return jSONObject;
			}
			userService.updateUserPasswordInit(check_ids);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		
		return jSONObject;
	}
	
	/**
	 * 패스워드 강제 변경 페이지
	 * @param request
	 * @param userInfo
	 * @param bindingResult
	 * @param model
	 * @return
	 */
	@GetMapping(value = "modify-password.do")
	public String modifyPassword(HttpServletRequest request, Model model) {
		model.addAttribute("policy", CacheManager.getPolicy());
		model.addAttribute("userInfo", new UserInfo());
		return "/user/modify-password";
	}
	
	/**
	 * 비밀번호 수정
	 * @param request
	 * @param userInfo
	 * @param bindingResult
	 * @param model
	 * @return
	 */
	@PostMapping(value = "update-password.do")
	public String updatePassword(HttpServletRequest request, @ModelAttribute("userInfo") UserInfo userInfo, BindingResult bindingResult, Model model) {
		
		Policy policy = CacheManager.getPolicy();
		// TODO validator 이용하게 수정해야 함
		
		// 등록, 수정 화면의 validation 항목이 다를 경우를 위한 변수
		userInfo.setMethod_mode("updatePassword");

		String errorcode = userValidate(policy, userInfo);
		if(errorcode != null) {
			log.info("@@@@@@@@@@@@@ errcode = {}", errorcode);
			userInfo.setError_code(errorcode);
			model.addAttribute("policy", CacheManager.getPolicy());
			return "/user/modify-password";		
		}
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
		UserInfo dbUserInfo = userService.getUser(userSession.getUser_id());
		
		ShaPasswordEncoder shaPasswordEncoder = new ShaPasswordEncoder(512);
		shaPasswordEncoder.setIterations(1000);
		String PasswordCheck = shaPasswordEncoder.encodePassword(userInfo.getPassword(), dbUserInfo.getSalt());
		if(!(PasswordCheck.equals(dbUserInfo.getPassword())) ){
			errorcode = "user.password.compare.invalid";
			log.info("@@@@@@@@@@@@@ errcode = {}", errorcode);
			userInfo.setError_code(errorcode);
			model.addAttribute("policy", CacheManager.getPolicy());
			return "/user/modify-password";
		}
		
		String encryptPassword = shaPasswordEncoder.encodePassword(userInfo.getNew_password(), dbUserInfo.getSalt());
		userInfo.setUser_id(userSession.getUser_id());
		userInfo.setPassword(encryptPassword);
		userInfo.setStatus(UserInfo.STATUS_USE);
		userService.updatePassword(userInfo);
		
		// 임시 패스워드인 경우 세션을 사용중 상태로 변경
		if(UserInfo.STATUS_TEMP_PASSWORD.equals(userSession.getStatus())) {
			userSession.setStatus(UserInfo.STATUS_USE);
		}
	
		return "redirect:/main/index.do";
	}
	
	/**
	 * 사용자 그룹 정보
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-user-group-info.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String, Object> ajaxUserGroupInfo(HttpServletRequest request, @RequestParam("user_group_id") Long user_group_id) {
		
		log.info("@@@@@@@ user_group_id = {}", user_group_id);
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		UserGroup userGroup = null;
		try {	
			userGroup = userGroupService.getUserGroup(user_group_id);
			log.info("@@@@@@@ userGroup = {}", userGroup);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		jSONObject.put("result", result);
		jSONObject.put("userGroup", userGroup);
		
		return jSONObject;
	}
	
	/**
	 * 검색 조건
	 * @param userInfo
	 * @return
	 */
	private String getSearchParameters(UserInfo userInfo) {
		// TODO 아래 메소드랑 통합
		StringBuilder builder = new StringBuilder(100);
		builder.append("&");
		builder.append("search_word=" + StringUtil.getDefaultValue(userInfo.getSearch_word()));
		builder.append("&");
		builder.append("search_option=" + StringUtil.getDefaultValue(userInfo.getSearch_option()));
		builder.append("&");
		try {
			builder.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(userInfo.getSearch_value()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			builder.append("search_value=");
		}
		builder.append("&");
		builder.append("user_group_id=" + userInfo.getUser_group_id());
		builder.append("&");
		builder.append("status=" + StringUtil.getDefaultValue(userInfo.getStatus()));
		builder.append("&");
		builder.append("user_insert_type=" + StringUtil.getDefaultValue(userInfo.getUser_insert_type()));
		builder.append("&");
		builder.append("start_date=" + StringUtil.getDefaultValue(userInfo.getStart_date()));
		builder.append("&");
		builder.append("end_date=" + StringUtil.getDefaultValue(userInfo.getEnd_date()));
		builder.append("&");
		builder.append("order_word=" + StringUtil.getDefaultValue(userInfo.getOrder_word()));
		builder.append("&");
		builder.append("order_value=" + StringUtil.getDefaultValue(userInfo.getOrder_value()));
		builder.append("&");
		builder.append("list_count=" + userInfo.getList_counter());
		return builder.toString();
	}
	
	/**
	 * 목록 페이지 이동 검색 조건
	 * @param request
	 * @return
	 */
	private String getListParameters(HttpServletRequest request) {
		StringBuilder builder = new StringBuilder(100);
		String pageNo = request.getParameter("pageNo");
		builder.append("pageNo=" + pageNo);
		builder.append("&");
		builder.append("search_word=" + StringUtil.getDefaultValue(request.getParameter("search_word")));
		builder.append("&");
		builder.append("search_option=" + StringUtil.getDefaultValue(request.getParameter("search_option")));
		builder.append("&");
		try {
			builder.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(request.getParameter("search_value")), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			builder.append("search_value=");
		}
		builder.append("&");
		builder.append("user_group_id=" + request.getParameter("user_group_id"));
		builder.append("&");
		builder.append("status=" + StringUtil.getDefaultValue(request.getParameter("status")));
		builder.append("&");
		builder.append("user_insert_type=" + StringUtil.getDefaultValue(request.getParameter("user_insert_type")));
		builder.append("&");
		builder.append("start_date=" + StringUtil.getDefaultValue(request.getParameter("start_date")));
		builder.append("&");
		builder.append("end_date=" + StringUtil.getDefaultValue(request.getParameter("end_date")));
		builder.append("&");
		builder.append("order_word=" + StringUtil.getDefaultValue(request.getParameter("order_word")));
		builder.append("&");
		builder.append("order_value=" + StringUtil.getDefaultValue(request.getParameter("order_value")));
		builder.append("&");
		builder.append("list_count=" + StringUtil.getDefaultValue(request.getParameter("list_count")));
		return builder.toString();
	}
}