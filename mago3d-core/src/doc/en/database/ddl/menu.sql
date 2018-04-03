drop table if exists menu cascade;

-- menu
create table menu(
	menu_id				int,
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


comment on table menu is 'menu';
comment on column menu.menu_id is 'unique number';
comment on column menu.name is 'menu name';
comment on column menu.name_en is 'English menu name';
comment on column menu.lang is 'language';
comment on column menu.parent is 'parent number';
comment on column menu.depth is 'depth';
comment on column menu.view_order is 'List order';
comment on column menu.url is 'URL';
comment on column menu.url_alias is 'URL Alias';
comment on column menu.image is 'image';
comment on column menu.image_alt is 'Image Alt';
comment on column menu.css_class is 'css class name';
comment on column menu.default_yn is 'Default display menu, Y: Basic, N: Select';
comment on column menu.use_yn is 'Use, Y: Use, N: Do not use';
comment on column menu.display_yn is 'Screen display, Y: display, N: non-display';
comment on column menu.description is 'Description';
comment on column menu.insert_date is 'Registered Date';
