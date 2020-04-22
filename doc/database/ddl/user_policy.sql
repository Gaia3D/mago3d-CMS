drop table if exists user_policy cascade;

create table user_policy (
	user_policy_id				integer,
	user_id						varchar(32)			not null,
	base_layers					text,
	init_latitude				varchar(30)			default '37.521168',
	init_longitude				varchar(30)			default '126.924185',
	init_altitude				varchar(30)			default '3000.0',
	init_duration				integer				default 3,
	init_default_fov			numeric(3,2)		default 0,
	lod0						varchar(20)			default '15',
	lod1						varchar(20)			default '60',
	lod2						varchar(20)			default '90',
	lod3						varchar(20)			default '200',
	lod4						varchar(20)			default '1000',
	lod5						varchar(20)			default '50000',
	ssao_radius					numeric(8,2)		default  0.15,
	update_date					timestamp with time zone,
	insert_date					timestamp with time zone		default now(),
	constraint user_policy_pk	primary key (user_policy_id)
);

comment on table user_policy is '사용자 설정';
comment on column user_policy.user_policy_id is '고유번호';
comment on column user_policy.init_latitude is '초기 카메라 이동 위도';
comment on column user_policy.init_longitude is '초기 카메라 이동 경도';
comment on column user_policy.init_altitude is '초기 카메라 이동 높이';
comment on column user_policy.init_duration is '초기 카메라 이동 시간. 초 단위';
comment on column user_policy.init_default_fov is 'field of view. 기본값 0(1.8 적용)';
comment on column user_policy.lod0 is 'lod0';
comment on column user_policy.lod1 is 'lod1';
comment on column user_policy.lod2 is 'lod2';
comment on column user_policy.lod3 is 'lod3';
comment on column user_policy.lod4 is 'lod4';
comment on column user_policy.lod5 is 'lod5';
comment on column user_policy.ssao_radius is '그림자 반경';
comment on column user_policy.update_date is '수정일';
comment on column user_policy.insert_date is '등록일';


