package gaia3d.domain;

import lombok.Getter;
import lombok.Setter;

public enum SharingType {

	// 공통
	COMMON("공통"),
	// 공개
	PUBLIC("공개"),
	// 비공개
	PRIVATE("비공개"),
	// 그룹
	GROUP("그룹");
	
	private @Setter @Getter String sharing;
	
	SharingType(String sharing) {
		this.sharing = sharing;
	}
	
}
