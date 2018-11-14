-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists upload_data cascade;
drop table if exists upload_data_file cascade;

-- 사용자 업로드 정보
create table upload_data(
	upload_data_id					bigint,
	project_id						int,
	sharing_type					char(1)								default '1',
	data_type						varchar(30),
	user_id							varchar(32),
	data_name						varchar(256),
	latitude						numeric(13,10),
	longitude						numeric(13,10),
	height							numeric(7,3),
	description						varchar(256),
	file_count						int									default 0,
	status							char(1)								default '0',
	update_date						timestamp with time zone,
	insert_date						timestamp with time zone			default now(),
	constraint upload_data_pk	primary key (upload_data_id)	
);

comment on table upload_data is '사용자 업로드 정보';
comment on column upload_data.upload_data_id is '고유번호';
comment on column upload_data.project_id is '프로젝트 고유번호';
comment on column upload_data.sharing_type is '공유 타입';
comment on column upload_data.data_type is '데이터 타입';
comment on column upload_data.user_id is '사용자 아이디';
comment on column upload_data.data_name is '파일명';
comment on column upload_data.latitude is '위도';
comment on column upload_data.longitude is '경도';
comment on column upload_data.height is '높이';
comment on column upload_data.description is '설명';
comment on column upload_data.file_count is '파일 개수';
comment on column upload_data.status is '상태. 0 : 업로딩 완료, 1 : 변환';
comment on column upload_data.update_date is '수정일';
comment on column upload_data.insert_date is '등록일';


-- 사용자 업로드 파일 정보 
create table upload_data_file(
	upload_data_file_id				bigint,
	upload_data_id					bigint,
	project_id						int,
	sharing_type					char(1)								default '1',
	data_type						varchar(30),
	user_id							varchar(32),
	file_name						varchar(100)						not null,
	file_real_name					varchar(100)						not null,
	file_path						varchar(256)						not null,
	file_size						varchar(12)							not null,
	file_ext						varchar(10)							not null,
	converter_count					int									default 0,
	insert_date						timestamp with time zone			default now(),
	constraint upload_data_file_pk	primary key (upload_data_file_id)	
);

comment on table upload_data_file is '사용자 업로드 파일 정보 ';
comment on column upload_data_file.upload_data_file_id is '고유번호';
comment on column upload_data_file.upload_data_id is '사용자 업로드 정보 고유번호';
comment on column upload_data_file.project_id is '프로젝트 아이디(중복)';
comment on column upload_data_file.sharing_type is '공유 타입(중복)';
comment on column upload_data_file.data_type is '데이터 타입(중복)';
comment on column upload_data_file.user_id is '사용자 아이디';
comment on column upload_data_file.file_name is '파일 이름';
comment on column upload_data_file.file_real_name is '파일 실제 이름';
comment on column upload_data_file.file_path is '파일 경로';
comment on column upload_data_file.file_size is '파일 사이즈';
comment on column upload_data_file.file_ext is '파일 확장자';
comment on column upload_data_file.insert_date is '등록일';

