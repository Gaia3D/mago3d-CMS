drop table if exists policy cascade;

-- 運営ポリシー
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
	geo_data_path						varchar(100)		default '/f4d',
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

comment on table policy is '運営方針';
comment on column policy.policy_id is '固有番号';

comment on column policy.user_id_min_length is 'ユーザー名最小の長さ。デフォルト5';
comment on column policy.user_fail_login_count is 'ユーザーログイン失敗回数';
comment on column policy.user_fail_lock_release is 'ユーザーログイン失敗のロック解除期間';
comment on column policy.user_last_login_lock is 'ユーザーの最後のログインからロックアウト期間';
comment on column policy.user_duplication_login_yn is '重複ログインを許可するかどうか。 Y：許可、N：許可しない(デフォルト)';
comment on column policy.user_login_type is 'ユーザーログイン認証方法。 0：一般的な(ユーザ名/パスワード(デフォルト))、1：エンタープライズ(社員番号を追加)、2：一般的な+ OTP、3：一般的な+証明書、4：OTP +証明書、5：一般+ OTP +証明書';
comment on column policy.user_update_check is 'ユーザー情報の変更時に確認';
comment on column policy.user_delete_check is 'のユーザー情報の削除時に確認';
comment on column policy.user_delete_type is 'のユーザー情報を削除する方法。 0：論理(デフォルト)、1：物理的な(DB削除)';

comment on column policy.password_change_term is 'パスワードの変更周期の基本30日';
comment on column policy.password_min_length is 'パスワード最小長の基本8';
comment on column policy.password_max_length is 'パスワードの最大長の基本32';
comment on column policy.password_eng_upper_count is 'パスワード英語の大文字数基本1';
comment on column policy.password_eng_lower_count is 'パスワード英小文字数基本1';
comment on column policy.password_number_count is 'パスワードの数字数の基本1';
comment on column policy.password_special_char_count is 'パスワードの特殊文字の数1';
comment on column policy.password_continuous_char_count is 'パスワードの連続文字の制限数3';
comment on column policy.password_create_type is 'の初期パスワードを生成する方法。 0：ユーザー名+初期文字(デフォルト)、1：初期文字';
comment on column policy.password_create_char is 'の初期パスワードを生成する文字列です。エクセルアップロードなど';
comment on column policy.password_exception_char is 'パスワードで使用できない特殊文字(XSS)。 <、>、＆、単一引用音符、二重引用括ってもよい';

comment on column policy.geo_view_library is 'view library。基本cesium';
comment on column policy.geo_data_path is 'dataフォルダ。基本/ data';
comment on column policy.geo_data_default_projects is 'の起動時にロードするプロジェクト。配列に格納';
comment on column policy.geo_data_change_request_decision is '데이터 정보 변경 요청에 대한 처리. 0 : 자동승인, 1 : 결재(초기값)';
comment on column policy.geo_cull_face_enable is 'cullFace使用の有無。基本false';
comment on column policy.geo_time_line_enable is 'timeLine使用の有無。基本false';
	
comment on column policy.geo_init_camera_enable is 'の初期カメラ移動の有無。基本true';
comment on column policy.geo_init_latitude is 'の初期カメラ移動緯度';
comment on column policy.geo_init_longitude is 'の初期カメラ移動硬';
comment on column policy.geo_init_height is 'の初期カメラ移動の高さ';
comment on column policy.geo_init_duration is 'の初期カメラ移動時間。秒単位';
comment on column policy.geo_init_default_terrain is '基本Terrain';
comment on column policy.geo_init_default_fov is 'field of view。デフォルト値の0(1.8適用)';
comment on column policy.geo_lod0 is 'LOD0。デフォルト15M';
comment on column policy.geo_lod1 is 'LOD1。デフォルト60M';
comment on column policy.geo_lod2 is 'LOD2。デフォルト90M';
comment on column policy.geo_lod3 is 'LOD3。デフォルト200M';
comment on column policy.geo_lod4 is 'LOD4。デフォルト1000M';
comment on column policy.geo_lod5 is 'LOD5。デフォルト50000M';
comment on column policy.geo_ambient_reflection_coef is 'ダイレクト光ではなく、反射率の範囲。デフォルトは0.5';
comment on column policy.geo_diffuse_reflection_coef is '自分の色の反射率の範囲。デフォルト1.0';
comment on column policy.geo_specular_reflection_coef is 'の表面の盤質感の範囲。デフォルト1.0';
comment on column policy.geo_ambient_color is 'ダイレクト光ではなく、反射率RGB、コンマで接続';
comment on column policy.geo_specular_color is 'の表面の盤質感色。 RGB、コンマで接続';
comment on column policy.geo_ssao_radius is '影半径';
	
comment on column policy.geo_server_enable is 'geo server使用の有無';
comment on column policy.geo_server_url is 'geo server基本Layers url';
comment on column policy.geo_server_layers is 'geo server基本layers';
comment on column policy.geo_server_parameters_service is 'geo server基本Layers service変数の値';
comment on column policy.geo_server_parameters_version is 'geo server基本Layers version変数の値';
comment on column policy.geo_server_parameters_request is 'geo server基本Layers request変数の値';
comment on column policy.geo_server_parameters_transparent is 'geo server基本Layers transparent変数の値';
comment on column policy.geo_server_parameters_format is 'geo server基本Layers format変数の値';
comment on column policy.geo_server_add_url is 'geo server追加Layers url';
comment on column policy.geo_server_add_layers is 'geo server追加Layers';
comment on column policy.geo_server_add_parameters_service is 'geo server追加Layers service変数の値';
comment on column policy.geo_server_add_parameters_version is 'geo server追加Layers version変数の値';
comment on column policy.geo_server_add_parameters_request is 'geo server追加Layers request変数の値';
comment on column policy.geo_server_add_parameters_transparent is 'geo server追加Layers transparent変数の値';
comment on column policy.geo_server_add_parameters_format is 'geo server追加Layers format変数の値';
	
comment on column policy.geo_callback_enable is 'のコールバックfunction使用の有無。デフォルトfalse';
comment on column policy.geo_callback_apiresult is 'api処理結果callback function名';
comment on column policy.geo_callback_datainfo is 'data info 表示 callback function';
comment on column policy.geo_callback_moveddata is 'moved data callback function';
comment on column policy.geo_callback_selectedobject is 'object選択callback function名';
comment on column policy.geo_callback_insertissue is 'issue登録callback function名';
comment on column policy.geo_callback_listissue is 'issueリストcallback function名';
comment on column policy.geo_callback_clickposition is 'mouse click時の位置情報callback function名';

comment on column policy.notice_service_yn is 'の通知サービスを使用の有無。 Y：使用すると、N：を使用しない(デフォルト)';
comment on column policy.notice_service_send_type is 'の通知発送媒体。 0：SMS(デフォルト)、1：電子メール、2：メッセンジャー';
comment on column policy.notice_risk_yn is 'の通知障害発生時。 Y：使用すると、Nを無効にする(デフォルト)';
comment on column policy.notice_risk_send_type is 'の通知障害発送媒体。 0：SMS(デフォルト)、1：電子メール、2：メッセンジャー';
comment on column policy.notice_risk_grade is 'の通知発送障害の評価。 1：1の評価(デフォルト)、2：2評価、3：3評価';

comment on column policy.security_session_timeout_yn is 'のセキュリティセッションタイムアウト。 Y：使用すると、Nを無効にする(デフォルト)';
comment on column policy.security_session_timeout is 'のセキュリティセッションタイムアウトの時間。デフォルト30分';
comment on column policy.security_user_ip_check_yn is 'ログインIPチェックの有無。 Y：使用すると、Nを無効にする(デフォルト)';
comment on column policy.security_session_hijacking is 'のセキュリティセッションハイジャックの処置。 0：使用しない、1：使用(デフォルト)、2：OTP追加の認証';
comment on column policy.security_sso is 'のセキュリティSSO。 0：使用しない(デフォルト)、1：TOKEN認証';
comment on column policy.security_sso_token_verify_time is 'のセキュリティSingle Sign-Onトークンの有効時間(分単位)。基本3分';
comment on column policy.security_log_save_type is 'セキュリティログの保存方法。 0：DB(デフォルト)、1：ファイル';
comment on column policy.security_log_save_term is 'セキュリティログの保存期間。 2年デフォルト';
comment on column policy.security_dynamic_block_yn is 'のセキュリティダイナミックブロックします。 Y：使用すると、Nを無効にする(デフォルト)';
comment on column policy.security_api_result_secure_yn is 'APIの結果、暗号化の使用。 Y：使用すると、Nを無効にする(デフォルト)';
comment on column policy.security_masking_yn is '個人情報マスキング処理します。 Y：使用(デフォルト)、Nを無効にする';

comment on column policy.content_cache_version is 'css、js更新用cache version';
comment on column policy.content_main_widget_count is 'のメイン画面のウィジェット表示本数。基本6個';
comment on column policy.content_main_widget_interval is 'のメイン画面のウィジェットRefresh間隔。基本65秒(監視間隔60秒の時間間隔を考慮)';
comment on column policy.content_statistics_interval is '統計の基本検索の期間。 0：1年単位、1：上/後半、2四半期単位、3：月ごと';
comment on column policy.content_menu_group_root is 'メニューグループの最上位グループ名';
comment on column policy.content_user_group_root is 'ユーザーグループの最上位グループ名';
comment on column policy.content_data_group_root is 'のデータグループの最上位グループ名';

comment on column policy.site_name is 'サービス名';
comment on column policy.site_admin_name is 'サイト管理者名';
comment on column policy.site_admin_mobile_phone is 'サイト管理者の携帯電話番号';
comment on column policy.site_admin_email is 'サイト管理者の電子メール';
comment on column policy.site_product_log is 'の上部のソリューションロゴ画像';
comment on column policy.site_company_log is 'Footer会社のロゴ画像';

comment on column policy.backoffice_email_host IS 'Email連動サーバhost';
comment on column policy.backoffice_email_port IS 'Email連動サーバーのポート';
comment on column policy.backoffice_email_user IS 'Email連動サーバーのユーザー';
comment on column policy.backoffice_email_password IS 'Email連動サーバーのパスワード';
comment on column policy.backoffice_user_db_driver IS 'のユーザーDB連動Driver';
comment on column policy.backoffice_user_db_url IS 'のユーザーDB連動URL';
comment on column policy.backoffice_user_db_user IS 'のユーザーDB連動ユーザー';
comment on column policy.backoffice_user_db_password IS 'のユーザーDB連動パスワード';

comment on column policy.solution_name IS '商品名';
comment on column policy.solution_version IS '製品版';
comment on column policy.solution_company IS '製品会社名';
comment on column policy.solution_company_phone IS '製品会社の連絡先';
comment on column policy.solution_manager IS '製品会社の担当者';
comment on column policy.solution_manager_phone IS '製品会社の担当者の電話番号';
comment on column policy.solution_manager_email IS '製品会社の担当者の電子メール';

comment on column policy.insert_date is '登録';
