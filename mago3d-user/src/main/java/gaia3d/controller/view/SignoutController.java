package gaia3d.controller.view;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import gaia3d.domain.Key;
import gaia3d.domain.user.UserSession;
import lombok.extern.slf4j.Slf4j;

/**
 * Sign Out 처리
 * 
 * @author jeongdae
 */
@Slf4j
@Controller
@RequestMapping("/sign")
public class SignoutController {

	/**
	 * Sign out
	 * @param request
	 * @return
	 */
	@GetMapping(value = "/signout")
	public String signout(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		UserSession userSession = (UserSession)session.getAttribute(Key.USER_SESSION.name());
		
		if(userSession == null) {
			return "redirect:/sign/signin";
		}
		
		session.removeAttribute(userSession.getUserId());
		session.removeAttribute(Key.USER_SESSION.name());
		session.invalidate();
		
		return "redirect:/sign/signin";
	}
}
