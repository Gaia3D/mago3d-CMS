package gaia3d.domain;

import java.util.Arrays;

public enum ConverterJobStatus {

	// 준비
	READY("ready"),
	// 성공
	SUCCESS("success"),
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

	public static ConverterJobStatus findByStatus(String value) {
		return Arrays.stream(ConverterJobStatus.values())
					 .filter(e -> e.value.equals(value))
					 .findAny()
					 .orElse(null);
	}
}
