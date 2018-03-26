drop table if exists common_code cascade;

-- Common code
create table common_code (
	code_key					varchar(50),	
	code_type					varchar(50)							not null,
	code_name					varchar(60)							not null,
	code_name_en				varchar(60),
	code_value					varchar(256)						not null,
	use_yn						char(1)								default 'Y',
	view_order					int							default 1,
	css_class					varchar(30),
	image						varchar(256),
	description					varchar(256),
	insert_date					timestamp without time zone			default now(),
	constraint common_code_pk primary key (code_key)	
);

comment on table common_code is 'common code';
comment on column common_code.code_key is 'unique key';
comment on column common_code.code_type is 'code classification';
comment on column common_code.code_name is 'code name';
comment on column common_code.code_name_en is 'English code name';
comment on column common_code.code_value is 'code value';
comment on column common_code.use_yn is 'Use. Y: Use (default), N: Do not use';
comment on column common_code.view_order is 'Display order. Default 1';
comment on column common_code.css_class is 'css class';
comment on column common_code.image is 'Image path';
comment on column common_code.description is 'Description';
comment on column common_code.insert_date is 'Registered Date';
