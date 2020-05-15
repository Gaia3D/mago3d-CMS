update geopolicy set
	geoserver_data_url = 'http://localhost:8080/geoserver',
	geoserver_data_workspace = 'mago3d',
	geoserver_data_store ='mago3d',
	geoserver_user ='admin',
	geoserver_password = 'geoserver';


-- smart tiling 이후에 해 줘야 할 작업, 벌크 업로드 시 처리됨.
-- 1 데이터 건수 수정	

-- 2 데이터 타입 수정
-- 한줄짜리는 위험

-- 3 그룹 기본 좌표 확인
