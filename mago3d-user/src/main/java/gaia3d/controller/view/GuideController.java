package gaia3d.controller.view;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import gaia3d.domain.Key;
import gaia3d.domain.cache.CacheManager;
import gaia3d.domain.policy.Policy;

/**
 * @author hansangkim
 *
 */
@Controller
@RequestMapping("/guide")
public class GuideController {
	
	/**
	 * @param request
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/help")
	public String gotoApiHelpKo(HttpServletRequest request, Model model) {
		Policy policy = CacheManager.getPolicy();
		model.addAttribute("contentCacheVersion", policy.getContentCacheVersion());
		String lang = "ko";
		String k = (String)request.getSession().getAttribute(Key.LANG.name());
		if(k!=null) {
			lang = "en";
		}
		return "/guide/"+lang+"/layout";
	}
	
	/**
	 * @param request
	 * @param api
	 * @return
	 */
	@PostMapping(value = "/loadPage")
	public String gotoApiToggleKo(HttpServletRequest request, @RequestParam(value="api") String api) {
		String k = (String)request.getSession().getAttribute(Key.LANG.name());
		String lang = "ko";
		if(k!=null) {
			lang = "en";
		}
		return "/guide/"+lang+"/"+api;
	}
}
