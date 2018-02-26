-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists project cascade;
drop table if exists data_info cascade;

-- 사용자 그룹
create table project(
	project_id				smallint,
	project_key				varchar(60)							not null ,
	project_name			varchar(100)						not null,
	view_order				smallint							default 1,
	default_yn				char(1)								default 'N',
	use_yn					char(1)								default 'Y',
	latitude				numeric(13,10),
	longitude				numeric(13,10),
	height					numeric(7,3),
	duration				smallint,
	description				varchar(256),
	insert_date				timestamp with time zone			default now(),
	constraint project_pk 	primary key (project_id)	
);

comment on table project is 'project(F4D Data) 그룹';
comment on column project.project_id is '고유번호';
comment on column project.project_key is '링크 활용 등을 위한 확장 컬럼';
comment on column project.project_name is '프로젝트';
comment on column project.view_order is '나열 순서';
comment on column project.default_yn is '삭제 불가, Y : 기본, N : 선택';
comment on column project.use_yn is '사용유무, Y : 사용, N : 사용안함';
comment on column project.latitude is '위도';
comment on column project.longitude is '경도';
comment on column project.height is '높이';
comment on column project.duration is 'flyTo 이동시간';
comment on column project.description is '설명';
comment on column project.insert_date is '등록일';


-- Data 기본정보
create table data_info(
	data_id						bigint,
	project_id					smallint							not null,
	data_key					varchar(128)						not null,
	data_name					varchar(64),
	parent						bigint								default 1,
	depth						smallint							default 1,
	view_order					smallint							default 1,
	child_yn					char(1)								default 'N',
	location		 			GEOGRAPHY(POINT, 4326),
	latitude					numeric(13,10),
	longitude					numeric(13,10),
	height						numeric(7,3),
	heading						numeric(8,5),
	pitch						numeric(8,5),
	roll						numeric(8,5),
	attributes					jsonb,
	status						char(1)								default '0',
	public_yn					char(1)								default 'N',
	data_insert_type			varchar(30)							default 'SELF',
	description					varchar(256),
	update_date					timestamp without time zone,
	insert_date					timestamp without time zone			default now(),
	constraint data_info_pk 	primary key(data_id)
);

comment on table data_info is 'Data 정보';
comment on column data_info.data_id is '고유번호';
comment on column data_info.project_id is 'project 고유번호';
comment on column data_info.data_key is 'data 고유 식별번호';
comment on column data_info.data_name is 'data 이름';
comment on column data_info.location is '위도, 경도 정보';
comment on column data_info.latitude is '위도';
comment on column data_info.longitude is '경도';
comment on column data_info.height is '높이';
comment on column data_info.heading is 'heading';
comment on column data_info.pitch is 'pitch';
comment on column data_info.roll is 'roll';
comment on column data_info.attributes is 'Data Control 속성';
comment on column data_info.public_yn is '공개 유무. 기본값 N(비공개)';
comment on column data_info.status is 'Data 상태. 0:사용중, 1:사용중지(관리자), 2:기타';
comment on column data_info.data_insert_type is 'data 등록 방법. 기본 : SELF';
comment on column data_info.description is '설명';
comment on column data_info.update_date is '수정일';
comment on column data_info.insert_date is '등록일';

-- point 는 경도, 위도 순서다.
-- insert into data_info(location) values(st_geometryfromtext('POINT(128.5952254 34.93630567)'))
