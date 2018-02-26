drop table if exists sso_log cascade;

-- SSO history
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


comment on table sso_log is 'SSO log';
comment on column sso_log.sso_log_id is 'unique key';
comment on column sso_log.user_id is 'User ID';
comment on column sso_log.server_ip is 'server ip';
comment on column sso_log.device_kind is 'Used media (0: Web, 1: Other)';
comment on column sso_log.request_type is 'Administrator request: ADMIN_REQUEST, user request: USER_REQUEST';
comment on column sso_log.token is 'token';
comment on column sso_log.token_status is' Token state. 0: generated, 1: authentication succeeded, 2: failed, 3: timeout ';
comment on column sso_log.redirect_url is 'URL to move to after SSO authentication';
comment on column sso_log.update_date is 'Modified';
comment on column sso_log.year is 'year';
comment on column sso_log.month is 'month';
comment on column sso_log.day is 'day';
comment on column sso_log.year_week is 'a few weeks of the year';
comment on column sso_log.week is 'several weeks this month';
comment on column sso_log.hour is 'Time';
comment on column sso_log.minute is 'minutes';
comment on column sso_log.insert_date is 'Registered Date';
