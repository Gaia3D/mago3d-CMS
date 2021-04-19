update geopolicy set
	geoserver_data_url = 'http://localhost:18080/geoserver',
	geoserver_data_workspace = 'mago3d',
	geoserver_data_store ='mago3d',
	geoserver_user ='admin',
	geoserver_password = 'geoserver';


-- 고사양 PC일 경우 포인트클라우드 파라미터 최적화
update geopolicy set
    max_ratio_points_dist_0m = 1,
    max_ratio_points_dist_100m = 3,
    max_ratio_points_dist_200m = 10,
    max_ratio_points_dist_400m = 20,
    max_ratio_points_dist_800m = 40,
    max_ratio_points_dist_1600m = 80,
    max_ratio_points_dist_over_1600m = 160;
