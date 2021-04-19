package gaia3d.domain.role;

public enum RoleType {

	// 사용자
	USER("0"),
	// 서버
	SERVER("1"),
	// api
	API("2");

	private final String value;
		
	RoleType(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return this.value;
	}
	
	/**
	 * TODO values for loop 로 변환
	 * @param value
	 * @return
	 */
	public static RoleType findBy(String value) {
		for(RoleType roleType : values()) {
			if(roleType.getValue().equals(value)) return roleType; 
		}
		return null;
	}
}
