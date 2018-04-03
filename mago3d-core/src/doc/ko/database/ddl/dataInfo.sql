-- FK, Index �� ���� ���Ϸ� �и�. �� �������� �۾� ����
drop table if exists project cascade;
drop table if exists data_info cascade;

-- ����� �׷�
create table project(
	project_id				int,
	project_key				varchar(60)							not null ,
	project_name			varchar(100)						not null,
	view_order				int							default 1,
	default_yn				char(1)								default 'N',
	use_yn					char(1)								default 'Y',
	latitude				numeric(13,10),
	longitude				numeric(13,10),
	height					numeric(7,3),
	duration				int,
	description				varchar(256),
	insert_date				timestamp with time zone			default now(),
	constraint project_pk 	primary key (project_id)	
);

comment on table project is 'project(F4D Data) �׷�';
comment on column project.project_id is '������ȣ';
comment on column project.project_key is '��ũ Ȱ�� ���� ���� Ȯ�� �÷�';
comment on column project.project_name is '������Ʈ';
comment on column project.view_order is '���� ����';
comment on column project.default_yn is '���� �Ұ�, Y : �⺻, N : ����';
comment on column project.use_yn is '�������, Y : ���, N : ������';
comment on column project.latitude is '����';
comment on column project.longitude is '�浵';
comment on column project.height is '����';
comment on column project.duration is 'flyTo �̵��ð�';
comment on column project.description is '����';
comment on column project.insert_date is '�����';


-- Data �⺻����
create table data_info(
	data_id						bigint,
	project_id					int							not null,
	data_key					varchar(128)						not null,
	data_name					varchar(64),
	parent						bigint								default 1,
	depth						int							default 1,
	view_order					int							default 1,
	child_yn					char(1)								default 'N',
	location		 			GEOGRAPHY(POINT, 4326),
	latitude					numeric(13,10),
	longitude					numeric(13,10),
	height						numeric(7,3),
	heading						numeric(8,5),
	pitch						numeric(8,5),
	roll						numeric(8,5),
	attributes					jsonb,
	status						char(1)								default '0',
	public_yn					char(1)								default 'N',
	data_insert_type			varchar(30)							default 'SELF',
	description					varchar(256),
	update_date					timestamp with time zone,
	insert_date					timestamp with time zone			default now(),
	constraint data_info_pk 	primary key(data_id)
);

comment on table data_info is 'Data ����';
comment on column data_info.data_id is '������ȣ';
comment on column data_info.project_id is 'project ������ȣ';
comment on column data_info.data_key is 'data ���� �ĺ���ȣ';
comment on column data_info.data_name is 'data �̸�';
comment on column data_info.location is '����, �浵 ����';
comment on column data_info.latitude is '����';
comment on column data_info.longitude is '�浵';
comment on column data_info.height is '����';
comment on column data_info.heading is 'heading';
comment on column data_info.pitch is 'pitch';
comment on column data_info.roll is 'roll';
comment on column data_info.attributes is 'Data Control �Ӽ�';
comment on column data_info.public_yn is '���� ����. �⺻�� N(�����)';
comment on column data_info.status is 'Data ����. 0:�����, 1:�������(������), 2:��Ÿ';
comment on column data_info.data_insert_type is 'data ��� ���. �⺻ : SELF';
comment on column data_info.description is '����';
comment on column data_info.update_date is '������';
comment on column data_info.insert_date is '�����';

-- point �� �浵, ���� ������.
-- insert into data_info(location) values(st_geometryfromtext('POINT(128.5952254 34.93630567)'))
