package com.gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.Schedule;
import com.gaia3d.domain.ScheduleLog;
import com.gaia3d.persistence.ScheduleMapper;
import com.gaia3d.service.ScheduleService;

import lombok.extern.slf4j.Slf4j;

/**
 * 사용자
 * @author jeongdae
 *
 */
@Slf4j
@Service
public class ScheduleServiceImpl implements ScheduleService {

	@Autowired
	private ScheduleMapper scheduleMapper;
	
	/**
	 * 스케줄 목록
	 * @param schedule
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<Schedule> getListSchedule(Schedule schedule) {
		return scheduleMapper.getListSchedule(schedule);
	}
	
	/**
	 * 스케줄 정보 취득
	 * @param schedule_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public Schedule getSchedule(Long schedule_id) {
		return scheduleMapper.getSchedule(schedule_id);
	}
	
	/**
	 * 스케줄 정보 취득
	 * @param schedule_code
	 * @return
	 */
	@Transactional(readOnly=true)
	public Schedule getScheduleByScheduleCode(String schedule_code) {
		return scheduleMapper.getScheduleByScheduleCode(schedule_code);
	}
	
	/**
	 * 스케줄 실행 이력 총건 수
	 * @param scheduleLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getScheduleLogTotalCount(ScheduleLog scheduleLog) {
		return scheduleMapper.getScheduleLogTotalCount(scheduleLog);
	}
	
	/**
	 * 스케줄 실행 이력 목록
	 * @param scheduleLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<ScheduleLog> getListScheduleLog(ScheduleLog scheduleLog) {
		return scheduleMapper.getListScheduleLog(scheduleLog);
	}
	
	/**
	 * 스케줄 실행 이력 등록
	 * @param scheduleLog
	 * @return
	 */
	@Transactional
	public int insertScheduleLog(ScheduleLog scheduleLog) {
		return scheduleMapper.insertScheduleLog(scheduleLog);
	}
}
