package gaia3d.utils;

public class StringUtil {

	public static boolean isEmpty(String str) {
		return ((str == null) || (str.length() == 0));
	}

	public static boolean isNotEmpty(String str) {
		return (!(isEmpty(str)));
	}
	
	/**
	 * 입력 값이 숫자인지를 판단
	 * @param value
	 * @return
	 */
	public static boolean isNumber(String value) {
		String pattern = "^[0-9]*$";
		return value.matches(pattern);
	}
	
	/**
	 * Null 또는 공백일 경우 기본값으로 리턴
	 * @param value
	 * @return
	 */
	public static String getDefaultValue(String value) {
		return getDefaultValue(value, "");
	}
	
	public static String getDefaultValue(String value, String defaultValue) {
		if(value == null || "".equals(value.trim())) {
			return defaultValue;
		}
		
		return value;
	}
	
	/**
	 * 스트링 값을 Integer 값으로 변환
	 * @param value
	 * @return
	 */
	public static Integer getIntegerFromString(String value) {
		if(value == null || "".equals(value)) {
			return Integer.valueOf(0);
		}
		return  Integer.valueOf(value);
	}
	
	/**
	 * 줄바꿈 치환
	 * @param value
	 * @return
	 */
	public static String getStringNewLineConvertForHtml(String value) {
		return value.replaceAll("\n", "<br>");
	}
	
	/**
	 * 화면 표시를 위한 특수문자 치환
	 * @param value
	 * @return
	 */
	public static String getStringConvertForHtml(String value) {
		value = value.replaceAll("<", "&lt;");
		value = value.replaceAll(">", "&gt;");
		value = value.replaceAll("&", "&amp;");
		value = value.replaceAll(" ", "&nbsp;");
		value = value.replaceAll("\'", "&apos;");
		value = value.replaceAll("\"", "&quot;");
		return value;
	}
}
