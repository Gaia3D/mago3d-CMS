drop table if exists layer cascade;
drop table if exists layer_group cascade;
drop table if exists layer_file_info cascade;

create table layer_group (
	layer_group_id				integer,
	layer_group_name      		varchar(256)					not null,
	user_id						varchar(32),
	ancestor					integer							default 0,	
	parent                		integer							default 0,	
	depth                	  	integer							default 1,	
	view_order					integer							default 1,	
	children					integer							default 0,
	available					boolean							default true,
	description					varchar(256),	
	update_date             	timestamp with time zone,	
	insert_date					timestamp with time zone		default now(),
	constraint layer_group_pk 		primary key (layer_group_id)
);

comment on table layer_group is '레이어 그룹';
comment on column layer_group.layer_group_id is '레이어 그룹 고유번호';
comment on column layer_group.layer_group_name is '레이어 그룹명';
comment on column layer_group.user_id is '사용자 아이디';
comment on column layer_group.ancestor is '조상';
comment on column layer_group.parent is '부모';
comment on column layer_group.depth is '깊이';
comment on column layer_group.view_order is '나열 순서';
comment on column layer_group.children is '자식 존재 개수';
comment on column layer_group.available is '사용 여부';
comment on column layer_group.description is '설명';
comment on column layer_group.update_date is '수정일';
comment on column layer_group.insert_date is '등록일';

-- layer 관리
create table layer (
	layer_id					integer,
	layer_group_id				integer,
	layer_key					varchar(100)					not null,
	layer_name					varchar(256)					not null,
	user_id						varchar(32),
	
	sharing						varchar(30)						default 'public',
	ogc_web_services			varchar(30),
	layer_type					varchar(30),
	layer_insert_type			varchar(30),
	geometry_type				varchar(30),
	
	layer_fill_color			varchar(30),	
	layer_line_color			varchar(30),	
	layer_line_style			numeric,	
	layer_alpha_style			numeric,
	
	view_order					integer							default 1,
	z_index						integer,
	default_display				boolean							default false,
	available					boolean							default true,
	label_display				boolean							default false,
	cache_available				boolean							default false,
	
	coordinate					varchar(256),
	description					varchar(256),
	update_date					timestamp with time zone		default now(),
	insert_date					timestamp with time zone 		default now(),
	constraint layer_pk 		primary key (layer_id)
);

comment on table layer is '레이어';
comment on column layer.layer_id is '레이어 고유번호';
comment on column layer.layer_group_id is '레이어 그룹 고유번호';
comment on column layer.layer_key is '레이어 고유키(API용)';
comment on column layer.layer_name is '레이어명';
comment on column layer.user_id is '사용자명';
comment on column layer.sharing is '공유 유형. common : 공통, public : 공개, private : 개인, group : 그룹';
comment on column layer.ogc_web_services is 'OGC Web Services (wms, wfs, wcs, wps)';
comment on column layer.layer_type is '레이어 타입 (Raster, Vector)';
comment on column layer.layer_insert_type is '레이어 등록 타입(파일, geoserver)';
comment on column layer.geometry_type is '도형 타입';
comment on column layer.layer_fill_color is '외곽선 색상';
comment on column layer.layer_line_color is '외곽선 두께';
comment on column layer.layer_line_style is '채우기 색상';
comment on column layer.layer_alpha_style is '투명도';
comment on column layer.view_order is '나열 순서';
comment on column layer.z_index is '지도위에 노출 순위(css z-index와 동일)';
comment on column layer.default_display is '기본 표시';
comment on column layer.available is '사용유무.';
comment on column layer.label_display is '레이블 표시';
comment on column layer.cache_available is '캐시 사용 유무';
comment on column layer.coordinate is '좌표계 정보';
comment on column layer.description is '설명';
comment on column layer.update_date is '수정일';
comment on column layer.insert_date is '등록일';


-- layer shape 파일 관리
create table layer_file_info (
	layer_file_info_id			integer,			  					
	layer_id					integer							not null,
	layer_file_info_group_id	integer,
	user_id						varchar(32)						not null,
	enable_yn					char(1)							default 'N',
	file_name					varchar(100)					not null,
	file_real_name				varchar(100)					not null,
	file_path					varchar(256)					not null,
	file_size					varchar(12)						not null,
	file_ext					varchar(10)						not null,
	shape_encoding				varchar(100),
	version_id					integer							default 0,
	update_date					timestamp with time zone,
	insert_date					timestamp with time zone		default now(),
	constraint layer_file_info_pk primary key (layer_file_info_id)
);

comment on table layer_file_info is 'layer shape 파일 관리';
comment on column layer_file_info.layer_file_info_id is '파일 고유번호';
comment on column layer_file_info.layer_id is '파일 고유번호';
comment on column layer_file_info.layer_file_info_group_id is 'shape 파일 그룹 아이디. .shp 파일의 layer_file_info_id 를 group_id로 함';
comment on column layer_file_info.user_id is '사용자 id';
comment on column layer_file_info.enable_yn is 'layer 활성화 유무. Y: 활성화, N: 비활성화';
comment on column layer_file_info.file_name is '파일 이름';
comment on column layer_file_info.file_real_name is '파일 실제 이름';
comment on column layer_file_info.file_path is '파일 경로';
comment on column layer_file_info.file_size is '파일 용량';
comment on column layer_file_info.file_ext is '파일 확장자';
comment on column layer_file_info.shape_encoding is 'Shape 파일 인코딩';
comment on column layer_file_info.version_id is 'shape 파일 버전 정보';
comment on column layer_file_info.update_date is '갱신일';
comment on column layer_file_info.insert_date is '등록일';

