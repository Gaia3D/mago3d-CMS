-- DROP FUNCTION IF EXISTS create_health_check_log CASCADE;

CREATE OR REPLACE FUNCTION create_health_check_log(table_name varchar, start_time varchar(26), end_time varchar(26))
RETURNS INTEGER
LANGUAGE plpgsql
AS $function$
BEGIN
    EXECUTE FORMAT('CREATE TABLE health_check_log_%s PARTITION OF health_check_log FOR VALUES FROM (''%s'') TO (''%s'')', table_name, start_time, end_time);
    EXECUTE FORMAT('ALTER TABLE ONLY health_checklog_%s ADD CONSTRAINT health_checklog_%s_pk PRIMARY KEY (health_check_log_id)', table_name, table_name);

    RETURN 0;

EXCEPTION
    WHEN undefined_table THEN
        raise notice '%, %', SQLSTATE, SQLERRM;
        RETURN -1;

END;
$function$;
