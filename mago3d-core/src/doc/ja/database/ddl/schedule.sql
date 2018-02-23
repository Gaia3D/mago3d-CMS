drop table if exists schedule_log cascade;
drop table if exists schedule_detail_log cascade;
drop table if exists schedule cascade;

-- 스케줄
create table schedule(
	schedule_id					bigint,
	schedule_name				varchar(100)		not null,
	schedule_code				varchar(30)			not null,
	expression					varchar(50),
	use_yn						char(1)				default 'Y',
	start_date					timestamp without time zone,
	end_date					timestamp without time zone,
	user_id						varchar(32),
	execute_type				char(1)				default '0',
	description					varchar(256),
	insert_date				timestamp without time zone			default now(),
	constraint schedule_pk primary key (schedule_id)	
);

comment on table schedule is '스케줄';
comment on column schedule.schedule_id is '고유번호';
comment on column schedule.schedule_name is '스케줄명';
comment on column schedule.schedule_code is '스케줄 KEY';
comment on column schedule.expression is '스케줄 실행 Quartz 표현식';
comment on column schedule.use_yn is '사용유무, Y : 사용, N : 사용안함';
comment on column schedule.start_date is '시작 시간';
comment on column schedule.end_date is '종료 시간';
comment on column schedule.user_id is '등록자 아이디';
comment on column schedule.execute_type is '실행 주체, 0 : WEB';
comment on column schedule.description is '설명';
comment on column schedule.insert_date is '등록일';


-- 스케줄 실행 이력
create table schedule_log(
	schedule_log_id				bigint,
	schedule_id					bigint 				not null,
	execute_result				char(1)				not null,
	execute_total_count			int									default 0,
	execute_message				varchar(1000)		not null,
	insert_date				timestamp without time zone			default now(),
	constraint schedule_log_pk primary key (schedule_log_id)	
);

comment on table schedule_log is '스케줄 실행 이력';
comment on column schedule_log.schedule_log_id is '스케줄 실행 이력 고유번호';
comment on column schedule_log.schedule_id is '스케줄 고유번호';
comment on column schedule_log.execute_result is '스케줄 실행 전체 결과. 0 : 성공, 1 : 실패, 2 : 부분성공';
comment on column schedule_log.execute_total_count is '스케줄 실행 총 건수';
comment on column schedule_log.execute_message is '스케줄 실행 결과 상세 내용';
comment on column schedule_log.insert_date is '등록일';

-- 스케줄 실행 상세 이력
create table schedule_detail_log(
	schedule_detail_log_id		bigint,
	schedule_log_id				bigint 				not null,
	execute_detail_result		char(1)				not null,
	execute_detail_message		varchar(1000)		not null,
	insert_date				timestamp without time zone			default now(),
	constraint schedule_detail_log_pk primary key (schedule_detail_log_id)	
);

comment on table schedule_detail_log is '스케줄 실행 상세 이력';
comment on column schedule_detail_log.schedule_detail_log_id is '스케줄 실행 상세 이력 고유번호';
comment on column schedule_detail_log.schedule_log_id is '스케줄 실행 이력 고유번호';
comment on column schedule_detail_log.execute_detail_result is '실행 결과. 0 : 성공, 1 : 실패';
comment on column schedule_detail_log.execute_detail_message is '실행 결과 상세 내용';
comment on column schedule_detail_log.insert_date is '등록일';
