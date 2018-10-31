package com.gaia3d.controller;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ErrorController {

	/**
	 * Project 목록
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/error")
	public String clientList(HttpServletRequest request, Model model) {
		
		log.info("@@@@@@@@@@ error");
		
		printHead(request);
		
		return "/error/error";
	}
	
	private void printHead(HttpServletRequest request) {
    	Enumeration<String> headerNames = request.getHeaderNames();
        while (headerNames.hasMoreElements()) {
        	String headerName = headerNames.nextElement();
        	log.info("headerName = {}", headerName);
        	Enumeration<String> headers = request.getHeaders(headerName);
        	while (headers.hasMoreElements()) {
        		String headerValue = headers.nextElement();
        		log.info(" ---> headerValue = {}", headerValue);
        	}
        }
    }
}
