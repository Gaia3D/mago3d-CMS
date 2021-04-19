package gaia3d.domain.menu;

public enum MenuTarget {
	// 사용자
	USER("0"),
	// 서버
	ADMIN("1");
	
	private final String value;
		
	MenuTarget(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return this.value;
	}
	
	public static MenuTarget findBy(String value) {
		for(MenuTarget menuTarget : values()) {
			if(menuTarget.getValue().equals(value)) return menuTarget;
		}
		return null;
	}
}
