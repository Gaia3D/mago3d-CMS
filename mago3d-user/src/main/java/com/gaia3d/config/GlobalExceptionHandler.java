//package com.gaia3d.config;
//
//import java.io.IOException;
//
//import org.springframework.web.bind.annotation.ControllerAdvice;
//import org.springframework.web.bind.annotation.ExceptionHandler;
//import org.springframework.web.servlet.ModelAndView;
//
//import com.gaia3d.exception.BusinessLogicException;
//
///**
// * Exception 처리 global 설정?
// * @author Cheon JeongDae
// *
// */
//@ControllerAdvice
//public class GlobalExceptionHandler {
//	
//	@ExceptionHandler(Exception.class)
//	public ModelAndView myError(Exception exception) {
//		System.out.println("----Caught IOException----");
//		ModelAndView mav = new ModelAndView();
//	    mav.addObject("exception", exception);
//	    mav.setViewName("/error/error");
//	    return mav;
//	}
//
//	@ExceptionHandler(BusinessLogicException.class)
//	public String notFound() {
//		System.out.println("----Caught KeywordNotFoundException----");
//		return "404";
//	}
//}
