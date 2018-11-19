-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists converter_job cascade;
drop table if exists converter_job_detail cascade;

-- 사용자 f4d 변환 job
create table converter_job(
	converter_job_id				bigint,
	user_id							varchar(32),
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
comment on column converter_job.converter_type is '0: 기본, 1: 큰 메쉬 하나';
comment on column converter_job.status is '0: 준비, 1: 성공, 2: 확인필요, 3: 실패';
comment on column converter_job.error_code is '에러 코드';
comment on column converter_job.update_date is '수정일';
comment on column converter_job.insert_date is '등록일';


-- 사용자 f4d 변환 이력
create table converter_job_detail(
	converter_job_detail_id				bigint,
	converter_job_id				bigint,
	upload_data_id			bigint,
	user_id							varchar(32),
	project_id					int	,
	data_key					varchar(128)						not null,
	data_name					varchar(256),
	parent						bigint								default 1,
	depth						int									default 1,
	view_order					int									default 1,
	child_yn					char(1)								default 'N',
	mapping_type				varchar(30)							default 'origin',
	location		 			GEOGRAPHY(POINT, 4326),
	latitude					numeric(13,10),
	longitude					numeric(13,10),
	height						numeric(7,3),
	heading						numeric(8,5),
	pitch						numeric(8,5),
	roll						numeric(8,5),
	attributes					jsonb,
	status							char(1)								default '0',
	converter_result				char(1),
	error_code						varchar(4000),
	insert_date						timestamp with time zone			default now(),
	constraint converter_job_detail_pk primary key (converter_job_detail_id)	
);

comment on table converter_job_detail is '사용자 f4d 변환 이력';
comment on column converter_job_detail.converter_job_detail_id is '고유번호';
comment on column converter_job_detail.converter_job_id is '파일 변환 job 고유번호';
comment on column converter_job_detail.converter_upload_log_id is '파일 정보 고유번호';
comment on column converter_job_detail.user_id is '사용자 아이디';
comment on column converter_job_detail.project_id is 'project 고유번호';
comment on column converter_job_detail.data_key is 'data 고유 식별번호';
comment on column converter_job_detail.data_name is 'data 이름';
comment on column converter_job_detail.parent is '부모 data_id';
comment on column converter_job_detail.depth is 'depth';
comment on column converter_job_detail.view_order is '정렬 순서';
comment on column converter_job_detail.child_yn is '자식 존재 유무';
comment on column converter_job_detail.mapping_type is '기본값 origin : latitude, longitude, height를 origin에 맞춤. boundingboxcenter : latitude, longitude, height를 boundingboxcenter 맞춤';
comment on column converter_job_detail.location is '위도, 경도 정보';
comment on column converter_job_detail.latitude is '위도';
comment on column converter_job_detail.longitude is '경도';
comment on column converter_job_detail.height is '높이';
comment on column converter_job_detail.heading is 'heading';
comment on column converter_job_detail.pitch is 'pitch';
comment on column converter_job_detail.roll is 'roll';
comment on column converter_job_detail.attributes is 'Data Control 속성';
comment on column converter_job_detail.status is '상태. 0: 미등록, 1: 등록중, 2: 등록완료, 3: 오류';
comment on column converter_job_detail.converter_result is '0: 성공, 1: 확인필요, 2: 실패';
comment on column converter_job_detail.error_code is '에러 코드';
comment on column converter_job_detail.insert_date is '등록일';



