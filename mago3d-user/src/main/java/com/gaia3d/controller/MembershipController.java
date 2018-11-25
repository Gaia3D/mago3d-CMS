package com.gaia3d.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.domain.Membership;
import com.gaia3d.domain.UserSession;
import com.gaia3d.service.MembershipService;

import lombok.extern.slf4j.Slf4j;

/**
 * 운영 정책
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/membership/")
public class MembershipController {
	
	@Autowired
	private MembershipService membershipService;
	
	/**
	 * 회원권 수정 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "modify-membership.do")
	public String modifyMembership(HttpServletRequest request, Model model) {
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
		Optional<Membership> membership = Optional.ofNullable(membershipService.getMembership(userSession.getUser_id()));
		membership.orElse(new Membership());
		log.info("@@@@@@@@@@ membership = {}", membership);
		
		model.addAttribute("membership", membership);
		
		return "/membership/modify-membership";
	}
	
	/**
	 * 회원권 수정
	 * @param request
	 * @param membership
	 * @return
	 */
	@PostMapping(value = "ajax-update-membership.do")
	@ResponseBody
	public Map<String, String> updateMembership(HttpServletRequest request, Membership membership) {
		Map<String, String> map = new HashMap<>();
		String result = "success";
		try {
			log.info("@@ membership = {} ", membership);
			
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);	
			
			membership.setUser_id(userSession.getUser_id());
			
			membershipService.updateMembership(membership);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
}
