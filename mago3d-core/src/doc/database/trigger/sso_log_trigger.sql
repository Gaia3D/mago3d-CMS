-- drop function sso_log_insert();
-- drop function sso_logupdate();
drop trigger if exists sso_log_insert_trigger on sso_log;
drop trigger if exists sso_log_update_trigger on sso_log;

CREATE OR REPLACE FUNCTION sso_log_insert()
RETURNS TRIGGER AS $$
BEGIN
	IF( NEW.insert_date >= to_timestamp('20180101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20190101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into sso_log_2018 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20190101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20200101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into sso_log_2019 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20200101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20210101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into sso_log_2020 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20210101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20220101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into sso_log_2021 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20220101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20230101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into sso_log_2022 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20230101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20240101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into sso_log_2023 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20240101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20250101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into sso_log_2024 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20250101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20260101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into sso_log_2025 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20260101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20270101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into sso_log_2026 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20270101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20280101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into sso_log_2027 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20280101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20290101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into sso_log_2028 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20290101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20300101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into sso_log_2029 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20300101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20310101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into sso_log_2030 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20310101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date < to_timestamp('20320101000000000000', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into sso_log_2031 values (NEW.*);
	ELSE
		RAISE EXCEPTION 'Error in sso_log_insert() : data out of range';
	END IF;
	RETURN NULL;
END;
$$
LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION sso_log_update()
RETURNS TRIGGER AS $$
BEGIN
	IF( NEW.insert_date >= to_timestamp('20180101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20181231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		update sso_log_2018 SET token_status = NEW.token_status, device_kind = NEW.device_kind, request_type = NEW.request_type, redirect_url = NEW.redirect_url, update_date = NEW.update_date WHERE sso_log_id = NEW.sso_log_id;
	ELSIF( NEW.insert_date >= to_timestamp('20190101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20191231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		update sso_log_2019 SET token_status = NEW.token_status, device_kind = NEW.device_kind, request_type = NEW.request_type, redirect_url = NEW.redirect_url, update_date = NEW.update_date WHERE sso_log_id = NEW.sso_log_id;
	ELSIF( NEW.insert_date >= to_timestamp('20200101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20201231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		update sso_log_2020 SET token_status = NEW.token_status, device_kind = NEW.device_kind, request_type = NEW.request_type, redirect_url = NEW.redirect_url, update_date = NEW.update_date WHERE sso_log_id = NEW.sso_log_id;
	ELSIF( NEW.insert_date >= to_timestamp('20210101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20211231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		update sso_log_2021 SET token_status = NEW.token_status, device_kind = NEW.device_kind, request_type = NEW.request_type, redirect_url = NEW.redirect_url, update_date = NEW.update_date WHERE sso_log_id = NEW.sso_log_id;
	ELSIF( NEW.insert_date >= to_timestamp('20220101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20221231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		update sso_log_2022 SET token_status = NEW.token_status, device_kind = NEW.device_kind, request_type = NEW.request_type, redirect_url = NEW.redirect_url, update_date = NEW.update_date WHERE sso_log_id = NEW.sso_log_id;
	ELSIF( NEW.insert_date >= to_timestamp('20230101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20231231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		update sso_log_2023 SET token_status = NEW.token_status, device_kind = NEW.device_kind, request_type = NEW.request_type, redirect_url = NEW.redirect_url, update_date = NEW.update_date WHERE sso_log_id = NEW.sso_log_id;
	ELSIF( NEW.insert_date >= to_timestamp('20240101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20241231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		update sso_log_2024 SET token_status = NEW.token_status, device_kind = NEW.device_kind, request_type = NEW.request_type, redirect_url = NEW.redirect_url, update_date = NEW.update_date WHERE sso_log_id = NEW.sso_log_id;
	ELSIF( NEW.insert_date >= to_timestamp('20250101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20251231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		update sso_log_2025 SET token_status = NEW.token_status, device_kind = NEW.device_kind, request_type = NEW.request_type, redirect_url = NEW.redirect_url, update_date = NEW.update_date WHERE sso_log_id = NEW.sso_log_id;
	ELSIF( NEW.insert_date >= to_timestamp('20260101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20261231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		update sso_log_2026 SET token_status = NEW.token_status, device_kind = NEW.device_kind, request_type = NEW.request_type, redirect_url = NEW.redirect_url, update_date = NEW.update_date WHERE sso_log_id = NEW.sso_log_id;
	ELSIF( NEW.insert_date >= to_timestamp('20270101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20271231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		update sso_log_2027 SET token_status = NEW.token_status, device_kind = NEW.device_kind, request_type = NEW.request_type, redirect_url = NEW.redirect_url, update_date = NEW.update_date WHERE sso_log_id = NEW.sso_log_id;
	ELSIF( NEW.insert_date >= to_timestamp('20280101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20281231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		update sso_log_2028 SET token_status = NEW.token_status, device_kind = NEW.device_kind, request_type = NEW.request_type, redirect_url = NEW.redirect_url, update_date = NEW.update_date WHERE sso_log_id = NEW.sso_log_id;
	ELSIF( NEW.insert_date >= to_timestamp('20290101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20291231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		update sso_log_2029 SET token_status = NEW.token_status, device_kind = NEW.device_kind, request_type = NEW.request_type, redirect_url = NEW.redirect_url, update_date = NEW.update_date WHERE sso_log_id = NEW.sso_log_id;
	ELSIF( NEW.insert_date >= to_timestamp('20300101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20301231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		update sso_log_2030 SET token_status = NEW.token_status, device_kind = NEW.device_kind, request_type = NEW.request_type, redirect_url = NEW.redirect_url, update_date = NEW.update_date WHERE sso_log_id = NEW.sso_log_id;
	ELSIF( NEW.insert_date >= to_timestamp('20310101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20311231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		update sso_log_2031 SET token_status = NEW.token_status, device_kind = NEW.device_kind, request_type = NEW.request_type, redirect_url = NEW.redirect_url, update_date = NEW.update_date WHERE sso_log_id = NEW.sso_log_id;
	ELSE
		RAISE EXCEPTION 'Error in sso_log_insert() : data out of range';
	END IF;
	RETURN NULL;
END;
$$
LANGUAGE PLPGSQL;

create trigger sso_log_insert_trigger
	before insert on sso_log
	for each row execute procedure sso_log_insert();

create trigger sso_log_update_trigger
	before update on sso_log
	for each row execute procedure sso_log_update();
