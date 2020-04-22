drop table if exists geopolicy cascade;

-- 2D, 3D 운영 정책
create table geopolicy(
	geopolicy_id										integer,

	basic_globe											varchar(20)			default 'cesium',
	cesium_ion_token									varchar(256),
	terrain_type										varchar(30)			default 'cesium-default',
	terrain_value										varchar(256),
	
	data_api_url										varchar(256),
	data_service_path									varchar(256)		default '/f4d/',
	data_change_request_decision						varchar(20)			default 'approval',
	
	geoserver_enable									boolean				default true,
	geoserver_wms_version								varchar(5)         	default '1.1.1',
	geoserver_data_url									varchar(256),
	geoserver_data_workspace							varchar(60),
	geoserver_data_store								varchar(60),
	geoserver_user										varchar(256),
	geoserver_password									varchar(256),
	
	geoserver_imageprovider_enable						boolean				default false,
	geoserver_imageprovider_url							varchar(256),
	geoserver_imageprovider_layer_name					varchar(60),
	geoserver_imageprovider_style_name					varchar(60),
	geoserver_imageprovider_parameters_width			integer				default 256,
	geoserver_imageprovider_parameters_height			integer				default 256,
	geoserver_imageprovider_parameters_format			varchar(30),

	geoserver_terrainprovider_layer_name				varchar(60),
	geoserver_terrainprovider_style_name				varchar(60),
	geoserver_terrainprovider_parameters_width			integer				default 256,
	geoserver_terrainprovider_parameters_height			integer				default 256,
	geoserver_terrainprovider_parameters_format			varchar(30),

	init_camera_enable									boolean				default true,
	init_latitude										varchar(30)			default '37.521168',
	init_longitude										varchar(30)			default '126.924185',
	init_altitude										varchar(30)			default '3000.0',
	init_duration										integer				default 3,
	init_default_terrain								varchar(64),
	init_default_fov									numeric(3,2)		default 0,

	lod0												varchar(20)			default '15',
	lod1												varchar(20)			default '60',
	lod2												varchar(20)			default '90',
	lod3												varchar(20)			default '200',
	lod4												varchar(20)			default '1000',
	lod5												varchar(20)			default '50000',

	ssao_radius											numeric(8,2)		default 0.15,
	cull_face_enable									boolean				default false,
	time_line_enable									boolean				default false,
	
	max_partitions_lod0 								integer				default 4,
	max_partitions_lod1 								integer				default 2,
	max_partitions_lod2_or_less 						integer				default 1,
	max_ratio_points_dist_0m 							integer				default 10,
	max_ratio_points_dist_100m 							integer				default 120,
	max_ratio_points_dist_200m 							integer				default 240,
	max_ratio_points_dist_400m 							integer				default 480,
	max_ratio_points_dist_800m 							integer				default 960,
	max_ratio_points_dist_1600m 						integer				default 1920,
	max_ratio_points_dist_over_1600m 					integer				default 3840,
	max_point_size_for_pc								numeric(4,1)		default 40.0,
	min_point_size_for_pc								numeric(4,1)		default 3.0,
	pendent_point_size_for_pc							numeric(4,1)		default 60.0,
	memory_management									boolean				default false,
	
	layer_source_coordinate								varchar(50)			default 'EPSG:4326',
	layer_target_coordinate								varchar(50)			default 'EPSG:4326',
	
	insert_date											timestamp with time zone	default now(),

	constraint geopolicy_pk primary key (geopolicy_id)	
);

comment on table geopolicy is '2D, 3D 운영정책';
comment on column geopolicy.geopolicy_id is '고유번호';

comment on column geopolicy.basic_globe is 'javascript library 3D globe. 기본 cesium';
comment on column geopolicy.cesium_ion_token is 'Cesium ion token 발급. 기본 mago3D';
comment on column geopolicy.terrain_type is	'Terrain 유형. geoserver, cesium-default, cesium-ion-default, cesium-ion-cdn : 우리 dem 을 업로딩, cesium-customer : cesium docker provier';
comment on column geopolicy.terrain_value is 'url 또는 cesium ion code 값';

comment on column geopolicy.data_api_url is 'F4D converter file 정보 취득 api url';
comment on column geopolicy.data_service_path is '데이터 서비스 Root Path';
comment on column geopolicy.data_change_request_decision is '데이터 정보 변경 요청에 대한 처리. auto : 자동승인, approval : 결재(초기값)';

comment on column geopolicy.geoserver_enable is 'geoserver 사용유무. true : 사용, false : 미사용';
comment on column geopolicy.geoserver_wms_version is 'geoserver wms 버전';
comment on column geopolicy.geoserver_data_url is 'geoserver 데이터 URL';
comment on column geopolicy.geoserver_data_workspace is 'geoserver 데이터 작업공간';
comment on column geopolicy.geoserver_data_store is 'geoserver 데이터 저장소';
comment on column geopolicy.geoserver_user is 'geoserver 사용자 계정';
comment on column geopolicy.geoserver_password is 'geoserver 비밀번호';

comment on column geopolicy.geoserver_imageprovider_enable is 'geoserver imageprovider 사용 유무. 기본 false';
comment on column geopolicy.geoserver_imageprovider_url is 'geoserver imageprovider 요청 URL';
comment on column geopolicy.geoserver_imageprovider_layer_name is 'geoserver imageprovider 로 사용할 레이어명';
comment on column geopolicy.geoserver_imageprovider_style_name is 'geoserver imageprovider 에 사용할 스타일명';
comment on column geopolicy.geoserver_imageprovider_parameters_width is 'geoserver 레이어 이미지 가로크기';
comment on column geopolicy.geoserver_imageprovider_parameters_height is 'geoserver 레이어 이미지 세로크기';
comment on column geopolicy.geoserver_imageprovider_parameters_format is 'geoserver 레이어 포맷형식';

comment on column geopolicy.geoserver_terrainprovider_layer_name is 'geoserver terrainprovider 로 사용할 레이어명';
comment on column geopolicy.geoserver_terrainprovider_style_name  is 'geoserver terrainprovider 에 사용할 스타일명';
comment on column geopolicy.geoserver_terrainprovider_parameters_width is 'geoserver 레이어 이미지 가로크기';
comment on column geopolicy.geoserver_terrainprovider_parameters_height is 'geoserver 레이어 이미지 세로크기';
comment on column geopolicy.geoserver_terrainprovider_parameters_format is 'geoserver 레이어 포맷형식';

comment on column geopolicy.init_camera_enable is '초기 카메라 이동 유무. true : 기본, false : 없음';
comment on column geopolicy.init_latitude is '초기 카메라 이동 위도';
comment on column geopolicy.init_longitude is '초기 카메라 이동 경도';
comment on column geopolicy.init_altitude is '초기 카메라 이동 높이';
comment on column geopolicy.init_duration is '초기 카메라 이동 시간. 초 단위';
comment on column geopolicy.init_default_terrain is '기본 Terrain';
comment on column geopolicy.init_default_fov is 'field of view. 기본값 0(1.8 적용)';

comment on column geopolicy.lod0 is 'LOD0. 기본값 15M';
comment on column geopolicy.lod1 is 'LOD1. 기본값 60M';
comment on column geopolicy.lod2 is 'LOD2. 기본값 90M';
comment on column geopolicy.lod3 is 'LOD3. 기본값 200M';
comment on column geopolicy.lod4 is 'LOD4. 기본값 1000M';
comment on column geopolicy.lod5 is 'LOD5. 기본값 50000M';

comment on column geopolicy.ssao_radius is '그림자 반경';
comment on column geopolicy.cull_face_enable is 'cullFace 사용유무. 기본 false';
comment on column geopolicy.time_line_enable is 'timeLine 사용유무. 기본 false';

comment on column geopolicy.max_partitions_lod0 is 'LOD0일시 PointCloud 데이터 파티션 개수. 기본값 4';
comment on column geopolicy.max_partitions_lod1 is 'LOD1일시 PointCloud 데이터 파티션 개수. 기본값 2';
comment on column geopolicy.max_partitions_lod2_or_less is 'LOD2 이상 일시 PointCloud 데이터 파티션 개수. 기본값 1';
comment on column geopolicy.max_ratio_points_dist_0m is '카메라와의 거리가 10미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 10';
comment on column geopolicy.max_ratio_points_dist_100m is '카메라와의 거리가 100미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 120';
comment on column geopolicy.max_ratio_points_dist_200m is '카메라와의 거리가 200미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 240';
comment on column geopolicy.max_ratio_points_dist_400m is '카메라와의 거리가 400미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 480';
comment on column geopolicy.max_ratio_points_dist_800m is '카메라와의 거리가 800미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 960';
comment on column geopolicy.max_ratio_points_dist_1600m is '카메라와의 거리가 1600미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 1920';
comment on column geopolicy.max_ratio_points_dist_over_1600m is '카메라와의 거리가 1600미터 이상일때, PointCloud 점의 갯수의 비율의 분모, 기본값 3840';
comment on column geopolicy.max_point_size_for_pc is 'PointCloud 점의 최대 크기. 기본값 40.0';
comment on column geopolicy.min_point_size_for_pc is 'PointCloud 점의 최소 크기. 기본값 3.0';
comment on column geopolicy.pendent_point_size_for_pc is 'PointCloud 점의 크기 보정치. 높아질수록 점이 커짐. 기본값 60.0';
comment on column geopolicy.memory_management is 'GPU Memory Pool 사용유무. 기본값 false';

comment on column geopolicy.layer_source_coordinate is 'Layer 원본 좌표계';
comment on column geopolicy.layer_target_coordinate is 'Layer 좌표계 정의';

comment on column geopolicy.insert_date is '등록일';
