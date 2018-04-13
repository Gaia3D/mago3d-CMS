package com.gaia3d.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.Pagination;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.ReportMaintenance;
import com.gaia3d.service.UserService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.FormatUtil;
import com.gaia3d.util.StringUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * 레포트
 * 
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/report/")
public class ReportController {
	
	@Autowired
	private UserService userService;
	
	/**
	 * 정기 레포트 목록
	 * @param request
	 * @param reportMaintenance
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list-report-maintenance.do")
	public String listReportMaintenance(HttpServletRequest request, ReportMaintenance reportMaintenance, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		log.info("@@ reportMaintenance = {}", reportMaintenance);
		if(StringUtil.isNotEmpty(reportMaintenance.getStart_date())) {
			reportMaintenance.setStart_date(reportMaintenance.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isNotEmpty(reportMaintenance.getEnd_date())) {
			reportMaintenance.setEnd_date(reportMaintenance.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}

		//long totalCount = reportService.getReportMaintenanceTotalCount(reportMaintenance);
		long totalCount = 0l;
		
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(reportMaintenance), totalCount, Long.valueOf(pageNo).longValue());
		log.info("@@ pagination = {}", pagination);
		
		reportMaintenance.setOffset(pagination.getOffset());
		reportMaintenance.setLimit(pagination.getPageRows());
		List<ReportMaintenance> reportMaintenanceList = new ArrayList<ReportMaintenance>();
		if(totalCount > 0l) {
			//reportMaintenanceList = reportService.getListReportMaintenance(reportMaintenance);
			reportMaintenanceList = new ArrayList<>();
		}
		
		model.addAttribute(pagination);
		model.addAttribute("reportMaintenanceList", reportMaintenanceList);
		model.addAttribute("reportMaintenance", reportMaintenance);
		
		return "/report/list-report-maintenance";
	}
	
	/**
	 * 레포트 생성
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-insert-report-maintenance.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> ajaxIinsertReportMaintenance(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			//reportService.insertReportMaintenance(createReportMaintenance(request));
		} catch (Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		map.put("result", result);
		return map;
	}
	
	/**
	 * 레포트 상세 페이지
	 * @param report_maintenance_id
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "detail-report-maintenance.do")
	public ModelAndView detailReportMaintenance(@RequestParam("report_maintenance_id") Long report_maintenance_id, HttpServletRequest request) {
		Map<String,Object> parameterMap = new HashMap<String, Object>();
		ModelAndView modelAndView = new ModelAndView("preMaintenanceView" , parameterMap);
		List<ReportMaintenance> reportMaintenanceList = new ArrayList<ReportMaintenance>();
		
		
		modelAndView.addObject(reportMaintenanceList);
        
        return modelAndView;
	}
	
	/**
	 * 정기점검 데이터를 생성
	 * @param request
	 * @return
	 */
	public ReportMaintenance createReportMaintenance(HttpServletRequest request) {
		
		Policy policy = CacheManager.getPolicy();
		String today = DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY_TIME14);
		String report_date = today.substring(0, 8);
		String report_time = today.substring(8, 14);
		String year = today.substring(0, 4);
		String month = today.substring(4, 6);
		
		ReportMaintenance reportMaintenance = new ReportMaintenance();
		reportMaintenance.setReport_date(report_date);
		reportMaintenance.setReport_time(report_time);
		reportMaintenance.setYear(year);
		reportMaintenance.setMonth(month);
		reportMaintenance.setThis_year(year);
		
		reportMaintenance.setService_name(policy.getSite_name());
		reportMaintenance.setVersion(policy.getSolution_version());
		
		// 회사 로그
		String imagePath = request.getSession().getServletContext().getRealPath("/");
		
		return reportMaintenance;
	}
	
	private ReportMaintenance getMonitoringLog(ReportMaintenance reportMaintenance) {
		// 현재 디스크 사용량
		return reportMaintenance;
	}
	
	/**
	 * 검색 조건
	 * @param reportMaintenance
	 * @return
	 */
	private String getSearchParameters(ReportMaintenance reportMaintenance) {
		// TODO 아래 메소드랑 통합
		StringBuilder builder = new StringBuilder(100);
		builder.append("&");
		builder.append("start_date=" + StringUtil.getDefaultValue(reportMaintenance.getStart_date()));
		builder.append("&");
		builder.append("end_date=" + StringUtil.getDefaultValue(reportMaintenance.getEnd_date()));
		builder.append("&");
		builder.append("order_word=" + StringUtil.getDefaultValue(reportMaintenance.getOrder_word()));
		builder.append("&");
		builder.append("order_value=" + StringUtil.getDefaultValue(reportMaintenance.getOrder_value()));
		return builder.toString();
	}
}
