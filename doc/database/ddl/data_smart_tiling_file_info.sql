drop table if exists data_smart_tiling_file_info cascade;
drop table if exists data_smart_tiling_file_parse_log cascade;

-- Smart Tiling 데이터 파일 관리
create table data_smart_tiling_file_info(
	data_smart_tiling_file_info_id			bigint,
	data_group_id							integer,
	user_id									varchar(32)	 		not null,
	file_name								varchar(100)		not null,
	file_real_name							varchar(100)		not null,
	file_path								varchar(256)		not null,
	file_size								varchar(12)			not null,
	file_ext								varchar(10)			not null,
	total_count								bigint				default 0,
	parse_success_count						bigint				default 0,
	parse_error_count						bigint				default 0,
	insert_success_count					bigint				default 0,
	insert_error_count						bigint				default 0,
	insert_date								timestamp with time zone			default now(),
	constraint data_smart_tiling_file_info_pk primary key (data_smart_tiling_file_info_id)	
);

comment on table data_smart_tiling_file_info is 'Smart Tiling 데이터 파일 관리';
comment on column data_smart_tiling_file_info.data_smart_tiling_file_info_id is '고유번호';
comment on column data_smart_tiling_file_info.data_group_id is '데이터 그룹 고유번호';
comment on column data_smart_tiling_file_info.user_id is '사용자 아이디';
comment on column data_smart_tiling_file_info.file_name is '파일 이름';
comment on column data_smart_tiling_file_info.file_real_name is '파일 실제 이름';
comment on column data_smart_tiling_file_info.file_path is '파일 경로';
comment on column data_smart_tiling_file_info.file_size is '파일 사이즈';
comment on column data_smart_tiling_file_info.file_ext is '파일 확장자';
comment on column data_smart_tiling_file_info.total_count is '전체 데이터 건수';
comment on column data_smart_tiling_file_info.parse_success_count is '파싱 성공 건수';
comment on column data_smart_tiling_file_info.parse_error_count is '파싱 오류';
comment on column data_smart_tiling_file_info.insert_success_count is 'SQL Insert 성공 건수';
comment on column data_smart_tiling_file_info.insert_error_count is 'SQL Insert 실패 건수';
comment on column data_smart_tiling_file_info.insert_date is '등록일';

create table data_smart_tiling_file_parse_log(
	data_smart_tiling_file_parse_log_id			bigint,
	data_smart_tiling_file_info_id				bigint 				not null,
	identifier_value							varchar(100)	 	not null,
	error_code									varchar(256),
	log_type									varchar(20),
	status										varchar(20),
	insert_date									timestamp with time zone			default now(),
	constraint data_smart_tiling_file_parse_log_pk primary key (data_smart_tiling_file_parse_log_id)	
);

comment on table data_smart_tiling_file_parse_log is '파일 파싱 이력';
comment on column data_smart_tiling_file_parse_log.data_smart_tiling_file_parse_log_id is '고유번호';
comment on column data_smart_tiling_file_parse_log.data_smart_tiling_file_info_id is '파일 정보 고유번호';
comment on column data_smart_tiling_file_parse_log.identifier_value is '식별자 값';
comment on column data_smart_tiling_file_parse_log.error_code is '에러 코드';
comment on column data_smart_tiling_file_parse_log.log_type is '로그 타입. file: 파일, db: DB Insert';
comment on column data_smart_tiling_file_parse_log.status is '상태. success, error';
comment on column data_smart_tiling_file_parse_log.insert_date is '등록일';
