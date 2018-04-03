-- FK、Indexは別途ファイルに分離した。最後に作業予定
drop table if exists user_group cascade;
drop table if exists user_group_role cascade;
drop table if exists user_group_menu;
drop table if exists user_info cascade;
drop table if exists user_device cascade;

-- ユーザーグループ
create table user_group(
	user_group_id				int,
	group_key					varchar(60)							not null ,
	group_name					varchar(100)						not null,
	ancestor					int							default 0,
	parent						int							default 1,
	depth						int							default 1,
	view_order					int							default 1,
	child_yn					char(1)								default 'N',
	default_yn					char(1)								default 'N',
	use_yn						char(1)								default 'Y',
	description					varchar(256),
	insert_date					timestamp with time zone			default now(),
	constraint user_group_pk 	primary key (user_group_id)	
);

comment on table user_group is 'ユーザーグループ';
comment on column user_group.user_group_id is '固有番号';
comment on column user_group.group_key is 'リンクを活用等のための拡張カラム';
comment on column user_group.group_name is 'グループ名';
comment on column user_group.ancestor is 'の祖先固有番号';
comment on column user_group.parent is '両親固有番号';
comment on column user_group.depth is '深さ';
comment on column user_group.view_order is '一覧表示順';
comment on column user_group.child_yn is '子の存在の有無、Y：存在する、N：存在しない(基本)';
comment on column user_group.default_yn is 'の削除不可、Y：基本、N：選択';
comment on column user_group.use_yn is 'を使用の有無、Y：使用すると、N：を無効にする';
comment on column user_group.description is 'の説明';
comment on column user_group.insert_date is '登録';

-- ユーザーグループ別Role
create table user_group_role (
	user_group_role_id				int,
	user_group_id					int 								not null,
	role_id							int	 							not null,
	insert_date						timestamp with time zone				default now(),
	constraint user_group_role_pk 	primary key (user_group_role_id)
);

comment on table user_group_role is 'ユーザーグループごとRole';
comment on column user_group_role.user_group_role_id is '固有番号';
comment on column user_group_role.user_group_id is 'ユーザーグループ固有のキー';
comment on column user_group_role.role_id is 'Role固有のキー';
comment on column user_group_role.insert_date is '登録日';

-- ユーザーグループの権限
create table user_group_menu(
	user_group_menu_id				int,
	user_group_id					int 							not null,
	menu_id							int 							not null,
	all_yn							char(1)								default 'N',
	read_yn							char(1)								default 'N',
	write_yn						char(1)								default 'N',
	update_yn						char(1)								default 'N',
	delete_yn						char(1)								default 'N',
	insert_date						timestamp with time zone			default now(),
	constraint user_group_menu_pk 	primary key (user_group_menu_id)
);

comment on table user_group_menu is 'ユーザーグループメニュー';
comment on column user_group_menu.user_group_menu_id is '固有番号';
comment on column user_group_menu.user_group_id is 'ユーザーグループ固有のキー';
comment on column user_group_menu.menu_id is 'メニュー固有のキー';
comment on column user_group_menu.all_yn is 'メニューアクセスのすべての権限';
comment on column user_group_menu.read_yn is '読み取り権限';
comment on column user_group_menu.write_yn is '書き込み権限';
comment on column user_group_menu.update_yn is '修正権限';
comment on column user_group_menu.delete_yn is '削除権限';
comment on column user_group_menu.insert_date is '登録日';


-- ユーザーの基本情報
create table user_info(
	user_id						varchar(32),
	user_group_id				int								not null,
	user_name					varchar(64)							not null,
	password					varchar(512)						not null,
	salt						varchar(256)						not null,
	telephone					varchar(256),
	mobile_phone				varchar(256),
	email						varchar(256),
	messanger					varchar(100),
	employee_id 				varchar(20),
  	postal_code					varchar(6),
	address						varchar(256),
	address_etc					varchar(1000),
	ci							varchar(256),
	di							varchar(256),
	status						char(1)								default '0',
	user_role_check_yn			char(1)								default 'Y',
	user_insert_type			varchar(30)							default 'USER_REGISTER_SELF',
	sso_use_yn					char(1)								default 'N',
	login_count					bigint								default 0,
	fail_login_count			int							default 0,
	last_login_date				timestamp with time zone,
	last_password_change_date	timestamp with time zone			default now(),
	update_date					timestamp with time zone,
	insert_date				timestamp with time zone			default now(),
	constraint user_info_pk primary key(user_id)
);

comment on table user_info is 'ユーザーの基本情報';
comment on column user_info.user_id is '固有番号';
comment on column user_info.user_group_id is 'ユーザーグループ固有の番号';
comment on column user_info.user_name is 'name';
comment on column user_info.password is  'パスワード';
comment on column user_info.salt is 'SALT';
comment on column user_info.telephone is '電話番号';
comment on column user_info.mobile_phone is '携帯電話番号';
comment on column user_info.email is 'メール';
comment on column user_info.messanger is 'メッセンジャーIDを';
comment on column user_info.employee_id is '社員番号';
comment on column user_info.postal_code is '郵便番号';
comment on column user_info.address is 'アドレス';
comment on column user_info.address_etc is '詳細アドレス';
comment on column user_info.ci is '実名認証CI固有値';
comment on column user_info.di is '実名認証DIドメイン固有の値';
comment on column user_info.user_role_check_yn is '最初のログイン時にユーザーRole権限チェックパス機能。デフォルトY：チェック';
comment on column user_info.status is 'ユーザーの状態。 0：使用中、1：無効(管理者)、2：ロック(パスワード失敗回数を超える)、3：休眠(ログイン期間)、4：有効期限(使用期間終了)、5：削除(画面非表示、policy.user_delete_type = 0)、6：仮パスワード';
comment on column user_info.user_insert_type is 'ユーザー登録方法。基本：SELF';
comment on column user_info.sso_use_yn is 'Single Sign-Onを使用の有無。デフォルトN：使用不可';
comment on column user_info.login_count is 'ログイン回数';
comment on column user_info.fail_login_count is 'ログイン失敗回数';
comment on column user_info.last_login_date is '最終ログイン ';
comment on column user_info.last_password_change_date is '最終ログインパスワード変更日';
comment on column user_info.update_date is '個人情報の変更日付';
comment on column user_info.insert_date is '登録日';


-- ユーザーの使用デバイス
create table user_device (
	user_device_id				bigint,
	user_id						varchar(32)	 						not null,
	device_name1				varchar(60)							not null,
	device_type1				char(1)								default '0',
	device_ip1					varchar(45),
	device_priority1			int							default 1,
	use_yn1						char(1)								default 'Y',
	description1				varchar(256),
	device_name2				varchar(60)							not null,
	device_type2				char(1)								default '0',
	device_ip2					varchar(45),
	device_priority2			int							default 2,
	use_yn2						char(1)								default 'Y',
	description2				varchar(256),
	device_name3				varchar(60)							not null,
	device_type3				char(1)								default '0',
	device_ip3					varchar(45),
	device_priority3			int							default 3,
	use_yn3						char(1)								default 'Y',
	description3				varchar(256),
	device_name4				varchar(60)							not null,
	device_type4				char(1)								default '0',
	device_ip4					varchar(45),
	device_priority4			int							default 4,
	use_yn4						char(1)								default 'Y',
	description4				varchar(256),
	device_name5				varchar(60)							not null,
	device_type5				char(1)								default '0',
	device_ip5					varchar(45),
	device_priority5			int							default 5,
	use_yn5						char(1)								default 'Y',
	description5				varchar(256),
	insert_date				timestamp with time zone			default now(),
	constraint user_device_pk primary key (user_device_id)
);


comment on table user_device is 'ユーザーの使用デバイス';
comment on column user_device.user_device_id is '固有番号';
comment on column user_device.user_id is 'ユーザID';
comment on column user_device.device_name1 is 'を使用機器名1';
comment on column user_device.device_type1 is '使用機器タイプ1。 0：PC、1：携帯電話';
comment on column user_device.device_ip1 is 'IP1';
comment on column user_device.device_priority1 is 'の優先順位1';
comment on column user_device.use_yn1 is 'を使用の有無1。 Y：使用すると、N：未使用';
comment on column user_device.description1 is 'の説明1';
comment on column user_device.device_name2 is 'を使用機器名2';
comment on column user_device.device_type2 is '使用機器タイプ2。 0：PC、1：携帯電話';
comment on column user_device.device_ip2 is 'IP2';
comment on column user_device.device_priority2 is 'の優先順位2';
comment on column user_device.use_yn2 is 'を使用の有無2。 Y：使用すると、N：未使用';
comment on column user_device.description2 is '説明2';
comment on column user_device.device_name3 is 'を使用機器名3';
comment on column user_device.device_type3 is '使用機器タイプ3。 0：PC、1：携帯電話';
comment on column user_device.device_ip3 is 'IP3';
comment on column user_device.device_priority3 is 'の優先順位3';
comment on column user_device.use_yn3 is 'を使用の有無3。 Y：使用すると、N：未使用';
comment on column user_device.description3 is 'の説明3';
comment on column user_device.device_name4 is 'を使用機器名4';
comment on column user_device.device_type4 is '使用機器タイプ4。 0：PC、1：携帯電話';
comment on column user_device.device_ip4 is 'IP4';
comment on column user_device.device_priority4 is 'の優先順位4';
comment on column user_device.use_yn4 is 'を使用の有無4。 Y：使用すると、N：未使用';
comment on column user_device.description4 is 'の説明4';
comment on column user_device.device_name5 is 'を使用機器名5';
comment on column user_device.device_type5 is '使用機器タイプ5。 0：PC、1：携帯電話';
comment on column user_device.device_ip5 is 'IP5';
comment on column user_device.device_priority5 is 'の優先順位5';
comment on column user_device.use_yn5 is 'を使用の有無5。 Y：使用すると、N：未使用';
comment on column user_device.description5 is 'の説明5';
comment on column user_device.insert_date is '登録日';
