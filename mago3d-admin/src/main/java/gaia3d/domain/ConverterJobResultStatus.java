package gaia3d.domain;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Stream;

public enum ConverterJobResultStatus {
	// 성공
	SUCCESS("success"),
	// 실패
	FAILURE("failure");

	private final String value;

	ConverterJobResultStatus(String value) {
		this.value = value;
	}

	public String getValue() {
		return this.value;
	}

//	@JsonCreator
//	public static ConverterJobResultStatus fromString(String symbol) {
//		return findByStatus(symbol);
//	}

	public static Map<String, Object> toEnumHashMap() {
		Map<String, Object> eMap = new HashMap<>();
		Stream.of(ConverterJobResultStatus.values())
				.forEach(e -> eMap.put(e.toString(), 0L));
		return eMap;
	}

	public static ConverterJobResultStatus findByStatus(String value) {
		return Arrays.stream(ConverterJobResultStatus.values())
				.filter(e -> e.value.equals(value))
				.findAny()
				.orElse(null);
	}

}
