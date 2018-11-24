-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists converter_job cascade;
drop table if exists converter_job_detail cascade;

-- file converter job
create table converter_job(
	converter_job_id				bigint,
	upload_data_id					bigint,
	user_id							varchar(32),
	title							varchar(256)						not null,
	converter_type					char(1)								default '0',
	file_count						int									default 0,
	status							char(1)								default '0',
	error_code						varchar(4000),
	year							char(4)								default to_char(now(), 'yyyy'),
	month							varchar(2)							default to_char(now(), 'MM'),
	day								varchar(2)							default to_char(now(), 'DD'),
	year_week						varchar(2)							default to_char(now(), 'WW'),
	week							varchar(2)							default to_char(now(), 'W'),
	hour							varchar(2)							default to_char(now(), 'HH24'),
	minute							varchar(2)							default to_char(now(), 'MI'),
	update_date						timestamp with time zone,
	insert_date						timestamp with time zone			default now(),
	constraint converter_job_pk 	primary key (converter_job_id)	
);

comment on table converter_job is 'file converter job';
comment on column converter_job.converter_job_id is '고유번호';
comment on column converter_job.upload_data_id is '사용자 아이디';
comment on column converter_job.user_id is '사용자 아이디';
comment on column converter_job.converter_type is '변환 템플릿. 0 : 정밀(공장배관), 1 : 기본, 2 : 큰 건물, 3 : 초대형 건물';
comment on column converter_job.file_count is '대상 file 개수';
comment on column converter_job.status is '0: 준비, 1: 성공, 2: 확인필요, 3: 실패';
comment on column converter_job.error_code is '에러 코드';
comment on column converter_job.year is '년';
comment on column converter_job.month is '월';
comment on column converter_job.day is '일';
comment on column converter_job.year_week is '일년중 몇주';
comment on column converter_job.week is '이번달 몇주';
comment on column converter_job.hour is '시간';
comment on column converter_job.minute is '분';
comment on column converter_job.update_date is '수정일';
comment on column converter_job.insert_date is '등록일';


-- 사용자 f4d 변환 이력
create table converter_job_file(
	converter_job_file_id				bigint,
	converter_job_id					bigint,
	upload_data_id						bigint,
	upload_data_file_id					bigint,
	project_id							int,
	user_id								varchar(32),
	status								char(1)								default '0',
	error_code							varchar(4000),
	year								char(4)								default to_char(now(), 'yyyy'),
	month								varchar(2)							default to_char(now(), 'MM'),
	day									varchar(2)							default to_char(now(), 'DD'),
	year_week							varchar(2)							default to_char(now(), 'WW'),
	week								varchar(2)							default to_char(now(), 'W'),
	hour								varchar(2)							default to_char(now(), 'HH24'),
	minute								varchar(2)							default to_char(now(), 'MI'),
	insert_date							timestamp with time zone			default now(),
	constraint converter_job_file_pk 	primary key (converter_job_file_id)	
);

comment on table converter_job_file is 'converter 대상 파일';
comment on column converter_job_file.converter_job_file_id is '고유번호';
comment on column converter_job_file.converter_job_id is 'converter job 고유번호';
comment on column converter_job_file.upload_data_id is '업로딩 정보 고유번호';
comment on column converter_job_file.upload_data_file_id is '업로딩 파일 고유번호';
comment on column converter_job_file.project_id is 'project 고유번호';
comment on column converter_job_file.user_id is '사용자 아이디';
comment on column converter_job_file.status is '상태. 0: 성공, 1: 확인필요, 2: 실패';
comment on column converter_job_file.error_code is '에러 코드';
comment on column converter_job_file.year is '년';
comment on column converter_job_file.month is '월';
comment on column converter_job_file.day is '일';
comment on column converter_job_file.year_week is '일년중 몇주';
comment on column converter_job_file.week is '이번달 몇주';
comment on column converter_job_file.hour is '시간';
comment on column converter_job_file.minute is '분';
comment on column converter_job_file.insert_date is '등록일';



