-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists object_group cascade;
drop table if exists object_info cascade;

-- 사용자 그룹
create table object_group(
	object_group_id				smallint							not null,
	object_group_key			varchar(60)							not null ,
	object_group_name			varchar(100)						not null,
	ancestor					smallint							default 0,
	parent						smallint							default 1,
	depth						smallint							default 1,
	view_order					smallint							default 1,
	child_yn					char(1)								default 'N',
	default_yn					char(1)								default 'N',
	use_yn						char(1)								default 'Y',
	description					varchar(256),
	insert_date					timestamp with time zone			default now(),
	constraint object_group_pk 	primary key (object_group_id)	
);

comment on table object_group is 'Object(F4D Data) 그룹';
comment on column object_group.object_group_id is '고유번호';
comment on column object_group.object_group_key is '링크 활용 등을 위한 확장 컬럼';
comment on column object_group.object_group_name is '그룹명';
comment on column object_group.ancestor is '조상 고유번호';
comment on column object_group.parent is '부모 고유번호';
comment on column object_group.depth is '깊이';
comment on column object_group.view_order is '나열 순서';
comment on column object_group.child_yn is '자식 존재유무, Y : 존재, N : 존재안함(기본)';
comment on column object_group.default_yn is '삭제 불가, Y : 기본, N : 선택';
comment on column object_group.use_yn is '사용유무, Y : 사용, N : 사용안함';
comment on column object_group.description is '설명';
comment on column object_group.insert_date is '등록일';


-- Object 기본정보
create table object_info(
	object_id					varchar(32)	 						not null,
	object_group_id				smallint							not null,
	object_key					varchar(128)						not null,
	object_name					varchar(64)							not null,
	location		 			GEOGRAPHY(POINT, 4326),
	height						varchar(30),
	heading						varchar(10),
	pitch						varchar(10),
	roll						varchar(10),
	status						char(1)								default '0',
	update_date					timestamp without time zone,
	insert_date					timestamp without time zone			default now(),
	constraint object_info_pk 	primary key(object_id)
);

comment on table object_info is 'Object 정보';
comment on column object_info.object_id is '고유번호';
comment on column object_info.object_group_id is 'Object Group 고유번호';
comment on column object_info.object_key is 'object 고유 식별번호';
comment on column object_info.object_name is 'object 이름';
comment on column object_info.location is '위도, 경도 정보';
comment on column object_info.height is '높이';
comment on column object_info.heading is 'heading';
comment on column object_info.pitch is 'pitch';
comment on column object_info.roll is 'roll';
comment on column object_info.status is '사용자 상태. 0:사용중, 1:사용중지(관리자), 2:기타';
comment on column object_info.update_date is '수정일';
comment on column object_info.insert_date is '등록일';

-- point 는 경도, 위도 순서다.
-- insert into object_info(location) values(st_geometryfromtext('POINT(128.5952254 34.93630567)'))
