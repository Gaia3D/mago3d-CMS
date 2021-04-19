-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists data_group cascade;
drop table if exists data_info cascade;

-- data의 논리적인 그룹
create table data_group (
	data_group_id				integer,
	data_group_key				varchar(60)							not null,
	data_group_name				varchar(100)						not null,
	data_group_path				varchar(256),
	data_group_target			varchar(5)							default 'user',
	sharing						varchar(30)							default 'public',
	user_id						varchar(32),
	ancestor					integer								default 0,
	parent						integer								default 1,
	depth						integer								default 1,
	view_order					integer								default 1,
	children					integer								default 0,
	basic						boolean								default false,
	available					boolean								default true,
	tiling						boolean								default false,
	data_count					integer								default 0,
	location		 			GEOMETRY(POINT, 4326),
	altitude					numeric(13,7),
	duration					integer,
	location_update_type		varchar(20)							default 'auto',
	metainfo					jsonb,
	description					varchar(256),
	update_date					timestamp with time zone,
	insert_date					timestamp with time zone			default now(),
	constraint data_group_pk 	primary key (data_group_id)
);

comment on table data_group is '데이터 그룹';
comment on column data_group.data_group_id is '고유번호';
comment on column data_group.data_group_key is '링크 활용 등을 위한 확장 컬럼';
comment on column data_group.data_group_name is '그룹명';
comment on column data_group.data_group_path is '서비스 경로';
comment on column data_group.data_group_target is 'admin : 관리자용 데이터 그룹, user : 일반 사용자용 데이터 그룹';
comment on column data_group.sharing is 'common : 공통, public : 공개, private : 비공개, group : 그룹';
comment on column data_group.user_id is '사용자 아이디';
comment on column data_group.data_count is '데이터 총 건수';
comment on column data_group.view_order is '나열 순서';
comment on column data_group.children is '자식 존재 개수';
comment on column data_group.basic is 'true : 기본, false : 선택';
comment on column data_group.available is 'true : 사용, false : 사용안함';
comment on column data_group.tiling is 'true : 사용, false : 사용안함(기본)';
comment on column data_group.location is 'POINT(위도, 경도). 공간 검색 속도 때문에 altitude는 분리';
comment on column data_group.altitude is '높이';
comment on column data_group.duration is 'Map 이동시간';
comment on column data_group.location_update_type is 'location 업데이트 방법. auto : data 입력시 자동, user : 사용자가 직접 입력';
comment on column data_group.metainfo is '데이터 그룹 메타 정보. 그룹 control을 위해 인위적으로 만든 속성';
comment on column data_group.description is '설명';
comment on column data_group.update_date is '수정일';
comment on column data_group.insert_date is '등록일';


-- Data 기본정보
create table data_info(
	data_id						bigint,
	data_group_id				integer								not null,
	converter_job_id			bigint,
	data_key					varchar(128)						not null,
	data_name					varchar(256),
	data_type					varchar(30),
	sharing						varchar(30)							default 'public',
	user_id						varchar(32),
	update_user_id				varchar(32),
	mapping_type				varchar(30)							default 'origin',
	location		 			GEOMETRY(POINT, 4326),
	altitude					numeric(13,7),
	heading						numeric(8,5),
	pitch						numeric(8,5),
	roll						numeric(8,5),
	children_ancestor			integer								default 0,
	children_parent				integer								default 1,
	children_depth				integer								default 1,
	children_view_order			integer								default 1,
	metainfo					jsonb,
	status						varchar(20)							default 'use',
	attribute_exist				boolean								default false,
	object_attribute_exist		boolean								default false,
	description					varchar(256),
	update_date					timestamp with time zone,
	insert_date					timestamp with time zone			default now(),
	constraint data_info_pk 	primary key(data_id)
);

comment on table data_info is 'Data 정보';
comment on column data_info.data_id is '고유번호';
comment on column data_info.data_group_id is 'data_group 고유번호';
comment on column data_info.converter_job_id is 'converter job 고유번호';
comment on column data_info.data_key is 'data 고유 식별번호';
comment on column data_info.data_name is 'data 이름';
comment on column data_info.data_type is '데이터 타입(중복). 3ds,obj,dae,collada,ifc,las,citygml,indoorgml,etc';
comment on column data_info.sharing is 'common : 공통, public : 공개, private : 비공개, group : 그룹';
comment on column data_info.user_id is '사용자 아이디';
comment on column data_info.update_user_id is '수정 수정자 아이디';
comment on column data_info.mapping_type is '기본값 origin : latitude, longitude, height를 origin에 맞춤. boundingboxcenter : latitude, longitude, height를 boundingboxcenter 맞춤';
comment on column data_info.location is 'POINT(위도, 경도). 공간 검색 속도 때문에 altitude는 분리';
comment on column data_info.altitude is '높이';
comment on column data_info.heading is 'heading';
comment on column data_info.pitch is 'pitch';
comment on column data_info.roll is 'roll';
comment on column data_info.children_ancestor is '조상';
comment on column data_info.children_parent is '부모';
comment on column data_info.children_depth is '깊이';
comment on column data_info.children_view_order is '표시 순서';
comment on column data_info.metainfo is '데이터 메타 정보. 데이터  control을 위해 인위적으로 만든 속성';
comment on column data_info.status is '상태. processing : 변환중, use : 사용중, unused : 사용중지(관리자), delete : 삭제(비표시)';
comment on column data_info.attribute_exist is '속성 존재 유무. true : 존재, false : 존재하지 않음(기본값)';
comment on column data_info.object_attribute_exist is 'Object 속성 존재 유무. true : 존재, false : 존재하지 않음(기본값)';
comment on column data_info.description is '설명';
comment on column data_info.update_date is '수정일';
comment on column data_info.insert_date is '등록일';

-- point 는 경도, 위도 순서다.
-- insert into data_info(location) values(st_geometryfromtext('POINT(128.5952254 34.93630567)'))