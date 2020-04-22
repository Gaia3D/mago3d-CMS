drop table if exists role cascade;


-- Role role_key unique 제약 조건 걸어야 함
create table role(
	role_id						integer,
	role_name					varchar(100)							not null,
	role_key					varchar(50)								not null,
	role_target					char(1)									not null,
	role_type					varchar(2)								not null,
	use_yn						char(1)									default 'Y',
	default_yn					char(1)									default 'N',
	description					varchar(256),
	insert_date					timestamp with time zone default now(),
	constraint role_pk primary key (role_id)	
);

comment on table role is 'Role';
comment on column role.role_id is '고유번호';
comment on column role.role_name is 'Role 명';
comment on column role.role_key is 'Role KEY';
comment on column role.role_target is 'Role 타켓. 0 : 사용자 사이트, 1 : 관리자 사이트, 2 : 서버';
comment on column role.role_type is 'Role 업무 유형. 0 : 사용자, 1 : 서버, 2 : api';
comment on column role.use_yn is '사용유무. Y : 사용, N : 사용안함';
comment on column role.default_yn is '기본사용 유무. Y : 사용, N : 사용안함';
comment on column role.description is '설명';
comment on column role.insert_date is '등록일';
