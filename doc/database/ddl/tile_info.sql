drop table if exists tile_info cascade;
drop table if exists tile_data_group cascade;
drop table if exists tile_log cascade;

-- 스마트 타일링 정보
create table tile_info(
	tile_id				            integer,
	tile_key				        varchar(60)							not null,
	tile_name				        varchar(100)						not null,
	tile_path				        varchar(256),
	user_id						    varchar(32),
    status							varchar(20)							default 'ready',
	available					    boolean								default true,
	description					    varchar(256),
	update_date					    timestamp with time zone,
	insert_date					    timestamp with time zone			default now(),
	constraint tile_info_pk primary key (tile_id)
);

comment on table tile_info is '스마트 타일링 정보';
comment on column tile_info.tile_id is '스마트 타일링 고유번호';
comment on column tile_info.tile_name is '타일명';
comment on column tile_info.tile_key is '타일 KEY';
comment on column tile_info.tile_path is '스마트 타일 경로';
comment on column tile_info.user_id is '사용자 아이디';
comment on column tile_info.status is '상태. ready : 준비, success : 성공, waiting : 승인대기, fail : 실패';
comment on column tile_info.available is 'true : 사용, false : 사용안함';
comment on column tile_info.description is '설명';
comment on column tile_info.update_date is '수정일';
comment on column tile_info.insert_date is '등록일';


-- 스마트 타일링 정보
create table tile_data_group(
    tile_data_group_id			bigint,
    tile_id				        integer                             not null,
    tile_path				    varchar(256),
    data_group_id               integer                             not null,
    update_date					timestamp with time zone,
    insert_date					timestamp with time zone			default now(),
    constraint tile_data_group_pk primary key (tile_data_group_id)
);

comment on table tile_data_group is '스마트 타일링 데이터 그룹 정보';
comment on column tile_data_group.tile_data_group_id is '스마트 타일링 데이터 그룹 고유번호';
comment on column tile_data_group.tile_id is '스마트 타일링 고유번호';
comment on column tile_data_group.data_group_id is '데이터 그룹 고유번호';
comment on column tile_data_group.tile_path is '스마트 타일 경로(중복. Join)';
comment on column tile_data_group.update_date is '수정일';
comment on column tile_data_group.insert_date is '등록일';


-- 타일링 정보 생성 이력
create table tile_log(
    tile_log_id				            bigint,
    tile_id				                integer                             not null,
    user_id						        varchar(32)	 		                not null,
    status						        varchar(20)			                default 'ready',
    file_real_name				        varchar(100)					    not null,
    file_path					        varchar(256)					    not null,
    year						        char(4)				                default to_char(now(), 'YYYY'),
    month						        varchar(2)			                default to_char(now(), 'MM'),
    day							        varchar(2)			                default to_char(now(), 'DD'),
    year_week					        varchar(2)			                default to_char(now(), 'WW'),
    week						        varchar(2)			                default to_char(now(), 'W'),
    hour						        varchar(2)			                default to_char(now(), 'HH24'),
    minute						        varchar(2)			                default to_char(now(), 'MI'),
    update_date					        timestamp with time zone,
    insert_date					        timestamp with time zone			default now(),
    constraint tile_log_pk primary key (tile_log_id)
);

comment on table tile_log is '타일링 정보 생성 이력';
comment on column tile_log.tile_log_id is '타일링 정보 생성 이력 고유번호';
comment on column tile_log.user_id is '사용자 아이디';
comment on column tile_log.status is '상태. ready : 준비, success : 성공, waiting : 승인대기, fail : 실패';
comment on column tile_log.year is '년';
comment on column tile_log.month is '월';
comment on column tile_log.day is '일';
comment on column tile_log.year_week is '일년중 몇주';
comment on column tile_log.week is '이번달 몇주';
comment on column tile_log.hour is '시간';
comment on column tile_log.minute is '분';
comment on column tile_log.update_date is '수정일';
comment on column tile_log.insert_date is '등록일';




















