-- FK、Indexは別途ファイルに分離した。最後に作業予定
drop table if exists project cascade;
drop table if exists data_info cascade;

-- ユーザーグループ
create table project(
	project_id				int,
	project_key				varchar(60)							not null ,
	project_name			varchar(100)						not null,
	view_order				int							default 1,
	default_yn				char(1)								default 'N',
	use_yn					char(1)								default 'Y',
	latitude				numeric(13,10),
	longitude				numeric(13,10),
	height					numeric(7,3),
	duration				int,
	description				varchar(256),
	insert_date				timestamp with time zone			default now(),
	constraint project_pk 	primary key (project_id)	
);

comment on table project is 'project（F4D Data）グループ';
comment on column project.project_id is '固有番号';
comment on column project.project_key is 'リンクを活用等のための拡張カラム';
comment on column project.project_name is 'プロジェクト';
comment on column project.view_order is '一覧表示順';
comment on column project.default_yn is 'の削除不可、Y：基本、N：選択';
comment on column project.use_yn is 'を使用の有無、Y：使用すると、N：を無効にする';
comment on column project.latitude is '緯度';
comment on column project.longitude is '硬度';
comment on column project.height is '高';
comment on column project.duration is 'flyTo移動時間';
comment on column project.description is 'の説明';
comment on column project.insert_date is '登録';


-- Data基本情報
create table data_info(
	data_id						bigint,
	project_id					int							not null,
	data_key					varchar(128)						not null,
	data_name					varchar(64),
	parent						bigint								default 1,
	depth						int							default 1,
	view_order					int							default 1,
	child_yn					char(1)								default 'N',
	mapping_type				varchar(30)							default 'origin',
	location		 			GEOGRAPHY(POINT, 4326),
	latitude					numeric(13,10),
	longitude					numeric(13,10),
	height						numeric(7,3),
	heading						numeric(8,5),
	pitch						numeric(8,5),
	roll						numeric(8,5),
	attributes					jsonb,
	status						char(1)								default '0',
	public_yn					char(1)								default 'N',
	data_insert_type			varchar(30)							default 'SELF',
	description					varchar(256),
	update_date					timestamp with time zone,
	insert_date					timestamp with time zone			default now(),
	constraint data_info_pk 	primary key(data_id)
);

comment on table data_info is 'Data情報';
comment on column data_info.data_id is '固有番号';
comment on column data_info.project_id is 'project固有番号';
comment on column data_info.data_key is 'data一意の識別番号';
comment on column data_info.data_name is 'data名';
comment on column data_info.parent is '親 data_id';
comment on column data_info.depth is 'depth';
comment on column data_info.view_order is 'sort';
comment on column data_info.child_yn is 'children';
comment on column data_info.mapping_type is 'Defaults to origin: aligns latitude, longitude, and height to origin. boundingboxcenter: align latitude, longitude, height boundingboxcenter';
comment on column data_info.location is 'は、緯度、経度の情報';
comment on column data_info.latitude is '緯度';
comment on column data_info.longitude is '硬度';
comment on column data_info.height is '高';
comment on column data_info.heading is 'heading';
comment on column data_info.pitch is 'pitch';
comment on column data_info.roll is 'roll';
comment on column data_info.attributes is 'Data Controlのプロパティ';
comment on column data_info.public_yn is '公開の有無。デフォルトN(プライベート)';
comment on column data_info.status is 'Data状態。 0：使用中、1：無効（管理者）、2：その他の';
comment on column data_info.data_insert_type is 'dataの登録方法。基本：SELF';
comment on column data_info.description is 'の説明';
comment on column data_info.update_date is '更新日';
comment on column data_info.insert_date is '登録';

-- pointは、経度、緯度の順だ。
-- insert into data_info(location) values(st_geometryfromtext('POINT(128.5952254 34.93630567)'))
