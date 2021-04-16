package gaia3d.domain.menu;

public enum MenuType {
	// 사용자
	URL("0"),
	// 서버
	HTMLID("1");
	
	private final String value;
		
	MenuType(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return this.value;
	}
}
