package gaia3d.controller.view;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import gaia3d.domain.UserInfo;
import gaia3d.domain.UserStatus;
import gaia3d.service.UserService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/widget")
public class WidgetController {
	
	@Autowired private UserService userService;

	@GetMapping(value = "/modify")
	public String modify(HttpServletRequest reuqet, Model model) {
		// 사용자 상태별 현황 
		UserInfo userInfo = new UserInfo();
		long totalUserCount = userService.getUserTotalCount(userInfo);
		userInfo.setStatus("0");
		Long activeUserTotalCount = userService.getUserTotalCount(userInfo);
		userInfo.setStatus("2");
		Long fobidUserTotalCount = userService.getUserTotalCount(userInfo);
		userInfo.setStatus("3");
		Long failUserTotalCount = userService.getUserTotalCount(userInfo);
		userInfo.setStatus("4");
		Long sleepUserTotalCount = userService.getUserTotalCount(userInfo);
		userInfo.setStatus("5");
		Long expireUserTotalCount = userService.getUserTotalCount(userInfo);
		userInfo.setStatus("6");
		Long tempPasswordUserTotalCount = userService.getUserTotalCount(userInfo);

		// 사용자 상태별 현황
		model.addAttribute("totalUserCount", totalUserCount);
		model.addAttribute("activeUserTotalCount", activeUserTotalCount);
		model.addAttribute("fobidUserTotalCount", fobidUserTotalCount);
		model.addAttribute("failUserTotalCount", failUserTotalCount);
		model.addAttribute("sleepUserTotalCount", sleepUserTotalCount);
		model.addAttribute("expireUserTotalCount", expireUserTotalCount);
		model.addAttribute("tempPasswordUserTotalCount", tempPasswordUserTotalCount);

		return "/widget/modify";
	}
}
