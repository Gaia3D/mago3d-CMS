-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists data_info_log cascade;
drop table if exists data_info_log_2020 cascade;
drop table if exists data_info_log_2021 cascade;
drop table if exists data_info_log_2022 cascade;
drop table if exists data_info_log_2023 cascade;
drop table if exists data_info_log_2024 cascade;
drop table if exists data_info_log_2025 cascade;
drop table if exists data_info_log_2026 cascade;
drop table if exists data_info_log_2027 cascade;
drop table if exists data_info_log_2028 cascade;
drop table if exists data_info_log_2029 cascade;
drop table if exists data_info_log_2030 cascade;
drop table if exists data_info_log_2031 cascade;
drop table if exists data_info_log_2032 cascade;
drop table if exists data_info_log_2033 cascade;
drop table if exists data_info_log_2034 cascade;
drop table if exists data_info_log_2035 cascade;
drop table if exists data_info_log_2036 cascade;
drop table if exists data_info_log_2037 cascade;
drop table if exists data_info_log_2038 cascade;
drop table if exists data_info_log_2039 cascade;
drop table if exists data_info_log_2040 cascade;

-- 데이터 위치 변경 요청 이력. 파티션 pruning 확인해야 함(지금 임시버전)
create table data_info_log(
	data_log_id						bigint,
	data_group_id					integer,
	data_id							bigint,
	data_key						varchar(128)						not null,
	data_name						varchar(256),
	data_type						varchar(30),
	converter_job_id				bigint,
	sharing							varchar(30)							default 'public',
	user_id							varchar(32),
	update_user_id					varchar(32),
	mapping_type					varchar(30),
	location		 				GEOMETRY(POINT, 4326),
	altitude						numeric(13,7),
	heading							numeric(8,5),
	pitch							numeric(8,5),
	roll							numeric(8,5),
	change_type						varchar(30) default 'insert',
	metainfo						jsonb,
	year							char(4)								default to_char(now(), 'yyyy'),
	month							varchar(2)							default to_char(now(), 'MM'),
	day								varchar(2)							default to_char(now(), 'DD'),
	year_week						varchar(2)							default to_char(now(), 'WW'),
	week							varchar(2)							default to_char(now(), 'W'),
	hour							varchar(2)							default to_char(now(), 'HH24'),
	minute							varchar(2)							default to_char(now(), 'MI'),
	description						varchar(256),
	update_date						timestamp with time zone,
	insert_date						timestamp with time zone			default now()
) partition by range(insert_date);

comment on table data_info_log is '데이터 변경 이력 정보';
comment on column data_info_log.data_log_id is '고유번호';
comment on column data_info_log.data_group_id is '데이터 그룹 고유번호, join 성능때문에 중복 허용';
comment on column data_info_log.data_id is '데이터 고유번호';
comment on column data_info_log.data_key is '데이터 고유 식별키';
comment on column data_info_log.data_name is '데이터명';
comment on column data_info_log.data_type is '데이터 타입(중복). 3ds,obj,dae,collada,ifc,las,citygml,indoorgml,etc';
comment on column data_info_log.converter_job_id is 'converter job 고유번호';
comment on column data_info_log.sharing is 'common : 공통, public : 공개, private : 비공개, group : 그룹';
comment on column data_info_log.user_id is '사용자 아이디';
comment on column data_info_log.update_user_id is '수정 요청자 아이디';
comment on column data_info_log.mapping_type is '기본값 origin : latitude, longitude, height를 origin에 맞춤. boundingboxcenter : latitude, longitude, height를 boundingboxcenter 맞춤';
comment on column data_info_log.location is 'POINT(위도, 경도). 공간 검색 속도 때문에 altitude는 분리';
comment on column data_info_log.altitude is '높이';
comment on column data_info_log.heading is 'heading';
comment on column data_info_log.pitch is 'pitch';
comment on column data_info_log.roll is 'roll';
comment on column data_info_log.change_type is '변경 유형. insert : 등록, update : 수정';
comment on column data_info_log.metainfo is '데이터 메타 정보. 데이터  control을 위해 인위적으로 만든 속성';
comment on column data_info_log.year is '년';
comment on column data_info_log.month is '월';
comment on column data_info_log.day is '일';
comment on column data_info_log.year_week is '일년중 몇주';
comment on column data_info_log.week is '이번달 몇주';
comment on column data_info_log.hour is '시간';
comment on column data_info_log.minute is '분';
comment on column data_info_log.description is '설명';
comment on column data_info_log.update_date is '수정일';
comment on column data_info_log.insert_date is '등록일';


create table data_info_log_2020 partition of data_info_log for values from ('2020-01-01 00:00:00.000000') to ('2021-01-01 00:00:00.000000');
create table data_info_log_2021 partition of data_info_log for values from ('2021-01-01 00:00:00.000000') to ('2022-01-01 00:00:00.000000');
create table data_info_log_2022 partition of data_info_log for values from ('2022-01-01 00:00:00.000000') to ('2023-01-01 00:00:00.000000');
create table data_info_log_2023 partition of data_info_log for values from ('2023-01-01 00:00:00.000000') to ('2024-01-01 00:00:00.000000');
create table data_info_log_2024 partition of data_info_log for values from ('2024-01-01 00:00:00.000000') to ('2025-01-01 00:00:00.000000');
create table data_info_log_2025 partition of data_info_log for values from ('2025-01-01 00:00:00.000000') to ('2026-01-01 00:00:00.000000');
create table data_info_log_2026 partition of data_info_log for values from ('2026-01-01 00:00:00.000000') to ('2027-01-01 00:00:00.000000');
create table data_info_log_2027 partition of data_info_log for values from ('2027-01-01 00:00:00.000000') to ('2028-01-01 00:00:00.000000');
create table data_info_log_2028 partition of data_info_log for values from ('2028-01-01 00:00:00.000000') to ('2029-01-01 00:00:00.000000');
create table data_info_log_2029 partition of data_info_log for values from ('2029-01-01 00:00:00.000000') to ('2030-01-01 00:00:00.000000');
create table data_info_log_2030 partition of data_info_log for values from ('2030-01-01 00:00:00.000000') to ('2031-01-01 00:00:00.000000');
create table data_info_log_2031 partition of data_info_log for values from ('2031-01-01 00:00:00.000000') to ('2032-01-01 00:00:00.000000');
create table data_info_log_2032 partition of data_info_log for values from ('2032-01-01 00:00:00.000000') to ('2033-01-01 00:00:00.000000');
create table data_info_log_2033 partition of data_info_log for values from ('2033-01-01 00:00:00.000000') to ('2034-01-01 00:00:00.000000');
create table data_info_log_2034 partition of data_info_log for values from ('2034-01-01 00:00:00.000000') to ('2035-01-01 00:00:00.000000');
create table data_info_log_2035 partition of data_info_log for values from ('2035-01-01 00:00:00.000000') to ('2036-01-01 00:00:00.000000');
create table data_info_log_2036 partition of data_info_log for values from ('2036-01-01 00:00:00.000000') to ('2037-01-01 00:00:00.000000');
create table data_info_log_2037 partition of data_info_log for values from ('2037-01-01 00:00:00.000000') to ('2038-01-01 00:00:00.000000');
create table data_info_log_2038 partition of data_info_log for values from ('2038-01-01 00:00:00.000000') to ('2039-01-01 00:00:00.000000');
create table data_info_log_2039 partition of data_info_log for values from ('2039-01-01 00:00:00.000000') to ('2040-01-01 00:00:00.000000');
create table data_info_log_2040 partition of data_info_log for values from ('2040-01-01 00:00:00.000000') to ('2041-01-01 00:00:00.000000');
