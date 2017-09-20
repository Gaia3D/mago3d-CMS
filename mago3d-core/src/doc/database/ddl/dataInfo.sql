-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists data_group cascade;
drop table if exists data_info cascade;

-- 사용자 그룹
create table data_group(
	data_group_id				smallint							not null,
	data_group_key			varchar(60)							not null ,
	data_group_name			varchar(100)						not null,
	ancestor					smallint							default 0,
	parent						smallint							default 1,
	depth						smallint							default 1,
	view_order					smallint							default 1,
	child_yn					char(1)								default 'N',
	default_yn					char(1)								default 'N',
	use_yn						char(1)								default 'Y',
	latitude					varchar(30),
	longitude					varchar(30),
	height						varchar(30),
	duration					smallint,
	description					varchar(256),
	insert_date					timestamp with time zone			default now(),
	constraint data_group_pk 	primary key (data_group_id)	
);

comment on table data_group is 'Data(F4D Data) 그룹';
comment on column data_group.data_group_id is '고유번호';
comment on column data_group.data_group_key is '링크 활용 등을 위한 확장 컬럼';
comment on column data_group.data_group_name is '그룹명';
comment on column data_group.ancestor is '조상 고유번호';
comment on column data_group.parent is '부모 고유번호';
comment on column data_group.depth is '깊이';
comment on column data_group.view_order is '나열 순서';
comment on column data_group.child_yn is '자식 존재유무, Y : 존재, N : 존재안함(기본)';
comment on column data_group.default_yn is '삭제 불가, Y : 기본, N : 선택';
comment on column data_group.use_yn is '사용유무, Y : 사용, N : 사용안함';
comment on column data_group.latitude is '위도';
comment on column data_group.longitude is '경도';
comment on column data_group.height is '높이';
comment on column data_group.duration is 'flyTo 이동시간';
comment on column data_group.description is '설명';
comment on column data_group.insert_date is '등록일';


-- Data 기본정보
create table data_info(
	data_id						bigint			not null,
	data_group_id				smallint							not null,
	data_key					varchar(128)						not null,
	data_name					varchar(64),
	location		 			GEOGRAPHY(POINT, 4326),
	latitude					varchar(30)							not null,
	longitude					varchar(30)							not null,
	height						varchar(30),
	heading						varchar(10),
	pitch						varchar(10),
	roll						varchar(10),
	status						char(1)								default '0',
	public_yn					char(1)								default 'N',
	data_insert_type			varchar(30)							default 'DATA_REGISTER_SELF',
	update_date					timestamp without time zone,
	insert_date					timestamp without time zone			default now(),
	constraint data_info_pk 	primary key(data_id)
);

comment on table data_info is 'Data 정보';
comment on column data_info.data_id is '고유번호';
comment on column data_info.data_group_id is 'Data Group 고유번호';
comment on column data_info.data_key is 'data 고유 식별번호';
comment on column data_info.data_name is 'data 이름';
comment on column data_info.location is '위도, 경도 정보';
comment on column data_info.latitude is '위도';
comment on column data_info.longitude is '경도';
comment on column data_info.height is '높이';
comment on column data_info.heading is 'heading';
comment on column data_info.pitch is 'pitch';
comment on column data_info.roll is 'roll';
comment on column data_info.public_yn is '공개 유무. 기본값 N(비공개)';
comment on column data_info.status is 'Data 상태. 0:사용중, 1:사용중지(관리자), 2:기타';
comment on column data_info.data_insert_type is 'data 등록 방법. 기본 : SELF';
comment on column data_info.update_date is '수정일';
comment on column data_info.insert_date is '등록일';

-- point 는 경도, 위도 순서다.
-- insert into data_info(location) values(st_geometryfromtext('POINT(128.5952254 34.93630567)'))
