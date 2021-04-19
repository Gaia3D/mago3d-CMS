package gaia3d.support;

import lombok.extern.slf4j.Slf4j;

/**
 * profile에 따른 logMessage 출력
 * @author PSH
 *
 */
@Slf4j
public class LogMessageSupport {
	
	public static boolean stackTraceEnable = false;
	private static final String DEFAULT_MESSAGE = "Default Message = {}";
	
	/**
	 * log print
	 * @param e
	 */
	public static void printMessage(Exception e) {
		if(stackTraceEnable) {
			e.printStackTrace();
		} else {
			log.info(DEFAULT_MESSAGE, e.getMessage());
		}
	}
	
	/**
	 * log print
	 * @param e
	 * @param message
	 */
	public static void printMessage(Exception e, String message) {
		if(stackTraceEnable) {
			e.printStackTrace();
		} else {
			log.info(message, e.getMessage());
		}
	}
	
	/**
	 * log print
	 * @param e
	 * @param message
	 * @param value
	 */
	public static void printMessage(Exception e, String message, Object... value) {
		if(stackTraceEnable) {
			e.printStackTrace();
		} else {
			log.info(message, value);
		}
	}
}
