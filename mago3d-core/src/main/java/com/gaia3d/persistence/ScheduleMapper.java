package com.gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.Schedule;
import com.gaia3d.domain.ScheduleLog;

/**
 * 스케줄
 * @author jeongdae
 *
 */
@Repository
public interface ScheduleMapper {

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
	 * 스케줄 실행 이력 등록건 수
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
