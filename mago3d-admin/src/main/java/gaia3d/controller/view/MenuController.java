package gaia3d.controller.view;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/menu")
public class MenuController {
	
	@GetMapping(value = "/admin-menu")
	public String adminMenu(HttpServletRequest request, Model model) {
		return "/menu/admin-menu";
	}
	
	@GetMapping(value = "/user-menu")
	public String userMenu (HttpServletRequest request, Model model) {
		return "/menu/user-menu";
	}
}
