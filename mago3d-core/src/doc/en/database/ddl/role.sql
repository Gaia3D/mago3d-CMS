drop table if exists role cascade;

-- Role role_key unique constraint
create table role(
	role_id				bigint,
	role_name			varchar(100)							not null,
	role_key			varchar(50)								not null,
	role_type			char(1)									not null,
	business_type		varchar(2),
	use_yn				char(1)									default 'Y',
	default_yn			char(1)									default 'N',
	description			varchar(256),
	insert_date				timestamp with time zone			default now(),
	constraint role_pk primary key (role_id)	
);

comment on table role is 'Role';
comment on column role.role_id is 'unique number';
comment on column role.role_name is 'Role name';
comment on column role.role_key is 'Role KEY';
comment on column role.role_type is' Role type. 0: user, 1: server, 2: account ';
comment on column role.business_type is' Business type. 0: user, 1: server, 2: account ';
comment on column role.use_yn is' Use or not. Y: Use, N: Do not use ';
comment on column role.default_yn is' Default enabled or disabled. Y: Use, N: Do not use ';
comment on column role.description is 'Description';
comment on column role.insert_date is 'Registered Date';
