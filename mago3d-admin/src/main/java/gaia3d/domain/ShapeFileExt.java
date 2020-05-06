package gaia3d.domain;

/**
 * shape 파일 확장자
 * @author PSH
 *
 */
public enum ShapeFileExt {
	SHP("shp"),
	DBF("dbf"),
	SHX("shx"),
	PRJ("prj");
	
	private final String value;
		
	ShapeFileExt(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return this.value;
	}
	
	public static ShapeFileExt findBy(String value) {
		for(ShapeFileExt shapeFileExt : values()) {
			if(shapeFileExt.getValue().equals(value)) return shapeFileExt;
		}
		return null;
	}
}
