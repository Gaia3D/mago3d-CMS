drop table if exists file_info cascade;
drop table if exists file_parse_log cascade;

-- 파일 관리(Excel, Pdf등)
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

comment on table file_info is '파일 관리';
comment on column file_info.file_info_id is '고유번호';
comment on column file_info.user_id is '사용자 아이디';
comment on column file_info.job_type is '업무 타입';
comment on column file_info.file_name is '파일 이름';
comment on column file_info.file_real_name is '파일 실제 이름';
comment on column file_info.file_path is '파일 경로';
comment on column file_info.file_size is '파일 사이즈';
comment on column file_info.file_ext is '파일 확장자';
comment on column file_info.total_count is 'Excel 전체 데이터 건수';
comment on column file_info.parse_success_count is 'Excel 파싱 성공 건수';
comment on column file_info.parse_error_count is 'Excel 파싱 오류';
comment on column file_info.insert_success_count is 'Excel 데이터 Target Table SQL Insert 성공 건수';
comment on column file_info.insert_error_count is 'Excel 데이터 Target Table SQL Insert 실패 건수';
comment on column file_info.register_date is '등록일';

-- 파일 파싱 이력(Excel, Pdf등)
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

comment on table file_parse_log is '파일 파싱 이력';
comment on column file_parse_log.file_parse_log_id is '고유번호';
comment on column file_parse_log.file_info_id is '파일 정보 고유번호';
comment on column file_parse_log.identifier_value is '식별자 값';
comment on column file_parse_log.error_code is '에러 코드';
comment on column file_parse_log.log_type is '로그 타입 0: 파일, 1: DB Insert';
comment on column file_parse_log.status is '상태. 0: success, 1: error';
comment on column file_parse_log.register_date is '등록일';

