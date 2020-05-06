package gaia3d.domain;

public enum ShapeFileField {
	VERSION_ID("version_id"),
	ENABLE_YN("enable_yn");
	
	private final String value;
		
	ShapeFileField(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return this.value;
	}
	
	public static ShapeFileField findBy(String value) {
		for(ShapeFileField shapeFileField : values()) {
			if(shapeFileField.getValue().equals(value)) return shapeFileField;
		}
		return null;
	}
}
