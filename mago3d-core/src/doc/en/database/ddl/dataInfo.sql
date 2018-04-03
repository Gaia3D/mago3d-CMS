-- Separate FK and Index into separate files. Scheduled to work last
drop table if exists project cascade;
drop table if exists data_info cascade;

-- User groups
create table project(
	project_id				int,
	project_key				varchar(60)							not null ,
	project_name			varchar(100)						not null,
	view_order				int									default 1,
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

comment on table project is 'project (F4D Data) group';
comment on column project.project_id is 'unique number';
comment on column project.project_key is 'Extension column for link utilization';
comment on column project.project_name is 'Project';
comment on column project.view_order is 'List order';
comment on column project.default_yn is 'Unable to delete, Y: default, N: select';
comment on column project.use_yn is 'Use, Y: Use, N: Do not use';
comment on column project.latitude is 'latitude';
comment on column project.longitude is 'longitude';
comment on column project.height is 'height';
comment on column project.duration is 'flyTo move time';
comment on column project.description is 'Description';
comment on column project.insert_date is 'Registered Date';


-- Data basic information
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

comment on table data_info is 'Data information';
comment on column data_info.data_id is 'unique number';
comment on column data_info.project_id is 'project unique number';
comment on column data_info.data_key is 'data unique identification number';
comment on column data_info.data_name is 'data name';
comment on column data_info.location is 'latitude, longitude information';
comment on column data_info.latitude is 'latitude';
comment on column data_info.longitude is 'longitude';
comment on column data_info.height is 'height';
comment on column data_info.heading is 'heading';
comment on column data_info.pitch is 'pitch';
comment on column data_info.roll is 'roll';
comment on column data_info.attributes is 'Data Control property';
comment on column data_info.public_yn is' Open or not. Default is N (private) ';
comment on column data_info.status is 'Data state. 0: in use, 1: disabled (administrator), 2: other';
comment on column data_info.data_insert_type is 'data registration method. Default: SELF';
comment on column data_info.description is 'Description';
comment on column data_info.update_date is 'Modified';
comment on column data_info.insert_date is 'Registered Date';

-- point is longitude, latitude order.
-- insert into data_info(location) values(st_geometryfromtext('POINT(128.5952254 34.93630567)'))
