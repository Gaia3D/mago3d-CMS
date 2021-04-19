drop table if exists issue cascade;
drop table if exists issue_detail cascade;
drop table if exists issue_comment cascade;
drop table if exists issue_file cascade;
drop table if exists issue_people cascade;

-- 이슈
create table issue (
	issue_id					bigint,
	data_group_id				integer							not null,
	data_id						bigint							not null,
	data_key 					varchar(128) 					not null,
	object_key 					varchar(256),
	
	user_id						varchar(32)	 					not null,
	title						varchar(300)					not null,
	priority					varchar(30),
	due_date					timestamp with time zone,
	issue_type					varchar(30),
	status						varchar(20),
	location 					GEOMETRY(Point, 4326),
	altitude					numeric(13,7),
	
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

comment on table issue is '이슈';
comment on column issue.issue_id is '고유번호';
comment on column issue.data_group_id is '데이터 그룹 고유 번호';
comment on column issue.data_id is '데이터 고유 번호';
comment on column issue.data_key is 'Data key';
comment on column issue.object_key is 'Object key';

comment on column issue.user_id is '사용자 아이디';
comment on column issue.title is '이슈명';
comment on column issue.priority is '우선순위. common_code 동적 생성';
comment on column issue.due_date is '예정일. 마감일';
comment on column issue.issue_type is '이슈 유형. common_code 동적 생성';
comment on column issue.status is '상태. 등록 : insert, 진행중 : process, 완료 : complete, reject : 반려';
comment on column issue.location is 'location(위도, 경도)';
comment on column issue.altitude is '높이';

comment on column issue.year is '년';
comment on column issue.month is '월';
comment on column issue.day is '일';
comment on column issue.year_week is '일년중 몇주';
comment on column issue.week is '이번달 몇주';
comment on column issue.hour is '시간';
comment on column issue.minute is '분';

comment on column issue.client_ip is '요청 IP';
comment on column issue.update_date is '수정일';
comment on column issue.insert_date is '등록일';

-- 이슈 상세
create table issue_detail (
	issue_detail_id				bigint,
	issue_id					bigint 								not null,
	contents					text								not null,
	insert_date					timestamp with time zone			default now(),
	constraint issue_detail_pk 	primary key (issue_detail_id)	
);

comment on table issue_detail is '이슈 상세';
comment on column issue_detail.issue_detail_id is '이슈 상세 고유번호';
comment on column issue_detail.issue_id is '이슈 고유번호';
comment on column issue_detail.contents is '내용';
comment on column issue.insert_date is '등록일';
