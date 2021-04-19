package gaia3d.utils;

import java.util.Calendar;
import java.util.Date;

public class DateUtils {
	
	// 시작일 Timestamp MMDDHH24MISSUS
	public static final String START_DAY_TIME = "0101000000000000";
	// 시작일 Timestamp HH24MISSUS
	public static final String START_TIME = "000000000000";
	// 종료일 Timestamp HH24MISSUS
	public static final String END_TIME = "235959999999";
	// Timestamp US
	public static final String MICROSECOND  = "00000";

	/**
	 * 현재 날짜 yyyy-MM-dd HH:mm:ss
	 * @return
	 */
	public static String getToday() {
		return getToday(FormatUtils.VIEW_YEAR_MONTH_DAY_TIME);
	}
	
	/**
	 * 현재 날짜
	 * @param pattern
	 * @return
	 */
	public static String getToday(String pattern) {
		Calendar calendar = Calendar.getInstance();
		return FormatUtils.getDayFormat(calendar.getTime(), pattern);
	}
	
	/**
	 * 입력 날짜를 원하는 포맷으로 전달
	 * @param date
	 * @param pattern
	 * @return
	 */
	public static String getViewDay(Date date, String pattern) {
		return FormatUtils.getDayFormat(date, pattern);
	}
	
	/**
	 * 입력 값이 비교 값보다 이전이면 true, 그외는 false
	 * @param dayPattern 입력받는 날짜 타입
	 * @param comparePattern 비교해야 하는 날짜 타입
	 * @param periodPattern 기간 타입
	 * @param period 기간
	 * @param inputDay 입력 날짜
	 * @param compareDay 비교 날짜
	 * @return
	 */
	public static boolean isValidTime(	String dayPattern, 
										String comparePattern, 
										int periodPattern, 
										int period, 
										String inputDay, 
										String compareDay) {
		
		boolean result = false;
		
		Calendar inputCalendar = Calendar.getInstance();
		Calendar compareCalendar = Calendar.getInstance();
		
		if(FormatUtils.YEAR_MONTH_DAY_TIME14.equals(dayPattern)) {
			inputCalendar.set(	Integer.parseInt(inputDay.substring(0, 4)),
								Integer.parseInt(inputDay.substring(4, 6)) - 1,
								Integer.parseInt(inputDay.substring(6, 8)),
								Integer.parseInt(inputDay.substring(8, 10)),
								Integer.parseInt(inputDay.substring(10, 12)),
								Integer.parseInt(inputDay.substring(12, 14)));
			
			compareCalendar.set(Integer.parseInt(compareDay.substring(0, 4)),
								Integer.parseInt(compareDay.substring(4, 6)) - 1,
								Integer.parseInt(compareDay.substring(6, 8)),
								Integer.parseInt(compareDay.substring(8, 10)),
								Integer.parseInt(compareDay.substring(10, 12)),
								Integer.parseInt(compareDay.substring(12, 14)));
		}
		
		inputCalendar.add(periodPattern, period);
		
		if(inputCalendar.after(compareCalendar)) {
			result = true;
		}
		
		return result;
	}
	
	/**
	 * 입력월의 마지막 날을 구함
	 * @param yearMonth
	 * @return
	 */
	public static String getMonthLastDay(String yearMonth) {
		int year = Integer.valueOf(yearMonth.substring(0, 4));
		int month = Integer.valueOf(yearMonth.substring(4, 6));
		
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.YEAR, year);
		calendar.set(Calendar.MONTH, month -1);
		calendar.set(Calendar.DATE, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
		
		return FormatUtils.getDayFormat(calendar.getTime(), FormatUtils.YEAR_MONTH_DAY);
	}
	
	/**
	 * TODO 나중에 공통으로 만들자.
	 * 날짜를 더하는 함수
	 * @param value
	 * @return
	 */
	public static String getAddDate(String type, String value) {
		Calendar calendar = Calendar.getInstance();
		
		if("DAY".equals(type)) {
			calendar.add(Calendar.DAY_OF_MONTH, Integer.valueOf(value));
			return FormatUtils.getDayFormat(calendar.getTime(), FormatUtils.YEAR_MONTH_DAY);
		} else if("HOUR".equals(type)) {
			calendar.add(Calendar.HOUR, Integer.valueOf(value));
			return FormatUtils.getDayFormat(calendar.getTime(), FormatUtils.YEAR_MONTH_DAY_TIME14);
		} else {
			return null;
		}
	}
}
