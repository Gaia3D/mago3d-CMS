package com.gaia3d.config;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.HttpMediaTypeNotSupportedException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import com.gaia3d.domain.APIResult;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestControllerAdvice
public class APIExceptionHandler {
	
//	@ExceptionHandler(Exception.class)
//	@ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
//	public ResponseEntity<APIResult> notFoundException(Exception e) {
//		//e.printStackTrace();
//		log.info("@@@ exception. message = {}", e.getMessage());
//		APIResult aPIResult = new APIResult();
//		aPIResult.setStatusCode(HttpStatus.INTERNAL_SERVER_ERROR.value());
//		aPIResult.setMessage(e.getMessage());
//		return new ResponseEntity<APIResult>(aPIResult, HttpStatus.valueOf(aPIResult.getStatusCode()));
//	}

	@ExceptionHandler(HttpRequestMethodNotSupportedException.class)
	@ResponseStatus(value = HttpStatus.METHOD_NOT_ALLOWED)
	public ResponseEntity<APIResult> methodNotSupportedException(HttpRequestMethodNotSupportedException e) {
		//e.printStackTrace();
		log.info("@@@ methodNotSupportedException. message = {}", e.getMessage());
		APIResult aPIResult = new APIResult();
		aPIResult.setStatusCode(HttpStatus.METHOD_NOT_ALLOWED.value());
		aPIResult.setMessage(e.getMessage());
		return new ResponseEntity<APIResult>(aPIResult, HttpStatus.valueOf(aPIResult.getStatusCode()));
	}
	
	@ExceptionHandler(HttpMediaTypeNotSupportedException.class)
	@ResponseStatus(value = HttpStatus.UNSUPPORTED_MEDIA_TYPE)
	public ResponseEntity<APIResult> mediaTypeNotSupportedException(HttpMediaTypeNotSupportedException e) {
		//e.printStackTrace();
		log.info("@@@ mediaTypeNotSupportedException. message = {}", e.getMessage());
		APIResult aPIResult = new APIResult();
		aPIResult.setStatusCode(HttpStatus.UNSUPPORTED_MEDIA_TYPE.value());
		aPIResult.setMessage(e.getMessage());
		return new ResponseEntity<APIResult>(aPIResult, HttpStatus.valueOf(aPIResult.getStatusCode()));
	}
	
	@ExceptionHandler(HttpMessageNotReadableException.class)
	@ResponseStatus(value = HttpStatus.BAD_REQUEST)
	public ResponseEntity<APIResult> messageNotReadableException(HttpMessageNotReadableException e) {
		//e.printStackTrace();
		log.info("@@@ messageNotReadableException. message = {}", e.getMessage());
		APIResult aPIResult = new APIResult();
		aPIResult.setStatusCode(HttpStatus.BAD_REQUEST.value());
		aPIResult.setMessage(e.getMessage());
		return new ResponseEntity<APIResult>(aPIResult, HttpStatus.valueOf(aPIResult.getStatusCode()));
	}
	
}
