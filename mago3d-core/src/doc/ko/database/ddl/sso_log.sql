drop table if exists sso_log cascade;


-- SSO 이력
create table sso_log (
	sso_log_id 			bigint,
  	user_id 			varchar(30) 		not null, 
  	server_ip 			varchar(45) 		not null,
  	device_kind			varchar(1),
	request_type 		varchar(60),
  	token				varchar(256),
	token_status 		char(1) 			default '0',
	redirect_url		varchar(256),
  	update_date 		timestamp without time zone,
	year				char(4)				default to_char(now(), 'YYYY'),
	month				varchar(2)			default to_char(now(), 'MM'),
	day					varchar(2)			default to_char(now(), 'DD'),
	year_week			varchar(2)			default to_char(now(), 'WW'),
	week				varchar(2)			default to_char(now(), 'W'),
	hour				varchar(2)			default to_char(now(), 'HH24'),
	minute				varchar(2)			default to_char(now(), 'MI'),
	insert_date				timestamp without time zone			default now(),
  	constraint sso_log_pk primary key (sso_log_id)
);


comment on table sso_log is 'SSO 로그';
comment on column sso_log.sso_log_id is '고유키';
comment on column sso_log.user_id is '사용자 아이디';
comment on column sso_log.server_ip is '서버 ip';
comment on column sso_log.device_kind is '사용 매체( 0 : 웹, 1 : 기타)';
comment on column sso_log.request_type is '관리자 요청 : ADMIN_REQUEST, 사용자 요청 : USER_REQUEST';
comment on column sso_log.token is '토큰';
comment on column sso_log.token_status is '토큰 상태. 0 : 생성, 1 : 인증성공, 2 : 실패, 3 : 시간만료';
comment on column sso_log.redirect_url is 'SSO 인증 후 이동할 URL';
comment on column sso_log.update_date is '수정일';
comment on column sso_log.year is '년';
comment on column sso_log.month is '월';
comment on column sso_log.day is '일';
comment on column sso_log.year_week is '일년중 몇주';
comment on column sso_log.week is '이번달 몇주';
comment on column sso_log.hour is '시간';
comment on column sso_log.minute is '분';
comment on column sso_log.insert_date is '등록일';
