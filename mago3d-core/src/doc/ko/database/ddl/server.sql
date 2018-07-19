drop table if exists server_group cascade;
drop table if exists server_group_server cascade;
drop table if exists server_group_user cascade;
drop table if exists server cascade;

-- 서버 그룹
create table server_group(
	server_group_id				bigint 								not null,
	group_key					varchar(60)			unique			not null ,
	group_name					varchar(100)						not null,
	level						int									default 10,
	ancestor					int								default 0,
	parent						int								default 1,
	depth						int							default 1,
	view_order					int							default 1,
	child_yn					char(1)								default 'N',
	default_yn					char(1)								default 'N',
	use_yn						char(1)								default 'Y',
	description					varchar(256),
	register_date				timestamp with time zone			default now(),
	constraint server_group_pk primary key (server_group_id)	
);

comment on table server_group is '서버 그룹';
comment on column server_group.server_group_id is '고유번호';
comment on column server_group.group_key is '링크 활용 등을 위한 확장 컬럼';
comment on column server_group.level is '추후 삭제';
comment on column server_group.group_name is '그룹명';
comment on column server_group.ancestor is '조상 고유번호';
comment on column server_group.parent is '부모 고유번호';
comment on column server_group.depth is '깊이';
comment on column server_group.view_order is '나열 순서';
comment on column server_group.child_yn is '자식 존재유무, Y : 존재, N : 존재안함(기본)';
comment on column server_group.default_yn is '삭제 불가, Y : 기본, N : 선택';
comment on column server_group.use_yn is '사용유무, Y : 사용, N : 사용안함';
comment on column server_group.description is '설명';
comment on column server_group.register_date is '등록일';

-- 서버 그룹별 Role
create table server_group_role (
	server_group_role_id		bigint 							not null,
	server_group_id				bigint 							not null,
	role_id						bigint	 						not null,
	role_key					varchar(50)						not null,
	register_date				timestamp with time zone			default now(),
	constraint server_group_role_pk primary key (server_group_role_id)
);

comment on table server_group_role is '서버 그룹별 Role';
comment on column server_group_role.server_group_role_id is '고유번호';
comment on column server_group_role.server_group_id is '서버 그룹 고유키';
comment on column server_group_role.role_id is 'Role 고유키';
comment on column server_group_role.role_key is 'Role KEY(속도를 위한 중복)';
comment on column server_group_role.register_date is '등록일';


-- 서버 그룹별 서버 목록
create table server_group_server (
	server_group_server_id		bigint 							not null,
	server_group_id				bigint 							not null,
	server_id					bigint 							not null,
	server_ip 					varchar(45) 					not null,
	register_date				timestamp with time zone			default now(),
	constraint server_group_server_pk primary key (server_group_server_id)
);

comment on table server_group_server is '서버 그룹별 서버 목록';
comment on column server_group_server.server_group_server_id is '고유번호';
comment on column server_group_server.server_group_id is '서버 그룹 고유키';
comment on column server_group_server.server_id is '서버 고유키';
comment on column server_group_server.server_ip is '서버 IP(속도를 위한 중복)';
comment on column server_group_server.register_date is '등록일';

-- 서버 그룹별 사용자 목록
create table server_group_user (
	server_group_user_id		bigint 							not null,
	server_group_id				bigint 							not null,
	user_id						varchar(32)	 						not null,
	register_date				timestamp with time zone			default now(),
	constraint server_group_user_pk primary key (server_group_user_id)
);

comment on table server_group_user is '서버 그룹별 사용자 목록';
comment on column server_group_user.server_group_user_id is '고유번호';
comment on column server_group_user.server_group_id is '서버 그룹 고유키';
comment on column server_group_user.user_id is '사용자 아이디';
comment on column server_group_user.register_date is '등록일';


-- 서버
create table server (
	server_id				bigint					not null,
	server_group_id			bigint,
	server_name				varchar(100)			not null,
	server_ip 				varchar(45) 			not null,
	use_yn 					char(1) 				default 'N',
	api_key 				varchar(256),
	description 			varchar(256),
  	update_date 			timestamp with time zone,
	register_date				timestamp with time zone			default now(),
	constraint server_pk primary key (server_id)	
);



comment on table server is '서버';
comment on column server.server_id is '고유번호';
comment on column server.server_group_id is '고유번호';
comment on column server.server_name is '서버명';
comment on column server.server_ip is '서버 IP';
comment on column server.use_yn is '사용유무, Y : 사용, N : 사용안함(기본)';
comment on column server.api_key is 'API KEY';
comment on column server.description is '설명';
comment on column server.update_date is '수정일';
comment on column server.register_date is '등록일';
