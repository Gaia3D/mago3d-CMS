package gaia3d.domain;

import java.util.Arrays;

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
	GML("gml"),
	CITYGML("citygml"),
	INDOORGML("indoorgml"),
	
	JPG("jpg"),
	JPEG("jpeg"),
	GIF("gif"),
	PNG("png"),
	BMP("bmp"),
	DDS("dds"),
	
	ZIP("zip"),
	MTL("mtl");
	
	private final String value;
	
	DataType(final String value) {
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
	public static DataType findBy(final String value) {
		for(final DataType dataType : values()) {
			if(dataType.getValue().equals(value)) return dataType; 
		}
		return null;
	}

	public static DataType findByDataType(String value) {
		return Arrays.stream(DataType.values())
				.filter(e -> e.value.equals(value))
				.findAny()
				.orElse(null);
	}
	
}
