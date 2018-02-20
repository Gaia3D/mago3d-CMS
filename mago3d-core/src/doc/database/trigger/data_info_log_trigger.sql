drop trigger if exists data_info_log_insert_trigger on data_info_log;

CREATE OR REPLACE FUNCTION data_info_log_insert()
RETURNS TRIGGER AS $$
BEGIN
	IF( NEW.insert_date >= to_timestamp('20180101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20190101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into data_info_log_2018 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20190101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20200101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into data_info_log_2019 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20200101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20210101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into data_info_log_2020 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20210101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20220101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into data_info_log_2021 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20220101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20230101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into data_info_log_2022 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20230101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20240101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into data_info_log_2023 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20240101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20250101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into data_info_log_2024 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20250101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20260101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into data_info_log_2025 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20260101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20270101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into data_info_log_2026 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20270101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20280101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into data_info_log_2027 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20280101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20290101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into data_info_log_2028 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20290101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20300101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into data_info_log_2029 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20300101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20310101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into data_info_log_2030 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20310101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20320101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into data_info_log_2031 values (NEW.*);
	ELSE
		RAISE EXCEPTION 'Error in data_info_log_insert() : data out of range';
	END IF;
	RETURN NULL;
END;
$$
LANGUAGE PLPGSQL;

create trigger data_info_log_insert_trigger
	before insert on data_info_log
	for each row execute procedure data_info_log_insert();

