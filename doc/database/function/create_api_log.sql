-- DROP FUNCTION IF EXISTS create_access_log CASCADE;

CREATE OR REPLACE FUNCTION create_api_log(table_name varchar, start_time varchar(26), end_time varchar(26))
RETURNS INTEGER
LANGUAGE plpgsql
AS $function$
BEGIN
    EXECUTE FORMAT('CREATE TABLE api_log_%s PARTITION OF api_log FOR VALUES FROM (''%s'') TO (''%s'')', table_name, start_time, end_time);
    EXECUTE FORMAT('ALTER TABLE ONLY api_log_%s ADD CONSTRAINT api_log_%s_pk PRIMARY KEY (api_log_id)', table_name, table_name);

    RETURN 0;

EXCEPTION
    WHEN undefined_table THEN
        raise notice '%, %', SQLSTATE, SQLERRM;
        RETURN -1;

END;
$function$;
