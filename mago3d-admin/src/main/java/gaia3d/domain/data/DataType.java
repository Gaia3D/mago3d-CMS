package gaia3d.domain.data;

import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

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

	/**
	 * 위젯 처리를 위해 0 값으로 세팅
	 * @return
	 */
	public static Map<String, Long> getStatisticsMap() {
		return Stream.of(values()).collect(Collectors.toMap(DataType::getValue, t -> 0L));
	}
}
