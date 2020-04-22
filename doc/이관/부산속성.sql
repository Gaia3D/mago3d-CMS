-- 부산시 데이터 건수
select * from data_group where data_group_name like '부산%'
select count(*) from data_info where data_group_id in (20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30);
-- 부산 광역시 데이터 총 건수 : 79, 556건)
-- 부산 명지 1동 건물 : 4795건
-- 부산 EDC : 691건
-- 부산 스마트 빌리지 : 56건
-- 부산시 일반 주택 : 16,134건
-- 부산시 공동 주택 : 977건
-- 부산시 공공기관 : 3건
-- 부산시 산업 시설 : 14, 542건
-- 부산시 문화 교육 시설 : 674건
-- 부산시 의료 복지 시설 : 104건
-- 부산시 서비스 시설 : 408건
-- 부산시 기타 시설 : 41,172건




-- 부산 명지 아파트
data_group_id = 20
data_group_key = 'busan-mj';

-- 118 건
select count(*)
from data_info where data_group_id = 20;

-- 건물명이 null 이 아닌 건수 384건
select count(*) 
from mj_build
where buld_nm is not null;

-- 건물부 명칭 null 이 아닌 건수 554건
select count(*) 
from mj_build
where buld_nm is not null;

-- 전체 매핑 건수 data_key 로 매핑. 건물명칭이 null 이 아닌 경우 384건
select data_id, data_key, data_name, build_name, buld_nm
from data_info A, mj_build B
where A.data_key = B.build_name
	AND A.data_group_id = 20
	AND B.buld_nm is not null;


-- 데이터 명을 update
update data_info
set data_name = Z.buld_nm
from (
		select data_id, data_key, data_name, build_name, buld_nm
		from data_info A, mj_build B
		where A.data_key = B.build_name
			AND A.data_group_id = 20
			AND B.buld_nm is not null
) AS Z
where data_info.data_id = Z.data_id;

-- 속성 존재 유무를 update
update data_info
set attribute_exist = true
from (
		select data_id, data_key, data_name, build_name, buld_nm
		from data_info A, mj_build B
		where A.data_key = B.build_name
			AND A.data_group_id = 20
) AS Z
where data_info.data_id = Z.data_id;

commit;