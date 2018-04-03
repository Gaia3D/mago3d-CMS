drop table if exists access_log cascade;

-- Service request history
create table access_log(
	access_log_id				bigint,
	user_id						varchar(32)	 		not null,
	user_name					varchar(64)			not null,
	client_ip					varchar(45)			not null,
	request_uri					varchar(256)		not null,
	parameters					varchar(1000),
	user_agent					varchar(256),
	referer						varchar(256),
	year						char(4)				default to_char(now(), 'YYYY'),
	month						varchar(2)			default to_char(now(), 'MM'),
	day							varchar(2)			default to_char(now(), 'DD'),
	year_week					varchar(2)			default to_char(now(), 'WW'),
	week						varchar(2)			default to_char(now(), 'W'),
	hour						varchar(2)			default to_char(now(), 'HH24'),
	minute						varchar(2)			default to_char(now(), 'MI'),
	insert_date					timestamp with time zone			default now(),
	constraint access_log_pk primary key (access_log_id)	
);


comment on table access_log is 'Service request history';
comment on column access_log.access_log_id is 'unique number';
comment on column access_log.user_id is 'User ID';
comment on column access_log.user_name is 'username';
comment on column access_log.client_ip is 'Request IP';
comment on column access_log.request_uri is 'URI';
comment on column access_log.parameters is 'Request Paramter';
comment on column access_log.user_agent is 'User-Agent';
comment on column access_log.parameters is 'Referer';
comment on column access_log.year is 'year';
comment on column access_log.month is 'month';
comment on column access_log.day is 'day';
comment on column access_log.year_week is 'a few weeks of the year';
comment on column access_log.week is 'several weeks this month';
comment on column access_log.hour is 'Time';
comment on column access_log.minute is 'minutes';
comment on column access_log.insert_date is 'Registered Date';


create table access_log_2018 (
	check ( insert_date >= to_timestamp('20180101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20181231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (access_log);
create table access_log_2019 (
	check ( insert_date >= to_timestamp('20190101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20191231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (access_log);
create table access_log_2020 (
	check ( insert_date >= to_timestamp('20200101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20201231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (access_log);
create table access_log_2021 (
	check ( insert_date >= to_timestamp('20210101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20211231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (access_log);
create table access_log_2022 (
	check ( insert_date >= to_timestamp('20220101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20221231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (access_log);
create table access_log_2023 (
	check ( insert_date >= to_timestamp('20230101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20231231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (access_log);
create table access_log_2024 (
	check ( insert_date >= to_timestamp('20240101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20241231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (access_log);
create table access_log_2025 (
	check ( insert_date >= to_timestamp('20250101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20251231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (access_log);
create table access_log_2026 (
	check ( insert_date >= to_timestamp('20260101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20261231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (access_log);
create table access_log_2027 (
	check ( insert_date >= to_timestamp('20270101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20271231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (access_log);
create table access_log_2028 (
	check ( insert_date >= to_timestamp('20280101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20281231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (access_log);
create table access_log_2029 (
	check ( insert_date >= to_timestamp('20290101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20291231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (access_log);
create table access_log_2030 (
	check ( insert_date >= to_timestamp('20300101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20301231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (access_log);
create table access_log_2031 (
	check ( insert_date >= to_timestamp('20310101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20311231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (access_log);

alter table only access_log_2018 add constraint access_log_2018_pk primary key (access_log_id);
alter table only access_log_2019 add constraint access_log_2019_pk primary key (access_log_id);
alter table only access_log_2020 add constraint access_log_2020_pk primary key (access_log_id);
alter table only access_log_2021 add constraint access_log_2021_pk primary key (access_log_id);
alter table only access_log_2022 add constraint access_log_2022_pk primary key (access_log_id);
alter table only access_log_2023 add constraint access_log_2023_pk primary key (access_log_id);
alter table only access_log_2024 add constraint access_log_2024_pk primary key (access_log_id);
alter table only access_log_2025 add constraint access_log_2025_pk primary key (access_log_id);
alter table only access_log_2026 add constraint access_log_2026_pk primary key (access_log_id);
alter table only access_log_2027 add constraint access_log_2027_pk primary key (access_log_id);
alter table only access_log_2028 add constraint access_log_2028_pk primary key (access_log_id);
alter table only access_log_2029 add constraint access_log_2029_pk primary key (access_log_id);
alter table only access_log_2030 add constraint access_log_2030_pk primary key (access_log_id);
alter table only access_log_2031 add constraint access_log_2031_pk primary key (access_log_id);