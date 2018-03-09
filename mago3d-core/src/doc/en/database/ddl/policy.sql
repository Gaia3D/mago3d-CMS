drop table if exists policy cascade;

-- Operational policy
create table policy(
	policy_id							smallint,
	
	user_id_min_length					smallint			default 5,
	user_fail_login_count				smallint			default 3,
	user_fail_lock_release				varchar(3)			default '30',
	user_last_login_lock				varchar(3)			default '90',
	user_duplication_login_yn			char(1)				default 'N',
	user_login_type						char(1)				default '0',
	user_update_check					char(1)				default '0',
	user_delete_check					char(1)				default '0',
	user_delete_type					char(1)				default '0',
	
	password_change_term 				varchar(3)			default '30',
	password_min_length					smallint			default 8,
	password_max_length					smallint			default 32,
	password_eng_upper_count 			smallint			default 1,
	password_eng_lower_count 			smallint			default 1,
	password_number_count 				smallint			default 1,
	password_special_char_count 		smallint			default 1,
	password_continuous_char_count 		smallint			default 3,
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
	geo_init_duration					smallint			default 3,
	geo_init_default_terrain			varchar(64),
	geo_init_default_fov				smallint			default 0,
	
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
	geo_callback_selectedObject				varchar(64),
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
	security_sso_token_verify_time		smallint			default 3,
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
	
	insert_date				timestamp without time zone			default now(),
	constraint policy_pk primary key (policy_id)	
);

comment on table policy is 'operational policy';
comment on column policy.policy_id is 'unique number';

comment on column policy.user_id_min_length is 'User ID minimum length. Default is 5';
comment on column policy.user_fail_login_count is 'Number of user login failures';
comment on column policy.user_fail_lock_release is 'User login failure unlock period';
comment on column policy.user_last_login_lock is 'User lockout period from last login';
comment on column policy.user_duplication_login_yn is 'Allow duplicate logins. Y: allowed, N: not allowed (default)';
comment on column policy.user_login_type is 'User login authentication method. 0: General (ID / password (default)), 1: Enterprise (additional number), 2: Generic + OTP, 3: Generic + certificate, 4: OTP + certificate, 5: Generic + OTP + certificate';
comment on column policy.user_update_check is 'Confirm when modifying user information';
comment on column policy.user_delete_check is 'Confirm when deleting user information';
comment on column policy.user_delete_type is 'How to delete user information. 0: Logical (default), 1: Physical (DB delete)';

comment on column policy.password_change_term is 'Password change cycle default 30 days';
comment on column policy.password_min_length is 'Password minimum length default 8';
comment on column policy.password_max_length is 'Maximum password length 32';
comment on column policy.password_eng_upper_count is 'Password uppercase capital number base 1';
comment on column policy.password_eng_lower_count is 'Password Lowercase Number Default 1';
comment on column policy.password_number_count is 'Number of password digits default 1';
comment on column policy.password_special_char_count is 'Password special character count 1';
comment on column policy.password_continuous_char_count is 'Password consecutive character limit 3';
comment on column policy.password_create_type is 'How to create an initial password. 0: user ID + initial character (default), 1: initial character';
comment on column policy.password_create_char is 'Initial password generation string. Excel upload, etc';
comment on column policy.password_exception_char is 'Special character (XSS) that can not be used as a password. <,>, &, Pound, double pound';

comment on column policy.geo_view_library is 'view library. Basic cesium';
comment on column policy.geo_data_path is 'data folder. Default / data';
comment on column policy.geo_data_default_projects is 'Loading project at startup. Save as array';
comment on column policy.geo_data_change_request_decision is '데이터 정보 변경 요청에 대한 처리. 0 : 자동승인, 1 : 결재(초기값)';
comment on column policy.geo_cull_face_enable is 'Use of cullFace. Default false';
comment on column policy.geo_time_line_enable is 'Use timeLine. Default false';
	
comment on column policy.geo_init_camera_enable is' Initial camera movement. Default true ';
comment on column policy.geo_init_latitude is 'Initial camera movement latitude';
comment on column policy.geo_init_longitude is 'Initial camera moving hardness';
comment on column policy.geo_init_height is 'Initial camera movement height';
comment on column policy.geo_init_duration is' Initial camera move time. Seconds';
comment on column policy.geo_init_default_terrain is 'Default Terrain';
comment on column policy.geo_init_default_fov is' field of view. Default is 0 (1.8 applies) ';
comment on column policy.geo_lod0 is' LOD0. Default is 15M ';
comment on column policy.geo_lod1 is' LOD1. Default 60M ';
comment on column policy.geo_lod2 is' LOD2. Default is 90M ';
comment on column policy.geo_lod3 is' LOD3. Default 200M ';
comment on column policy.geo_lod4 is' LOD4. Default 1000M ';
comment on column policy.geo_lod5 is' LOD5. Default is 50000M ';
comment on column policy.geo_ambient_reflection_coef is' Reflectance range, not direct light. Default is 0.5 ';
comment on column policy.geo_diffuse_reflection_coef is' Reflectivity range of self color. Default is 1.0 ';
comment on column policy.geo_specular_reflection_coef is' Span of the surface. Default is 1.0 ';
comment on column policy.geo_ambient_color is 'Direct light, not reflectance RGB, comma';
comment on column policy.geo_specular_color is' The color of the surface shattering. RGB, comma ';
comment on column policy.geo_ssao_radius is 'shadow radius';
	
comment on column policy.geo_server_enable is 'Use geo server';
comment on column policy.geo_server_url is 'geo server Default Layers url';
comment on column policy.geo_server_layers is 'geo server default layers';
comment on column policy.geo_server_parameters_service is 'geo server Default Layers service variable value';
comment on column policy.geo_server_parameters_version is 'geo server Default Layers version variable value';
comment on column policy.geo_server_parameters_request is 'geo server Default Layers request variable value';
comment on column policy.geo_server_parameters_transparent is 'geo server Default Layers transparent variable value';
comment on column policy.geo_server_parameters_format is 'geo server Default Layers format variable value';
comment on column policy.geo_server_add_url is 'geo server Add Layers url';
comment on column policy.geo_server_add_layers is 'geo server Add Layers';
comment on column policy.geo_server_add_parameters_service is 'geo server Additional Layers service variable value';
comment on column policy.geo_server_add_parameters_version is 'geo server Additional Layers version variable value';
comment on column policy.geo_server_add_parameters_request is 'geo server Additional Layers request variable value';
comment on column policy.geo_server_add_parameters_transparent is 'geo server additional Layers transparent variable value';
comment on column policy.geo_server_add_parameters_format is 'geo server Additional Layers format variable value';
	
comment on column policy.geo_callback_enable is 'Enable or disable callback function. Default false';
comment on column policy.geo_callback_apiresult is 'api processing result callback function name';
comment on column policy.geo_callback_dataInfo is 'data info 표시 callback function 이름';
comment on column policy.geo_callback_selectedObject is 'select object callback function name';
comment on column policy.geo_callback_insertIssue is 'issue registration callback function name';
comment on column policy.geo_callback_listIssue is 'issue list callback function name';
comment on column policy.geo_callback_clickposition is 'Position information callback function name at mouse click';

comment on column policy.notice_service_yn is 'Enable or disable notification service. Y: Enabled, N: Disabled (default)';
comment on column policy.notice_service_send_type is 'Notification delivery medium. 0: SMS (default), 1: Email, 2: Messenger';
comment on column policy.notice_risk_yn is 'Notification failure. Y: enabled, N disabled (default)';
comment on column policy.notice_risk_send_type is 'Notification Dispatch medium. 0: SMS (default), 1: Email, 2: Messenger';
comment on column policy.notice_risk_grade is 'Notification Disability Rating. 1: 1 rating (default), 2: 2 rating, 3: 3 rating';

comment on column policy.security_session_timeout_yn is 'Security session timeout. Y: enabled, N disabled (default)';
comment on column policy.security_session_timeout is 'Security session timeout time. Default is 30 minutes';
comment on column policy.security_user_ip_check_yn is 'Checking login user IP. Y: enabled, N disabled (default)';
comment on column policy.security_session_hijacking is 'Security session hijacking processing. 0: Disabled, 1: Enabled (default), 2: OTP additional authentication';
comment on column policy.security_sso is 'Secure SSO. 0: Disable (default), 1: TOKEN authentication';
comment on column policy.security_sso_token_verify_time is'Security Single Sign-On token valid time in minutes. Basic 3 minutes';
comment on column policy.security_log_save_type is 'How to save the security log. 0: DB (default), 1: file';
comment on column policy.security_log_save_term is 'Security log retention period. 2 years default';
comment on column policy.security_dynamic_block_yn is 'Secure dynamic blocking. Y: enabled, N disabled (default)';
comment on column policy.security_api_result_secure_yn is 'Enable API result encryption. Y: enabled, N disabled (default)';
comment on column policy.security_masking_yn is 'Personal information masking processing. Y: enabled (default), N disabled';

comment on column policy.content_cache_version is 'css, js cache version for updating.';
comment on column policy.content_main_widget_count is' The number of main screen widget displays. Basic 6 ';
comment on column policy.content_main_widget_interval is' Main screen widget Refresh interval. Default is 65 seconds (considering the time interval for monitoring interval 60 seconds) ';
comment on column policy.content_statistics_interval is' Statistics default search period. 0: year unit, 1: upper / second half, 2: quarter unit, 3: monthly unit ';
comment on column policy.content_menu_group_root is 'menu group top group name';
comment on column policy.content_user_group_root is 'User group top group name';
comment on column policy.content_data_group_root is 'Data group top group name';

comment on column policy.site_name is 'service name';
comment on column policy.site_admin_name is 'Site administrator name';
comment on column policy.site_admin_mobile_phone is 'Site admin phone number';
comment on column policy.site_admin_email is 'Site admin email';
comment on column policy.site_product_log is 'Top solution logo image';
comment on column policy.site_company_log is 'Footer company logo image';

comment on column policy.backoffice_email_host IS 'Email interworking server host';
comment on column policy.backoffice_email_port IS 'Email interworking server port';
comment on column policy.backoffice_email_user IS 'Email linked server user';
comment on column policy.backoffice_email_password IS 'Email linked server password';
comment on column policy.backoffice_user_db_driver IS 'User DB linked Driver';
comment on column policy.backoffice_user_db_url IS 'User DB associated URL';
comment on column policy.backoffice_user_db_user IS 'User DB associated user';
comment on column policy.backoffice_user_db_password IS 'User DB login password';

comment on column policy.solution_name IS 'product name';
comment on column policy.solution_version IS 'product version';
comment on column policy.solution_company IS 'Product Company Name';
comment on column policy.solution_company_phone IS 'Product Company Contact';
comment on column policy.solution_manager IS 'Product contact person';
comment on column policy.solution_manager_phone IS 'Product Company Contact Phone';
comment on column policy.solution_manager_email IS 'Product contact person email';

comment on column policy.insert_date is 'Registered Date';
