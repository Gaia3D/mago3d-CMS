package gaia3d.controller.view;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import gaia3d.domain.Policy;
import gaia3d.service.PolicyService;

/**
 * @author hansangkim
 *
 */
@Controller
@RequestMapping("/guide")
public class GuideController {
	
	@Autowired
	private PolicyService policyService;
	/**
	 * @param request
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/help")
	public String gotoApiHelp(HttpServletRequest request, Model model) {
		Policy policy = policyService.getPolicy();
		model.addAttribute("contentCacheVersion", policy.getContentCacheVersion());
		
		return "/guide/layout";
	}
	
	/**
	 * @param request
	 * @param api
	 * @return
	 */
	@PostMapping(value = "/loadPage")
	public String gotoApiToggle(HttpServletRequest request, @RequestParam(value="api") String api) {
		return "/guide/"+api;
	}
}
