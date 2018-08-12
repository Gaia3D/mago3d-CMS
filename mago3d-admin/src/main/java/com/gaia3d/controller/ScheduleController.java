package com.gaia3d.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gaia3d.domain.Pagination;
import com.gaia3d.domain.Schedule;
import com.gaia3d.domain.ScheduleLog;
import com.gaia3d.service.ScheduleService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.StringUtil;
import com.gaia3d.validator.ScheduleValidator;
import lombok.extern.slf4j.Slf4j;

/**
 * 스케줄
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/schedule/")
public class ScheduleController {
	
	@Resource(name="scheduleValidator")
	private ScheduleValidator scheduleValidator;
	@Autowired
	private ScheduleService scheduleService;
	
	/**
	 * 스케줄 목록
	 * @param request
	 * @param schedule
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list-schedule.do")
	public String listSchedule(HttpServletRequest request, Schedule schedule, Model model) {
		List<Schedule> scheduleList = scheduleService.getListSchedule(schedule);
		long totalCount = scheduleList.size();
		
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("scheduleList", scheduleList);
		
		return "/schedule/list-schedule";
	}
	
//	/**
//	 * 스케줄 등록 화면
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value = "input-schedule.do", method = RequestMethod.GET)
//	public String inputSchedule(Model model) {
//		
//		Schedule schedule = new Schedule();
//		model.addAttribute(schedule);
//		return "/schedule/input-schedule";
//	}
//	
//	/**
//	 * 스케줄 등록
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value = "insert-schedule.do", method = RequestMethod.POST)
//	public String insertSchedule(HttpServletRequest request, @ModelAttribute("schedule") Schedule schedule, BindingResult bindingResult, Model model) {
//		
//		// 등록, 수정 화면의 validation 항목이 다를 경우를 위한 변수
//		schedule.setMethod_mode("insert");
//		this.scheduleValidator.validate(schedule, bindingResult);
//		if(bindingResult.hasErrors()) {
//			return "/schedule/input-schedule";
//		}
//		
//		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
//		schedule.setUser_id(userSession.getUser_id());
//		
//		Integer schedule_id = scheduleService.insertSchedule(schedule);
//		
//		return "redirect:/schedule/result-schedule.do?method_mode=insert&schedule_id=" + schedule_id;
//	}
//	
//	/**
//	 * 스케줄 정보
//	 * @param schedule_id
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value = "detail-schedule.do", method = RequestMethod.GET)
//	public String detailSchedule(@RequestParam("schedule_id") Long schedule_id, Model model) {
//		
//		Schedule schedule = scheduleService.getSchedule(schedule_id);
//		model.addAttribute(schedule);
//		
//		return "/schedule/detail-schedule";
//	}
//	
//	/**
//	 * 스케줄 정보 수정 화면
//	 * @param user_id
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value = "modify-schedule.do", method = RequestMethod.GET)
//	public String modifySchedule(@RequestParam("schedule_id") Long schedule_id, Model model) {
//		
//		Schedule schedule = scheduleService.getSchedule(schedule_id);
//		model.addAttribute(schedule);
//		
//		return "/schedule/modify-schedule";
//	}
//	
//	/**
//	 * 스케줄 정보 수정
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value = "update-schedule.do", method = RequestMethod.POST)
//	public String updateSchedule(HttpServletRequest request, @ModelAttribute("schedule") Schedule schedule, BindingResult bindingResult, Model model) {
//		
//		// 등록, 수정 화면의 validation 항목이 다를 경우를 위한 변수
//		schedule.setMethod_mode("update");
//		this.scheduleValidator.validate(schedule, bindingResult);
//		if(bindingResult.hasErrors()) {
//			log.info("@@ validation error!");
//			return "/schedule/modify-schedule";
//		}
//		
//		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
//		schedule.setUser_id(userSession.getUser_id());
//		
//		scheduleService.updateSchedule(schedule);
//		
//		return "redirect:/schedule/result-schedule.do?method_mode=update&schedule_id=" + schedule.getSchedule_id();
//	}
//	
//	/**
//	 * 스케줄 삭제
//	 * @param user_id
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value = "delete-schedule.do", method = RequestMethod.GET)
//	public String deleteSchedule(@RequestParam("schedule_id") Long schedule_id, Model model) {
//		
//		scheduleService.deleteSchedule(schedule_id);
//		
//		return "redirect:/schedule/result-schedule.do?method_mode=delete";
//	}
//	
//	/**
//	 * 스케줄 등록, 수정, 삭제 처리 결과 페이지
//	 * @param user_id
//	 * @param method_mode insert 는 등록, update 수정, delete 는 삭제
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value = "result-schedule.do", method = RequestMethod.GET)
//	public String resultSchedule(HttpServletRequest request, @RequestParam("method_mode") String method_mode, Model model) {
//		
//		if("insert".equals(method_mode) || "update".equals(method_mode)) {
//			String schedule_id = request.getParameter("schedule_id");
//			if(schedule_id == null || "".equals(schedule_id)) {
//				log.error("@@ Invalid schedule_id. schedule_id = {}", schedule_id);
//				return "redirect:/schedule/list-schedule.do";
//			}
//			Schedule schedule = scheduleService.getSchedule(Long.valueOf(schedule_id));
//			model.addAttribute(schedule);
//		}
//		model.addAttribute("method_mode", method_mode);
//		
//		return "/schedule/result-schedule";
//	}
//	
	/**
	 * 스케줄 실행 이력 목록
	 * @param request
	 * @param schedule
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list-schedule-log.do")
	public String listScheduleLog(HttpServletRequest request, ScheduleLog scheduleLog, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		if(StringUtil.isNotEmpty(scheduleLog.getStart_date())) {
			scheduleLog.setStart_date(scheduleLog.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isNotEmpty(scheduleLog.getEnd_date())) {
			scheduleLog.setEnd_date(scheduleLog.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}
		long totalCount = scheduleService.getScheduleLogTotalCount(scheduleLog);
		
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(scheduleLog), totalCount, Long.valueOf(pageNo).longValue());
		log.info("@@ pagination = {}", pagination);
		
		scheduleLog.setOffset(pagination.getOffset());
		scheduleLog.setLimit(pagination.getPageRows());
		List<ScheduleLog> scheduleLogList = new ArrayList<ScheduleLog>();
		if(totalCount > 0l) {
			scheduleLogList = scheduleService.getListScheduleLog(scheduleLog);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("scheduleLogList", scheduleLogList);
		return "/schedule/list-schedule-log";
	}
//	
//	/**
//	 * 스케줄 실행 상세 이력 목록
//	 * @param request
//	 * @param schedule
//	 * @param pageNo
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value = "list-schedule-detail-log.do")
//	public String listScheduleDetailLog(HttpServletRequest request, ScheduleDetailLog scheduleDetailLog, @RequestParam(defaultValue="1") String pageNo, Model model) {
//		
//		long totalCount = scheduleService.getScheduleDetailLogTotalCount(scheduleDetailLog);
//		
//		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(scheduleDetailLog), totalCount, Long.valueOf(pageNo).longValue());
//		log.info("@@ pagination = {}", pagination);
//		
//		scheduleDetailLog.setOffset(pagination.getOffset());
//		scheduleDetailLog.setLimit(pagination.getPageRows());
//		List<ScheduleDetailLog> scheduleDetailLogList = new ArrayList<ScheduleDetailLog>();
//		if(totalCount > 0l) {
//			scheduleDetailLogList = scheduleService.getListScheduleDetailLog(scheduleDetailLog);
//		}
//		
//		model.addAttribute(pagination);
//		model.addAttribute("scheduleDetailLogList", scheduleDetailLogList);
//		return "/schedule/list-schedule-detail-log";
//	}
	
	/**
	 * 검색 조건
	 * @param scheduleLog
	 * @return
	 */
	private String getSearchParameters(ScheduleLog scheduleLog) {
		// TODO 아래 메소드랑 통합
		StringBuffer buffer = new StringBuffer();
		buffer.append("&");
		buffer.append("search_word=" + StringUtil.getDefaultValue(scheduleLog.getSearch_word()));
		buffer.append("&");
		buffer.append("search_option=" + StringUtil.getDefaultValue(scheduleLog.getSearch_option()));
		buffer.append("&");
		try {
			buffer.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(scheduleLog.getSearch_value()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			buffer.append("search_value=");
		}
		buffer.append("&");
		buffer.append("start_date=" + StringUtil.getDefaultValue(scheduleLog.getStart_date()));
		buffer.append("&");
		buffer.append("end_date=" + StringUtil.getDefaultValue(scheduleLog.getEnd_date()));
		buffer.append("&");
		buffer.append("order_word=" + StringUtil.getDefaultValue(scheduleLog.getOrder_word()));
		buffer.append("&");
		buffer.append("order_value=" + StringUtil.getDefaultValue(scheduleLog.getOrder_value()));
		buffer.append("&");
		buffer.append("list_count=" + scheduleLog.getList_counter());
		return buffer.toString();
	}
	
	/**
	 * 목록 페이지 이동 검색 조건
	 * @param request
	 * @return
	 */
	private String getListParameters(HttpServletRequest request) {
		StringBuffer buffer = new StringBuffer();
		String pageNo = request.getParameter("pageNo");
		buffer.append("pageNo=" + pageNo);
		buffer.append("&");
		buffer.append("search_word=" + StringUtil.getDefaultValue(request.getParameter("search_word")));
		buffer.append("&");
		buffer.append("search_option=" + StringUtil.getDefaultValue(request.getParameter("search_option")));
		buffer.append("&");
		try {
			buffer.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(request.getParameter("search_value")), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			buffer.append("search_value=");
		}
		buffer.append("&");
		buffer.append("start_date=" + StringUtil.getDefaultValue(request.getParameter("start_date")));
		buffer.append("&");
		buffer.append("end_date=" + StringUtil.getDefaultValue(request.getParameter("end_date")));
		buffer.append("&");
		buffer.append("order_word=" + StringUtil.getDefaultValue(request.getParameter("order_word")));
		buffer.append("&");
		buffer.append("order_value=" + StringUtil.getDefaultValue(request.getParameter("order_value")));
		buffer.append("&");
		buffer.append("list_count=" + StringUtil.getDefaultValue(request.getParameter("list_count")));
		return buffer.toString();
	}
}
