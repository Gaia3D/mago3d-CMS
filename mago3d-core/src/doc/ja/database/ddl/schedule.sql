drop table if exists schedule_log cascade;
drop table if exists schedule_detail_log cascade;
drop table if exists schedule cascade;

-- スケジュール
create table schedule(
	schedule_id					bigint,
	schedule_name				varchar(100)		not null,
	schedule_code				varchar(30)			not null,
	expression					varchar(50),
	use_yn						char(1)				default 'Y',
	start_date					timestamp with time zone,
	end_date					timestamp with time zone,
	user_id						varchar(32),
	execute_type				char(1)				default '0',
	description					varchar(256),
	insert_date				timestamp with time zone			default now(),
	constraint schedule_pk primary key (schedule_id)	
);

comment on table schedule is 'スケジュール';
comment on column schedule.schedule_id is '固有番号';
comment on column schedule.schedule_name is 'スケジュール名';
comment on column schedule.schedule_code is 'スケジュールKEY';
comment on column schedule.expression is 'のスケジュール実行Quartz式';
comment on column schedule.use_yn is 'を使用の有無、Y：使用すると、N：を無効にする';
comment on column schedule.start_date is '開始時間';
comment on column schedule.end_date is '終了時間';
comment on column schedule.user_id is '登録者名';
comment on column schedule.execute_type is '実行主体、0：WEB';
comment on column schedule.description is 'の説明';
comment on column schedule.insert_date is '登録';


-- スケジュール実行履歴
create table schedule_log(
	schedule_log_id				bigint,
	schedule_id					bigint 				not null,
	execute_result				char(1)				not null,
	execute_total_count			int									default 0,
	execute_message				varchar(1000)		not null,
	insert_date				timestamp with time zone			default now(),
	constraint schedule_log_pk primary key (schedule_log_id)	
);

comment on table schedule_log is 'スケジュールの実行履歴';
comment on column schedule_log.schedule_log_id is 'のスケジュール実行履歴一意の番号';
comment on column schedule_log.schedule_id is 'スケジュール固有番号';
comment on column schedule_log.execute_result is 'のスケジュール実行全体の結果。0：成功、1：失敗すると、2：部分成功';
comment on column schedule_log.execute_total_count is 'のスケジュール実行の合計件数';
comment on column schedule_log.execute_message is 'スケジュールの実行結果詳細';
comment on column schedule_log.insert_date is '登録';

-- スケジュール実行の詳細履歴
create table schedule_detail_log(
	schedule_detail_log_id		bigint,
	schedule_log_id				bigint 				not null,
	execute_detail_result		char(1)				not null,
	execute_detail_message		varchar(1000)		not null,
	insert_date				timestamp with time zone			default now(),
	constraint schedule_detail_log_pk primary key (schedule_detail_log_id)	
);

comment on table schedule_detail_log is 'のスケジュール実行の詳細履歴';
comment on column schedule_detail_log.schedule_detail_log_id is 'のスケジュール実行の詳細履歴一意の番号';
comment on column schedule_detail_log.schedule_log_id is 'のスケジュール実行履歴一意の番号';
comment on column schedule_detail_log.execute_detail_result is 'の実行結果。0：成功、1：失敗';
comment on column schedule_detail_log.execute_detail_message is 'の実行結果詳細';
comment on column schedule_detail_log.insert_date is '登録日';
