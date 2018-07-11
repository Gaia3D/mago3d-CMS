drop table if exists menu cascade;

-- メニュー
create table menu(
	menu_id				int,
	menu_type			char(1),
	name				varchar(100)							not null,
	name_en				varchar(30)								not null,
	lang				varchar(10)								default 'ko',
	parent				int								default '1',
	depth				int								default '1',
	view_order			int								default '1',
	url					varchar(256)							not null,
	url_alias			varchar(256),
	image				varchar(256),
	image_alt			varchar(100),
	css_class			varchar(30),
	default_yn			char(1)									default 'N',
	use_yn				char(1)									default 'Y',
	display_yn			char(1)									default 'Y',
	description			varchar(256),
	insert_date				timestamp with time zone			default now(),
	constraint menu_pk primary key (menu_id)	
);


comment on table menu is 'メニュー';
comment on column menu.menu_id is '固有番号';
comment on column menu.menu_type is 'メニュータイプ、0：管理者サイト、1：ユーザーのサイト';
comment on column menu.name is 'メニュー名';
comment on column menu.name_en is '英語メニュー名';
comment on column menu.lang is '言語';
comment on column menu.parent is '両親固有番号';
comment on column menu.depth is '深さ';
comment on column menu.view_order is '一覧表示順';
comment on column menu.url is 'URL';
comment on column menu.url_alias is 'URL Alias';
comment on column menu.image is 'イメージ';
comment on column menu.image_alt is '画像Alt';
comment on column menu.css_class is 'css class人';
comment on column menu.default_yn is 'デフォルトの表示メニュー、Y：基本、N：選択';
comment on column menu.use_yn is 'を使用の有無、Y：使用すると、N：を無効にする';
comment on column menu.display_yn is '画面表示、Y：表示、N：非表示';
comment on column menu.description is 'の説明';
comment on column menu.insert_date is '登録';

