package gaia3d.domain.role;

public enum RoleKey {
	// 관리자 페이지 sign in
	ADMIN_SIGNIN,
	// 관리자 페이지 사용자 관리
	ADMIN_USER_MANAGE,
	// 관리자 페이지 레이어 관리
	ADMIN_LAYER_MANAGE,
	
	// 사용자 페이지 sign int
	USER_SIGNIN,
	// 사용자 페이지 DATA 등록 권한
	USER_DATA_CREATE,
	// 사용자 페이지 DATA 조회 권한
	USER_DATA_READ,
	// 사용자 페이지 시민참여 관리 권한
	USER_CIVIL_VOICE_MANAGE;
}
