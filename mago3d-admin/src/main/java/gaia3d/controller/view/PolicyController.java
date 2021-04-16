package gaia3d.controller.view;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import gaia3d.domain.policy.Policy;
import gaia3d.service.PolicyService;

@Controller
@RequestMapping("/policy")
public class PolicyController {

	@Autowired
	private PolicyService policyService;

	@GetMapping(value = "/modify")
	public String modify(HttpServletRequest request, Model model) {
		Policy policy = policyService.getPolicy();

		model.addAttribute("policy", policy);

		return "/policy/modify";
	}
}
