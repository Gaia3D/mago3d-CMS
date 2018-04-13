package com.gaia3d.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.DataInfoLog;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.Statistic;
import com.gaia3d.domain.UserInfo;
import com.gaia3d.service.UserService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.FormatUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * 통계
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/statistic/")
public class StatisticController {
	
//	// 시작년도
//	private static final int START_YEAR = 2018;
//	// 6개월 주기
//	private static final String SIX_MONTH_INTERVAL = "0";
//	// 1년 주기
//	private static final String TWELVE_MONTH_INTERVAL = "1";

	@Autowired
	private UserService userService;	 
	
	/**
	 * 통계 페이지
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "index.do")
	public String index(Statistic statistic, Model model) {
		
		String periodYearMonth = DateUtil.getToday(FormatUtil.VIEW_YEAR_MONTH_DAY_TIME).substring(0, 7);
		periodYearMonth = periodYearMonth.replaceAll("-", "");

		String year = null;
		String month = null;
		if(statistic.getYear_month_day() == null || "".equals(statistic.getYear_month_day())) {
			year = periodYearMonth.substring(0, 4);
			month = periodYearMonth.substring(4, 6);
		} else {
			year = statistic.getYear_month_day().substring(0, 4);
			month = statistic.getYear_month_day().substring(4, 6);
		}
		
		Policy policy = CacheManager.getPolicy();
		
		model.addAttribute("periodYearMonth", periodYearMonth);
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("policy", policy);
		model.addAttribute("excelStatistic", new Statistic());
		
		return "/statistic/index";
	}
	
	/**
	 * Data Info Log 통계
	 * @param type
	 * @param year_month_day
	 * @return
	 */
	@RequestMapping(value = "ajax-data-log-statistics.do")
	@ResponseBody
	public Map<String, Object> ajaxUserStatistics(@RequestParam("type") String type, @RequestParam(value="year_month_day", required=false) String year_month_day) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		
		long userTotalCount = 0l;
		
		
		try {
			UserInfo userInfo = new UserInfo();
			DataInfoLog dataInfoLog = new DataInfoLog();
			
			
			
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		map.put("userTotalCount", userTotalCount);
		
		return map;
	}
	
	/**
	 * Issue 통계
	 * @param type
	 * @param year_month_day
	 * @return
	 */
	@RequestMapping(value = "ajax-issue-statistics.do")
	@ResponseBody
	public Map<String, Object> ajaxIssueStatistics(@RequestParam("type") String type, @RequestParam(value="year_month_day", required=false) String year_month_day) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		
		
		
		try {
			
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		
		
		return map;
	}
	
	/**
	 * 시작일
	 * @param type
	 * @param year_month_day
	 * @return
	 */
	private String getStartDate(String year_month_day) {
		return year_month_day + DateUtil.START_TIME;
	}
	
	/**
	 * 종료일
	 * @param type
	 * @param year_month_day
	 * @return
	 */
	private String getEndDate(String type, String year_month_day) {
		
		String endDate = null;
		String year = year_month_day.substring(0, 4);
		String month = year_month_day.substring(4, 6);
		
		if(Policy.STATISTICS_YEAR.equals(type)) {
			// 년도
			endDate = year + "1231" + DateUtil.END_TIME;
		} else if(Policy.STATISTICS_YEAR_HALF.equals(type)) {
			// 상/하반기
			if("01".equals(month)) {
				endDate = year + "0630" + DateUtil.END_TIME;
			} else {
				endDate = year + "1231" + DateUtil.END_TIME;
			}
		} else if(Policy.STATISTICS_QUARTER.equals(type)) {
			// 분기
			if("01".equals(month)) {
				endDate = year + "0331" + DateUtil.END_TIME;
			} else if("04".equals(month)) {
				endDate = year + "0630" + DateUtil.END_TIME;
			} else if("07".equals(month)) {
				endDate = year + "0930" + DateUtil.END_TIME;
			} else if("10".equals(month)) {
				endDate = year + "1231" + DateUtil.END_TIME;
			}
		} else if(Policy.STATISTICS_MONTH.equals(type)) {
			// 월
			endDate = DateUtil.getMonthLastDay(year + month) + DateUtil.END_TIME;
		}
		
		return endDate;
	}
	
	/**
	 * 통계 Excel 다운로드
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "download-excel-statistic.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView downloadExcelStatistic(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("excelStatistic") Statistic statistic, Model model) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("pOIExcelView");
		modelAndView.addObject("fileType", "STATISTIC");
		modelAndView.addObject("fileName", "STATISTIC");
		modelAndView.addObject("statistic", statistic);
		return modelAndView;
	}
}
