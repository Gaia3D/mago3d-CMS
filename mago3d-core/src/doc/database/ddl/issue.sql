drop table if exists issue cascade;
drop table if exists issue_detail cascade;
drop table if exists issue_comment cascade;
drop table if exists issue_info cascade;

-- 이슈
create table issue (
	issue_id					bigint			not null,
	title						varchar(4000)		not null,
	user_id						varchar(32)	 		not null,
	user_name					varchar(64)			not null,
	start_date					timestamp without time zone,
	end_date					timestamp without time zone,
	use_yn						char(1)				default 'Y',
	client_ip					varchar(45)			not null,
	view_count					bigint				default '0',
	insert_date				timestamp without time zone			default now(),
	constraint issue_pk primary key (issue_id)	
);

comment on table issue is '이슈';
comment on column issue.issue_id is '고유번호';
comment on column issue.title is '제목';
comment on column issue.user_id is '사용자 아이디';
comment on column issue.user_name is '사용자 이름';
comment on column issue.start_date is '게시 시작시간';
comment on column issue.end_date is '게시 종료시간';
comment on column issue.use_yn is '사용유무, Y : 사용, N : 사용안함';
comment on column issue.client_ip is '요청 IP';
comment on column issue.view_count is '조회수';
comment on column issue.insert_date is '등록일';

-- 이슈 상세
create table issue_detail (
	issue_detail_id			bigint			not null,
	issue_id				bigint 			not null,
	contents				varchar(4000)		not null,
	insert_date				timestamp without time zone			default now(),
	constraint issue_detail_pk primary key (issue_detail_id)	
);

comment on table issue_detail is '이슈 상세';
comment on column issue_detail.issue_id is '게시판 고유번호';
comment on column issue_detail.contents is '내용';
comment on column issue.insert_date is '등록일';

-- 이슈 파일
create table issue_file(
	issue_file_id				bigint			not null,
	user_id						varchar(32)	 		not null,
	job_type					varchar(50)			not null,
	file_name					varchar(100)		not null,
	file_real_name				varchar(100)		not null,
	file_path					varchar(256)		not null,
	file_size					varchar(12)			not null,
	file_ext					varchar(10)			not null,
	insert_date				timestamp without time zone			default now(),
	constraint issue_file_pk primary key (issue_file_id)	
);

comment on table issue_file is '이슈 파일 관리';
comment on column issue_file.issue_file_id is '고유번호';
comment on column issue_file.user_id is '사용자 아이디';
comment on column issue_file.job_type is '업무 타입';
comment on column issue_file.file_name is '파일 이름';
comment on column issue_file.file_real_name is '파일 실제 이름';
comment on column issue_file.file_path is '파일 경로';
comment on column issue_file.file_size is '파일 사이즈';
comment on column issue_file.file_ext is '파일 확장자';
comment on column issue_file.insert_date is '등록일';

-- 이슈 댓글(Comment)
create table issue_comment (
	issue_comment_id			bigint 			not null,
	issue_id					bigint			not null,
	user_id						varchar(32)	 		not null,
	comment						varchar(4000)		not null,
	client_ip					varchar(45)			not null,
	insert_date				timestamp without time zone			default now(),
	constraint issue_comment_pk primary key (issue_comment_id)	
);

comment on table issue_comment is '이슈 댓글(Comment)';
comment on column issue_comment.issue_comment_id is '고유번호';
comment on column issue_comment.issue_id is '게시판 고유번호';
comment on column issue_comment.user_id is '사용자 아이디';
comment on column issue_comment.comment is '댓글(Comment)';
comment on column issue_comment.client_ip is '요청 IP';
comment on column issue_comment.insert_date is '등록일';
