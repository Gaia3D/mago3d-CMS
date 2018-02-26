drop table if exists api_log cascade;
drop table if exists external_service cascade;

-- API呼び出し履歴
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

comment on table api_log is 'のAPI呼び出し履歴';
comment on column api_log.api_log_id is '固有のキー';
comment on column api_log.service_code is'APIコード';
comment on column api_log.service_name is 'API名';
comment on column api_log.client_ip is 'サービスの提供を要求されたClient IP';
comment on column api_log.client_server_name is 'サービスの提供を要求されたサーバ名';
comment on column api_log.api_key is 'API KEY ';
comment on column api_log.device_kind is 'を使用媒体(0：ウェブ、1：その他)';
comment on column api_log.request_type is 'サービス要求タイプ。認証：ADMIN_PASSWORD、テスト：ADMIN_TEST、ログイン：ADMIN_LOGIN、テスト：USER_TEST、ログイン：USER_LOGIN、外部：API ';
comment on column api_log.user_id is 'ユーザID';
comment on column api_log.user_ip is 'ユーザーIP ';
comment on column api_log.data_count is 'データ件数 ';
comment on column api_log.data_delimiter is 'デオト区切り文字 ';
comment on column api_log.phone is '電話番号';
comment on column api_log.email is 'email';
comment on column api_log.messanger is 'メッセンジャー';
comment on column api_log.field1 is '臨時フィールド1';
comment on column api_log.field2 is '臨時フィールド2';
comment on column api_log.field3 is '一時フィールド3';
comment on column api_log.field4 is '臨時フィールド4';
comment on column api_log.field5 is '臨時フィールド5';
comment on column api_log.success_yn is 'のAPI呼び出しに成功有無(Y：成功、N：失敗)';
comment on column api_log.business_success_yn is '業務例外発生の有無(エラーが発生しましたが、無視してもされている場合には、Y：成功、N：失敗)';
comment on column api_log.result_message is 'サービス呼び出しメッセージ';
comment on column api_log.business_result_message is '業務呼び出しメッセージ';
comment on column api_log.result_value1 is 'の結果値1';
comment on column api_log.result_value2 is 'の結果値2';
comment on column api_log.result_value3 is 'の結果値3';
comment on column api_log.result_value4 is 'の結果値4';
comment on column api_log.result_value5 is 'の結果値5';
comment on column api_log.insert_date is '登録';


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


-- プライベートAPI
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
comment on column external_service.external_service_id is '固有のキー';
comment on column external_service.service_code is 'サービスコード';
comment on column external_service.service_name is 'サービス名';
comment on column external_service.service_type is 'サービスの種類。 0：Cache(キャッシュReload)';
comment on column external_service.server_ip is 'サーバーのIP';
comment on column external_service.api_key is 'API KEY';
comment on column external_service.url_scheme is '使用するプロトコル';
comment on column external_service.url_host is 'ホスト';
comment on column external_service.url_port is 'ポート';
comment on column external_service.url_path is '経路、リソースの場所';
comment on column external_service.status is '状態。 0：使用すると、1：未使用';
comment on column external_service.default_yn is 'の削除不可、Y：基本、N：選択';
comment on column external_service.description is 'の説明';
comment on column external_service.extra_key1 is 'の余分キー1';
comment on column external_service.extra_key2 is 'の余分キー2';
comment on column external_service.extra_key3 is 'の余分キー3';
comment on column external_service.extra_value1 is 'の余分キーの値1';
comment on column external_service.extra_value2 is 'の余分キーの値2';
comment on column external_service.extra_value3 is 'の余分キーの値の3';
comment on column external_service.insert_date is '登録';
