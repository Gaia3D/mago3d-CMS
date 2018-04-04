drop table if exists issue cascade;
drop table if exists issue_detail cascade;
drop table if exists issue_comment cascade;
drop table if exists issue_file cascade;
drop table if exists issue_people cascade;

-- issue
create table issue (
	issue_id					bigint,
	project_id					int			not null,
	user_id						varchar(32)	 		not null,
	
	title						varchar(300)		not null,
	priority					varchar(30),
	due_date					timestamp with time zone,
	issue_type					varchar(30),
	status						varchar(30),
	
	data_key 					varchar(128) 		NOT NULL,
	object_key 					varchar(256),
	location 					geography(Point,4326),
	latitude					numeric(13,10),
	longitude					numeric(13,10),
	height						numeric(7,3),
	
	year						char(4)				default to_char(now(), 'YYYY'),
	month						varchar(2)			default to_char(now(), 'MM'),
	day							varchar(2)			default to_char(now(), 'DD'),
	year_week					varchar(2)			default to_char(now(), 'WW'),
	week						varchar(2)			default to_char(now(), 'W'),
	hour						varchar(2)			default to_char(now(), 'HH24'),
	minute						varchar(2)			default to_char(now(), 'MI'),
	
	client_ip					varchar(45)			not null,
	update_date					timestamp with time zone,
	insert_date					timestamp with time zone			default now(),
	constraint issue_pk primary key (issue_id)	
);

comment on table issue is 'issue';
comment on column issue.issue_id is 'unique number';
comment on column issue.project_id is 'project id';
comment on column issue.user_id is 'User ID';
comment on column issue.title is 'issue name';
comment on column issue.priority is 'priority. common_code dynamic creation';
comment on column issue.due_date is 'due date. deadline';
comment on column issue.issue_type is 'Issue type. common_code dynamic creation';
comment on column issue.status is 'state. common_code dynamic creation';
comment on column issue.data_key is 'Data key';
comment on column issue.object_key is 'Object key';
comment on column issue.location is 'location (latitude, longitude)';
comment on column issue.latitude is 'latitude';
comment on column issue.longitude is 'longitude';
comment on column issue.height is 'height';
comment on column issue.client_ip is 'Request IP';

comment on column access_log.year is 'year';
comment on column access_log.month is 'month';
comment on column access_log.day is 'day';
comment on column access_log.year_week is 'a few weeks of the year';
comment on column access_log.week is 'several weeks this month';
comment on column access_log.hour is 'Time';
comment on column access_log.minute is 'minutes';

comment on column issue.update_date is 'Modified';
comment on column issue.insert_date is 'Registered Date';

-- Issue Details
create table issue_detail (
	issue_detail_id				bigint,
	issue_id					bigint 					not null,
	contents					text					not null,
	insert_date					timestamp with time zone			default now(),
	constraint issue_detail_pk 	primary key (issue_detail_id)	
);

comment on table issue_detail is 'issue details';
comment on column issue_detail.issue_detail_id is 'issue detail number';
comment on column issue_detail.issue_id is 'issue unique number';
comment on column issue_detail.contents is 'content';
comment on column issue.insert_date is 'Registered Date';

-- Issue files
create table issue_file(
	issue_file_id				bigint,
	issue_id					bigint 				not null,
	file_name					varchar(100)		not null,
	file_real_name				varchar(100)		not null,
	file_path					varchar(256)		not null,
	file_size					varchar(12)			not null,
	file_ext					varchar(10)			not null,
	insert_date					timestamp with time zone			default now(),
	constraint issue_file_pk primary key (issue_file_id)	
);

comment on table issue_file is 'Manage issue files';
comment on column issue_file.issue_file_id is 'unique number';
comment on column issue_file.issue_id is 'unique number';
comment on column issue_file.file_name is 'filename';
comment on column issue_file.file_real_name is 'file actual name';
comment on column issue_file.file_path is 'file path';
comment on column issue_file.file_size is 'file size';
comment on column issue_file.file_ext is 'file extension';
comment on column issue_file.insert_date is 'Registered Date';

-- Issue comment
create table issue_comment (
	issue_comment_id			bigint,
	issue_id					bigint				not null,
	user_id						varchar(32)	 		not null,
	comment						varchar(4000)		not null,
	client_ip					varchar(45)			not null,
	insert_date					timestamp with time zone			default now(),
	constraint issue_comment_pk primary key (issue_comment_id)	
);

comment on table issue_comment is 'issue comment';
comment on column issue_comment.issue_comment_id is 'unique number';
comment on column issue_comment.issue_id is 'issue unique number';
comment on column issue_comment.user_id is 'User ID';
comment on column issue_comment.comment is 'Comment';
comment on column issue_comment.client_ip is 'Request IP';
comment on column issue_comment.insert_date is 'Registered Date';

-- issue officials
create table issue_people (
	issue_people_id				bigint,
	issue_id					bigint			not null,
	role_type					char(1),
	user_id						varchar(32),
	insert_date					timestamp with time zone			default now(),
	constraint issue_people_pk primary key (issue_people_id)	
);

comment on table issue_people is 'issue person';
comment on column issue_people.issue_people_id is 'unique number';
comment on column issue_people.issue_id is 'issue unique number';
comment on column issue_people.role_type is 'Issue type. 1: Delegate, 2: Contact';
comment on column issue_people.user_id is 'User ID';
comment on column issue_people.insert_date is 'Registered Date';
