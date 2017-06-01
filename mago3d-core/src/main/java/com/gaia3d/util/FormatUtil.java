package com.gaia3d.util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 데이터 포맷을 처리
 * @author jeongdae
 *
 */
public class FormatUtil {
	
	public static final String VIEW_YEAR_MONTH_DAY_TIME = "yyyy-MM-dd HH:mm:ss";
	public static final String YEAR_MONTH_DAY = "yyyyMMdd";
	public static final String YEAR_MONTH_DAY_TIME14 = "yyyyMMddHHmmss";
	public static final String YEAR_MONTH_DAY_TIME12 = "yyyyMMddHHmm";
	
	/**
	 * 년월일 시간분초 까지 표시
	 * @param date
	 * @param pattern
	 * @return
	 */
	public static String getDayFormat(Date date) {
		return getDayFormat(date, VIEW_YEAR_MONTH_DAY_TIME);
	}

	/**
	 * 입력 받은 패턴으로 표시
	 * @param date
	 * @param pattern
	 * @return
	 */
	public static String getDayFormat(Date date, String pattern) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
		return simpleDateFormat.format(date);
	}
}
