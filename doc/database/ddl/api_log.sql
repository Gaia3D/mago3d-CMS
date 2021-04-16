drop table if exists api_log cascade;
drop table if exists api_log_2021 cascade;
commit;


-- API 호출 이력
create table api_log(
	api_log_id					bigint,
	service_code				varchar(100),
	service_name				varchar(100),
	client_ip					varchar(45)			not null,
	client_server_name			varchar(30),
    request_uri					varchar(256)		not null,
    status_code					int,
	api_key						varchar(256),
	device_kind					varchar(1),
	request_type 				varchar(20),
	user_id						varchar(32),
	user_ip						varchar(45),
	phone						varchar(256),
	email						varchar(256),
	messenger					varchar(256),
	success_yn					char(1),
	business_success_yn			char(1),
	result_message				varchar(1000),
	business_result_message		varchar(1000),
	insert_date				timestamp 			with time zone			default now()
) partition by range(insert_date);

comment on table api_log is 'API 호출 이력';
comment on column api_log.api_log_id is '고유키';
comment on column api_log.service_code is 'API 코드';
comment on column api_log.service_name is 'API 이름 ';
comment on column api_log.client_ip is '서비스 제공을 요청한 Client IP';
comment on column api_log.client_server_name is '서비스 제공을 요청한 서버명';
comment on column api_log.request_uri is '요청 uri';
comment on column api_log.status_code is 'http 상태코드';
comment on column api_log.api_key is 'API KEY';
comment on column api_log.device_kind is '사용 매체( 0 : 웹, 1 : 기타)';
comment on column api_log.request_type is '서비스 요청 타입. 인증 : ADMIN_PASSWORD, 테스트 : ADMIN_TEST, 로그인 : ADMIN_LOGIN, 테스트 : USER_TEST, 로그인 : USER_LOGIN, 외부 : API';
comment on column api_log.user_id is '사용자 아이디';
comment on column api_log.user_ip is '사용자 IP';
comment on column api_log.phone is '전화번호';
comment on column api_log.email is 'email';
comment on column api_log.messenger is '메신저';
comment on column api_log.success_yn is 'API 호출 성공 유무( Y : 성공, N : 실패 )';
comment on column api_log.business_success_yn is '업무 예외 발생 유무(오류가 발생했지만 무시해도 되는 경우, Y : 성공, N : 실패)';
comment on column api_log.result_message is '서비스 호출 메시지';
comment on column api_log.business_result_message is '업무 호출 메시지';
comment on column api_log.insert_date is '등록일';

create table api_log_2021 partition of api_log for values from ('2021-01-01 00:00:00.000000') to ('2022-01-01 00:00:00.000000');