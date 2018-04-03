drop table if exists widget cascade;

-- ����
create table widget(
	widget_id			int,
	name				varchar(100)			not null ,
	view_order			int								default '1',
	user_id				varchar(32)	 			not null,
	insert_date				timestamp with time zone			default now(),
	constraint widget_pk primary key (widget_id)	
);


comment on table widget is '����';
comment on column widget.widget_id is '������ȣ';
comment on column widget.name is '�̸�';
comment on column widget.view_order is '���� ����';
comment on column widget.user_id is '����� ���̵�';
comment on column widget.insert_date is '�����';
