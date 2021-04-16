
alter table only data_info_log_2021 add constraint data_info_log_2021_pk primary key (data_log_id);


create index data_info_log_idx on data_info_log (insert_date);
commit;
