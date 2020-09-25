package gaia3d.domain.converter;

import lombok.Getter;

public enum ConverterTemplate {

	BASIC("basic", "0", "4"),
	BUILDING("building", "0", "3"),
	EXTRA_BIG_BUILDING("extra-big-building", "0", "5"),
	POINT_CLOUD("point-cloud", "3", null);

	private final @Getter String name;
	private final @Getter String meshType;
	private final @Getter String skinLevel;

	ConverterTemplate(String name, String meshType, String skinLevel) {
		this.name = name;
		this.meshType = meshType;
		this.skinLevel = skinLevel;
	}

	public static ConverterTemplate findBy(String name) {
		for(ConverterTemplate converterTemplate : values()) {
			if(converterTemplate.getName().equalsIgnoreCase(name)) return converterTemplate;
		}
		return null;
	}
}
