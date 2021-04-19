package gaia3d.controller.rest;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.domain.data.DataInfoLog;
import gaia3d.service.DataLogService;
import lombok.extern.slf4j.Slf4j;

/**
 * Data
 * @author jeongdae
 *
 */
@Slf4j
@RestController
@RequestMapping("/data-logs")
public class DataLogRestController {

	@Autowired
	private DataLogService dataLogService;

	/**
	 * Data Info Log 상태 수정
	 * @param request
	 * @param dataInfoLog
	 * @param errors
	 * @return
	 */
	@PostMapping
	public Map<String, Object> insert(HttpServletRequest request, @Valid DataInfoLog dataInfoLog, Errors errors) {
		log.info("@@ dataInfoLog = {}", dataInfoLog);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		if(errors.hasErrors()) {
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", "validation.error");
			result.put("message", errors.getAllErrors().get(0).getDefaultMessage());
			return result;
        }

		dataLogService.insertDataInfoLog(dataInfoLog);
		int statusCode = HttpStatus.OK.value();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
}