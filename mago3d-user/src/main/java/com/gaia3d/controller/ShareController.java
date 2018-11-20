package com.gaia3d.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

/**
 * share
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/share/")
public class ShareController {
	
	/**
	 * list project
	 * @param model
	 * @return
	 */
	@GetMapping(value = "list-project.do")
	public String listProject(HttpServletRequest request, Model model) {
		return "/share/list-project";
	}
	
	/**
	 * map project
	 * @param model
	 * @return
	 */
	@GetMapping(value = "map-project.do")
	public String mapProject(HttpServletRequest request, Model model) {
		return "/share/map-project";
	}
}