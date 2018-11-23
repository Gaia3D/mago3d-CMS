drop table if exists membership cascade;


-- 회원 관리
create table membership(
	membership_id				bigint,
	user_id						varchar(32),
	membership_type				char(1)						default '0',
	charge_type					char(1)						default '0',
	insert_date					timestamp with time zone default now(),
	constraint membership_pk 	primary key (membership_id)	
);

comment on table membership is 'mago3D membership';
comment on column membership.membership_id is '고유번호';
comment on column membership.user_id is '사용자 아이디';
comment on column membership.membership_type is '회원 타입. 0: Basic, 1 : 실버, 2 : 골드';
comment on column membership.charge_type is '요금 지불 타입. 0: 사용안함, 1 : 월정액, 2 : 년비';
comment on column membership.insert_date is '등록일';
