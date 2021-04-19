drop table if exists access_log cascade;
drop table if exists access_log_2020 cascade;
drop table if exists access_log_2021 cascade;
drop table if exists access_log_2022 cascade;
drop table if exists access_log_2023 cascade;
drop table if exists access_log_2024 cascade;
drop table if exists access_log_2025 cascade;
drop table if exists access_log_2026 cascade;
drop table if exists access_log_2027 cascade;
drop table if exists access_log_2028 cascade;
drop table if exists access_log_2029 cascade;
drop table if exists access_log_2030 cascade;
drop table if exists access_log_2031 cascade;
drop table if exists access_log_2032 cascade;
drop table if exists access_log_2033 cascade;
drop table if exists access_log_2034 cascade;
drop table if exists access_log_2035 cascade;
drop table if exists access_log_2036 cascade;
drop table if exists access_log_2037 cascade;
drop table if exists access_log_2038 cascade;
drop table if exists access_log_2039 cascade;
drop table if exists access_log_2040 cascade;
commit;


-- 관리자 페이지 사용 이력
create table access_log(
	access_log_id				bigint,
	user_id						varchar(32)	 		not null,
	user_name					varchar(64),
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
	insert_date					timestamp with time zone			default now()
) partition by range(insert_date);

comment on table access_log is '관리자 페이지 사용 이력';
comment on column access_log.access_log_id is '고유번호';
comment on column access_log.user_id is '사용자 아이디';
comment on column access_log.user_name is '사용자 이름';
comment on column access_log.client_ip is '요청 IP';
comment on column access_log.request_uri is 'URI';
comment on column access_log.parameters is '요청 Paramter';
comment on column access_log.user_agent is 'User-Agent';
comment on column access_log.referer is 'Referer';
comment on column access_log.year is '년';
comment on column access_log.month is '월';
comment on column access_log.day is '일';
comment on column access_log.year_week is '일년중 몇주';
comment on column access_log.week is '이번달 몇주';
comment on column access_log.hour is '시간';
comment on column access_log.minute is '분';
comment on column access_log.insert_date is '등록일';


create table access_log_2020 partition of access_log for values from ('2020-01-01 00:00:00.000000') to ('2021-01-01 00:00:00.000000');
create table access_log_2021 partition of access_log for values from ('2021-01-01 00:00:00.000000') to ('2022-01-01 00:00:00.000000');
create table access_log_2022 partition of access_log for values from ('2022-01-01 00:00:00.000000') to ('2023-01-01 00:00:00.000000');
create table access_log_2023 partition of access_log for values from ('2023-01-01 00:00:00.000000') to ('2024-01-01 00:00:00.000000');
create table access_log_2024 partition of access_log for values from ('2024-01-01 00:00:00.000000') to ('2025-01-01 00:00:00.000000');
create table access_log_2025 partition of access_log for values from ('2025-01-01 00:00:00.000000') to ('2026-01-01 00:00:00.000000');
create table access_log_2026 partition of access_log for values from ('2026-01-01 00:00:00.000000') to ('2027-01-01 00:00:00.000000');
create table access_log_2027 partition of access_log for values from ('2027-01-01 00:00:00.000000') to ('2028-01-01 00:00:00.000000');
create table access_log_2028 partition of access_log for values from ('2028-01-01 00:00:00.000000') to ('2029-01-01 00:00:00.000000');
create table access_log_2029 partition of access_log for values from ('2029-01-01 00:00:00.000000') to ('2030-01-01 00:00:00.000000');
create table access_log_2030 partition of access_log for values from ('2030-01-01 00:00:00.000000') to ('2031-01-01 00:00:00.000000');
create table access_log_2031 partition of access_log for values from ('2031-01-01 00:00:00.000000') to ('2032-01-01 00:00:00.000000');
create table access_log_2032 partition of access_log for values from ('2032-01-01 00:00:00.000000') to ('2033-01-01 00:00:00.000000');
create table access_log_2033 partition of access_log for values from ('2033-01-01 00:00:00.000000') to ('2034-01-01 00:00:00.000000');
create table access_log_2034 partition of access_log for values from ('2034-01-01 00:00:00.000000') to ('2035-01-01 00:00:00.000000');
create table access_log_2035 partition of access_log for values from ('2035-01-01 00:00:00.000000') to ('2036-01-01 00:00:00.000000');
create table access_log_2036 partition of access_log for values from ('2036-01-01 00:00:00.000000') to ('2037-01-01 00:00:00.000000');
create table access_log_2037 partition of access_log for values from ('2037-01-01 00:00:00.000000') to ('2038-01-01 00:00:00.000000');
create table access_log_2038 partition of access_log for values from ('2038-01-01 00:00:00.000000') to ('2039-01-01 00:00:00.000000');
create table access_log_2039 partition of access_log for values from ('2039-01-01 00:00:00.000000') to ('2040-01-01 00:00:00.000000');
create table access_log_2040 partition of access_log for values from ('2040-01-01 00:00:00.000000') to ('2041-01-01 00:00:00.000000');
