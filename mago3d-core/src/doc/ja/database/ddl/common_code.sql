drop table if exists common_code cascade;

-- 共通コード
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

comment on table common_code is '共通コード';
comment on column common_code.code_key is '固有のキー';
comment on column common_code.code_type is 'コード分類';
comment on column common_code.code_name is 'コード名';
comment on column common_code.code_name_en is '英語コード名';
comment on column common_code.code_value is 'コード値';
comment on column common_code.use_yn is 'を使用の有無、Y：使用（基本）、N：を無効にする';
comment on column common_code.view_order is 'の表示順。デフォルト1';
comment on column common_code.css_class is 'css class';
comment on column common_code.image is '画像パス';
comment on column common_code.description is 'の説明';
comment on column common_code.insert_date is '登録';

