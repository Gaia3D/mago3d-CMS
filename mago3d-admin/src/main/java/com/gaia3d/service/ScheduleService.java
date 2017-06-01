package com.gaia3d.service;

import java.util.List;

import com.gaia3d.domain.Schedule;
import com.gaia3d.domain.ScheduleLog;

/**
 * 메뉴 관리
 * @author jeongdae
 *
 */
public interface ScheduleService {
	
	/**
	 * 스케줄 목록
	 * @param schedule
	 * @return
	 */
	List<Schedule> getListSchedule(Schedule schedule);
	
	/**
	 * 스케줄 정보 취득
	 * @param schedule_id
	 * @return
	 */
	Schedule getSchedule(Long schedule_id);
	
	/**
	 * 스케줄 정보 취득
	 * @param schedule_code
	 * @return
	 */
	Schedule getScheduleByScheduleCode(String schedule_code);
	
	/**
	 * 스케줄 실행 이력 총건 수
	 * @param scheduleLog
	 * @return
	 */
	Long getScheduleLogTotalCount(ScheduleLog scheduleLog);
	
	/**
	 * 스케줄 실행 이력 목록
	 * @param scheduleLog
	 * @return
	 */
	List<ScheduleLog> getListScheduleLog(ScheduleLog scheduleLog);
	
	/**
	 * 스케줄 실행 이력 등록
	 * @param scheduleLog
	 * @return
	 */
	int insertScheduleLog(ScheduleLog scheduleLog);
}
