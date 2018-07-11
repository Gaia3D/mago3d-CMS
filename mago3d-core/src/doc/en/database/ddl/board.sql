drop table if exists board_notice cascade;
drop table if exists board_notice_detail cascade;
drop table if exists board_notice_comment cascade;
drop table if exists board_notice_file cascade;

-- Notice
create table board_notice(
	notice_id 			bigint 							not null,
	title				varchar(4000)					not null,
	user_id				varchar(32)						not null,
	notice_site			varchar(30),
	start_date			timestamp with time zone,
	end_date			timestamp with time zone,
	use_yn				char(1) 						default 'Y',
	client_ip 			varchar(45)						not null,
	view_count			int								default 0,
	insert_date			timestamp with time zone,
	constraint board_notice_pk 	primary key (notice_id)	
);

comment on table board_notice is 'notice';
comment on column board_notice.notice_id is 'unique key';
comment on column board_notice.title is 'title';
comment on column board_notice.user_id is 'user id';
comment on column board_notice.notice_site is 'notice publish page';
comment on column board_notice.start_date is 'post start time';
comment on column board_notice.end_date is 'post close time';
comment on column board_notice.use_yn is 'use, Y: use, N: do not use';
comment on column board_notice.client_ip is 'request IP';
comment on column board_notice.view_count is 'views';
comment on column board_notice.insert_date is 'insert date';

-- Notice Detail
create table board_notice_detail (
	notice_detail_id		bigint						not null,
	notice_id				bigint 						not null,
	contents				text,
	insert_date				timestamp with time zone	default now(),
	constraint board_notice_detail_pk 	primary key (notice_detail_id)	
);

comment on table board_notice_detail is 'notice detail';
comment on column board_notice_detail.notice_detail_id is 'unique key';
comment on column board_notice_detail.notice_id is 'notice unique key';
comment on column board_notice_detail.contents is 'content';
comment on column board_notice_detail.insert_date is 'insert date';


-- Notice Comment
create table board_notice_comment (
	notice_comment_id		bigint 						not null,
	notice_id				bigint						not null,
	user_id					varchar(32)	 				not null,
	comment					varchar(4000)				not null,
	client_ip				varchar(45)					not null,
	insert_date				timestamp with time zone	default now(),
	constraint board_notice_comment_pk 	primary key (notice_comment_id)	
);

comment on table board_notice_comment is 'notice comment';
comment on column board_notice_comment.notice_comment_id is 'unique key';
comment on column board_notice_comment.notice_id is 'notice unique key';
comment on column board_notice_comment.user_id is 'user id';
comment on column board_notice_comment.comment is 'comment';
comment on column board_notice_comment.client_ip is 'request IP';
comment on column board_notice_comment.insert_date is 'insert date';


-- Notice File
create table board_notice_file(
	notice_file_id			bigint,
	notice_id				bigint 						not null,
	file_name				varchar(256)				not null,
	file_real_name			varchar(100)				not null,
	file_path				varchar(256)				not null,
	file_size				varchar(12)					not null,
	file_ext				varchar(10)					not null,
	insert_date				timestamp with time zone	default now(),
	constraint board_notice_file_pk 	primary key (notice_file_id)	
);

comment on table board_notice_file is 'notice file management';
comment on column board_notice_file.notice_file_id is 'unique key';
comment on column board_notice_file.notice_id is 'unique key';
comment on column board_notice_file.file_name is 'file name';
comment on column board_notice_file.file_real_name is 'file real name';
comment on column board_notice_file.file_path is 'file path';
comment on column board_notice_file.file_size is 'file size';
comment on column board_notice_file.file_ext is 'file extension';
comment on column board_notice_file.insert_date is 'insert date';



drop table if exists board_faq cascade;
drop table if exists board_faq_detail cascade;
drop table if exists board_faq_comment cascade;
drop table if exists board_faq_file cascade;

-- FAQ
create table board_faq(
	faq_id 				bigint 							not null,
	title				varchar(4000)					not null,
	user_id				varchar(32)						not null,
	faq_site			varchar(30),
	start_date			timestamp with time zone,
	end_date			timestamp with time zone,
	use_yn				char(1) 						default 'Y',
	client_ip 			varchar(45)						not null,
	view_count			bigint							default 0,
	insert_date			timestamp with time zone,
	constraint board_faq_pk 	primary key (faq_id)	
);

comment on table board_faq is 'FAQ';
comment on column board_faq.faq_id is 'unique key';
comment on column board_faq.title is 'title';
comment on column board_faq.user_id is 'user id';
comment on column board_faq.faq_site is 'FAQ publish page';
comment on column board_faq.start_date is 'post start time';
comment on column board_faq.end_date is 'post close time';
comment on column board_faq.use_yn is 'use, Y: use, N: do not use';
comment on column board_faq.client_ip is 'request IP';
comment on column board_faq.view_count is 'views';
comment on column board_faq.insert_date is 'insert date';

-- FAQ Detail
create table board_faq_detail (
	faq_detail_id			bigint						not null,
	faq_id					bigint 						not null,
	contents				text,
	insert_date				timestamp with time zone	default now(),
	constraint board_faq_detail_pk 		primary key (faq_detail_id)	
);

comment on table board_faq_detail is 'FAQ detail';
comment on column board_faq_detail.faq_detail_id is 'unique key';
comment on column board_faq_detail.faq_id is 'FAQ unique key';
comment on column board_faq_detail.contents is 'content';
comment on column board_faq_detail.insert_date is 'insert date';


-- FAQ Comment
create table board_faq_comment (
	faq_comment_id			bigint 						not null,
	faq_id					bigint						not null,
	user_id					varchar(32)	 				not null,
	comment					varchar(4000)				not null,
	client_ip				varchar(45)					not null,
	insert_date				timestamp with time zone	default now(),
	constraint board_faq_comment_pk 	primary key (faq_comment_id)	
);

comment on table board_faq_comment is 'FAQ comment';
comment on column board_faq_comment.faq_comment_id is 'unique key';
comment on column board_faq_comment.faq_id is 'FAQ unique key';
comment on column board_faq_comment.user_id is 'user id';
comment on column board_faq_comment.comment is 'comment';
comment on column board_faq_comment.client_ip is 'request IP';
comment on column board_faq_comment.insert_date is 'insert date';


-- FAQ File
create table board_faq_file(
	faq_file_id				bigint,
	faq_id					bigint 						not null,
	file_name				varchar(100)				not null,
	file_real_name			varchar(100)				not null,
	file_path				varchar(256)				not null,
	file_size				varchar(12)					not null,
	file_ext				varchar(10)					not null,
	insert_date				timestamp with time zone	default now(),
	constraint board_faq_file_pk	 primary key (faq_file_id)	
);

comment on table board_faq_file is 'FAQ file management';
comment on column board_faq_file.faq_file_id is 'FAQ file unique key';
comment on column board_faq_file.faq_id is 'unique key';
comment on column board_faq_file.file_name is 'file name';
comment on column board_faq_file.file_real_name is 'file real name';
comment on column board_faq_file.file_path is 'file path';
comment on column board_faq_file.file_size is 'file size';
comment on column board_faq_file.file_ext is 'file extension';
comment on column board_faq_file.insert_date is 'insert date';



drop table if exists board_press cascade;
drop table if exists board_press_detail cascade;
drop table if exists board_press_comment cascade;
drop table if exists board_press_file cascade;

-- Press
create table board_press(
	press_id 			bigint 							not null,
	title				varchar(4000)					not null,
	user_id				varchar(32)						not null,
	press_site			varchar(30),
	start_date			timestamp with time zone,
	end_date			timestamp with time zone,
	use_yn				char(1) 						default 'Y',
	client_ip 			varchar(45)						not null,
	view_count			bigint							default 0,
	insert_date			timestamp with time zone,
	constraint board_press_pk	 primary key (press_id)	
);

comment on table board_press is 'press';
comment on column board_press.press_id is 'unique key';
comment on column board_press.title is 'title';
comment on column board_press.user_id is 'user id';
comment on column board_press.press_site is 'press publish page';
comment on column board_press.start_date is 'post start time';
comment on column board_press.end_date is 'post close time';
comment on column board_press.use_yn is 'use, Y: use, N: do not use';
comment on column board_press.client_ip is 'request IP';
comment on column board_press.view_count is 'views';
comment on column board_press.insert_date is 'insert date';

-- Press Detail
create table board_press_detail (
	press_detail_id			bigint						not null,
	press_id				bigint 						not null,
	contents				text,
	insert_date				timestamp with time zone	default now(),
	constraint board_press_detail_pk 	primary key (press_detail_id)	
);

comment on table board_press_detail is 'press detail';
comment on column board_press_detail.press_detail_id is 'unique key';
comment on column board_press_detail.press_id is 'press unique key';
comment on column board_press_detail.contents is 'content';
comment on column board_press_detail.insert_date is 'insert date';


-- Press comment
create table board_press_comment (
	press_comment_id		bigint 						not null,
	press_id				bigint						not null,
	user_id					varchar(32)	 				not null,
	comment					varchar(4000)				not null,
	client_ip				varchar(45)					not null,
	insert_date				timestamp with time zone	default now(),
	constraint board_press_comment_pk 	primary key (press_comment_id)	
);

comment on table board_press_comment is 'press comment';
comment on column board_press_comment.press_comment_id is 'unique key';
comment on column board_press_comment.press_id is 'press unique key';
comment on column board_press_comment.user_id is 'user id';
comment on column board_press_comment.comment is 'comment';
comment on column board_press_comment.client_ip is 'request IP';
comment on column board_press_comment.insert_date is 'insert date';


-- Press File
create table board_press_file(
	press_file_id			bigint,
	press_id				bigint 						not null,
	file_name				varchar(100)				not null,
	file_real_name			varchar(100)				not null,
	file_path				varchar(256)				not null,
	file_size				varchar(12)					not null,
	file_ext				varchar(10)					not null,
	insert_date				timestamp with time zone	default now(),
	constraint board_press_file_pk		primary key (press_file_id)		
);

comment on table board_press_file is 'press file management';
comment on column board_press_file.press_file_id is 'unique key';
comment on column board_press_file.press_id is 'press unique key';
comment on column board_press_file.file_name is 'file name';
comment on column board_press_file.file_real_name is 'file real name';
comment on column board_press_file.file_path is 'file path';
comment on column board_press_file.file_size is 'file size';
comment on column board_press_file.file_ext is 'file extension';
comment on column board_press_file.insert_date is 'insert date';



drop table if exists board_forum cascade;
drop table if exists board_forum_detail cascade;
drop table if exists board_forum_comment cascade;
drop table if exists board_forum_file cascade;

-- Forum
create table board_forum(
	forum_id 			bigint 							not null,
	title				varchar(4000)					not null,
	user_id				varchar(32)						not null,
	forum_site			varchar(30),
	start_date			timestamp with time zone,
	end_date			timestamp with time zone,
	use_yn				char(1) 						default 'Y',
	client_ip 			varchar(45)						not null,
	view_count			int								default 0,
	insert_date			timestamp with time zone,
	constraint board_forum_pk 	primary key (forum_id)	
);

comment on table board_forum is 'forum';
comment on column board_forum.forum_id is 'unique key';
comment on column board_forum.title is 'title';
comment on column board_forum.user_id is 'user id';
comment on column board_forum.forum_site is 'forum publish page';
comment on column board_forum.use_yn is 'use, Y: use, N: do not use';
comment on column board_forum.client_ip is 'request IP';
comment on column board_forum.view_count is 'views';
comment on column board_forum.insert_date is 'insert date';

-- Forum Detail
create table board_forum_detail (
	forum_detail_id			bigint						not null,
	forum_id				bigint 						not null,
	contents				text,
	insert_date				timestamp with time zone	default now(),
	constraint board_forum_detail_pk 	primary key (forum_detail_id)	
);

comment on table board_forum_detail is 'forum detail';
comment on column board_forum_detail.forum_detail_id is 'unique key';
comment on column board_forum_detail.forum_id is 'forum unique key';
comment on column board_forum_detail.contents is 'content';
comment on column board_forum_detail.insert_date is 'insert date';


-- Forum Comment
create table board_forum_comment (
	forum_comment_id		bigint 						not null,
	forum_id				bigint						not null,
	user_id					varchar(32)	 				not null,
	comment					varchar(4000)				not null,
	client_ip				varchar(45)					not null,
	insert_date				timestamp with time zone	default now(),
	constraint board_forum_comment_pk 	primary key (forum_comment_id)	
);

comment on table board_forum_comment is 'notice comment';
comment on column board_forum_comment.forum_comment_id is 'unique key';
comment on column board_forum_comment.forum_id is 'notice unique key';
comment on column board_forum_comment.user_id is 'user id';
comment on column board_forum_comment.comment is 'comment';
comment on column board_forum_comment.client_ip is 'request IP';
comment on column board_forum_comment.insert_date is 'insert date';


-- Forum File
create table board_forum_file(
	forum_file_id			bigint,
	forum_id				bigint 						not null,
	file_name				varchar(256)				not null,
	file_real_name			varchar(100)				not null,
	file_path				varchar(256)				not null,
	file_size				varchar(12)					not null,
	file_ext				varchar(10)					not null,
	insert_date				timestamp with time zone	default now(),
	constraint board_forum_file_pk 		primary key (forum_file_id)	
);

comment on table board_forum_file is 'forum file management';
comment on column board_forum_file.forum_file_id is 'unique key';
comment on column board_forum_file.forum_id is 'forum unique key';
comment on column board_forum_file.file_name is 'file name';
comment on column board_forum_file.file_real_name is 'file real name';
comment on column board_forum_file.file_path is 'file path';
comment on column board_forum_file.file_size is 'file size';
comment on column board_forum_file.file_ext is 'file extension';
comment on column board_forum_file.insert_date is 'insert date';

