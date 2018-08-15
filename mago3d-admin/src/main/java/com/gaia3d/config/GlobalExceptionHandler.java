package com.gaia3d.config;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

/**
 * Exception 처리 global 설정?
 * @author Cheon JeongDae
 *
 */
@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {
	
	@ExceptionHandler(Exception.class)
	public ModelAndView error(Exception exception) {
		log.error("**********************************************************");
		log.error("**************** GlobalExceptionHandler ******************");
		log.error("**********************************************************");
		
		exception.printStackTrace();
		
		ModelAndView mav = new ModelAndView();
	    mav.addObject("exception", exception);
	    mav.setViewName("/error/error");
	    return mav;
	}

//	@ExceptionHandler(BusinessLogicException.class)
//	public String notFound(Exception exception) {
//		//System.out.println("----Caught KeywordNotFoundException----");
//		exception.printStackTrace();
//		return "404";
//	}
}
