-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists data_attribute cascade;
drop table if exists data_object_attribute cascade;


-- Data 기본정보
create table data_attribute (
	data_attribute_id			bigint,
	data_id						bigint,
	attributes					json,
	update_date					timestamp with time zone,
	insert_date					timestamp with time zone			default now(),
	constraint data_attribute_pk 	primary key(data_attribute_id)
);

comment on table data_attribute is 'Data 속성 정보';
comment on column data_attribute.data_attribute_id is '고유번호';
comment on column data_attribute.data_id is 'Data 고유번호';
comment on column data_attribute.attributes is '속성';
comment on column data_attribute.update_date is '수정일';
comment on column data_attribute.insert_date is '등록일';


create table data_object_attribute (
	data_object_attribute_id			bigint,
	data_id								bigint,
	object_id							varchar(256),
	attributes							json,
	update_date							timestamp with time zone,
	insert_date							timestamp with time zone			default now(),
	constraint data_object_attribute_pk 	primary key(data_object_attribute_id)
);

comment on table data_object_attribute is '데이터 Object 속성 정보';
comment on column data_object_attribute.data_object_attribute_id is '고유번호';
comment on column data_object_attribute.data_id is 'Data 고유번호';
comment on column data_object_attribute.object_id is '오브젝트 번호';
comment on column data_object_attribute.attributes is 'Object 속성';
comment on column data_object_attribute.update_date is '수정일';
comment on column data_object_attribute.insert_date is '등록일';