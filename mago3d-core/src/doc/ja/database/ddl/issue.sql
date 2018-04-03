drop table if exists issue cascade;
drop table if exists issue_detail cascade;
drop table if exists issue_comment cascade;
drop table if exists issue_file cascade;
drop table if exists issue_people cascade;

-- 問題
create table issue (
	issue_id					bigint,
	project_id					int			not null,
	user_id						varchar(32)	 		not null,
	
	title						varchar(300)		not null,
	priority					varchar(30),
	due_date					timestamp without 	time zone,
	issue_type					varchar(30),
	status						varchar(30),
	
	data_key 					varchar(128) 		NOT NULL,
	object_key 					varchar(256),
	location 					geography(Point,4326),
	latitude					numeric(13,10),
	longitude					numeric(13,10),
	height						numeric(7,3),
	
	year						char(4)				default to_char(now(), 'YYYY'),
	month						varchar(2)			default to_char(now(), 'MM'),
	day							varchar(2)			default to_char(now(), 'DD'),
	year_week					varchar(2)			default to_char(now(), 'WW'),
	week						varchar(2)			default to_char(now(), 'W'),
	hour						varchar(2)			default to_char(now(), 'HH24'),
	minute						varchar(2)			default to_char(now(), 'MI'),
	
	client_ip					varchar(45)			not null,
	update_date					timestamp with time zone,
	insert_date					timestamp with time zone			default now(),
	constraint issue_pk primary key (issue_id)	
);

comment on table issue is 'イシュー';
comment on column issue.issue_id is '固有番号';
comment on column issue.project_id is 'プロジェクト名';
comment on column issue.user_id is 'ユーザID';
comment on column issue.title is 'イシュー人';
comment on column issue.priority is 'の優先順位。 common_code動的生成';
comment on column issue.due_date is '予定。締め切り';
comment on column issue.issue_type is '問題のタイプ。 common_code動的生成';
comment on column issue.status is '状態。 common_code動的生成';
comment on column issue.data_key is 'Data key';
comment on column issue.object_key is 'Object key';
comment on column issue.location is 'location（緯度、経度';
comment on column issue.latitude is '緯度';
comment on column issue.longitude is '硬度';
comment on column issue.height is '高';
comment on column issue.client_ip is 'リクエストIP';

comment on column access_log.year is '年';
comment on column access_log.month is'月';
comment on column access_log.day is 'である';
comment on column access_log.year_week is '今年の数週間';
comment on column access_log.week is '今月数週間';
comment on column access_log.hour is '時間';
comment on column access_log.minute is '分';

comment on column issue.update_date is '更新日';
comment on column issue.insert_date is '登録';

-- 問題の詳細
create table issue_detail (
	issue_detail_id				bigint,
	issue_id					bigint 					not null,
	contents					text					not null,
	insert_date					timestamp without 		time zone			default now(),
	constraint issue_detail_pk 	primary key (issue_detail_id)	
);

comment on table issue_detail is '問題の詳細';
comment on column issue_detail.issue_detail_id is '問題の詳細固有番号';
comment on column issue_detail.issue_id is '問題固有の番号';
comment on column issue_detail.contents is 'の内容';
comment on column issue.insert_date is '登録';

-- 問題のファイル
create table issue_file(
	issue_file_id				bigint,
	issue_id					bigint 				not null,
	file_name					varchar(100)		not null,
	file_real_name				varchar(100)		not null,
	file_path					varchar(256)		not null,
	file_size					varchar(12)			not null,
	file_ext					varchar(10)			not null,
	insert_date					timestamp without 	time zone			default now(),
	constraint issue_file_pk primary key (issue_file_id)	
);

comment on table issue_file is '問題のファイルの管理';
comment on column issue_file.issue_file_id is '固有番号';
comment on column issue_file.issue_id is '固有番号';
comment on column issue_file.file_name is'ファイル名';
comment on column issue_file.file_real_name is 'ファイル実際の名前';
comment on column issue_file.file_path is 'ファイルのパス';
comment on column issue_file.file_size is 'ファイルサイズ';
comment on column issue_file.file_ext is 'ファイルの拡張子';
comment on column issue_file.insert_date is '登録';

-- 問題のコメント（Comment）
create table issue_comment (
	issue_comment_id			bigint,
	issue_id					bigint				not null,
	user_id						varchar(32)	 		not null,
	comment						varchar(4000)		not null,
	client_ip					varchar(45)			not null,
	insert_date					timestamp with time zone			default now(),
	constraint issue_comment_pk primary key (issue_comment_id)	
);

comment on table issue_comment is '問題コメント(Comment)';
comment on column issue_comment.issue_comment_id is '固有番号';
comment on column issue_comment.issue_id is '問題固有の番号';
comment on column issue_comment.user_id is 'ユーザID';
comment on column issue_comment.comment is 'コメント(Comment)';
comment on column issue_comment.client_ip is 'リクエストIP';
comment on column issue_comment.insert_date is '登録';

-- 問題の関係者
create table issue_people (
	issue_people_id				bigint,
	issue_id					bigint			not null,
	role_type					char(1),
	user_id						varchar(32),
	insert_date					timestamp with time zone			default now(),
	constraint issue_people_pk primary key (issue_people_id)	
);

comment on table issue_people is '問題の関係者';
comment on column issue_people.issue_people_id is '固有番号';
comment on column issue_people.issue_id is '問題固有の番号';
comment on column issue_people.role_type is '問題の関係者のタイプ。1：デリゲート、2：担当者';
comment on column issue_people.user_id is 'ユーザID';
comment on column issue_people.insert_date is '登録';
