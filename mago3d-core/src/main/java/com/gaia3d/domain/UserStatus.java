package com.gaia3d.domain;

public enum UserStatus {
	USE(0), FORBID(1), FAIL_LOGIN_COUNT_OVER(2), SLEEP(3), TERM_END(4), LOGICAL_DELETE(5), TEMP_PASSWORD(6);
	
	private final int value;
	
	UserStatus(int value) {
		this.value = value;
	}
	
	public int getValue() {
		return this.value;
	}
}
