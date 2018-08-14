package com.gaia3d.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.config.PropertiesConfig;
import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.Project;
import com.gaia3d.domain.UserPolicy;
import com.gaia3d.domain.UserSession;
import com.gaia3d.service.UserPolicyService;

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