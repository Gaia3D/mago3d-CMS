package gaia3d.domain;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Stream;

public enum ConverterJobStatus {

	// 준비
	READY("ready"),
	// 성공
	SUCCESS("success"),
	// 부분 성공
	PARTIAL_SUCCESS("partial_success"),
	// 승인 대기
	WAITING("waiting"),
	// 실패
	FAIL("fail");

	private final String value;

	ConverterJobStatus(String value) {
		this.value = value;
	}

	public String getValue() {
		return this.value;
	}

	public static Map<String, Object> toEnumHashMap() {
		Map<String, Object> eMap = new HashMap<>();
		Stream.of(ConverterJobStatus.values())
			  .forEach(e ->  eMap.put(e.toString(), 0L));
		return eMap;
	}

	public static ConverterJobStatus findByStatus(String value) {
		return Arrays.stream(ConverterJobStatus.values())
					 .filter(e -> e.value.equals(value))
					 .findAny()
					 .orElse(null);
	}
}
