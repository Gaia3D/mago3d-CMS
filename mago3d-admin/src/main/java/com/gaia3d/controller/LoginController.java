package com.gaia3d.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

/**
 * 로그인 처리
 * 
 * @author jeongdae
 */
@Slf4j
@Controller
@RequestMapping("/login/")
public class LoginController {
	
	/**
	 * 로그인 페이지
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "login.do", method = RequestMethod.GET)
	public String login(HttpServletRequest request, Model model) {
		log.info("@@ wellcome");
		return "/login/login";
	}
}
