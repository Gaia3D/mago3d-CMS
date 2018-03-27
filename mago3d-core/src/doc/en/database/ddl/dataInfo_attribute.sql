-- Separate FK and Index into separate files. Scheduled to work last
drop table if exists data_info_attribute cascade;
drop table if exists data_info_object_attribute cascade;


-- Data Basic Information
create table data_info_attribute(
	data_attribute_id			bigint,
	data_id						bigint,
	attributes					json,
	update_date					timestamp without time zone,
	insert_date					timestamp without time zone			default now(),
	constraint data_info_attribute_pk 	primary key(data_attribute_id)
);

comment on table data_info_attribute is 'Data design file attribute information';
comment on column data_info_attribute.data_attribute_id is 'unique number';
comment on column data_info_attribute.data_id is 'Data unique number';
comment on column data_info_attribute.attributes is 'attribute';
comment on column data_info_attribute.update_date is 'Modified';
comment on column data_info_attribute.insert_date is 'Registered Date';


create table data_info_object_attribute(
	data_object_attribute_id			bigint,
	data_id								bigint,
	object_id							varchar(256),
	attributes							json,
	update_date							timestamp without time zone,
	insert_date							timestamp without time zone			default now(),
	constraint data_info_object_attribute_pk 	primary key(data_object_attribute_id)
);

comment on table data_info_object_attribute is 'Object attribute information';
comment on column data_info_object_attribute.data_object_attribute_id is 'unique number';
comment on column data_info_object_attribute.data_id is 'Data unique number';
comment on column data_info_object_attribute.attributes is 'Object attribute';
comment on column data_info_object_attribute.update_date is 'Modified';
comment on column data_info_object_attribute.insert_date is 'Registered Date';