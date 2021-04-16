package gaia3d.controller.view;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import gaia3d.domain.Key;
import gaia3d.domain.YOrN;
import gaia3d.domain.cache.CacheManager;
import gaia3d.domain.policy.Policy;
import gaia3d.domain.role.RoleKey;
import gaia3d.domain.user.UserInfo;
import gaia3d.domain.user.UserSession;
import gaia3d.domain.user.UserStatus;
import gaia3d.listener.Gaia3dHttpSessionBindingListener;
import gaia3d.service.PolicyService;
import gaia3d.service.SigninService;
import gaia3d.support.PasswordSupport;
import gaia3d.support.RoleSupport;
import gaia3d.support.SessionUserSupport;
import gaia3d.utils.WebUtils;
import lombok.extern.slf4j.Slf4j;

/**
 * Sign in 처리
 * 
 * @author jeongdae
 */
@Slf4j
@Controller
@RequestMapping("/sign")
public class SigninController {
	
	@Autowired
	private PolicyService policyService;
	@Autowired
	private SigninService signinService;
	
	/**
	 * Sign in 페이지
	 * @param request
	 * @param model
	 * @return
	 */
	@GetMapping("/signin")
	public String signin(HttpServletRequest request, Model model) {
		Policy policy = policyService.getPolicy();
		log.info("@@ policy = {}", policy);
		
		UserInfo signinForm = new UserInfo();
		model.addAttribute("signinForm", signinForm);
		model.addAttribute("policy", policy);
		model.addAttribute("contentCacheVersion", policy.getContentCacheVersion());
		
		return "/sign/signin";
	}
	
	/**
	 * Sign in 처리
	 * @param locale
	 * @param model
	 * @return
	 */
	@PostMapping(value = "/process-signin")
	public String processSignin(HttpServletRequest request, @Valid @ModelAttribute("signinForm") UserInfo signinForm, BindingResult bindingResult, Model model) {
		Policy policy = policyService.getPolicy();
			
		signinForm.setPasswordChangeTerm(policy.getPasswordChangeTerm());
		signinForm.setUserLastSigninLock(policy.getUserLastSigninLock());
		UserSession userSession = signinService.getUserSession(signinForm);
		log.info("@@ userSession = {} ", userSession);
		
		String errorCode = validate(request, policy, signinForm, userSession);
		if(errorCode != null) {
			if("usersession.password.invalid".equals(errorCode)) {
				userSession.setFailSigninCount(userSession.getFailSigninCount() + 1);
				// 실패 횟수가 운영 정책의 횟수와 일치할 경우 잠금(비밀번호 실패횟수 초과)
				if(userSession.getFailSigninCount() >= policy.getUserFailSigninCount()) {
					log.error("@@ 비밀번호 실패 횟수 초과에 의해 잠김 처리됨");
					userSession.setStatus(UserStatus.FAIL_SIGNIN_COUNT_OVER.getValue());
					signinForm.setStatus(UserStatus.FAIL_SIGNIN_COUNT_OVER.getValue());
				}
				signinService.updateSigninUserSession(userSession);
				
				bindingResult.rejectValue("userId", "usersession.password.invalid");
			} else if("usersession.lastsignin.invalid".equals(errorCode)) {
				userSession.setStatus(UserStatus.SLEEP.getValue());
				signinService.updateSigninUserSession(userSession);
				
				bindingResult.rejectValue("userId", "usersession.lastsignin.invalid");
			} else {
				bindingResult.rejectValue("userId", errorCode);
			}
			
			log.error("@@ errorCode = {} ", errorCode);
			signinForm.setErrorCode(errorCode);
			signinForm.setUserId(null);
			signinForm.setPassword(null);
			model.addAttribute("signinForm", signinForm);
			model.addAttribute("policy", policy);
			
			return "/sign/signin";
		}
		
		// 사용자 정보를 갱신
		userSession.setFailSigninCount(0);
		signinService.updateSigninUserSession(userSession);
		
		// TODO 고민을 하자. 사인인 시점에 토큰을 발행해서 사용하고.... 비밀번호와 SALT는 초기화 해서 세션에 저장할지
//		userSession.setPassword(null);
//		userSession.setSalt(null);
		
		userSession.setSigninIp(WebUtils.getClientIp(request));
		Gaia3dHttpSessionBindingListener sessionListener = new Gaia3dHttpSessionBindingListener();
		request.getSession().setAttribute(Key.USER_SESSION.name(), userSession);
		request.getSession().setAttribute(userSession.getUserId(), sessionListener);
		if(YOrN.Y == YOrN.valueOf(policy.getSecuritySessionTimeoutYn())) {
			// 세션 타임 아웃 시간을 초 단위로 변경해서 설정
			request.getSession().setMaxInactiveInterval(Integer.valueOf(policy.getSecuritySessionTimeout()).intValue() * 60);
		}

		// 패스워드 변경 기간이 오버 되었거나 , 6:임시 비밀번호(비밀번호 찾기, 관리자 설정에 의한 임시 비밀번호 발급 시)
		if(userSession.getPasswordChangeTermOver() || UserStatus.TEMP_PASSWORD == UserStatus.findBy(userSession.getStatus())){
			return "redirect:/user/modify-password";
		}
		
		return "redirect:/main/index";
	}
	
	/**
	 * 사용자 정보 유효성을 체크하여 에러 코드를 리턴
	 * @param request
	 * @param policy
	 * @param signinForm
	 * @param userSession
	 * @return
	 */
	private String validate(HttpServletRequest request, Policy policy, UserInfo signinForm, UserSession userSession) {
		// 사용자 정보가 존재하지 않을 경우
		if(userSession == null) {
			return "user.session.empty";
		}
		
		// 비밀번호 불일치
		if(!PasswordSupport.isEquals(userSession.getPassword(), signinForm.getPassword())) {
			return "usersession.password.invalid";
		}
		
		// 회원 상태 체크
		if(UserStatus.USE != UserStatus.findBy(userSession.getStatus()) && UserStatus.TEMP_PASSWORD != UserStatus.findBy(userSession.getStatus())) {
			// 0:사용중, 1:사용중지(관리자), 2:잠금(비밀번호 실패횟수 초과), 3:휴면(사인인 기간), 4:만료(사용기간 종료), 5:삭제(화면 비표시)
			signinForm.setStatus(userSession.getStatus());
			return "usersession.status.invalid";
		}
		
		// 사인인 실패 횟수
		if(userSession.getFailSigninCount().intValue() >= policy.getUserFailSigninCount()) {
			signinForm.setFailSigninCount(userSession.getFailSigninCount());
			return "usersession.failsignincount.invalid";
		}
		
		// 마지막 접속일(접속 정책이 3개월 미접속인 경우 접속 금지의 경우)
		if(userSession.getUserLastSigninLockOver()) {	
			signinForm.setLastSigninDate(userSession.getLastSigninDate());
			signinForm.setUserLastSigninLock(policy.getUserLastSigninLock());
			return "usersession.lastsignin.invalid";
		}
		
		// 초기 세팅시만 이 값을 N으로 세팅해서 사용자 Role 체크 하지 않음
		if(YOrN.N != YOrN.valueOf(userSession.getUserRoleCheckYn())) {
			// 사용자 그룹 ROLE 확인
			List<String> userGroupRoleKeyList = CacheManager.getUserGroupRoleKeyList(userSession.getUserGroupId());
			if(!RoleSupport.isUserGroupRoleValid(userGroupRoleKeyList, RoleKey.ADMIN_SIGNIN.name())) {
	 			return "usersession.role.invalid";
			}
		}
		
//		// 사용자 IP 체크
//		if(Policy.Y.equals(policy.getSecurity_user_ip_check_yn())) {
//			UserDevice userDevice = new UserDevice();
//			userDevice.setUser_id(userSession.getUser_id());
//			userDevice.setDevice_ip(WebUtil.getClientIp(request));
//			UserDevice dbUserDevice = userDeviceService.getUserDeviceByUserIp(userDevice);
//			if(dbUserDevice == null || dbUserDevice.getUser_device_id() == null || dbUserDevice.getUser_device_id().longValue() <= 0l) {
//				return "userdevice.ip.invalid";
//			}
//		}
			
		// TODO 사용기간이 종료 되었는지 확인할것
		
		// 중복 사인인 허용 하지 않을 경우, 동일 아이디로 생성된 세션이 존재할 경우 파기
		log.info("##################################### userDuplicationSigninYn() = {}", policy.getUserDuplicationSigninYn());
		if(YOrN.N == YOrN.valueOf(policy.getUserDuplicationSigninYn())) {
			if(SessionUserSupport.isExistSession(userSession.getUserId())) {
				log.info("######################### 중복 사인인 userId = {}", userSession.getUserId());
				SessionUserSupport.invalidateSession(userSession.getUserId());
			}
		}
		
		return null;
	}
	
	/**
	 * Sign out
	 * @param request
	 * @return
	 */
	@GetMapping(value = "/signout")
	public String signout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		UserSession userSession = (UserSession)session.getAttribute(Key.USER_SESSION.name());
		
		if(userSession == null) {
			return "redirect:/sign/signin";
		}
		
		session.removeAttribute(userSession.getUserId());
		session.removeAttribute(Key.USER_SESSION.name());
		session.invalidate();
		
		return "redirect:/sign/signin";
	}
}
