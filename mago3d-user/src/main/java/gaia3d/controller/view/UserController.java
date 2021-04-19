package gaia3d.controller.view;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import gaia3d.domain.Key;
import gaia3d.domain.cache.CacheManager;
import gaia3d.domain.policy.Policy;
import gaia3d.domain.user.UserInfo;
import gaia3d.domain.user.UserSession;
import gaia3d.domain.user.UserStatus;
import gaia3d.service.UserService;
import gaia3d.support.PasswordSupport;
import lombok.extern.slf4j.Slf4j;

/**
 * 사용자 관리
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	/**
	 * 비밀번호 수정
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/modify-password")
	public String modifyPassword(HttpServletRequest request, Model model) {
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		Policy policy = CacheManager.getPolicy();
		
		model.addAttribute("policy", policy);
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
	@PostMapping(value = "update-password")
	public String updatePassword(HttpServletRequest request, @ModelAttribute("userInfo") UserInfo userInfo, BindingResult bindingResult, Model model) {
		
		Policy policy = CacheManager.getPolicy();
		// TODO validator 이용하게 수정해야 함
		
		String errorcode = userValidate(policy, userInfo);
		if(errorcode != null) {
			log.info("@@@@@@@@@@@@@ errcode = {}", errorcode);
			userInfo.setErrorCode(errorcode);
			model.addAttribute("policy", policy);
			return "/user/modify-password";		
		}
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		UserInfo dbUserInfo = userService.getUser(userSession.getUserId());
		if(!PasswordSupport.isEquals(dbUserInfo.getPassword(), userInfo.getPassword())){
			errorcode = "user.password.compare.invalid";
			log.info("@@@@@@@@@@@@@ errcode = {}", errorcode);
			userInfo.setErrorCode(errorcode);
			model.addAttribute("policy", policy);
			return "/user/modify-password";
		}
		
		String encryptPassword = PasswordSupport.encodePassword(userInfo.getNewPassword());
		if(encryptPassword == null) {
			errorcode = "user.password.exception";
			log.info("@@@@@@@@@@@@@ errcode = {}", errorcode);
			userInfo.setErrorCode(errorcode);
			model.addAttribute("policy", policy);
			return "/user/modify-password";
		}
		
		userInfo.setUserId(userSession.getUserId());
		userInfo.setPassword(encryptPassword);
		userInfo.setStatus(UserStatus.USE.getValue());
		userService.updatePassword(userInfo);
		
		// 임시 패스워드인 경우 세션을 사용중 상태로 변경
		if(UserStatus.TEMP_PASSWORD == UserStatus.findBy(userSession.getStatus())) {
			userSession.setStatus(UserStatus.USE.getValue());
		}
	
		return "redirect:/data/map";
	}
	
	/**
	 * validation 체크
	 * @param userInfo
	 * @return
	 */
	private String userValidate(Policy policy, UserInfo userInfo) {
		return PasswordSupport.validateUserPassword(policy, userInfo);
	}
}
