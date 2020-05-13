-- constraint 는 부모 테이블에 생성 되지 않고 자식 테이블에 만들어야 함. index 를 잘 타는지는 테스트 필요.
alter table only access_log_2020 add constraint access_log_2020_pk primary key (access_log_id);
alter table only access_log_2021 add constraint access_log_2021_pk primary key (access_log_id);
alter table only access_log_2022 add constraint access_log_2022_pk primary key (access_log_id);
alter table only access_log_2023 add constraint access_log_2023_pk primary key (access_log_id);
alter table only access_log_2024 add constraint access_log_2024_pk primary key (access_log_id);
alter table only access_log_2025 add constraint access_log_2025_pk primary key (access_log_id);
alter table only access_log_2026 add constraint access_log_2026_pk primary key (access_log_id);
alter table only access_log_2027 add constraint access_log_2027_pk primary key (access_log_id);
alter table only access_log_2028 add constraint access_log_2028_pk primary key (access_log_id);
alter table only access_log_2029 add constraint access_log_2029_pk primary key (access_log_id);
alter table only access_log_2030 add constraint access_log_2030_pk primary key (access_log_id);
alter table only access_log_2031 add constraint access_log_2031_pk primary key (access_log_id);
alter table only access_log_2032 add constraint access_log_2032_pk primary key (access_log_id);
alter table only access_log_2033 add constraint access_log_2033_pk primary key (access_log_id);
alter table only access_log_2034 add constraint access_log_2034_pk primary key (access_log_id);
alter table only access_log_2035 add constraint access_log_2035_pk primary key (access_log_id);
alter table only access_log_2036 add constraint access_log_2036_pk primary key (access_log_id);
alter table only access_log_2037 add constraint access_log_2037_pk primary key (access_log_id);
alter table only access_log_2038 add constraint access_log_2038_pk primary key (access_log_id);
alter table only access_log_2039 add constraint access_log_2039_pk primary key (access_log_id);
alter table only access_log_2040 add constraint access_log_2040_pk primary key (access_log_id);

-- index 의 경우 부모 테이블에만 만들면 됨
create index access_log_idx on access_log (insert_date);
commit;