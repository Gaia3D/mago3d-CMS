-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists data_info_log cascade;
drop table if exists data_info_log_2021 cascade;
commit;


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


create table data_info_log_2021 partition of data_info_log for values from ('2021-01-01 00:00:00.000000') to ('2022-01-01 00:00:00.000000');
