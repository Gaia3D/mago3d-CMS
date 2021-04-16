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

import gaia3d.domain.data.DataAdjustLog;
import gaia3d.service.DataAdjustLogService;
import lombok.extern.slf4j.Slf4j;

/**
 * 데이터 geometry 변경 이력
 * @author jeongdae
 *
 */
@Slf4j
@RestController
@RequestMapping("/data-adjust-logs")
public class DataAdjustLogRestController {
	
	@Autowired
	private DataAdjustLogService dataAdjustLogService;
	
	/**
	 * TODO 이상함. 왜 사용하지도 않는 PathVariable 이 있지?
	 * 데이터 위치 변경 요청 수정
	 * @param request
	 * @param dataAdjustLog
	 * @return
	 */
	@PostMapping(value = "/status/{dataAdjustLogId:[0-9]+}")
	public Map<String, Object> update(HttpServletRequest request, @Valid DataAdjustLog dataAdjustLog, Errors errors) {
		log.info("@@ dataAdjustLog = {}", dataAdjustLog);
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		if(errors.hasErrors()) {
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", "validation.error");
			result.put("message", errors.getAllErrors().get(0).getDefaultMessage());
			return result;
        }
		
		dataAdjustLogService.updateDataAdjustLogStatus(dataAdjustLog);
		int statusCode = HttpStatus.OK.value();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
}