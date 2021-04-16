drop table if exists terrain cascade;

-- 위젯
create table terrain(
    terrain_id				                                    integer,
    terrain_name			                                    varchar(100)					not null,
    terrain_type				                                varchar(30)			            default 'cesium-default',
    geoserver_terrainprovider_layer_name				        varchar(60),
    url				                                            varchar(256)					not null,
    icon_path                                                   varchar(256)					not null,
    basic						                                boolean							default false,
    view_order				                                    integer							default 1,
    insert_date				                                    timestamp with time zone		default now(),
    constraint terrain_pk 	    primary key (terrain_id)
);

comment on table terrain is 'Terrain';
comment on column terrain.terrain_id is '고유번호';
comment on column terrain.terrain_name is '이름';
comment on column terrain.terrain_type is 'Terrain 유형. geoserver, cesium-default, cesium-ion-default, cesium-ion-cdn : 우리 dem 을 업로딩, cesium-customer : cesium docker provier';
comment on column terrain.geoserver_terrainprovider_layer_name is 'geoserver terrainprovider 로 사용할 레이어명';
comment on column terrain.url is 'url';
comment on column terrain.icon_path is '아이콘 경로';
comment on column terrain.basic is '기본 Terrain(여러개중 1개만 true). true : 활성화, false : 비활성화';
comment on column terrain.view_order is '표시 순서';
comment on column terrain.insert_date is '등록일';