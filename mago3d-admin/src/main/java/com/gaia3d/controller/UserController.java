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
import com.gaia3d.service.FileService;
import com.gaia3d.service.UserDeviceService;
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
	@Autowired
	private FileService fileService;
	@Autowired
	private UserDeviceService userDeviceService;
	
	/**
	 * 사용자 목록
	 * @param request
	 * @param userInfo
	 * @param pageNo
	 * @param list_counter
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list-user.do")
	public String listUser(	HttpServletRequest request, UserInfo userInfo, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		log.info("@@ userInfo = {}", userInfo);
		UserGroup userGroup = new UserGroup();
		userGroup.setUse_yn(UserGroup.IN_USE);
		List<UserGroup> userGroupList = userGroupService.getListUserGroup(userGroup);
		if(userInfo.getUser_group_id() == null) {
			userInfo.setUser_group_id(Long.valueOf(0l));
		}
		if(StringUtil.isNotEmpty(userInfo.getStart_date())) {
			userInfo.setStart_date(userInfo.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isNotEmpty(userInfo.getEnd_date())) {
			userInfo.setEnd_date(userInfo.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}

		// 논리적 삭제는 SELECT에서 제외
//		userInfo.setDelete_flag(UserInfo.STATUS_LOGICAL_DELETE);
		long totalCount = userService.getUserTotalCount(userInfo);
		
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(userInfo), totalCount, Long.valueOf(pageNo).longValue(), userInfo.getList_counter());
		log.info("@@ pagination = {}", pagination);
		
		userInfo.setOffset(pagination.getOffset());
		userInfo.setLimit(pagination.getPageRows());
		List<UserInfo> userList = new ArrayList<UserInfo>();
		if(totalCount > 0l) {
			userList = userService.getListUser(userInfo);
		}
		
		boolean txtDownloadFlag = false;
		if(totalCount > 60000l) {
			txtDownloadFlag = true;
		}
		
		@SuppressWarnings("unchecked")
		List<CommonCode> userRegisterTypeList = (List<CommonCode>)CacheManager.getCommonCode(CommonCode.USER_REGISTER_TYPE);
		
		model.addAttribute(pagination);
		model.addAttribute("commonCodeMap", CacheManager.getCommonCodeMap());
		model.addAttribute("userRegisterTypeList", userRegisterTypeList);
		model.addAttribute("userGroupList", userGroupList);
		model.addAttribute("txtDownloadFlag", Boolean.valueOf(txtDownloadFlag));
		model.addAttribute("userList", userList);
		model.addAttribute("excelUserInfo", userInfo);
		return "/user/list-user";
	}
	
	/**
	 * 사용자 그룹 등록된 사용자 목록
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-list-user-group-user.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String, Object> ajaxListUserGroupUser(HttpServletRequest request, @RequestParam("user_group_id") Long user_group_id, @RequestParam(defaultValue="1") String pageNo) {
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		Pagination pagination = null;
		List<UserInfo> userList = new ArrayList<UserInfo>();
		try {		
			UserInfo userInfo = new UserInfo();
			userInfo.setUser_group_id(user_group_id);
			
			long totalCount = userService.getUserTotalCount(userInfo);
			pagination = new Pagination(request.getRequestURI(), getSearchParameters(userInfo), totalCount, Long.valueOf(pageNo).longValue());
			
			userInfo.setOffset(pagination.getOffset());
			userInfo.setLimit(pagination.getPageRows());
			if(totalCount > 0l) {
				userList = userService.getListUser(userInfo);
			}
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		jSONObject.put("result", result);
		jSONObject.put("pagination", pagination);
		jSONObject.put("userList", userList);
		
		log.info(">>>>>>>>>>>>>>>>>> userlist = {}", jSONObject);
		
		return jSONObject;
	}
	
	/**
	 * 사용자 그룹 전체 User 에서 선택한 사용자 그룹에 등록된 User 를 제외한 User 목록
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-list-except-user-group-user-by-group-id.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String, Object> ajaxListExceptUserGroupUserByGroupId(HttpServletRequest request, UserInfo userInfo, @RequestParam(defaultValue="1") String pageNo) {
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		Pagination pagination = null;
		List<UserInfo> userList = new ArrayList<UserInfo>();
		try {
			long totalCount = userService.getExceptUserGroupUserByGroupIdTotalCount(userInfo);
			pagination = new Pagination(request.getRequestURI(), getSearchParameters(userInfo), totalCount, Long.valueOf(pageNo).longValue());
			
			userInfo.setOffset(pagination.getOffset());
			userInfo.setLimit(pagination.getPageRows());
			if(totalCount > 0l) {
				userList = userService.getListExceptUserGroupUserByGroupId(userInfo);
			}
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		jSONObject.put("result", result);
		jSONObject.put("pagination", pagination);
		jSONObject.put("userList", userList);
		return jSONObject;
	}
	
	/**
	 * 선택한 사용자 그룹에 등록된 User 목록
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-list-user-group-user-by-group-id.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String, Object> ajaxListUserGroupUserByGroupId(HttpServletRequest request, UserInfo userInfo, @RequestParam(defaultValue="1") String pageNo) {
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		Pagination pagination = null;
		List<UserInfo> userList = new ArrayList<UserInfo>();
		try {
			
			long totalCount = userService.getUserTotalCount(userInfo);
			pagination = new Pagination(request.getRequestURI(), getSearchParameters(userInfo), totalCount, Long.valueOf(pageNo).longValue());
			
			userInfo.setOffset(pagination.getOffset());
			userInfo.setLimit(pagination.getPageRows());
			if(totalCount > 0l) {
				userList = userService.getListUser(userInfo);
			}
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		jSONObject.put("result", result);
		jSONObject.put("pagination", pagination);
		jSONObject.put("userList", userList);
		return jSONObject;
	}
	
	/**
	 * 사용자 등록 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "input-user.do")
	public String inputUser(Model model) {
		
		UserGroup userGroup = new UserGroup();
		userGroup.setUse_yn(UserGroup.IN_USE);
		List<UserGroup> userGroupList = userGroupService.getListUserGroup(userGroup);
		
		Policy policy = CacheManager.getPolicy();
		UserInfo userInfo = new UserInfo();
		UserDevice userDevice = new UserDevice();
		
		String passwordExceptionChar = "";
		if(policy.getPassword_exception_char() != null && !"".equals(policy.getPassword_exception_char())) {
			for(int i=0; i< policy.getPassword_exception_char().length() - 1; i++) {
				passwordExceptionChar = passwordExceptionChar + "\\" + policy.getPassword_exception_char().substring(i, i+1);
			}
		}
		
		@SuppressWarnings("unchecked")
		List<CommonCode> emailCommonCodeList = (List<CommonCode>)CacheManager.getCommonCode(CommonCode.USER_EMAIL);
		
		model.addAttribute("passwordExceptionChar", passwordExceptionChar);
		model.addAttribute("emailCommonCodeList", emailCommonCodeList);
		model.addAttribute(userInfo);
		model.addAttribute("policy", policy);
		model.addAttribute("userGroupList", userGroupList);
		model.addAttribute("userDevice", userDevice);
		return "/user/input-user";
	}
	
	/**
	 * 사용자 등록
	 * @param request
	 * @param userInfo
	 * @return
	 */
	@PostMapping(value = "ajax-insert-user-info.do")
	@ResponseBody
	public Map<String, Object> ajaxInsertUserInfo(HttpServletRequest request, UserInfo userInfo) {
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
			userInfo.setMethod_mode("insert");
			String errorcode = userValidate(CacheManager.getPolicy(), userInfo);
			if(errorcode != null) {
				result = errorcode;
				jSONObject.put("result", result);
				return jSONObject;
			}
			
			int count = userService.getDuplicationIdCount(userInfo.getUser_id());
			if(count > 0) {
				result = "user.id.duplication";
				jSONObject.put("result", result);
				return jSONObject;
			}
			
			String salt = BCrypt.gensalt();
			ShaPasswordEncoder shaPasswordEncoder = new ShaPasswordEncoder(512);
			shaPasswordEncoder.setIterations(1000);
			String encryptPassword = shaPasswordEncoder.encodePassword(userInfo.getPassword(), salt);
			
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
			
			userInfo.setSalt(salt);
			userInfo.setPassword(encryptPassword);
			userInfo.setTelephone(Crypt.encrypt(userInfo.getTelephone()));
			userInfo.setMobile_phone(Crypt.encrypt(userInfo.getMobile_phone()));
			userInfo.setEmail(Crypt.encrypt(userInfo.getEmail()));
			userInfo.setAddress_etc(Crypt.encrypt(userInfo.getAddress_etc()));
						
			userService.insertUser(userInfo);
			
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
	 * 선택 사용자 그룹내 사용자 등록
	 * @param request
	 * @param user_all_id
	 * @param user_group_id
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-insert-user-group-user.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String, Object> ajaxInsertUserGroupUser(HttpServletRequest request,
			@RequestParam("user_group_id") Long user_group_id,
			@RequestParam("user_all_id") String[] user_all_id) {
		
		log.info("@@@ user_group_id = {}, user_all_id = {}", user_group_id, user_all_id);
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		List<UserInfo> exceptUserList = new ArrayList<UserInfo>();
		List<UserInfo> userList = new ArrayList<UserInfo>();
		String result = "success";
		try {
			if(user_group_id == null || user_group_id.longValue() == 0l ||				
					user_all_id == null || user_all_id.length < 1) {
				result = "input.invalid";
				jSONObject.put("result", result);
				return jSONObject;
			}
			
			UserInfo userInfo = new UserInfo();
			userInfo.setUser_group_id(user_group_id);
			userInfo.setUser_all_id(user_all_id);
			
			userService.updateUserGroupUser(userInfo);
			
			userList = userService.getListUser(userInfo);
			exceptUserList = userService.getListExceptUserGroupUserByGroupId(userInfo);
		} catch(Exception e) {
			e.printStackTrace();
			jSONObject.put("result", "db.exception");
		}
		
		jSONObject.put("result", result	);
		jSONObject.put("exceptUserList", exceptUserList);
		jSONObject.put("userList", userList);
		return jSONObject;
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
	 * 사용자 아이디 중복 체크
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-user-id-duplication-check.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String, Object> ajaxUserIdDuplicationCheck(HttpServletRequest request, UserInfo userInfo) {
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		String duplication_value = "";
		try {
			if(userInfo.getUser_id() == null || "".equals(userInfo.getUser_id())) {
				result = "user.id.empty";
				jSONObject.put("result", result);
				return jSONObject;
			}
			
			int count = userService.getDuplicationIdCount(userInfo.getUser_id());
			log.info("@@ duplication_value = {}", count);
			duplication_value = String.valueOf(count);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		jSONObject.put("duplication_value", duplication_value);
		
		return jSONObject;
	}
	
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
		UserDevice userDevice = userDeviceService.getUserDeviceByUserId(userInfo.getUser_id());
		
		Policy policy = CacheManager.getPolicy();
		
		model.addAttribute("policy", policy);
		model.addAttribute("listParameters", listParameters);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("userDevice", userDevice);
		
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
		UserDevice userDevice = userDeviceService.getUserDeviceByUserId(userInfo.getUser_id());
		
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
		
		model.addAttribute("passwordExceptionChar", passwordExceptionChar);
		model.addAttribute("emailCommonCodeList", emailCommonCodeList);
		model.addAttribute("listParameters", listParameters);
		model.addAttribute("policy", policy);
		model.addAttribute("userGroupList", userGroupList);
		model.addAttribute(userInfo);
		model.addAttribute("userDevice", userDevice);
		
		return "/user/modify-user";
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
	 * 사용자 상태 수정(패스워드 실패 잠금, 해제 등)
	 * @param request
	 * @param userInfo
	 * @return
	 */
	@PostMapping(value = "ajax-update-user-status.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String, Object> ajaxUpdateUserStatus(	HttpServletRequest request, 
										@RequestParam("check_ids") String check_ids, 
										@RequestParam("business_type") String business_type, 
										@RequestParam("status_value") String status_value) {
		
		log.info("@@@@@@@ check_ids = {}, business_type = {}, status_value = {}", check_ids, business_type, status_value);
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		String result_message = "";
		try {
			if(check_ids.length() <= 0) {
				jSONObject.put("result", "check.value.required");
				return jSONObject;
			}
			List<String> userList = userService.updateUserStatus(business_type, status_value, check_ids);
			if(!userList.isEmpty()) {
				int count = userList.size();
				int i = 1;
				for(String userId : userList) {
					if(count == i) {
						result_message = result_message + userId;
					} else {
						result_message = result_message + userId + ", ";
					}
					i++;
				}
				
				String[] userIds = check_ids.split(",");
				jSONObject.put("update_count", userIds.length - userList.size());
				jSONObject.put("business_type", business_type);
				jSONObject.put("result_message", result_message);
			}
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		
		return jSONObject;
	}
	
	/**
	 * 사용자 삭제
	 * @param user_id
	 * @param model
	 * @return
	 */
	@GetMapping(value = "delete-user.do")
	public String deleteUser(@RequestParam("user_id") String user_id, Model model) {
		
		// validation 체크 해야 함
		userService.deleteUser(user_id);
		return "redirect:/user/list-user.do";
	}
	
	/**
	 * 선택 사용자 삭제
	 * @param request
	 * @param user_select_id
	 * @param user_group_id
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-delete-users.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String, Object> ajaxDeleteUsers(HttpServletRequest request, @RequestParam("check_ids") String check_ids) {
		
		log.info("@@@@@@@ check_ids = {}", check_ids);
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
			if(check_ids.length() <= 0) {
				jSONObject.put("result", "check.value.required");
				return jSONObject;
			}
			
			userService.deleteUserList(check_ids);
		} catch(Exception e) {
			e.printStackTrace();
			jSONObject.put("result", "db.exception");
		}
		
		jSONObject.put("result", result	);
		return jSONObject;
	}
	
	/**
	 * 선택 사용자 그룹내 사용자 삭제
	 * @param request
	 * @param user_select_id
	 * @param user_group_id
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-delete-user-group-user.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String, Object> ajaxDeleteUserGroupUser(HttpServletRequest request,
			@RequestParam("user_group_id") Long user_group_id,
			@RequestParam("user_select_id") String[] user_select_id) {
		
		log.info("@@@ user_group_id = {}, user_select_id = {}", user_group_id, user_select_id);
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		List<UserInfo> exceptUserList = new ArrayList<UserInfo>();
		List<UserInfo> userList = new ArrayList<UserInfo>();
		String result = "success";
		try {
			if(user_group_id == null || user_group_id.longValue() == 0l ||				
					user_select_id == null || user_select_id.length < 1) {
				result = "input.invalid";
				jSONObject.put("result", result);
				return jSONObject;
			}
			
			UserInfo userInfo = new UserInfo();
			userInfo.setUser_group_id(user_group_id);
			userInfo.setUser_select_id(user_select_id);
			
			userService.updateUserGroupUser(userInfo);
			
			// UPDATE 문에서 user_group_id 를 temp 그룹으로 변경
			userInfo.setUser_group_id(user_group_id);
			
			userList = userService.getListUser(userInfo);
			exceptUserList = userService.getListExceptUserGroupUserByGroupId(userInfo);
		} catch(Exception e) {
			e.printStackTrace();
			jSONObject.put("result", "db.exception");
		}
		
		jSONObject.put("result", result	);
		jSONObject.put("exceptUserList", exceptUserList);
		jSONObject.put("userList", userList);
		return jSONObject;
	}
	
	/**
	 * 사용자 일괄 등록 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "popup-input-excel-user.do")
	public String popupInputExcelUser(Model model) {
		
		FileInfo fileInfo = new FileInfo();
		
		model.addAttribute("fileInfo", fileInfo);
		
		return "/user/popup-input-excel-user";
	}
	
	/**
	 * 사용자 일괄 등록
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-insert-excel-user.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<String, Object> ajaxInsertExcelUser(MultipartHttpServletRequest request) {
		
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
			MultipartFile multipartFile = request.getFile("file_name");
			FileInfo fileInfo = FileUtil.upload(multipartFile, FileUtil.USER_FILE_UPLOAD, propertiesConfig.getUserUploadDir());
			if(fileInfo.getError_code() != null && !"".equals(fileInfo.getError_code())) {
				jSONObject.put("result", fileInfo.getError_code());
				return jSONObject;
			}
			
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			fileInfo.setUser_id(userSession.getUser_id());
			
//			fileInfo = fileService.insertExcelUser(fileInfo);
			
			jSONObject.put("total_count", fileInfo.getTotal_count());
			jSONObject.put("parse_success_count", fileInfo.getParse_success_count());
			jSONObject.put("parse_error_count", fileInfo.getParse_error_count());
			jSONObject.put("insert_success_count", fileInfo.getInsert_success_count());
			jSONObject.put("insert_error_count", fileInfo.getInsert_error_count());
			
			// 파일 삭제
			File copyFile = new File(fileInfo.getFile_path() + fileInfo.getFile_real_name());
			if(copyFile.exists()) {
				copyFile.delete();
			}
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		
		return jSONObject;
	}
	
	/**
	 * 사용자 Excel 다운로드
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "download-excel-user.do")
	public ModelAndView downloadExcelUser(HttpServletRequest request, HttpServletResponse response, UserInfo userInfo, Model model) {
		log.info("@@ userInfo = {}", userInfo);
		if(userInfo.getUser_group_id() == null) {
			userInfo.setUser_group_id(Long.valueOf(0l));
		}
		if(StringUtil.isNotEmpty(userInfo.getStart_date())) {
			userInfo.setStart_date(userInfo.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isNotEmpty(userInfo.getEnd_date())) {
			userInfo.setEnd_date(userInfo.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}
		
		long totalCount = 0l;
		List<UserInfo> userList = new ArrayList<UserInfo>();
		try {
			// 논리적 삭제는 SELECT에서 제외
//			userInfo.setDelete_flag(UserInfo.STATUS_LOGICAL_DELETE);
			totalCount = userService.getUserTotalCount(userInfo);
			long pageNo = 1l;
			long lastPage = 0l;
			long pagePerCount = 1000l;
			long pageListCount = 1000l;
			if(totalCount > 0l) {
				Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(userInfo), totalCount, pageNo, pagePerCount, pageListCount);
				lastPage = pagination.getLastPage();
				for(; pageNo<= lastPage; pageNo++) {
					pagination = new Pagination(request.getRequestURI(), getSearchParameters(userInfo), totalCount, pageNo, pagePerCount, pageListCount);
					log.info("@@ pagination = {}", pagination);
					
					userInfo.setOffset(pagination.getOffset());
					userInfo.setLimit(pagination.getPageRows());
					List<UserInfo> subUserList = userService.getListUser(userInfo);
					
					userList.addAll(subUserList);
					
					Thread.sleep(3000);
				}
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
	
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("pOIExcelView");
		modelAndView.addObject("fileType", "USER_LIST");
		modelAndView.addObject("fileName", "USER_LIST");
		modelAndView.addObject("userList", userList);	
		return modelAndView;
	}
	
	/**
	 * 사용자 Txt 다운로드
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "download-txt-user.do")
	@ResponseBody
	public String downloadTxtUser(HttpServletRequest request, HttpServletResponse response, UserInfo userInfo, Model model) {
		
		response.setContentType("application/force-download");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Disposition", "attachment; filename=\"user_info.txt\"");
		
		log.info("@@ userInfo = {}", userInfo);
		if(userInfo.getUser_group_id() == null) {
			userInfo.setUser_group_id(Long.valueOf(0l));
		}
		if(StringUtil.isNotEmpty(userInfo.getStart_date())) {
			userInfo.setStart_date(userInfo.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isNotEmpty(userInfo.getEnd_date())) {
			userInfo.setEnd_date(userInfo.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}
		
		long totalCount = 0l;
		try {
			// 논리적 삭제는 SELECT에서 제외
//			userInfo.setDelete_flag(UserInfo.STATUS_LOGICAL_DELETE);
			totalCount = userService.getUserTotalCount(userInfo);
			long pageNo = 1l;
			long lastPage = 0l;
			long pagePerCount = 1000l;
			long pageListCount = 1000l;
			long number = 1l;
			String SEPARATE = "|";
			String NEW_LINE = "\n";
			if(totalCount > 0l) {
				Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(userInfo), totalCount, pageNo, pagePerCount, pageListCount);
				lastPage = pagination.getLastPage();
				for(; pageNo<= lastPage; pageNo++) {
					pagination = new Pagination(request.getRequestURI(), getSearchParameters(userInfo), totalCount, pageNo, pagePerCount, pageListCount);
					log.info("@@ pagination = {}", pagination);
					
					userInfo.setOffset(pagination.getOffset());
					userInfo.setLimit(pagination.getPageRows());
					List<UserInfo> userList = userService.getListUser(userInfo);
					
					int count = userList.size();
					for(int j=0; j<count; j++) {
						UserInfo dbUserInfo = userList.get(j);
						String data = number 
									+ SEPARATE + dbUserInfo.getUser_group_name() + SEPARATE + dbUserInfo.getUser_id()
									+ SEPARATE + dbUserInfo.getUser_name()+ SEPARATE + dbUserInfo.getViewStatus()
									+ SEPARATE + dbUserInfo.getViewMobilePhone()
									+ SEPARATE + dbUserInfo.getViewEmail() + SEPARATE + dbUserInfo.getViewLastLoginDate()
									+ NEW_LINE;
						response.getWriter().write(data);
						number++;
					}
					Thread.sleep(3000);
				}
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
	
		return null;
	}
	
	/**
	 * 사용자 다운로드 Sample
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "download-excel-user-sample.do")
	@ResponseBody
	public void downloadExcelUserSample(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		File rootDirectory = new File(propertiesConfig.getSampleUploadDir());
		if(!rootDirectory.exists()) {
			rootDirectory.mkdir();
		}
				
		File file = new File(propertiesConfig.getSampleUploadDir() + "sample.xlsx");
		if(file.exists()) {
			String mimetype = "application/x-msdownload";
			response.setContentType(mimetype);
			String dispositionPrefix = "attachment; filename=";
			String encodedFilename = "sample.xlsx";

			response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);
			response.setContentLength((int)file.length());

			BufferedInputStream in = null;
			BufferedOutputStream out = null;
			try {
				in = new BufferedInputStream(new FileInputStream(file));
				out = new BufferedOutputStream(response.getOutputStream());

				FileCopyUtils.copy(in, out);
				out.flush();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(out != null) { try { out.close(); } catch(Exception e) { e.printStackTrace(); } }
				if(in != null) { try { in.close(); } catch(Exception e) { e.printStackTrace(); } }
			}
		} else {
			response.setContentType("application/x-msdownload");
			PrintWriter printwriter = null;
			try {
				printwriter = response.getWriter();
				printwriter.println("샘플 파일이 존재하지 않습니다.");
				printwriter.flush();
				printwriter.close();
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				if(printwriter != null) { try { printwriter.close(); } catch(Exception e) { e.printStackTrace(); } }
			}
		}
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