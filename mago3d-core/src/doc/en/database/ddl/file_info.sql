drop table if exists file_info cascade;
drop table if exists file_parse_log cascade;

-- File management (Excel, Pdf, etc.)
create table file_info(
	file_info_id				bigint,
	user_id						varchar(32)	 		not null,
	job_type					varchar(50)			not null,
	file_name					varchar(100)		not null,
	file_real_name				varchar(100)		not null,
	file_path					varchar(256)		not null,
	file_size					varchar(12)			not null,
	file_ext					varchar(10)			not null,
	total_count					bigint				default 0,
	parse_success_count			bigint				default 0,
	parse_error_count			bigint				default 0,
	insert_success_count		bigint				default 0,
	insert_error_count			bigint				default 0,
	register_date				timestamp without time zone			default now(),
	constraint file_info_pk primary key (file_info_id)	
);

comment on table file_info is 'file management';
comment on column file_info.file_info_id is 'unique number';
comment on column file_info.user_id is 'User ID';
comment on column file_info.job_type is 'business type';
comment on column file_info.file_name is 'filename';
comment on column file_info.file_real_name is 'file actual name';
comment on column file_info.file_path is 'file path';
comment on column file_info.file_size is 'file size';
comment on column file_info.file_ext is 'File extension';
comment on column file_info.total_count is 'Total number of data in Excel';
comment on column file_info.parse_success_count is 'Number of successful Excel parsing';
comment on column file_info.parse_error_count is 'Excel parsing error';
comment on column file_info.insert_success_count is 'Excel Data Target Table SQL Insert Success Count';
comment on column file_info.insert_error_count is 'Excel Data Target Table SQL Insert Failure Count';
comment on column file_info.register_date is 'Registered Date';

-- File parsing history (Excel, Pdf, etc.)
create table file_parse_log(
	file_parse_log_id			bigint,
	file_info_id				bigint 				not null,
	identifier_value			varchar(100)	 		not null,
	error_code					varchar(4000),
	log_type					char(1)				default '0',
	status						char(1)				default '0',
	register_date				timestamp without time zone			default now(),
	constraint file_parse_log_pk primary key (file_parse_log_id)	
);

comment on table file_parse_log is 'file parsing history';
comment on column file_parse_log.file_parse_log_id is 'unique number';
comment on column file_parse_log.file_info_id is 'file information unique number';
comment on column file_parse_log.identifier_value is 'identifier value';
comment on column file_parse_log.error_code is 'Error code';
comment on column file_parse_log.log_type is 'Log type. 0: file, 1: DB Insert';
comment on column file_parse_log.status is 'status. 0: success, 1: error';
comment on column file_parse_log.register_date is 'Registered Date';

