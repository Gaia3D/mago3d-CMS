package gaia3d.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 데이터 포맷을 처리
 * @author jeongdae
 *
 */
public class FormatUtils {
	
	public static final String VIEW_YEAR_MONTH_DAY_TIME = "yyyy-MM-dd HH:mm:ss";
	public static final String YEAR_MONTH_DAY = "yyyyMMdd";
	public static final String YEAR_MONTH_DAY_TIME14 = "yyyyMMddHHmmss";
	public static final String YEAR_MONTH_DAY_TIME12 = "yyyyMMddHHmm";
	
	public static final SimpleDateFormat viewDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	/**
	 * 년월일 시간분초 까지 표시
	 * @param date
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
	
	public static String getViewDateyyyyMMddHHmmss(Date date) {
		return viewDateFormat.format(date);
		
	}
}
