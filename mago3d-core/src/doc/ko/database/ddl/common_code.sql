drop table if exists common_code cascade;

-- 공통 코드
create table common_code (
	code_key					varchar(50),	
	code_type					varchar(50)							not null,
	code_name					varchar(60)							not null,
	code_name_en				varchar(60),
	code_value					varchar(256)						not null,
	use_yn						char(1)								default 'Y',
	view_order					smallint							default 1,
	css_class					varchar(30),
	image						varchar(256),
	description					varchar(256),
	insert_date					timestamp without time zone			default now(),
	constraint common_code_pk primary key (code_key)	
);

comment on table common_code is '공통 코드';
comment on column common_code.code_key is '고유키';
comment on column common_code.code_type is '코드 분류';
comment on column common_code.code_name is '코드명';
comment on column common_code.code_name_en is '영어 코드명';
comment on column common_code.code_value is '코드값';
comment on column common_code.use_yn is '사용유무, Y : 사용(기본), N : 사용안함';
comment on column common_code.view_order is '표시순서. 기본값 1';
comment on column common_code.css_class is 'css class';
comment on column common_code.image is '이미지 경로';
comment on column common_code.description is '설명';
comment on column common_code.insert_date is '등록일';
