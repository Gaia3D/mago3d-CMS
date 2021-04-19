package gaia3d.controller.rest;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.LocaleResolver;

import gaia3d.domain.Key;
import lombok.extern.slf4j.Slf4j;

/**
 * Locale 관리
 * @author jeongdae
 *
 */
@Slf4j
@RestController
@RequestMapping("/languages")
public class LocaleRestController {

	@Autowired
	private LocaleResolver localeResolver;

	/**
	 * 사용자 Locale을 변경
	 * @param lang
	 * @return
	 */
	@GetMapping(value = "/{lang}")
	public Map<String, Object> changeLocale(HttpServletRequest request, HttpServletResponse response, @PathVariable String lang) {
		log.info("@@@@@ lang = {}", lang);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		if(Locale.KOREA.getLanguage().equals(lang)
				|| Locale.ENGLISH.getLanguage().equals(lang)
				|| Locale.JAPAN.getLanguage().equals(lang)) {
			request.getSession().setAttribute(Key.LANG.name(), lang);
			Locale locale = new Locale(lang);
//				LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
//				localeResolver.setLocale(request, response, locale);
			localeResolver.setLocale(request, response, locale);
		}

		int statusCode = HttpStatus.OK.value();

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
}
