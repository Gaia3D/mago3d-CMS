package com.gaia3d.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CustomErrorController implements ErrorController {
	private static final String PATH = "/error"; // configure 에서 Redirect 될 path

    @RequestMapping(value = PATH)
    public String error(HttpServletRequest request) {
    	log.error("******************* TODO REST 와 일반 Controller 구분을 어떻게 하지? *******************");
    	Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);

    	log.error("********************** status = {}, HttpStatus.NOT_FOUND = {}", status, HttpStatus.NOT_FOUND.toString());
    	if (String.valueOf(status).equalsIgnoreCase(String.valueOf(HttpStatus.NOT_FOUND.value()))) {
    		return "/error/error";
    		//return "errors/404"; // /WEB-INF/errors/404.jsp
    	}
    	//return "error";
    	return "/error/error";
    }

    @Override
    public String getErrorPath() {
    	return PATH;
    }
}