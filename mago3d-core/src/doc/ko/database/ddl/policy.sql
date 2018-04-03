drop table if exists policy cascade;

-- ���å
create table policy(
	policy_id							int,
	
	user_id_min_length					int			default 5,
	user_fail_login_count				int			default 3,
	user_fail_lock_release				varchar(3)			default '30',
	user_last_login_lock				varchar(3)			default '90',
	user_duplication_login_yn			char(1)				default 'N',
	user_login_type						char(1)				default '0',
	user_update_check					char(1)				default '0',
	user_delete_check					char(1)				default '0',
	user_delete_type					char(1)				default '0',
	
	password_change_term 				varchar(3)			default '30',
	password_min_length					int			default 8,
	password_max_length					int			default 32,
	password_eng_upper_count 			int			default 1,
	password_eng_lower_count 			int			default 1,
	password_number_count 				int			default 1,
	password_special_char_count 		int			default 1,
	password_continuous_char_count 		int			default 3,
	password_create_type				char(1)				default '0',
	password_create_char				varchar(32)			default '!@#',
	password_exception_char				varchar(10)			default '<>&',
	
	geo_view_library					varchar(20)			default 'cesium',
	geo_data_path						varchar(100)		default '/data',
	geo_data_default_projects			varchar(30)[],
	geo_data_change_request_decision	char(1)				default '1',
	geo_cull_face_enable				varchar(5)			default 'false',
	geo_time_line_enable				varchar(5)			default 'false',
	
	geo_init_camera_enable				varchar(5)			default 'true',
	geo_init_latitude					varchar(30)			default '37.521168',
	geo_init_longitude					varchar(30)			default '126.924185',
	geo_init_height						varchar(30)			default '3000.0',
	geo_init_duration					int			default 3,
	geo_init_default_terrain			varchar(64),
	geo_init_default_fov				int			default 0,
	
	geo_lod0							varchar(20)			default '15',
	geo_lod1							varchar(20)			default '60',
	geo_lod2							varchar(20)			default '90',
	geo_lod3							varchar(20)			default '200',
	geo_lod4							varchar(20)			default '1000',
	geo_lod5							varchar(20)			default '50000',
	geo_ambient_reflection_coef			varchar(10)			default '0.5',
	geo_diffuse_reflection_coef			varchar(10)			default '1.0',
	geo_specular_reflection_coef		varchar(10)			default '1.0',
	geo_specular_color					varchar(11)			default '#d8d8d8',
	geo_ambient_color					varchar(11)			default '#d8d8d8',
	geo_ssao_radius						varchar(20)			default '0.15',
	
	geo_server_enable						varchar(5)			default 'false',
	geo_server_url							varchar(256),
	geo_server_layers						varchar(60),
	geo_server_parameters_service			varchar(30),
	geo_server_parameters_version			varchar(30),
	geo_server_parameters_request			varchar(30),
	geo_server_parameters_transparent		varchar(30),
	geo_server_parameters_format			varchar(30),
	geo_server_add_url						varchar(256),
	geo_server_add_layers					varchar(60),
	geo_server_add_parameters_service		varchar(30),
	geo_server_add_parameters_version		varchar(30),
	geo_server_add_parameters_request		varchar(30),
	geo_server_add_parameters_transparent	varchar(30),
	geo_server_add_parameters_format		varchar(30),
	
	geo_callback_enable 					varchar(5)			default 'false',
	geo_callback_apiresult					varchar(64),
	geo_callback_dataInfo					varchar(64),
	geo_callback_selectedobject				varchar(64),
	geo_callback_moveddata					varchar(64),
	geo_callback_insertIssue				varchar(64),
	geo_callback_listIssue					varchar(64),
	geo_callback_clickposition				varchar(64),
	
	notice_service_yn					char(1)				default 'Y',
	notice_service_send_type			char(1)				default '0',
	notice_approval_request_yn			char(1)				default 'N',
	notice_approval_sign_yn				char(1)				default 'N',
	notice_password_update_yn			char(1)				default 'N',
	notice_approval_delay_yn			char(1)				default 'N',
	notice_risk_yn						char(1)				default 'N',
	notice_risk_send_type				char(1)				default '0',
	notice_risk_grade					char(1)				default '0',
	
	security_session_timeout_yn			char(1)				default 'N',
	security_session_timeout			varchar(4)			default '30',
	security_user_ip_check_yn			char(1)				default 'N',
	security_session_hijacking			char(1)				default '0',
	security_sso						char(1)				default '0',
	security_sso_token_verify_time		int			default 3,
	security_log_save_type				char(1)				default '0',
	security_log_save_term				varchar(3)			default '2',
	security_dynamic_block_yn			char(1)				default 'N',
	security_api_result_secure_yn		char(1)				default 'N',
	security_masking_yn					char(1)				default 'Y',
	
	content_cache_version				int					default 1,
	content_main_widget_count			int					default 6,
	content_main_widget_interval		int					default 65,
	content_monitoring_interval			int					default 1,
	content_statistics_interval			char(1)				default '0',
	content_load_balancing_interval		int					default 10,
	content_menu_group_root				varchar(60)			default 'Mago3D',
	content_user_group_root				varchar(60)			default 'Mago3D',
	content_server_group_root			varchar(60)			default 'Mago3D',
	content_data_group_root			varchar(60)			default 'Mago3D',
	
	site_name							varchar(60),
	site_admin_name						varchar(64),
	site_admin_mobile_phone				varchar(256),
	site_admin_email					varchar(256),
	site_product_log					varchar(256),
	site_company_log					varchar(256),
	
	backoffice_email_host				varchar(30),
	backoffice_email_port				int,
	backoffice_email_user				varchar(32),
	backoffice_email_password			varchar(256),
	backoffice_user_db_driver			varchar(20),
	backoffice_user_db_url				varchar(256),
	backoffice_user_db_user				varchar(32),
	backoffice_user_db_password			varchar(256),
	
	solution_name						varchar(64),
	solution_version					varchar(30),
	solution_company					varchar(45),
	solution_company_phone				varchar(256),
	solution_manager					varchar(60),
	solution_manager_phone				varchar(256),
	solution_manager_email				varchar(256),
	
	insert_date				timestamp with time zone			default now(),
	constraint policy_pk primary key (policy_id)	
);

comment on table policy is '���å';
comment on column policy.policy_id is '������ȣ';

comment on column policy.user_id_min_length is '����� ���̵� �ּ� ����. �⺻�� 5';
comment on column policy.user_fail_login_count is '����� �α��� ���� Ƚ��';
comment on column policy.user_fail_lock_release is '����� �α��� ���� ��� ���� �Ⱓ';
comment on column policy.user_last_login_lock is '����� ������ �α������� ���� ��� �Ⱓ';
comment on column policy.user_duplication_login_yn is '�ߺ� �α��� ��� ����. Y : ���, N : ������(�⺻��)';
comment on column policy.user_login_type is '����� �α��� ���� ���. 0 : �Ϲ�(���̵�/��й�ȣ(�⺻��)), 1 : �����(����߰�), 2 : �Ϲ� + OTP, 3 : �Ϲ� + ������, 4 : OTP + ������, 5 : �Ϲ� + OTP + ������';
comment on column policy.user_update_check is '����� ���� ������ Ȯ��';
comment on column policy.user_delete_check is '����� ���� ������ Ȯ��';
comment on column policy.user_delete_type is '����� ���� ���� ���. 0 : ����(�⺻��), 1 : ������(DB ����)';

comment on column policy.password_change_term is '�н����� ���� �ֱ� �⺻ 30��';
comment on column policy.password_min_length is '�н����� �ּ� ���� �⺻ 8';
comment on column policy.password_max_length is '�н����� �ִ� ���� �⺻ 32';
comment on column policy.password_eng_upper_count is '�н����� ���� �빮�� ���� �⺻ 1';
comment on column policy.password_eng_lower_count is '�н����� ���� �ҹ��� ���� �⺻ 1';
comment on column policy.password_number_count is '�н����� ���� ���� �⺻ 1';
comment on column policy.password_special_char_count is '�н����� Ư�� ���� ���� 1';
comment on column policy.password_continuous_char_count is '�н����� ���ӹ��� ���� ���� 3';
comment on column policy.password_create_type is '�ʱ� �н����� ���� ���. 0 : ����� ���̵� + �ʱ⹮��(�⺻��), 1 : �ʱ⹮��';
comment on column policy.password_create_char is '�ʱ� �н����� ���� ���ڿ�. ���� ���ε� ��';
comment on column policy.password_exception_char is '�н������ ����Ҽ� ���� Ư������(XSS). <,>,&,��������ǥ,ū����ǥ';

comment on column policy.geo_view_library is 'view library. �⺻ cesium';
comment on column policy.geo_data_path is 'data ����. �⺻ /data';
comment on column policy.geo_data_default_projects is '���۽� �ε� ������Ʈ. �迭�� ����';
comment on column policy.geo_data_change_request_decision is '������ ���� ���� ��û�� ���� ó��. 0 : �ڵ�����, 1 : ����(�ʱⰪ)';
comment on column policy.geo_cull_face_enable is 'cullFace �������. �⺻ false';
comment on column policy.geo_time_line_enable is 'timeLine �������. �⺻ false';
	
comment on column policy.geo_init_camera_enable is '�ʱ� ī�޶� �̵� ����. �⺻ true';
comment on column policy.geo_init_latitude is '�ʱ� ī�޶� �̵� ����';
comment on column policy.geo_init_longitude is '�ʱ� ī�޶� �̵� �浵';
comment on column policy.geo_init_height is '�ʱ� ī�޶� �̵� ����';
comment on column policy.geo_init_duration is '�ʱ� ī�޶� �̵� �ð�. �� ����';
comment on column policy.geo_init_default_terrain is '�⺻ Terrain';
comment on column policy.geo_init_default_fov is 'field of view. �⺻�� 0(1.8 ����)';
comment on column policy.geo_lod0 is 'LOD0. �⺻�� 15M';
comment on column policy.geo_lod1 is 'LOD1. �⺻�� 60M';
comment on column policy.geo_lod2 is 'LOD2. �⺻�� 90M';
comment on column policy.geo_lod3 is 'LOD3. �⺻�� 200M';
comment on column policy.geo_lod4 is 'LOD4. �⺻�� 1000M';
comment on column policy.geo_lod5 is 'LOD5. �⺻�� 50000M';
comment on column policy.geo_ambient_reflection_coef is '���̷�Ʈ ���� �ƴ� �ݻ��� ����. �⺻�� 0.5';
comment on column policy.geo_diffuse_reflection_coef is '�ڱ� ������ �ݻ��� ����. �⺻�� 1.0';
comment on column policy.geo_specular_reflection_coef is 'ǥ���� �����Ÿ� ����. �⺻�� 1.0';
comment on column policy.geo_ambient_color is '���̷�Ʈ ���� �ƴ� �ݻ��� RGB, �޸��� ����';
comment on column policy.geo_specular_color is 'ǥ���� �����Ÿ� ����. RGB, �޸��� ����';
comment on column policy.geo_ssao_radius is '�׸��� �ݰ�';
	
comment on column policy.geo_server_enable is 'geo server �������';
comment on column policy.geo_server_url is 'geo server �⺻ Layers url';
comment on column policy.geo_server_layers is 'geo server �⺻ layers';
comment on column policy.geo_server_parameters_service is 'geo server �⺻ Layers service ������';
comment on column policy.geo_server_parameters_version is 'geo server �⺻ Layers version ������';
comment on column policy.geo_server_parameters_request is 'geo server �⺻ Layers request ������';
comment on column policy.geo_server_parameters_transparent is 'geo server �⺻ Layers transparent ������';
comment on column policy.geo_server_parameters_format is 'geo server �⺻ Layers format ������';
comment on column policy.geo_server_add_url is 'geo server �߰� Layers url';
comment on column policy.geo_server_add_layers is 'geo server �߰� Layers';
comment on column policy.geo_server_add_parameters_service is 'geo server �߰� Layers service ������';
comment on column policy.geo_server_add_parameters_version is 'geo server �߰� Layers version ������';
comment on column policy.geo_server_add_parameters_request is 'geo server �߰� Layers request ������';
comment on column policy.geo_server_add_parameters_transparent is 'geo server �߰� Layers transparent ������';
comment on column policy.geo_server_add_parameters_format is 'geo server �߰� Layers format ������';
	
comment on column policy.geo_callback_enable is '�ݹ� function �������. �⺻�� false';
comment on column policy.geo_callback_apiresult is 'api ó�� ��� callback function �̸�';
comment on column policy.geo_callback_datainfo is 'data info ǥ�� callback function �̸�';
comment on column policy.geo_callback_moveddata is 'moved data callback function �̸�';
comment on column policy.geo_callback_selectedobject is 'object ���� callback function �̸�';
comment on column policy.geo_callback_insertissue is 'issue ��� callback function �̸�';
comment on column policy.geo_callback_listissue is 'issue ��� callback function �̸�';
comment on column policy.geo_callback_clickposition is 'mouse click �� ��ġ ���� callback function �̸�';

comment on column policy.notice_service_yn is '�˸� ���� ��� ����. Y : ���, N : ������(�⺻��)';
comment on column policy.notice_service_send_type is '�˸� �߼� ��ü. 0 : SMS(�⺻��), 1 : �̸���, 2 : �޽���';
comment on column policy.notice_risk_yn is '�˸� ��� �߻���. Y : ���, N ������(�⺻��)';
comment on column policy.notice_risk_send_type is '�˸� ��� �߼� ��ü. 0 : SMS(�⺻��), 1 : �̸���, 2 : �޽���';
comment on column policy.notice_risk_grade is '�˸� �߼� ��� ���. 1 : 1���(�⺻��), 2 : 2���, 3 : 3���';

comment on column policy.security_session_timeout_yn is '���� ���� Ÿ�Ӿƿ�. Y : ���, N ������(�⺻��)';
comment on column policy.security_session_timeout is '���� ���� Ÿ�Ӿƿ� �ð�. �⺻�� 30��';
comment on column policy.security_user_ip_check_yn is '�α��� ����� IP üũ ����. Y : ���, N ������(�⺻��)';
comment on column policy.security_session_hijacking is '���� ���� ������ŷ ó��. 0 : ������, 1 : ���(�⺻��), 2 : OTP �߰� ���� ';
comment on column policy.security_sso is '���� SSO. 0 : ������(�⺻��), 1 : TOKEN ����';
comment on column policy.security_sso_token_verify_time is '���� Single Sign-On ��ū ��ȿ�ð�(�д���). �⺻ 3��';
comment on column policy.security_log_save_type is '���� �α� ���� ���. 0 : DB(�⺻��), 1 : ����';
comment on column policy.security_log_save_term is '���� �α� ���� �Ⱓ. 2�� �⺻��';
comment on column policy.security_dynamic_block_yn is '���� ���� ����. Y : ���, N ������(�⺻��)';
comment on column policy.security_api_result_secure_yn is 'API ��� ��ȣȭ ���. Y : ���, N ������(�⺻��)';
comment on column policy.security_masking_yn is '�������� ����ŷ ó��. Y : ���(�⺻��), N ������';

comment on column policy.content_cache_version is 'css, js ���ſ� cache version.';
comment on column policy.content_main_widget_count is '���� ȭ�� ���� ǥ�� ����. �⺻ 6��';
comment on column policy.content_main_widget_interval is '���� ȭ�� ���� Refresh ����. �⺻ 65��(����͸� ���� 60�ʿ� ���� �ð� ���� ���)';
comment on column policy.content_statistics_interval is '��� �⺻ �˻� �Ⱓ. 0 : 1�� ����, 1 : ��/�Ϲݱ�, 2 : �б� ����, 3 : �� ����';
comment on column policy.content_menu_group_root is '�޴� �׷� �ֻ��� �׷��';
comment on column policy.content_user_group_root is '����� �׷� �ֻ��� �׷��';
comment on column policy.content_data_group_root is '������ �׷� �ֻ��� �׷��';

comment on column policy.site_name is '���񽺸�';
comment on column policy.site_admin_name is '����Ʈ �����ڸ�';
comment on column policy.site_admin_mobile_phone is '����Ʈ ������ �ڵ��� ��ȣ';
comment on column policy.site_admin_email is '����Ʈ ������ �̸���';
comment on column policy.site_product_log is '��� �ַ�� �ΰ� �̹���';
comment on column policy.site_company_log is 'Footer ȸ�� �ΰ� �̹���';

comment on column policy.backoffice_email_host IS 'Email ���� ���� host';
comment on column policy.backoffice_email_port IS 'Email ���� ���� ��Ʈ';
comment on column policy.backoffice_email_user IS 'Email ���� ���� �����';
comment on column policy.backoffice_email_password IS 'Email ���� ���� ��й�ȣ';
comment on column policy.backoffice_user_db_driver IS '����� DB ���� Driver';
comment on column policy.backoffice_user_db_url IS '����� DB ���� URL';
comment on column policy.backoffice_user_db_user IS '����� DB ���� �����';
comment on column policy.backoffice_user_db_password IS '����� DB ���� ��й�ȣ';

comment on column policy.solution_name IS '��ǰ��';
comment on column policy.solution_version IS '��ǰ ����';
comment on column policy.solution_company IS '��ǰ ȸ���';
comment on column policy.solution_company_phone IS '��ǰ ȸ�� ����ó';
comment on column policy.solution_manager IS '��ǰ ȸ�� �����';
comment on column policy.solution_manager_phone IS '��ǰ ȸ�� ����� ��ȭ��ȣ';
comment on column policy.solution_manager_email IS '��ǰ ȸ�� ����� �̸���';

comment on column policy.insert_date is '�����';
