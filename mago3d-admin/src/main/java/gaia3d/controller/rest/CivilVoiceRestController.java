package gaia3d.controller.rest;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import gaia3d.domain.CivilVoice;
import gaia3d.domain.Key;
import gaia3d.domain.UserSession;
import gaia3d.service.CivilVoiceService;

@Slf4j
@RestController
@RequestMapping("/civil-voices")
public class CivilVoiceRestController {

	@Autowired
	private CivilVoiceService civilVoiceService;

	/**
	 * 시민참여 등록
	 * @param request
	 * @param civilVoice
	 * @param bindingResult
	 * @return
	 */
	@PostMapping
	public Map<String, Object> insert(HttpServletRequest request, @Valid @ModelAttribute CivilVoice civilVoice, BindingResult bindingResult) {
		log.info("@@@@@ insert-group civilVoice = {}", civilVoice);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());

		if(bindingResult.hasErrors()) {
			message = bindingResult.getAllErrors().get(0).getDefaultMessage();
			log.info("@@@@@ message = {}", message);
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", errorCode);
			result.put("message", message);
            return result;
		}

		civilVoice.setUserId(userSession.getUserId());
		if(civilVoice.getLongitude() != null && civilVoice.getLatitude() != null) {
			civilVoice.setLocation("POINT(" + civilVoice.getLongitude() + " " + civilVoice.getLatitude() + ")");
		}
		civilVoiceService.insertCivilVoice(civilVoice);
		int statusCode = HttpStatus.OK.value();

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 시민참여 수정
	 * @param request
	 * @param civilVoice
	 * @param bindingResult
	 * @return
	 */
	@PostMapping("/{civilVoiceId:[0-9]+}")
	public Map<String, Object> update(HttpServletRequest request, @PathVariable Long civilVoiceId, @Valid CivilVoice civilVoice, BindingResult bindingResult) {
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		log.info("@@ civilVoice = {}", civilVoice);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		civilVoice.setUserId(userSession.getUserId());
		civilVoice.setCivilVoiceId(civilVoiceId);
		if(civilVoice.getLongitude() != null && civilVoice.getLatitude() != null) {
			civilVoice.setLocation("POINT(" + civilVoice.getLongitude() + " " + civilVoice.getLatitude() + ")");
		}
		civilVoiceService.updateCivilVoice(civilVoice);
		int statusCode = HttpStatus.OK.value();

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
}
