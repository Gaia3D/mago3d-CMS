drop table if exists widget cascade;

-- ウィジェット
create table widget(
	widget_id			int,
	name				varchar(100)			not null ,
	view_order			int								default '1',
	user_id				varchar(32)	 			not null,
	insert_date				timestamp with time zone			default now(),
	constraint widget_pk primary key (widget_id)	
);


comment on table widget is 'ウィジェット';
comment on column widget.widget_id is '固有番号';
comment on column widget.name is 'name';
comment on column widget.view_order is '一覧表示順';
comment on column widget.user_id is 'ユーザID';
comment on column widget.insert_date is '登録日';
