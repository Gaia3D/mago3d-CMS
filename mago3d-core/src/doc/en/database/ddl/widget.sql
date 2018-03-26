drop table if exists widget cascade;

-- Widget
create table widget(
	widget_id			int,
	name				varchar(100)			not null ,
	view_order			int								default '1',
	user_id				varchar(32)	 			not null,
	insert_date				timestamp without time zone			default now(),
	constraint widget_pk primary key (widget_id)	
);


comment on table widget is 'widget';
comment on column widget.widget_id is 'unique number';
comment on column widget.name is 'Name';
comment on column widget.view_order is 'List order';
comment on column widget.user_id is 'User ID';
comment on column widget.insert_date is 'Registered Date';
