package com.gaia3d.config;

import javax.servlet.http.HttpServletRequest;

import org.springframework.boot.context.config.ResourceNotFoundException;
import org.springframework.core.annotation.AnnotationUtils;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

//@Slf4j
//@ControllerAdvice
//public class GlobalDefaultExceptionHandler {
//	public static final String DEFAULT_ERROR_VIEW = "error/error";
//
//	@ExceptionHandler(value = Exception.class)
//	public ModelAndView defaultErrorHandler(HttpServletRequest request, Exception exception) throws Exception {
//		
//		if (AnnotationUtils.findAnnotation(exception.getClass(), ResponseStatus.class) != null) throw exception;
//
//		ModelAndView modelAndView = new ModelAndView();
//		modelAndView.addObject("exception", exception);
//		modelAndView.addObject("url", request.getRequestURL());
//		modelAndView.setViewName(DEFAULT_ERROR_VIEW);
//		
//		log.info("@@@@@@@@@@@@@@@@@ url d = {}", request.getRequestURL());
//		
//		return modelAndView;
//	}
//	
//	
//	@ExceptionHandler(value = NullPointerException.class)
//    public ModelAndView handleNullPointerException(HttpServletRequest request, Exception exception) {
//
//		ModelAndView modelAndView = new ModelAndView();
//		modelAndView.addObject("exception", exception);
//		modelAndView.addObject("url", request.getRequestURL());
//		modelAndView.setViewName(DEFAULT_ERROR_VIEW);
//		
//		log.info("@@@@@@@@@@@@@@@@@ url c = {}", request.getRequestURL());
//		
//		return modelAndView;
//    }
//
//
//    @ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
//    @ExceptionHandler(value = Exception.class)
//    public ModelAndView handleAllException(HttpServletRequest request, Exception exception) {
//
//    	ModelAndView modelAndView = new ModelAndView();
//		modelAndView.addObject("exception", exception);
//		modelAndView.addObject("url", request.getRequestURL());
//		modelAndView.setViewName(DEFAULT_ERROR_VIEW);
//		
//		log.info("@@@@@@@@@@@@@@@@@ url a = {}", request.getRequestURL());
//		
//		return modelAndView;
//    }
//
//
//    @ExceptionHandler(ResourceNotFoundException.class)
//    @ResponseStatus(HttpStatus.NOT_FOUND)
//    public ModelAndView handleResourceNotFoundException(HttpServletRequest request, Exception exception) {
//
//    	ModelAndView modelAndView = new ModelAndView();
//		modelAndView.addObject("exception", exception);
//		modelAndView.addObject("url", request.getRequestURL());
//		modelAndView.setViewName(DEFAULT_ERROR_VIEW);
//		
//		log.info("@@@@@@@@@@@@@@@@@ url b = {}", request.getRequestURL());
//		
//		return modelAndView;
//    }
//}
