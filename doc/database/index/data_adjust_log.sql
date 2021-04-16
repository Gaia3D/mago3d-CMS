
alter table only data_adjust_log_2021 add constraint data_adjust_log_2021_pk primary key (data_adjust_log_id);


create index data_adjust_log_idx on data_adjust_log (insert_date);
commit;
