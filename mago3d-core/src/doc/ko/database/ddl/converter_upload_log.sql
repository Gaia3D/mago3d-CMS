-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists converter_upload_log cascade;
drop table if exists converter_job cascade;
drop table if exists converter_log cascade;

-- 사용자 파일 upload 이력
create table converter_upload_log(
	converter_upload_log_id				bigint,
	user_id						varchar(32),
	file_name					varchar(100)				not null,
	file_real_name				varchar(100)				not null,
	file_path					varchar(256)				not null,
	file_size					varchar(12)					not null,
	file_ext					varchar(10)					not null,
	converter_count				int							default 0,
	insert_date					timestamp with time zone	default now(),
	constraint converter_upload_log_pk	primary key (converter_upload_log_id)	
);

comment on table converter_upload_log is '사용자 파일 upload 이력';
comment on column converter_upload_log.converter_upload_log_id is '고유번호';
comment on column converter_upload_log.user_id is '사용자 아이디';
comment on column converter_upload_log.file_name is '파일 이름';
comment on column converter_upload_log.file_real_name is '파일 실제 이름';
comment on column converter_upload_log.file_path is '파일 경로';
comment on column converter_upload_log.file_size is '파일 사이즈';
comment on column converter_upload_log.file_ext is '파일 확장자';
comment on column converter_upload_log.converter_count is 'F4D Converter 변환 횟수';
comment on column converter_upload_log.insert_date is '등록일';

-- 사용자 f4d 변환 job
create table converter_job(
	converter_job_id				bigint,
	user_id							varchar(32),
	project_id						bigint								not null,
	title							varchar(256)						not null,
	converter_type					char(1)								default '0',
	status							char(1)								default '0',
	error_code						varchar(4000),
	update_date						timestamp with time zone,
	insert_date						timestamp with time zone			default now(),
	constraint converter_job_pk primary key (converter_job_id)	
);

comment on table converter_job is '사용자 f4d 변환 이력';
comment on column converter_job.converter_job_id is '고유번호';
comment on column converter_job.user_id is '사용자 아이디';
comment on column converter_job.project_id is 'project 고유번호';
comment on column converter_job.converter_type is '0: 기본, 1: 큰 메쉬 하나';
comment on column converter_job.status is '0: 준비, 1: 성공, 2: 실패';
comment on column converter_job.error_code is '에러 코드';
comment on column converter_job.update_date is '수정일';
comment on column converter_job.insert_date is '등록일';


-- 사용자 f4d 변환 이력
create table converter_log(
	converter_log_id				bigint,
	converter_job_id				bigint,
	converter_upload_log_id			bigint,
	user_id							varchar(32),
	status							char(1)								default '0',
	error_code						varchar(4000),
	insert_date						timestamp with time zone			default now(),
	constraint converter_log_pk primary key (converter_log_id)	
);

comment on table converter_log is '사용자 f4d 변환 이력';
comment on column converter_log.converter_log_id is '고유번호';
comment on column converter_log.converter_job_id is '파일 변환 job 고유번호';
comment on column converter_log.converter_upload_log_id is '파일 정보 고유번호';
comment on column converter_log.user_id is '사용자 아이디';
comment on column converter_log.status is '상태. 0: 준비, 1: step1, 2: step2, 3: step3, 4: step4';
comment on column converter_log.error_code is '에러 코드';
comment on column converter_log.insert_date is '등록일';



