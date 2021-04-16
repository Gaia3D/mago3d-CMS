-- constraint 는 부모 테이블에 생성 되지 않고 자식 테이블에 만들어야 함. index 를 잘 타는지는 테스트 필요.
alter table only api_log_2021 add constraint api_log_2021_pk primary key (api_log_id);


-- index 의 경우 부모 테이블에만 만들면 됨
create index api_log_idx on api_log (insert_date);
commit;