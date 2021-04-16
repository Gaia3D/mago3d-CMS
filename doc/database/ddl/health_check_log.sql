drop table if exists health_check_log cascade;
drop table if exists health_check_log_2021 cascade;
commit;


-- Health Check 이력
create table health_check_log(
    health_check_log_id					    bigint,
    micro_service_id			            int,
    status						            varchar(20)			default 'use',
    insert_date				                timestamp 			with time zone			default now()
) partition by range(insert_date);

create table health_check_log_2021 partition of health_check_log for values from ('2021-01-01 00:00:00.000000') to ('2022-01-01 00:00:00.000000');