drop table if exists schedule_log cascade;
drop table if exists schedule_detail_log cascade;
drop table if exists schedule cascade;

-- schedule
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

comment on table schedule is 'schedule';
comment on column schedule.schedule_id is 'unique number';
comment on column schedule.schedule_name is 'schedule name';
comment on column schedule.schedule_code is 'Schedule KEY';
comment on column schedule.expression is 'Schedule execution Quartz expression';
comment on column schedule.use_yn is 'Use, Y: Use, N: Do not use';
comment on column schedule.start_date is 'start time';
comment on column schedule.end_date is 'End time';
comment on column schedule.user_id is 'Subscriber ID';
comment on column schedule.execute_type is 'Executor, 0: WEB';
comment on column schedule.description is 'Description';
comment on column schedule.insert_date is 'Registered Date';

-- Schedule execution history
create table schedule_log(
	schedule_log_id				bigint,
	schedule_id					bigint 				not null,
	execute_result				char(1)				not null,
	execute_total_count			int									default 0,
	execute_message				varchar(1000)		not null,
	insert_date				timestamp with time zone			default now(),
	constraint schedule_log_pk primary key (schedule_log_id)	
);

comment on table schedule_log is 'schedule execution history';
comment on column schedule_log.schedule_log_id is 'Schedule execution history unique number';
comment on column schedule_log.schedule_id is 'Schedule unique number';
comment on column schedule_log.execute_result is' The entire result of running the schedule. 0: Success, 1: Failure, 2: Partial success';
comment on column schedule_log.execute_total_count is 'Total number of schedule runs';
comment on column schedule_log.execute_message is 'Details of schedule execution result';
comment on column schedule_log.insert_date is 'Registered Date';

-- Detailed history of schedule execution
create table schedule_detail_log(
	schedule_detail_log_id		bigint,
	schedule_log_id				bigint 				not null,
	execute_detail_result		char(1)				not null,
	execute_detail_message		varchar(1000)		not null,
	insert_date				timestamp with time zone			default now(),
	constraint schedule_detail_log_pk primary key (schedule_detail_log_id)	
);

comment on table schedule_detail_log is 'Detailed history of schedule execution';
comment on column schedule_detail_log.schedule_detail_log_id is 'Schedule execution detail history unique number';
comment on column schedule_detail_log.schedule_log_id is 'Schedule execution history unique number';
comment on column schedule_detail_log.execute_detail_result is' Execution result. 0: success, 1: failure ';
comment on column schedule_detail_log.execute_detail_message is 'Execution result details';
comment on column schedule_detail_log.insert_date is 'Registered Date';
