package com.gaia3d.controller;

import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;

import org.springframework.cache.annotation.CacheConfig;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.SessionKey;
import com.gaia3d.domain.UserInfo;
import com.gaia3d.security.AESCipher;

import lombok.extern.slf4j.Slf4j;

/**
 * 로그인 처리
 * 
 * @author jeongdae
 */
@Slf4j
@Controller
@RequestMapping("/login/")
public class LoginController {
	
	/**
	 * 로그인 페이지
	 * @param request
	 * @param model
	 * @return
	 */
	@GetMapping("/login.do")
	public String login(HttpServletRequest request, Model model) {
		
		Policy policy = CacheManager.getPolicy();
		log.info("@@ policy = {}", policy);
		
		long nowTime = System.nanoTime();
		String TOKEN_AES_KEY = (String.valueOf(nowTime) + "0000000000").substring(0, 16);
		request.getSession().setAttribute(SessionKey.SESSION_TOKEN_AES_KEY.name() , TOKEN_AES_KEY);
		log.info("@@ SESSION_TOKEN_AES_KEY = {}", TOKEN_AES_KEY);
		
		UserInfo loginForm = new UserInfo();
		model.addAttribute("loginForm", loginForm);
		model.addAttribute("policy", policy);
		model.addAttribute(SessionKey.TOKEN_AES_KEY.name(), TOKEN_AES_KEY);
		
		return "/login/login";
	}
	
	/**
	 * 로그인 처리
	 * @param locale
	 * @param model
	 * @return
	 */
	@PostMapping(value = "process-login.do")
	public String processLogin(HttpServletRequest request, UserInfo loginForm, BindingResult bindingResult, Model model) {
		
		UserInfo otpLoginForm = new UserInfo();
		Policy policy = CacheManager.getPolicy();
		
		String SESSION_TOKEN_AES_KEY = (String)request.getSession().getAttribute(SessionKey.SESSION_TOKEN_AES_KEY.name());
		try {
			AESCipher aESCipher = new AESCipher(SESSION_TOKEN_AES_KEY);
			log.info("@@ SESSION_TOKEN_AES_KEY = {}", SESSION_TOKEN_AES_KEY);
			loginForm.setPassword(aESCipher.decrypt(URLDecoder.decode(loginForm.getPassword(), "utf-8")));
		} catch(Exception e) {
			e.printStackTrace();
			return "redirect:/login/login.do?error_code=login.encrypt.exception";
		}
			
//		log.info("@@ login_type = {} ", loginForm.getLogin_type());
//		// 사용자 로그인 인증 방법. 일반 : GENERAL, 기업용 : COMPANY, OTP : OTP
//		if("GENERAL".equals(loginForm.getLogin_type()) || "COMPANY".equals(loginForm.getLogin_type())) {
//			this.loginValidator.validate(loginForm, bindingResult);
//		} else if("OTP".equals(loginForm.getLogin_type())) {
//			loginForm.setUser_id(loginForm.getOtp_user_id());
//			loginForm.setPassword(loginForm.getOtp_password());
//			otpLoginForm.setLogin_type("OTP");
//			otpLoginForm.setOtp_user_id(loginForm.getOtp_user_id());
//			otpLoginForm.setOtp_password(loginForm.getOtp_password());
//			otpLoginForm.setOtp_number(loginForm.getOtp_number());
//			this.loginValidator.validate(otpLoginForm, bindingResult);
//		}
//		
//		if(bindingResult.hasErrors()) {
//			log.info("@@ validation error! ");
//			if("OTP".equals(loginForm.getLogin_type())) {
//				loginForm.setUser_id(null);
//				loginForm.setPassword(null);
//			}
//			model.addAttribute("otpLoginForm", otpLoginForm);
//			model.addAttribute("policy", policy);
//			model.addAttribute("TOKEN_AES_KEY", SESSION_TOKEN_AES_KEY);
//			
//			String viewName = WebUtil.getViewNameLogin(VIEW_PATH, ConfigCache.getCompanyName());
//			return viewName;
//		}
//		
//		loginForm.setPassword_change_term(policy.getPassword_change_term());
//		loginForm.setUser_last_login_lock(policy.getUser_last_login_lock());
//		UserSession userSession = loginService.getUserSession(loginForm);
//		log.info("@@ userSession = {} ", userSession);
//		
//		String errorCode = validateUserInfo(request, false, policy, loginForm, userSession);
//		if(errorCode != null) {
//			if("usersession.password.invalid".equals(errorCode)) {
//				UserInfo userInfo = new UserInfo();
//				userInfo.setUser_id(userSession.getUser_id());
//				userInfo.setFail_login_count(userSession.getFail_login_count() + 1);
//				// 실패 횟수가 운영 정책의 횟수와 일치할 경우 잠금(비밀번호 실패횟수 초과)
//				if(userInfo.getFail_login_count() >= policy.getUser_fail_login_count()) {
//					log.error("@@ 비밀번호 실패 횟수 초과에 의해 잠김 처리됨");
//					userInfo.setStatus(UserInfo.STATUS_FAIL_LOGIN_COUNT_OVER);
//					loginForm.setStatus(UserInfo.STATUS_FAIL_LOGIN_COUNT_OVER);
//				}
//				userService.updateUserFailLoginCount(userInfo);
//			} else if("usersession.lastlogin.invalid".equals(errorCode)) {
//				UserInfo userInfo = new UserInfo();
//				userInfo.setUser_id(userSession.getUser_id());
//				userInfo.setStatus(UserInfo.STATUS_SLEEP);
//				userService.updateUserStatus(userInfo);
//			}
//			
//			log.error("@@ errorCode = {} ", errorCode);
//			if(!"OTP".equals(loginForm.getLogin_type())) {
//				loginForm.setError_code(errorCode);
//			} else {
//				loginForm.setUser_id(null);
//				loginForm.setPassword(null);
//				otpLoginForm.setError_code(errorCode);
//			}
//			model.addAttribute("otpLoginForm", otpLoginForm);
//			model.addAttribute("policy", policy);
//			model.addAttribute("TOKEN_AES_KEY", SESSION_TOKEN_AES_KEY);
//			
//			String viewName = WebUtil.getViewNameLogin(VIEW_PATH, ConfigCache.getCompanyName());
//			return viewName;
//		}
//		
//		// 사용자 정보를 갱신
//		userSession.setFail_login_count(0);
//		loginService.updateLoginUserSession(userSession);
//		
//		// TODO 고민을 하자. 로그인 시점에 토큰을 발행해서 사용하고.... 비밀번호와 SALT는 초기화 해서 세션에 저장할지
////		userSession.setPassword(null);
////		userSession.setSalt(null);
//		
//		// 암호화를 위한 키 삭제
//		request.getSession().removeAttribute("SESSION_TOKEN_AES_KEY");
//		
//		userSession.setLogin_ip(WebUtil.getClientIp(request));
//		GT1000HttpSessionBindingListener sessionListener = new GT1000HttpSessionBindingListener();
//		request.getSession().setAttribute(UserSession.KEY, userSession);
//		request.getSession().setAttribute(userSession.getUser_id(), sessionListener);
//		if(Policy.Y.equals(policy.getSecurity_session_timeout_yn())) {
//			// 세션 타임 아웃 시간을 초 단위로 변경해서 설정
//			request.getSession().setMaxInactiveInterval(Integer.valueOf(policy.getSecurity_session_timeout()).intValue() * 60);
//		}
//
//		// 패스워드 변경 기간이 오버 되었거나 , 6:임시 비밀번호(비밀번호 찾기, 관리자 설정에 의한 임시 비밀번호 발급 시)
//		if(userSession.getPassword_change_term_over() || UserInfo.STATUS_TEMP_PASSWORD.equals(userSession.getStatus())){
//			return "redirect:/user/modify-password.do";
//		}
		
		return "redirect:/main/index.do";
	}
}
