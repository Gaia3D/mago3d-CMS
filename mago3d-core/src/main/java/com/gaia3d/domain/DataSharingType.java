package com.gaia3d.domain;

public enum DataSharingType {

	//공유 타입. 0 : common, 1: public, 2 : private, 3 : sharing
	//public DataSharingType(String value) {
	COMMON("0"), PUBLIC("1"), PRIVATE("2"), SHARING("3");
	
	private final String value;
	
	DataSharingType(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return this.value;
	}
}
