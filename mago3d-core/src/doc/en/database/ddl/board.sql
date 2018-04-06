drop table if exists board cascade;
drop table if exists board_detail cascade;
drop table if exists board_comment cascade;

-- 게시판
create table board (
	board_id					bigint				not null,
	title						varchar(4000)		not null,
	user_id						varchar(32)	 		not null,
	start_date					timestamp with 		time zone,
	end_date					timestamp with 		time zone,
	use_yn						char(1)				default 'Y',
	client_ip					varchar(45)			not null,
	view_count					bigint				default 0,
	insert_date					timestamp 			with time zone			default now(),
	constraint board_pk primary key (board_id)	
);

comment on table board is '게시판';
comment on column board.board_id is '고유번호';
comment on column board.title is '제목';
comment on column board.user_id is '사용자 아이디';
comment on column board.start_date is '게시 시작시간';
comment on column board.end_date is '게시 종료시간';
comment on column board.use_yn is '사용유무, Y : 사용, N : 사용안함';
comment on column board.client_ip is '요청 IP';
comment on column board.view_count is '조회수';
comment on column board.insert_date is '등록일';

-- 게시판 상세
create table board_detail (
	board_detail_id				bigint			not null,
	board_id					bigint 			not null,
	contents					text,
	insert_date					timestamp 		with time zone			default now(),
	constraint board_detail_pk 	primary key (board_detail_id)	
);

comment on table board_detail is '게시판 상세';
comment on column board_detail.board_id is '게시판 고유번호';
comment on column board_detail.contents is '내용';
comment on column board.insert_date is '등록일';

-- 게시판 댓글(Comment)
create table board_comment (
	board_comment_id			bigint 				not null,
	board_id					bigint				not null,
	user_id						varchar(32)	 		not null,
	comment						varchar(4000)		not null,
	client_ip					varchar(45)			not null,
	insert_date					timestamp 			with time zone			default now(),
	constraint board_comment_pk primary key (board_comment_id)	
);

comment on table board_comment is '게시판 댓글(Comment)';
comment on column board_comment.board_comment_id is '고유번호';
comment on column board_comment.board_id is '게시판 고유번호';
comment on column board_comment.user_id is '사용자 아이디';
comment on column board_comment.comment is '댓글(Comment)';
comment on column board_comment.client_ip is '요청 IP';
comment on column board_comment.insert_date is '등록일';
