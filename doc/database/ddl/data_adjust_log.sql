-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists data_adjust_log cascade;
drop table if exists data_adjust_log_2020 cascade;
drop table if exists data_adjust_log_2021 cascade;
drop table if exists data_adjust_log_2022 cascade;
drop table if exists data_adjust_log_2023 cascade;
drop table if exists data_adjust_log_2024 cascade;
drop table if exists data_adjust_log_2025 cascade;
drop table if exists data_adjust_log_2026 cascade;
drop table if exists data_adjust_log_2027 cascade;
drop table if exists data_adjust_log_2028 cascade;
drop table if exists data_adjust_log_2029 cascade;
drop table if exists data_adjust_log_2030 cascade;
drop table if exists data_adjust_log_2031 cascade;
drop table if exists data_adjust_log_2032 cascade;
drop table if exists data_adjust_log_2033 cascade;
drop table if exists data_adjust_log_2034 cascade;
drop table if exists data_adjust_log_2035 cascade;
drop table if exists data_adjust_log_2036 cascade;
drop table if exists data_adjust_log_2037 cascade;
drop table if exists data_adjust_log_2038 cascade;
drop table if exists data_adjust_log_2039 cascade;
drop table if exists data_adjust_log_2040 cascade;

-- 데이터 위치 변경 요청 이력. 파티션 pruning 확인해야 함(지금 임시버전)
create table data_adjust_log(
	data_adjust_log_id				bigint,
	data_group_id					integer,
	data_id							bigint,
	user_id							varchar(32),
	update_user_id					varchar(32),
	location		 				GEOMETRY(POINT, 4326),
	altitude						numeric(13,7),
	heading							numeric(8,5),
	pitch							numeric(8,5),
	roll							numeric(8,5),
	before_location					GEOMETRY(POINT, 4326),
	before_altitude					numeric(13,7),
	before_heading					numeric(8,5),
	before_pitch					numeric(8,5),
	before_roll						numeric(8,5),
	status							varchar								default 'request',
	change_type						varchar(30),
	description						varchar(256),
	update_date						timestamp with time zone,
	insert_date						timestamp with time zone			default now()
) partition by range(insert_date);

comment on table data_adjust_log is 'Data geometry 변경 이력 정보';
comment on column data_adjust_log.data_adjust_log_id is '고유번호';
comment on column data_adjust_log.data_group_id is '데이터 그룹 고유번호, join 성능때문에 중복 허용';
comment on column data_adjust_log.data_id is 'Data 고유번호';
comment on column data_adjust_log.user_id is '사용자 아이디';
comment on column data_adjust_log.update_user_id is '수정 요청자 아이디';
comment on column data_adjust_log.location is '위치';
comment on column data_adjust_log.altitude is '높이';
comment on column data_adjust_log.heading is 'heading';
comment on column data_adjust_log.pitch is 'pitch';
comment on column data_adjust_log.roll is 'roll';
comment on column data_adjust_log.before_location is '변경전 위치';
comment on column data_adjust_log.before_altitude is '변경전 높이';
comment on column data_adjust_log.before_heading is '변경전 heading';
comment on column data_adjust_log.before_pitch is '변경전 pitch';
comment on column data_adjust_log.before_roll is '변경전 roll';
comment on column data_adjust_log.status is '상태. request : 요청, approval : 승인, reject : 기각, rollback : 원복';
comment on column data_adjust_log.change_type is '변경 유형';
comment on column data_adjust_log.description is '설명';
comment on column data_adjust_log.update_date is '수정일';
comment on column data_adjust_log.insert_date is '등록일';


create table data_adjust_log_2020 partition of data_adjust_log for values from ('2020-01-01 00:00:00.000000') to ('2021-01-01 00:00:00.000000');
create table data_adjust_log_2021 partition of data_adjust_log for values from ('2021-01-01 00:00:00.000000') to ('2022-01-01 00:00:00.000000');
create table data_adjust_log_2022 partition of data_adjust_log for values from ('2022-01-01 00:00:00.000000') to ('2023-01-01 00:00:00.000000');
create table data_adjust_log_2023 partition of data_adjust_log for values from ('2023-01-01 00:00:00.000000') to ('2024-01-01 00:00:00.000000');
create table data_adjust_log_2024 partition of data_adjust_log for values from ('2024-01-01 00:00:00.000000') to ('2025-01-01 00:00:00.000000');
create table data_adjust_log_2025 partition of data_adjust_log for values from ('2025-01-01 00:00:00.000000') to ('2026-01-01 00:00:00.000000');
create table data_adjust_log_2026 partition of data_adjust_log for values from ('2026-01-01 00:00:00.000000') to ('2027-01-01 00:00:00.000000');
create table data_adjust_log_2027 partition of data_adjust_log for values from ('2027-01-01 00:00:00.000000') to ('2028-01-01 00:00:00.000000');
create table data_adjust_log_2028 partition of data_adjust_log for values from ('2028-01-01 00:00:00.000000') to ('2029-01-01 00:00:00.000000');
create table data_adjust_log_2029 partition of data_adjust_log for values from ('2029-01-01 00:00:00.000000') to ('2030-01-01 00:00:00.000000');
create table data_adjust_log_2030 partition of data_adjust_log for values from ('2030-01-01 00:00:00.000000') to ('2031-01-01 00:00:00.000000');
create table data_adjust_log_2031 partition of data_adjust_log for values from ('2031-01-01 00:00:00.000000') to ('2032-01-01 00:00:00.000000');
create table data_adjust_log_2032 partition of data_adjust_log for values from ('2032-01-01 00:00:00.000000') to ('2033-01-01 00:00:00.000000');
create table data_adjust_log_2033 partition of data_adjust_log for values from ('2033-01-01 00:00:00.000000') to ('2034-01-01 00:00:00.000000');
create table data_adjust_log_2034 partition of data_adjust_log for values from ('2034-01-01 00:00:00.000000') to ('2035-01-01 00:00:00.000000');
create table data_adjust_log_2035 partition of data_adjust_log for values from ('2035-01-01 00:00:00.000000') to ('2036-01-01 00:00:00.000000');
create table data_adjust_log_2036 partition of data_adjust_log for values from ('2036-01-01 00:00:00.000000') to ('2037-01-01 00:00:00.000000');
create table data_adjust_log_2037 partition of data_adjust_log for values from ('2037-01-01 00:00:00.000000') to ('2038-01-01 00:00:00.000000');
create table data_adjust_log_2038 partition of data_adjust_log for values from ('2038-01-01 00:00:00.000000') to ('2039-01-01 00:00:00.000000');
create table data_adjust_log_2039 partition of data_adjust_log for values from ('2039-01-01 00:00:00.000000') to ('2040-01-01 00:00:00.000000');
create table data_adjust_log_2040 partition of data_adjust_log for values from ('2040-01-01 00:00:00.000000') to ('2041-01-01 00:00:00.000000');
