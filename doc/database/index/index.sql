drop index if exists data_info_group_id_idx cascade;
drop index if exists data_info_user_id_idx cascade;

create index data_info_group_id_idx on data_info (data_group_id);
create index data_info_user_id_idx on data_info (user_id);

commit;