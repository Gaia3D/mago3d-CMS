drop table if exists role cascade;


-- Role role_key unique制約歩かなければならない
create table role(
	role_id				bigint,
	role_name			varchar(100)							not null,
	role_key			varchar(50)								not null,
	role_type			char(1)									not null,
	business_type		varchar(2),
	use_yn				char(1)									default 'Y',
	default_yn			char(1)									default 'N',
	description			varchar(256),
	insert_date				timestamp without time zone			default now(),
	constraint role_pk primary key (role_id)	
);

comment on table role is 'Role';
comment on column role.role_id is '固有番号';
comment on column role.role_name is 'Role人';
comment on column role.role_key is 'Role KEY';
comment on column role.role_type is 'Roleタイプ。0：ユーザー、1：サーバ、2：アカウント';
comment on column role.business_type is '業務の種類。0：ユーザー、1：サーバ、2：アカウント';
comment on column role.use_yn is 'を使用の有無。Y：使用すると、N：を無効にする';
comment on column role.default_yn is 'の基本使用の有無。Y：使用すると、N：を無効にする';
comment on column role.description is 'の説明';
comment on column role.insert_date is '登録日';