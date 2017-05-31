package com.gaia3d.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.UserInfo;

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
	@GetMapping("/login.do")
	public String login(HttpServletRequest request, Model model) {
		
		Policy policy = CacheManager.getPolicy();
		log.info("@@ policy = {}", policy);
		
		long nowTime = System.nanoTime();
		String TOKEN_AES_KEY = (String.valueOf(nowTime) + "0000000000").substring(0, 16);
		request.getSession().setAttribute("SESSION_TOKEN_AES_KEY", TOKEN_AES_KEY);
		log.info("@@ SESSION_TOKEN_AES_KEY = {}", TOKEN_AES_KEY);
		
		UserInfo loginForm = new UserInfo();
		model.addAttribute("loginForm", loginForm);
		model.addAttribute("policy", policy);
		model.addAttribute("TOKEN_AES_KEY", TOKEN_AES_KEY);
		
		return "/login/login";
	}
}
