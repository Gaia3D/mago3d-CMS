package mago3d.domain;

import lombok.Getter;
import lombok.Setter;

public enum MethodType {

	INSERT("등록"),
	UPDATE("수정");
	
	private @Setter @Getter String method;
	
	private MethodType(String method) {
		this.method = method;
	}
	
}