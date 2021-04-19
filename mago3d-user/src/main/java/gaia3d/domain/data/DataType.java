package gaia3d.domain.data;

/**
 * 3DS 를 enum 으로 바로 사용할 수가 없음
 * @author Jeongdae
 *
 */
public enum DataType {
	AUTODESK_3DS("3ds"),
	OBJ("obj"),
	DAE("dae"),
	COLLADA("collada"),
	IFC("ifc"),
	LAS("las"),
//	GML("gml"),
	CITYGML("citygml"),
	INDOORGML("indoorgml");

	private final String value;

	DataType(String value) {
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
	public static DataType findBy(String value) {
		for(DataType dataType : values()) {
			if(dataType.getValue().equals(value)) return dataType; 
		}
		return null;
	}
}
