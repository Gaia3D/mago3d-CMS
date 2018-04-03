-- Separate FK and Index into separate files. Scheduled to work last
drop table if exists user_group cascade;
drop table if exists user_group_role cascade;
drop table if exists user_group_menu;
drop table if exists user_info cascade;
drop table if exists user_device cascade;

-- User groups
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

comment on table user_group is 'user group';
comment on column user_group.user_group_id is 'unique number';
comment on column user_group.group_key is 'Extension column for link utilization';
comment on column user_group.group_name is 'group name';
comment on column user_group.ancestor is 'ancestor unique number';
comment on column user_group.parent is 'Parent number';
comment on column user_group.depth is 'depth';
comment on column user_group.view_order is 'List order';
comment on column user_group.child_yn is 'child exists, Y: exists, N: does not exist (default)';
comment on column user_group.default_yn is 'Unable to delete, Y: Default, N: select';
comment on column user_group.use_yn is 'Use. Y: Use, N: Do not use';
comment on column user_group.description is 'Description';
comment on column user_group.insert_date is 'Registered Date';

-- Role by user group
create table user_group_role (
	user_group_role_id				int,
	user_group_id					int 								not null,
	role_id							int	 							not null,
	insert_date						timestamp with time zone				default now(),
	constraint user_group_role_pk 	primary key (user_group_role_id)
);

comment on table user_group_role is 'Role by user group';
comment on column user_group_role.user_group_role_id is 'unique number';
comment on column user_group_role.user_group_id is 'User group unique key';
comment on column user_group_role.role_id is 'Role unique key';
comment on column user_group_role.insert_date is 'Registered Date';


-- User group permissions
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

comment on table user_group_menu is 'User group menu';
comment on column user_group_menu.user_group_menu_id is 'unique number';
comment on column user_group_menu.user_group_id is 'User group unique key';
comment on column user_group_menu.menu_id is 'Menu unique key';
comment on column user_group_menu.all_yn is 'Menu access all permissions';
comment on column user_group_menu.read_yn is 'Read permission';
comment on column user_group_menu.write_yn is 'Write permission';
comment on column user_group_menu.update_yn is 'Modify permission';
comment on column user_group_menu.delete_yn is 'Delete permission';
comment on column user_group_menu.insert_date is 'Registered Date';

-- User basics
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

comment on table user_info is 'User Basic Information';
comment on column user_info.user_id is 'unique number';
comment on column user_info.user_group_id is 'User group unique number';
comment on column user_info.user_name is 'name';
comment on column user_info.password is 'Password';
comment on column user_info.salt is 'SALT';
comment on column user_info.telephone is 'phone number';
comment on column user_info.mobile_phone is 'cell phone number';
comment on column user_info.email is 'email';
comment on column user_info.messanger is 'Messenger ID';
comment on column user_info.employee_id is 'employee';
comment on column user_info.postal_code is 'zip code';
comment on column user_info.address is 'Address';
comment on column user_info.address_etc is 'Detailed address';
comment on column user_info.ci is 'real name authentication CI eigenvalue';
comment on column user_info.di is 'real name authentication DI domain unique value';
comment on column user_info.user_role_check_yn is 'User Role privilege check pass for initial login. Default Y: Check';
comment on column user_info.status is 'User state. 0: In use, 1: Disabled (administrator), 2: Locked (password failure exceeded), 3: Sleeping (login period), 4: Expiration = 0), 6: temporary password';
comment on column user_info.user_insert_type is 'User registration method. Default: SELF';
comment on column user_info.sso_use_yn is 'Enable or disable single sign-on. Default is N: Disabled';
comment on column user_info.login_count is 'Login count';
comment on column user_info.fail_login_count is 'Number of login failures';
comment on column user_info.last_login_date is 'Last login date';
comment on column user_info.last_password_change_date is 'Last login password changed on';
comment on column user_info.update_date is 'Personal information modification date';
comment on column user_info.insert_date is 'Registered Date';


-- User-Used Device
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


comment on table user_device is 'User-Used Device';
comment on column user_device.user_device_id is 'unique number';
comment on column user_device.user_id is 'User ID';
comment on column user_device.device_name1 is 'used device name 1';
comment on column user_device.device_type1 is 'Used device type 1. 0: PC, 1: cell phone';
comment on column user_device.device_ip1 is 'IP1';
comment on column user_device.device_priority1 is 'priority 1';
comment on column user_device.use_yn1 is 'Use 1. Y: used, N: not used';
comment on column user_device.description1 is 'Description 1';
comment on column user_device.device_name2 is 'Used device name 2';
comment on column user_device.device_type2 is 'Used device type 2. 0: PC, 1: cell phone';
comment on column user_device.device_ip2 is 'IP2';
comment on column user_device.device_priority2 is 'priority 2';
comment on column user_device.use_yn2 is 'Usage 2. Y: used, N: not used';
comment on column user_device.description2 is 'Description 2';
comment on column user_device.device_name3 is 'Used device name 3';
comment on column user_device.device_type3 is 'Used device type 3. 0: PC, 1: cell phone';
comment on column user_device.device_ip3 is 'IP3';
comment on column user_device.device_priority3 is 'priority 3';
comment on column user_device.use_yn3 is 'Use 3. Y: used, N: not used';
comment on column user_device.description3 is 'Description 3';
comment on column user_device.device_name4 is 'used device name 4';
comment on column user_device.device_type4 is 'Used device type 4. 0: PC, 1: cell phone';
comment on column user_device.device_ip4 is 'IP4';
comment on column user_device.device_priority4 is 'priority 4';
comment on column user_device.use_yn4 is 'Yes ​​4. Y: used, N: not used';
comment on column user_device.description4 is 'Description 4';
comment on column user_device.device_name5 is 'Used device name 5';
comment on column user_device.device_type5 is 'Used device type 5. 0: PC, 1: cell phone';
comment on column user_device.device_ip5 is 'IP5';
comment on column user_device.device_priority5 is 'priority 5';
comment on column user_device.use_yn5 is '5. Y: used, N: not used';
comment on column user_device.description5 is 'Description 5';
comment on column user_device.insert_date is 'Registered Date';
