package gaia3d.config;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import gaia3d.support.LogMessageSupport;

/**
 * RestController Exception 처리
 * @author Cheon JeongDae
 *
 */
@RestControllerAdvice(basePackages = {"gaia3d.controller.rest"})
public class RestControllerExceptionHandler {
	
	@ExceptionHandler(DataAccessException.class)
	public Map<String, Object> error(DataAccessException e) {
		Map<String, Object> result = new HashMap<>();
		int statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
		String errorCode = "db.exception";
		String message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
		
		if(message == null) {
			if(e.getCause() != null && e.getCause().toString().length() > 10) {
				message = e.getCause().toString();
			} else {
				message = e.toString();
			}
		}
		
		LogMessageSupport.printMessage(e, "@@ DataAccessException. message = {}", message);
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	@ExceptionHandler(RuntimeException.class)
	public Map<String, Object> error(RuntimeException e) {
		Map<String, Object> result = new HashMap<>();
		int statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
		String errorCode = "runtime.exception";
		String message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
		if(message == null) {
			if(e.getCause() != null && e.getCause().toString().length() > 10) {
				message = e.getCause().toString();
			} else {
				message = e.toString();
			}
		}
		
		LogMessageSupport.printMessage(e, "@@ RuntimeException. message = {}", message);
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	@ExceptionHandler(IOException.class)
	public Map<String, Object> error(IOException e) {
		Map<String, Object> result = new HashMap<>();
		int statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
		String errorCode = "runtime.exception";
		String message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
		if(message == null) {
			if(e.getCause() != null && e.getCause().toString().length() > 10) {
				message = e.getCause().toString();
			} else {
				message = e.toString();
			}
		}
		
		LogMessageSupport.printMessage(e, "@@ IOException. message = {}", message);
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	@ExceptionHandler(Exception.class)
	public Map<String, Object> error(Exception e) {
		Map<String, Object> result = new HashMap<>();
		int statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
		String errorCode = "unknown.exception";
		String message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
		if(message == null) {
			if(e.getCause() != null && e.getCause().toString().length() > 10) {
				message = e.getCause().toString();
			} else {
				message = e.toString();
			}
		}
		
		LogMessageSupport.printMessage(e, "@@ Exception. message = {}", message);
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
}
