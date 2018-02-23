drop table if exists api_log cascade;
drop table if exists external_service cascade;

-- API 호출 이력
create table api_log(
	api_log_id					bigint,
	service_code				varchar(100)		not null,
	service_name				varchar(100)		not null,
	client_ip					varchar(45)			not null,
	client_server_name			varchar(30),
	api_key						varchar(256)		not null,
	device_kind					varchar(1)			not null,
	request_type 				varchar(20)			not null,
	user_id						varchar(32),
	user_ip						varchar(45),
	data_count					smallint,
	data_delimiter				varchar(3),
	phone						varchar(256),
	email						varchar(256),
	messanger					varchar(256),
	field1						varchar(256),
	field2						varchar(256),
	field3						varchar(256),
	field4						varchar(256),
	field5						varchar(256),
	success_yn					char(1),
	business_success_yn			char(1),
	result_message				varchar(1000),
	business_result_message		varchar(1000),
	result_value1				varchar(256),
	result_value2				varchar(256),
	result_value3				varchar(256),
	result_value4				varchar(256),
	result_value5				varchar(256),
	insert_date				timestamp without time zone			default now(),
	constraint api_log_pk primary key (api_log_id)	
);

comment on table api_log is 'API 호출 이력';
comment on column api_log.api_log_id is '고유키';
comment on column api_log.service_code is 'API 코드';
comment on column api_log.service_name is 'API 이름 ';
comment on column api_log.client_ip is '서비스 제공을 요청한 Client IP';
comment on column api_log.client_server_name is '서비스 제공을 요청한 서버명';
comment on column api_log.api_key is 'API KEY';
comment on column api_log.device_kind is '사용 매체( 0 : 웹, 1 : 기타)';
comment on column api_log.request_type is '서비스 요청 타입. 인증 : ADMIN_PASSWORD, 테스트 : ADMIN_TEST, 로그인 : ADMIN_LOGIN, 테스트 : USER_TEST, 로그인 : USER_LOGIN, 외부 : API';
comment on column api_log.user_id is '사용자 아이디';
comment on column api_log.user_ip is '사용자 IP';
comment on column api_log.data_count is '데이터 건수';
comment on column api_log.data_delimiter is '데어터 구분자';
comment on column api_log.phone is '전화번호';
comment on column api_log.email is 'email';
comment on column api_log.messanger is '메신저';
comment on column api_log.field1 is '임시 필드1';
comment on column api_log.field2 is '임시 필드2';
comment on column api_log.field3 is '임시 필드3';
comment on column api_log.field4 is '임시 필드4';
comment on column api_log.field5 is '임시 필드5';
comment on column api_log.success_yn is 'API 호출 성공 유무( Y : 성공, N : 실패 )';
comment on column api_log.business_success_yn is '업무 예외 발생 유무(오류가 발생했지만 무시해도 되는 경우, Y : 성공, N : 실패)';
comment on column api_log.result_message is '서비스 호출 메시지';
comment on column api_log.business_result_message is '업무 호출 메시지';
comment on column api_log.result_value1 is '결과 값1';
comment on column api_log.result_value2 is '결과 값2';
comment on column api_log.result_value3 is '결과 값3';
comment on column api_log.result_value4 is '결과 값4';
comment on column api_log.result_value5 is '결과 값5';
comment on column api_log.insert_date is '등록일';


create table api_log_2018 (
	check ( insert_date >= to_timestamp('20180101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20181231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2019 (
	check ( insert_date >= to_timestamp('20190101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20191231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2020 (
	check ( insert_date >= to_timestamp('20200101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20201231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2021 (
	check ( insert_date >= to_timestamp('20210101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20211231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2022 (
	check ( insert_date >= to_timestamp('20220101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20221231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2023 (
	check ( insert_date >= to_timestamp('20230101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20231231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2024 (
	check ( insert_date >= to_timestamp('20240101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20241231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2025 (
	check ( insert_date >= to_timestamp('20250101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20251231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2026 (
	check ( insert_date >= to_timestamp('20260101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20261231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2027 (
	check ( insert_date >= to_timestamp('20270101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20271231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2028 (
	check ( insert_date >= to_timestamp('20280101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20281231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2029 (
	check ( insert_date >= to_timestamp('20290101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20291231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2030 (
	check ( insert_date >= to_timestamp('20300101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20301231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2031 (
	check ( insert_date >= to_timestamp('20310101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20311231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);


alter table only api_log_2018 add constraint api_log_2018_pk primary key (api_log_id);
alter table only api_log_2019 add constraint api_log_2019_pk primary key (api_log_id);
alter table only api_log_2020 add constraint api_log_2020_pk primary key (api_log_id);
alter table only api_log_2021 add constraint api_log_2021_pk primary key (api_log_id);
alter table only api_log_2022 add constraint api_log_2022_pk primary key (api_log_id);
alter table only api_log_2023 add constraint api_log_2023_pk primary key (api_log_id);
alter table only api_log_2024 add constraint api_log_2024_pk primary key (api_log_id);
alter table only api_log_2025 add constraint api_log_2025_pk primary key (api_log_id);
alter table only api_log_2026 add constraint api_log_2026_pk primary key (api_log_id);
alter table only api_log_2027 add constraint api_log_2027_pk primary key (api_log_id);
alter table only api_log_2028 add constraint api_log_2028_pk primary key (api_log_id);
alter table only api_log_2029 add constraint api_log_2029_pk primary key (api_log_id);
alter table only api_log_2030 add constraint api_log_2030_pk primary key (api_log_id);
alter table only api_log_2031 add constraint api_log_2031_pk primary key (api_log_id);


-- Private API
create table external_service (
	external_service_id			bigint,
	service_code				varchar(30)			not null,
	service_name				varchar(60)			not null,
	service_type				char(1)				not null,
	server_ip					varchar(45)			not null,
	api_key						varchar(256)		not null,
	url_scheme					varchar(10)			not null,
	url_host					varchar(256)		not null,
	url_port					int					not null,
	url_path					varchar(256),			
	status						char(1)				default '0',
	default_yn					char(1)				default 'N',
	description					varchar(256),
	extra_key1					varchar(50),
	extra_key2					varchar(50),
	extra_key3					varchar(50),
	extra_value1				varchar(50),
	extra_value2				varchar(50),
	extra_value3				varchar(50),
	insert_date				timestamp without time zone			default now(),
	constraint external_service_pk primary key (external_service_id)	
);

comment on table external_service is 'Private API';
comment on column external_service.external_service_id is '고유키';
comment on column external_service.service_code is '서비스 코드';
comment on column external_service.service_name is '서비스명';
comment on column external_service.service_type is '서비스 유형. 0 : Cache(캐시 Reload)';
comment on column external_service.server_ip is '서버 IP';
comment on column external_service.api_key is 'API KEY';
comment on column external_service.url_scheme is '사용할 프로토콜';
comment on column external_service.url_host is '호스트';
comment on column external_service.url_port is '포트';
comment on column external_service.url_path is '경로, 리소스 위치';
comment on column external_service.status is '상태. 0 : 사용, 1 : 미사용';
comment on column external_service.default_yn is '삭제 불가, Y : 기본, N : 선택';
comment on column external_service.description is '설명';
comment on column external_service.extra_key1 is '여분 키 1';
comment on column external_service.extra_key2 is '여분 키 2';
comment on column external_service.extra_key3 is '여분 키 3';
comment on column external_service.extra_value1 is '여분 키 값 1';
comment on column external_service.extra_value2 is '여분 키 값 2';
comment on column external_service.extra_value3 is '여분 키 값 3';
comment on column external_service.insert_date is '등록일';

