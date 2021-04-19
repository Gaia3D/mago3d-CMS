package gaia3d.config;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import gaia3d.support.LogMessageSupport;

/**
 * Controller Exception 처리
 * @author Cheon JeongDae
 *
 */
@Slf4j
@ControllerAdvice(basePackages = {"gaia3d.controller.view"})
public class ControllerExceptionHandler {
	
	@ExceptionHandler(Exception.class)
	public ModelAndView error(Exception exception) {
		log.error("**********************************************************");
		log.error("**************** GlobalExceptionHandler ******************");
		log.error("**********************************************************");
		
		//log.info("@@@ message = {}", exception.getMessage());
		LogMessageSupport.printMessage(exception);
		
		ModelAndView mav = new ModelAndView();
	    mav.addObject("exception", exception);
	    mav.setViewName("/error/error");
	    return mav;
	}

//	@ExceptionHandler(BusinessLogicException.class)
//	public String notFound(Exception exception) {
//		//System.out.println("----Caught KeywordNotFoundException----");
//		return "404";
//	}
}
