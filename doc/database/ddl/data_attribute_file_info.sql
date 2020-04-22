drop table if exists data_attribute_file_info cascade;
drop table if exists data_object_attribute_file_info cascade;

-- 데이터 속성 파일 관리
create table data_attribute_file_info(
	data_attribute_file_info_id				bigint,
	data_id									bigint,
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
	constraint data_attribute_file_info_pk primary key (data_attribute_file_info_id)	
);

comment on table data_attribute_file_info is '데이터 속성 파일 관리';
comment on column data_attribute_file_info.data_attribute_file_info_id is '고유번호';
comment on column data_attribute_file_info.data_id is '데이터 고유번호';
comment on column data_attribute_file_info.user_id is '사용자 아이디';
comment on column data_attribute_file_info.file_name is '파일 이름';
comment on column data_attribute_file_info.file_real_name is '파일 실제 이름';
comment on column data_attribute_file_info.file_path is '파일 경로';
comment on column data_attribute_file_info.file_size is '파일 사이즈';
comment on column data_attribute_file_info.file_ext is '파일 확장자';
comment on column data_attribute_file_info.total_count is '전체 데이터 건수';
comment on column data_attribute_file_info.parse_success_count is '파싱 성공 건수';
comment on column data_attribute_file_info.parse_error_count is '파싱 오류';
comment on column data_attribute_file_info.insert_success_count is 'SQL Insert 성공 건수';
comment on column data_attribute_file_info.insert_error_count is 'SQL Insert 실패 건수';
comment on column data_attribute_file_info.insert_date is '등록일';


-- 데이터 Object 속성 파일 관리
create table data_object_attribute_file_info (
	data_object_attribute_file_info_id		bigint,
	data_id									bigint,
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
	constraint data_object_attribute_file_info_pk primary key (data_object_attribute_file_info_id)	
);

comment on table data_object_attribute_file_info is '데이터 Object 속성 파일 관리';
comment on column data_object_attribute_file_info.data_object_attribute_file_info_id is '고유번호';
comment on column data_object_attribute_file_info.data_id is '데이터 고유번호';
comment on column data_object_attribute_file_info.user_id is '사용자 아이디';
comment on column data_object_attribute_file_info.file_name is '파일 이름';
comment on column data_object_attribute_file_info.file_real_name is '파일 실제 이름';
comment on column data_object_attribute_file_info.file_path is '파일 경로';
comment on column data_object_attribute_file_info.file_size is '파일 사이즈';
comment on column data_object_attribute_file_info.file_ext is '파일 확장자';
comment on column data_object_attribute_file_info.total_count is '전체 데이터 건수';
comment on column data_object_attribute_file_info.parse_success_count is '파싱 성공 건수';
comment on column data_object_attribute_file_info.parse_error_count is '파싱 오류';
comment on column data_object_attribute_file_info.insert_success_count is 'SQL Insert 성공 건수';
comment on column data_object_attribute_file_info.insert_error_count is 'SQL Insert 실패 건수';
comment on column data_object_attribute_file_info.insert_date is '등록일';

