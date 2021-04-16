package gaia3d.controller.view;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import gaia3d.domain.widget.Widget;
import gaia3d.service.WidgetService;
import gaia3d.utils.DateUtils;
import gaia3d.utils.FormatUtils;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/widget")
public class WidgetController {

	@Autowired
	private WidgetService widgetService;

	@GetMapping(value = "/modify")
	public String modify(HttpServletRequest reuqet, Model model) {

		Widget widget = new Widget();
		List<Widget> widgetList = widgetService.getListWidget(widget);

		String today = DateUtils.getToday(FormatUtils.VIEW_YEAR_MONTH_DAY_TIME);
		String yearMonthDay = today.substring(0, 4) + today.substring(5,7) + today.substring(8,10);

		model.addAttribute("today", today);
		model.addAttribute("yearMonthDay", today.subSequence(0, 10));
		model.addAttribute("thisYear", yearMonthDay.subSequence(0, 4));

		model.addAttribute(widget);
		model.addAttribute(widgetList);

		return "/widget/modify";
	}
}
