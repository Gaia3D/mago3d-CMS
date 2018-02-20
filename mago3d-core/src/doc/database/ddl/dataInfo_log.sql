-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists data_info_log cascade;

create table data_info_log(
	data_info_log_id				bigint,					
	data_id							bigint,
	user_id							varchar(32),
	latitude						numeric(13,10),
	longitude						numeric(13,10),
	height							numeric(7,3),
	heading							numeric(8,5),
	pitch							numeric(8,5),
	roll							numeric(8,5),
	status							char(1)								default '0',
	change_type						varchar(30),
	description						varchar(256),
	update_date						timestamp without time zone,
	insert_date						timestamp without time zone			default now(),
	constraint data_info_log_pk 	primary key(data_info_log_id)
);

comment on table data_info_log is 'Data 이력 정보';
comment on column data_info_log.data_info_log_id is '고유번호';
comment on column data_info_log.data_id is 'Data 고유번호';
comment on column data_info_log.user_id is '사용자 고유번호';
comment on column data_info_log.latitude is '위도';
comment on column data_info_log.longitude is '경도';
comment on column data_info_log.height is '높이';
comment on column data_info_log.heading is 'heading';
comment on column data_info_log.pitch is 'pitch';
comment on column data_info_log.roll is 'roll';
comment on column data_info_log.status is '상태. 0:변경대기, 1:변경완료, 2:기각';
comment on column data_info_log.change_type is '요청 타입';
comment on column data_info_log.description is '설명';
comment on column data_info_log.update_date is '수정일';
comment on column data_info_log.insert_date is '등록일';


create table data_info_log_2018 (
	check ( insert_date >= to_timestamp('20180101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20181231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (data_info_log);
create table data_info_log_2019 (
	check ( insert_date >= to_timestamp('20190101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20191231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (data_info_log);
create table data_info_log_2020 (
	check ( insert_date >= to_timestamp('20200101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20201231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (data_info_log);
create table data_info_log_2021 (
	check ( insert_date >= to_timestamp('20210101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20211231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (data_info_log);
create table data_info_log_2022 (
	check ( insert_date >= to_timestamp('20220101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20221231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (data_info_log);
create table data_info_log_2023 (
	check ( insert_date >= to_timestamp('20230101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20231231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (data_info_log);
create table data_info_log_2024 (
	check ( insert_date >= to_timestamp('20240101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20241231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (data_info_log);
create table data_info_log_2025 (
	check ( insert_date >= to_timestamp('20250101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20251231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (data_info_log);
create table data_info_log_2026 (
	check ( insert_date >= to_timestamp('20260101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20261231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (data_info_log);
create table data_info_log_2027 (
	check ( insert_date >= to_timestamp('20270101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20271231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (data_info_log);
create table data_info_log_2028 (
	check ( insert_date >= to_timestamp('20280101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20281231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (data_info_log);
create table data_info_log_2029 (
	check ( insert_date >= to_timestamp('20290101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20291231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (data_info_log);
create table data_info_log_2030 (
	check ( insert_date >= to_timestamp('20300101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20301231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (data_info_log);
create table data_info_log_2031 (
	check ( insert_date >= to_timestamp('20310101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20311231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (data_info_log);


alter table only data_info_log_2018 add constraint data_info_log_2018_pk primary key (data_info_log_id);
alter table only data_info_log_2019 add constraint data_info_log_2019_pk primary key (data_info_log_id);
alter table only data_info_log_2020 add constraint data_info_log_2020_pk primary key (data_info_log_id);
alter table only data_info_log_2021 add constraint data_info_log_2021_pk primary key (data_info_log_id);
alter table only data_info_log_2022 add constraint data_info_log_2022_pk primary key (data_info_log_id);
alter table only data_info_log_2023 add constraint data_info_log_2023_pk primary key (data_info_log_id);
alter table only data_info_log_2024 add constraint data_info_log_2024_pk primary key (data_info_log_id);
alter table only data_info_log_2025 add constraint data_info_log_2025_pk primary key (data_info_log_id);
alter table only data_info_log_2026 add constraint data_info_log_2026_pk primary key (data_info_log_id);
alter table only data_info_log_2027 add constraint data_info_log_2027_pk primary key (data_info_log_id);
alter table only data_info_log_2028 add constraint data_info_log_2028_pk primary key (data_info_log_id);
alter table only data_info_log_2029 add constraint data_info_log_2029_pk primary key (data_info_log_id);
alter table only data_info_log_2030 add constraint data_info_log_2030_pk primary key (data_info_log_id);
alter table only data_info_log_2031 add constraint data_info_log_2031_pk primary key (data_info_log_id);
