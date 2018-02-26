drop table if exists sso_log cascade;


-- SSO履歴
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


comment on table sso_log is 'SSOログ';
comment on column sso_log.sso_log_id is '固有のキー';
comment on column sso_log.user_id is 'ユーザID';
comment on column sso_log.server_ip is 'サーバーip';
comment on column sso_log.device_kind is 'を使用媒体(0：ウェブ、1：その他)';
comment on column sso_log.request_type is '管理者の要求：ADMIN_REQUEST、ユーザの要求：USER_REQUEST';
comment on column sso_log.token is 'トークン';
comment on column sso_log.token_status is 'トークンの状態。 0：作成、1：認証成功、2：失敗すると、3：タイムアウト';
comment on column sso_log.redirect_url is 'SSO認証後移動先のURL';
comment on column sso_log.update_date is '更新日';
comment on column sso_log.year is '年';
comment on column sso_log.month is '月';
comment on column sso_log.day is 'である';
comment on column sso_log.year_week is '今年の数週間';
comment on column sso_log.week is '今月数週間';
comment on column sso_log.hour is '時間';
comment on column sso_log.minute is '分';
comment on column sso_log.insert_date is '登録';
