drop table if exists widget cascade;

-- 위젯
create table widget(
	widget_id				integer,
	widget_name				varchar(100)					not null,
	widget_key				varchar(100)					not null,
	view_order				integer							default 1,
	user_id					varchar(32)	 					not null,
	insert_date				timestamp with time zone		default now(),
	constraint widget_pk 	primary key (widget_id)	
);


comment on table widget is '위젯';
comment on column widget.widget_id is '고유번호';
comment on column widget.widget_name is '이름';
comment on column widget.widget_key is 'Key';
comment on column widget.view_order is '나열 순서';
comment on column widget.user_id is '사용자 아이디';
comment on column widget.insert_date is '등록일';
