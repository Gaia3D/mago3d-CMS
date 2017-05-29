
drop sequence if exists user_group_seq;
drop sequence if exists user_group_role_seq;
drop sequence if exists user_group_menu_seq;
drop sequence if exists role_seq;
drop sequence if exists menu_seq;
drop sequence if exists widget_seq;
drop sequence if exists common_code_seq;
drop sequence if exists policy_seq;

create sequence user_group_seq increment 1 minvalue 1 maxvalue 999999999999 start 1 cache 1;
create sequence user_group_role_seq increment 1 minvalue 1 maxvalue 999999999999 start 1 cache 1;
create sequence user_group_menu_seq increment 1 minvalue 1 maxvalue 999999999999 start 1 cache 1;
create sequence role_seq increment 1 minvalue 1 maxvalue 999999999999 start 1 cache 1;
create sequence menu_seq increment 1 minvalue 1 maxvalue 999999999999 start 1 cache 1;
create sequence widget_seq increment 1 minvalue 1 maxvalue 999999999999 start 1 cache 1;
create sequence common_code_seq increment 1 minvalue 1 maxvalue 999999999999 start 1 cache 1;
create sequence policy_seq increment 1 minvalue 1 maxvalue 999999999999 start 1 cache 1;
