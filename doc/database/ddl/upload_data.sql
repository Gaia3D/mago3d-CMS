-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists upload_data cascade;
drop table if exists upload_data_file cascade;

-- 사용자 업로드 정보
create table upload_data (
	upload_data_id					bigint,
	data_group_id					int,
	sharing							varchar(30)							default 'public',
	data_type						varchar(30),
	data_name						varchar(256),
	user_id							varchar(32),
	mapping_type					varchar(30)							default 'origin',
	height_reference				varchar(16)							default 'none',
	location		 				GEOMETRY(POINT, 4326),
	altitude						numeric(13,7),
    assemble                        boolean                             default false,
	file_count						int									default 0,
	converter_target_count			int									default 0,
	converter_count					int 								default 0,
	status							varchar(20)							default 'upload',
	year							char(4)								default to_char(now(), 'yyyy'),
	month							varchar(2)							default to_char(now(), 'MM'),
	day								varchar(2)							default to_char(now(), 'DD'),
	year_week						varchar(2)							default to_char(now(), 'WW'),
	week							varchar(2)							default to_char(now(), 'W'),
	hour							varchar(2)							default to_char(now(), 'HH24'),
	minute							varchar(2)							default to_char(now(), 'MI'),
	description						varchar(256),
	update_date						timestamp with time zone,
	insert_date						timestamp with time zone			default now(),
	constraint upload_data_pk		primary key (upload_data_id)	
);

comment on table upload_data is '사용자 업로드 정보';
comment on column upload_data.upload_data_id is '고유번호';
comment on column upload_data.data_group_id is '데이터 그룹 고유번호';
comment on column upload_data.sharing is '공유 유형. 0 : common, 1: public, 2 : private, 3 : sharing';
comment on column upload_data.data_type is '데이터 타입. 3ds,obj,dae,collada,ifc,las,citygml,indoorgml,gml,jpg,jpeg,gif,png,bmp,zip,mtl';
comment on column upload_data.data_name is '데이터명';
comment on column upload_data.user_id is '사용자 아이디';
comment on column upload_data.mapping_type is '기본값 origin : latitude, longitude, height를 origin에 맞춤. boundingboxcenter : latitude, longitude, height를 boundingboxcenter 맞춤';
comment on column upload_data.height_reference is '높이 설정 방법. none : 해발 고드, clampToGround : Terrain(지형)에 맞춤, relativeToGround : Terrain(지형)으로 부터 높이 설정';
comment on column upload_data.location is 'POINT(위도, 경도). 공간 검색 속도 때문에 altitude는 분리';
comment on column upload_data.altitude is '높이';
comment on column upload_data.assemble is '합체 가능한 데이터 유무. true : 합체, false : 단일';
comment on column upload_data.file_count is '파일 개수';
comment on column upload_data.converter_target_count is 'converter 변환 대상 파일 수';
comment on column upload_data.converter_count is 'converter 횟수';
comment on column upload_data.status is '상태. upload : 업로딩 완료, converter : 변환';
comment on column upload_data.year is '년';
comment on column upload_data.month is '월';
comment on column upload_data.day is '일';
comment on column upload_data.year_week is '일년중 몇주';
comment on column upload_data.week is '이번달 몇주';
comment on column upload_data.hour is '시간';
comment on column upload_data.minute is '분';
comment on column upload_data.description is '설명';
comment on column upload_data.update_date is '수정일';
comment on column upload_data.insert_date is '등록일';


-- 사용자 업로드 파일 정보 
create table upload_data_file(
	upload_data_file_id				bigint,
	upload_data_id					bigint,
	converter_target				boolean								default false,		
	user_id							varchar(32),
	file_type						varchar(9)							default 'file',
	file_name						varchar(100)						not null,
	file_real_name					varchar(100)						not null,
	file_path						varchar(256)						not null,
	file_sub_path					varchar(256),
	file_size						varchar(12)							not null,
	file_ext						varchar(20),
	depth							int									default 1,
	error_message					varchar(256),
	insert_date						timestamp with time zone			default now(),
	constraint upload_data_file_pk	primary key (upload_data_file_id)	
);

comment on table upload_data_file is '사용자 업로드 파일 정보 ';
comment on column upload_data_file.upload_data_file_id is '고유번호';
comment on column upload_data_file.upload_data_id is '사용자 업로드 정보 고유번호';
comment on column upload_data_file.converter_target is 'converter 대상 파일 유무. Y : 대상, N : 대상아님(기본값)';
comment on column upload_data_file.user_id is '사용자 아이디';
comment on column upload_data_file.file_type is '디렉토리/파일 구분. D : 디렉토리, F : 파일';
comment on column upload_data_file.file_name is '파일 이름';
comment on column upload_data_file.file_real_name is '파일 실제 이름';
comment on column upload_data_file.file_path is '파일 경로';
comment on column upload_data_file.file_sub_path is '프로젝트 경로 또는 공통 디렉토리 이하 부터의 파일 경로';
comment on column upload_data_file.file_size is '파일 사이즈';
comment on column upload_data_file.file_ext is '파일 확장자';
comment on column upload_data_file.depth is '계층구조 깊이. 1부터 시작';
comment on column upload_data_file.error_message is '오류 메시지';
comment on column upload_data_file.insert_date is '등록일';

