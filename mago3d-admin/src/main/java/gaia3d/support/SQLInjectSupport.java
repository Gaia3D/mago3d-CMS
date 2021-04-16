package gaia3d.support;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SQLInjectSupport {

	public static final List<String> sqlInjection = new ArrayList<>(
		Arrays.asList(
				"create",
				"drop",
				"delete",
				"truncate",
//				"grant",
				"rollback"
		)
	);
	
	/**
	 * sql injection 단어를 공백으로 치환
	 * @param value
	 * @return
	 */
	public static String replaceSqlInection(String value) {
		if(value != null && !"".equals(value)) {
			if(sqlInjection.contains(value.toLowerCase())) {
				log.info("@@ SQL Injection Replace. value = {}", value);
				return "";
			}
		}
		
		return value;
	}
}
