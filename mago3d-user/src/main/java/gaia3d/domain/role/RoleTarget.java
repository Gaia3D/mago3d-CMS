package gaia3d.domain.role;

public enum RoleTarget {

	// 사용자 사이트
	USER("0"),
	// 관리자 사이트
	ADMIN("1");

	private final String value;
		
	RoleTarget(String value) {
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
	public static RoleTarget findBy(String value) {
		for(RoleTarget roleTarget : values()) {
			if(roleTarget.getValue().equals(value)) return roleTarget; 
		}
		return null;
	}
}
