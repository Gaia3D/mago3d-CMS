drop table if exists tn_civil_voice cascade;
drop table if exists tn_civil_voice_comment cascade;

-- 시민참여. 실 서비스에서는 파티션으로 전환해야 함
create table tn_civil_voice (
	civil_voice_id 		bigint,
	user_id				varchar(32)						not null,
	user_ip 			varchar(45),
	title				varchar(256)					not null,
	content				text,
	location		 	GEOMETRY(POINT, 4326),
	heit				numeric(13,7),
	use_yn				boolean							default true,
	view_count			bigint							default 0,
	comment_count		bigint							default 0,
	year				char(4)							default to_char(now(), 'YYYY'),
	month				varchar(2)						default to_char(now(), 'MM'),
	day					varchar(2)						default to_char(now(), 'DD'),
	year_week			varchar(2)						default to_char(now(), 'WW'),
	week				varchar(2)						default to_char(now(), 'W'),
	hour				varchar(2)						default to_char(now(), 'HH24'),
	minute				varchar(2)						default to_char(now(), 'MI'),
	sido_cd				varchar(2),
	sgg_cd				varchar(5),
	emd_cd				varchar(8),
	update_dt			timestamp with time zone,
	regist_dt			timestamp with time zone		default now(),
	constraint tn_civil_voice_pk 	primary key (civil_voice_id)
);

comment on table tn_civil_voice is '시민참여';
comment on column tn_civil_voice.civil_voice_id is '고유번호';
comment on column tn_civil_voice.user_id is '사용자 아이디';
comment on column tn_civil_voice.user_ip is '사용자 IP';
comment on column tn_civil_voice.title is '제목';
comment on column tn_civil_voice.content is '내용';
comment on column tn_civil_voice.location is '위치 Point. 분석에 용이';
comment on column tn_civil_voice.heit is '높이';
comment on column tn_civil_voice.use_yn is '사용유무, true : 사용, false : 사용안함';
comment on column tn_civil_voice.view_count is '조회수';
comment on column tn_civil_voice.view_count is '댓글수';
comment on column tn_civil_voice.year is '년';
comment on column tn_civil_voice.month is '월';
comment on column tn_civil_voice.day is '일';
comment on column tn_civil_voice.year_week is '일년중 몇주';
comment on column tn_civil_voice.week is '이번달 몇주';
comment on column tn_civil_voice.hour is '시간';
comment on column tn_civil_voice.minute is '분';
comment on column tn_civil_voice.sido_cd is '시도 코드';
comment on column tn_civil_voice.sgg_cd is '시군구 코드';
comment on column tn_civil_voice.emd_cd is '읍면동 코드';
comment on column tn_civil_voice.update_dt is '수정일';
comment on column tn_civil_voice.regist_dt is '등록일';

-- 시민참여 Comment. 실 서비스에서는 파티션으로 전환해야 함
create table tn_civil_voice_comment (
	civil_voice_comment_id		bigint,
	civil_voice_id 					bigint,
	user_id					varchar(32)						not null,
	user_ip 				varchar(45),
	title					varchar(256)					not null,
	year					char(4)							default to_char(now(), 'YYYY'),
	month					varchar(2)						default to_char(now(), 'MM'),
	day						varchar(2)						default to_char(now(), 'DD'),
	year_week				varchar(2)						default to_char(now(), 'WW'),
	week					varchar(2)						default to_char(now(), 'W'),
	hour					varchar(2)						default to_char(now(), 'HH24'),
	minute					varchar(2)						default to_char(now(), 'MI'),
	update_dt				timestamp with time zone,
	regist_dt				timestamp with time zone,
	constraint tn_civil_voice_comment_pk 	primary key (civil_voice_comment_id)
);

comment on table tn_civil_voice_comment is '시민참여리 Comment';
comment on column tn_civil_voice_comment.civil_voice_comment_id is '고유번호';
comment on column tn_civil_voice_comment.civil_voice_id is '시민참여 고유번호';
comment on column tn_civil_voice_comment.user_id is 'comment 사용자 아이디';
comment on column tn_civil_voice_comment.user_ip is 'comment 사용자 IP';
comment on column tn_civil_voice_comment.title is 'comment 제목';
comment on column tn_civil_voice_comment.year is '년';
comment on column tn_civil_voice_comment.month is '월';
comment on column tn_civil_voice_comment.day is '일';
comment on column tn_civil_voice_comment.year_week is '일년중 몇주';
comment on column tn_civil_voice_comment.week is '이번달 몇주';
comment on column tn_civil_voice_comment.hour is '시간';
comment on column tn_civil_voice_comment.minute is '분';
comment on column tn_civil_voice_comment.update_dt is '수정일';
comment on column tn_civil_voice_comment.regist_dt is '등록일';


