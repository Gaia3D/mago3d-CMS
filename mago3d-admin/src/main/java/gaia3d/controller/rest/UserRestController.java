package gaia3d.controller.rest;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.controller.AuthorizationController;
import gaia3d.domain.user.UserInfo;
import gaia3d.service.UserService;
import lombok.extern.slf4j.Slf4j;

/**
 * 사용자
 * @author kimhj
 *
 */
@Slf4j
@RestController
@RequestMapping("/users")
public class UserRestController implements AuthorizationController {

	@Autowired
	private UserService userService;

	/**
	 * 사용자 ID 중복 체크
	 * @param request
	 * @param userInfo
	 * @return
	 */
	@GetMapping(value = "/duplication")
	public Map<String, Object> userIdDuplicationCheck(HttpServletRequest request, UserInfo userInfo) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		// TODO @Valid 로 구현해야 함
		if(StringUtils.isEmpty(userInfo.getUserId())) {
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", "user.id.empty");
			result.put("message", message);
			return result;
		}

		Boolean duplication = userService.isUserIdDuplication(userInfo);
		log.info("@@ duplication = {}", duplication);
		int statusCode = HttpStatus.OK.value();

		result.put("duplication", duplication);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 사용자 등록
	 * @param request
	 * @param userInfo
	 * @param bindingResult
	 * @return
	 */
	@PostMapping(value = "/insert")
	public Map<String, Object> insert(HttpServletRequest request, @Valid @ModelAttribute UserInfo userInfo, BindingResult bindingResult) {
		log.info("@@@@@ insert userInfo = {}", userInfo);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		if(bindingResult.hasErrors()) {
			message = bindingResult.getAllErrors().get(0).getDefaultMessage();
			log.info("@@@@@ message = {}", message);
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", errorCode);
			result.put("message", message);
            return result;
		}

		userService.insertUser(userInfo);
		int statusCode = HttpStatus.OK.value();

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 사용자 수정
	 * @param request
	 * @param userInfo
	 * @return
	 */
	@PutMapping(value = "/{userId}")
	public Map<String, Object> update(HttpServletRequest request, @PathVariable String userId, UserInfo userInfo) {
		log.info("@@ userInfo = {}", userInfo);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

//		if(bindingResult.hasErrors()) {
//			message = bindingResult.getAllErrors().get(0).getDefaultMessage();
//			log.info("@@@@@ message = {}", message);
//			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
//			result.put("errorCode", errorCode);
//			result.put("message", message);
//            return result;
//		}

		userInfo.setUserId(userId);
		userService.updateUser(userInfo);
		int statusCode = HttpStatus.OK.value();

		result.put("statusCode", statusCode);
			result.put("errorCode", errorCode);
			result.put("message", message);
            return result;
		}

	/**
	 * 사용 대기자 사용 승인
	 * @param request
	 * @param userId
	 * @return
	 */
	@PostMapping(value = "/{userId}/approvals")
	public Map<String, Object> approval(HttpServletRequest request, @PathVariable String userId) {
		log.info("@@@@@@@ approval , userId = {}", userId);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		userService.updateUserStatusUse(userId);
		int statusCode = HttpStatus.OK.value();

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 사용자 상태 변경
	 * @param request
	 * @param checkIds
	 * @param statusValue
	 * @return
	 */
	@PostMapping(value = "/status")
	public Map<String, Object> status(HttpServletRequest request,
										@RequestParam("checkIds") String checkIds,
										@RequestParam("statusValue") String statusValue) {

		log.info("@@@@@@@ checkIds = {}, statusValue = {}", checkIds, statusValue);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		if(checkIds.length() <= 0) {
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", "check.value.required");
			result.put("message", message);
            return result;
		}

		userService.updateUserStatus(statusValue, checkIds);
		int statusCode = HttpStatus.OK.value();

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
}
