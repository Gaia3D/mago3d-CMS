package com.gaia3d.domain;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 사용자 정책
 * @author Cheon JeongDae
 *
 */
@Getter
@Setter
@ToString
public class UserPolicy {

//	private String user_policy_id;
	// 사용자 아이디
	private String user_id;

	// view library. 기본 cesium
	private String geo_view_library;
	// data 폴더. 기본 /data
	private String geo_data_path;
	// 초기 로딩 프로젝트
	@Getter(AccessLevel.NONE)
	@Setter(AccessLevel.NONE)
	private String geo_data_default_projects;
	private String geo_data_default_projects_view;
	// cullFace 사용유무. 기본 false
	private String geo_cull_face_enable;
	// timeLine 사용유무. 기본 false
	private String geo_time_line_enable;
	
	// 초기 카메라 이동 유무. 기본 true
	private String geo_init_camera_enable;
	// 초기 카메라 이동 위도
	private String geo_init_latitude;
	// 초기 카메라 이동 경도
	private String geo_init_longitude;
	// 초기 카메라 이동 높이
	private String geo_init_height;
	// 초기 카메라 이동 시간. 초 단위
	private Long geo_init_duration;
	// 기본 Terrain
	private String geo_init_default_terrain;
	// field of view. 기본값 0(1.8 적용)
	private Long geo_init_default_fov;
	
	// LOD0. 기본값 15M
	private String geo_lod0;
	// LOD1. 기본값 60M
	private String geo_lod1;
	// LOD2. 기본값 900M
	private String geo_lod2;
	// LOD3. 기본값 200M
	private String geo_lod3;
	// LOD3. 기본값 1000M
	private String geo_lod4;
	// LOD3. 기본값 50000M
	private String geo_lod5;
	
	// 다이렉트 빛이 아닌 반사율 범위. 기본값 0.5
	private String geo_ambient_reflection_coef;
	// 자기 색깔의 반사율 범위. 기본값 1.0
	private String geo_diffuse_reflection_coef;
	// 표면의 반질거림 범위. 기본값 1.0
	private String geo_specular_reflection_coef;
	// 다이렉트 빛이 아닌 반사율 RGB, 콤마로 연결
	private String geo_ambient_color;
	private String geo_ambient_colorR;
	private String geo_ambient_colorG;
	private String geo_ambient_colorB;
	// 표면의 반질거림 색깔. RGB, 콤마로 연결
	private String geo_specular_color;
	private String geo_specular_colorR;
	private String geo_specular_colorG;
	private String geo_specular_colorB;
	// 그림자 반경
	private String geo_ssao_radius;

	// 수정일
	private String update_date;
	// 등록일
	private String insert_date;
	
	public String getGeo_data_default_projects() {
		return geo_data_default_projects;
	}

	public void setGeo_data_default_projects(String geo_data_default_projects) {
		this.geo_data_default_projects = geo_data_default_projects;
		if(this.geo_data_default_projects != null && !("").equals(this.geo_data_default_projects)) {
			this.geo_data_default_projects = this.geo_data_default_projects.replace("{", "");
			this.geo_data_default_projects = this.geo_data_default_projects.replace("}", "");
			this.geo_data_default_projects = this.geo_data_default_projects.replaceAll("\"", "");
		}
	}
}
