-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists data_adjust_log cascade;
drop table if exists data_adjust_log_2021 cascade;
commit;

-- 데이터 위치 변경 요청 이력
create table data_adjust_log(
	data_adjust_log_id				bigint,
	data_group_id					integer,
	data_id							bigint,
	user_id							varchar(32),
	update_user_id					varchar(32),
	location		 				GEOMETRY(POINT, 4326),
	altitude						numeric(13,7),
	heading							numeric(8,5),
	pitch							numeric(8,5),
	roll							numeric(8,5),
	height_reference				varchar(16)							default 'none',
	before_location					GEOMETRY(POINT, 4326),
	before_altitude					numeric(13,7),
	before_heading					numeric(8,5),
	before_pitch					numeric(8,5),
	before_roll						numeric(8,5),
	before_height_reference			varchar(16)							default 'none',
	status							varchar(30)							default 'request',
	change_type						varchar(30),
	description						varchar(256),
	update_date						timestamp with time zone,
	insert_date						timestamp with time zone			default now()
) partition by range(insert_date);

comment on table data_adjust_log is 'Data geometry 변경 이력 정보';
comment on column data_adjust_log.data_adjust_log_id is '고유번호';
comment on column data_adjust_log.data_group_id is '데이터 그룹 고유번호, join 성능때문에 중복 허용';
comment on column data_adjust_log.data_id is 'Data 고유번호';
comment on column data_adjust_log.user_id is '사용자 아이디';
comment on column data_adjust_log.update_user_id is '수정 요청자 아이디';
comment on column data_adjust_log.location is '위치';
comment on column data_adjust_log.altitude is '높이';
comment on column data_adjust_log.heading is 'heading';
comment on column data_adjust_log.pitch is 'pitch';
comment on column data_adjust_log.roll is 'roll';
comment on column data_adjust_log.height_reference is '높이 설정 방법. none : 해발 고드, clampToGround : Terrain(지형)에 맞춤, relativeToGround : Terrain(지형)으로 부터 높이 설정';
comment on column data_adjust_log.before_location is '변경전 위치';
comment on column data_adjust_log.before_altitude is '변경전 높이';
comment on column data_adjust_log.before_heading is '변경전 heading';
comment on column data_adjust_log.before_pitch is '변경전 pitch';
comment on column data_adjust_log.before_roll is '변경전 roll';
comment on column data_adjust_log.before_height_reference is '이전 높이 설정 방법. none : 해발 고드, clampToGround : Terrain(지형)에 맞춤, relativeToGround : Terrain(지형)으로 부터 높이 설정';
comment on column data_adjust_log.status is '상태. request : 요청, approval : 승인, reject : 기각, rollback : 원복';
comment on column data_adjust_log.change_type is '변경 유형';
comment on column data_adjust_log.description is '설명';
comment on column data_adjust_log.update_date is '수정일';
comment on column data_adjust_log.insert_date is '등록일';


create table data_adjust_log_2021 partition of data_adjust_log for values from ('2021-01-01 00:00:00.000000') to ('2022-01-01 00:00:00.000000');
