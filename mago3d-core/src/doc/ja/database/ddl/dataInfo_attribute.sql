-- FK、Indexは別途ファイルに分離した。最後に作業予定
drop table if exists data_info_attribute cascade;
drop table if exists data_info_object_attribute cascade;


-- Data基本情報
create table data_info_attribute(
	data_attribute_id			bigint,
	data_id						bigint,
	attributes					jsonb,
	update_date					timestamp without time zone,
	insert_date					timestamp without time zone			default now(),
	constraint data_info_attribute_pk 	primary key(data_attribute_id)
);

comment on table data_info_attribute is 'Data設計ファイルの属性情報';
comment on column data_info_attribute.data_attribute_id is '固有番号';
comment on column data_info_attribute.data_id is 'Data固有番号';
comment on column data_info_attribute.attributes is '属性';
comment on column data_info_attribute.update_date is '更新日';
comment on column data_info_attribute.insert_date is '登録';


create table data_info_object_attribute(
	data_object_attribute_id			bigint,
	data_id								bigint,
	object_id							varchar(256),
	attributes							jsonb,
	update_date							timestamp without time zone,
	insert_date							timestamp without time zone			default now(),
	constraint data_info_object_attribute_pk 	primary key(data_object_attribute_id)
);

comment on table data_info_object_attribute is 'Objectプロパティの詳細';
comment on column data_info_object_attribute.data_object_attribute_id is '固有番号';
comment on column data_info_object_attribute.data_id is 'Data固有番号';
comment on column data_info_object_attribute.attributes is 'Objectプロパティの';
comment on column data_info_object_attribute.update_date is '更新日';
comment on column data_info_object_attribute.insert_date is '登録';