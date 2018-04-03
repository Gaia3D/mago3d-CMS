drop table if exists sso_log cascade;


-- SSO �̷�
create table sso_log (
	sso_log_id 			bigint,
  	user_id 			varchar(30) 		not null, 
  	server_ip 			varchar(45) 		not null,
  	device_kind			varchar(1),
	request_type 		varchar(60),
  	token				varchar(256),
	token_status 		char(1) 			default '0',
	redirect_url		varchar(256),
  	update_date 		timestamp with time zone,
	year				char(4)				default to_char(now(), 'YYYY'),
	month				varchar(2)			default to_char(now(), 'MM'),
	day					varchar(2)			default to_char(now(), 'DD'),
	year_week			varchar(2)			default to_char(now(), 'WW'),
	week				varchar(2)			default to_char(now(), 'W'),
	hour				varchar(2)			default to_char(now(), 'HH24'),
	minute				varchar(2)			default to_char(now(), 'MI'),
	insert_date				timestamp with time zone			default now(),
  	constraint sso_log_pk primary key (sso_log_id)
);


comment on table sso_log is 'SSO �α�';
comment on column sso_log.sso_log_id is '����Ű';
comment on column sso_log.user_id is '����� ���̵�';
comment on column sso_log.server_ip is '���� ip';
comment on column sso_log.device_kind is '��� ��ü( 0 : ��, 1 : ��Ÿ)';
comment on column sso_log.request_type is '������ ��û : ADMIN_REQUEST, ����� ��û : USER_REQUEST';
comment on column sso_log.token is '��ū';
comment on column sso_log.token_status is '��ū ����. 0 : ����, 1 : ��������, 2 : ����, 3 : �ð�����';
comment on column sso_log.redirect_url is 'SSO ���� �� �̵��� URL';
comment on column sso_log.update_date is '������';
comment on column sso_log.year is '��';
comment on column sso_log.month is '��';
comment on column sso_log.day is '��';
comment on column sso_log.year_week is '�ϳ��� ����';
comment on column sso_log.week is '�̹��� ����';
comment on column sso_log.hour is '�ð�';
comment on column sso_log.minute is '��';
comment on column sso_log.insert_date is '�����';
