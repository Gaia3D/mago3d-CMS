-- 사용자 그룹 테이블 기본값 입력
insert into user_group(	user_group_id, user_group_key, user_group_name, ancestor, parent, depth, view_order, basic, available, description)
values
	(1, 'SUPER_ADMIN', '슈퍼 관리자', 1, 0, 1, 1, 'Y', 'Y', '기본값'),
	(2, 'USER', '사용자', 1, 0, 1, 2, 'Y', 'Y', '기본값'),
	(3, 'GUEST', 'GUEST', 1, 0, 1, 3, 'Y', 'Y', '기본값');

-- 슈퍼 관리자 등록
insert into user_info(
	user_id, user_group_id, user_name, password, user_role_check_yn, last_signin_date)
values
    ('admin', 1, '슈퍼관리자', '$2a$10$KFr/2p5Og2jBy8NkTaEb/eoUna6AVlQ.A7s4YpPJ9A8dZwLYum5f.', 'N', now()),
    ('mago3d', 2, 'mago3D', '$2a$10$lmYPqp2UJm4lHuF57Rs.wuzX034x7y/21jlCc8OQ4yFxbZt6Iich2', 'Y', now());

-- 관리자 메뉴
insert into menu(menu_id, menu_type, menu_target, name, name_en, ancestor, parent, depth, previous_depth, view_order, url, url_alias, html_id, css_class, default_yn, use_yn, display_yn)
values
	(1, '0', '1', '홈', 'HOME', 0, 0, 1, 0, 1, '/main/index', null, null, 'glyph-home', 'N', 'N', 'N'),
	(2, '0', '1', '사용자', 'USER', 2, 0, 1, 0, 2, '/user/list', null, null, 'glyph-users', 'Y', 'Y', 'Y'),
	(21, '0', '1', '사용자 그룹', 'USER', 2, 2, 2, 1, 1, '/user-group/list', null, null, 'glyph-users', 'Y', 'Y', 'Y'),
	(22, '0', '1', '사용자 그룹 등록', 'USER', 2, 2, 2, 2, 2, '/user-group/input', '/user-group/list', null, 'glyph-users', 'Y', 'Y', 'Y'),
	(23, '0', '1', '사용자 그룹 수정', 'USER', 2, 2, 2, 2, 3, '/user-group/modify', '/user-group/list', null, 'glyph-users', 'N', 'Y', 'N'),
	(24, '0', '1', '사용자 그룹 메뉴', 'USER', 2, 2, 2, 2, 4, '/user-group/menu', '/user-group/list', null, 'glyph-users', 'N', 'Y', 'N'),
	(25, '0', '1', '사용자 그룹 Role', 'USER', 2, 2, 2, 2, 5, '/user-group/role', '/user-group/list', null, 'glyph-users', 'N', 'Y', 'N'),
	(26, '0', '1', '사용자 목록', 'USER', 2, 2, 2, 2, 6, '/user/list', null, null, 'glyph-users', 'Y', 'Y', 'Y'),
	(27, '0', '1', '사용자 등록', 'USER', 2, 2, 2, 2, 7, '/user/input', '/user/list', null, 'glyph-users', 'Y', 'Y', 'Y'),
	(28, '0', '1', '사용자 정보 수정', 'USER', 2, 2, 2, 2, 8, '/user/modify', '/user/list', null, 'glyph-users', 'N', 'Y', 'N'),
	(29, '0', '1', '사용자 상세 정보', 'USER', 2, 2, 2, 2, 9, '/user/detail', '/user/list', null, 'glyph-users', 'N', 'Y', 'N'),

	(3, '0', '1', '데이터', 'DATA', 3, 0, 1, 2, 3, '/tile/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
    (31, '0', '1', '스마트 타일링', 'TILE', 3, 3, 2, 1, 1, '/tile/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
    (32, '0', '1', '스마트 타일링 등록', 'TILE', 3, 3, 2, 2, 2, '/tile/input', '/tile/list', null, 'glyph-monitor', 'Y', 'Y', 'Y'),
    (33, '0', '1', '스마트 타일링 수정', 'TILE', 3, 3, 2, 2, 3, '/tile/modify', '/tile/list', null, 'glyph-monitor', 'N', 'Y', 'N'),
	(34, '0', '1', '데이터 그룹', 'DATA', 3, 3, 2, 2, 4, '/data-group/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(35, '0', '1', '데이터 그룹 등록', 'DATA', 3, 3, 2, 2, 5, '/data-group/input', '/data-group/list', null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(36, '0', '1', '데이터 그룹 수정', 'DATA', 3, 3, 2, 2, 6, '/data-group/modify', '/data-group/list', null, 'glyph-monitor', 'N', 'Y', 'N'),
	(37, '0', '1', '사용자 데이터 그룹', 'DATA', 3, 3, 2, 2, 7, '/data-group/list-user', null, null, 'glyph-monitor', 'Y', 'N', 'Y'),
	(38, '0', '1', '데이터 목록', 'DATA', 3, 3, 2, 2, 8, '/data/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(39, '0', '1', '데이터 상세 정보', 'DATA', 3, 3, 2, 2, 9, '/data/detail', '/data/list', null, 'glyph-monitor', 'N', 'Y', 'N'),
	(40, '0', '1', '데이터 수정', 'DATA', 3, 3, 2, 2, 10, '/data/modify', '/data/list', null, 'glyph-monitor', 'N', 'Y', 'N'),
	(41, '0', '1', '업로드', 'DATA', 3, 3, 2, 2, 11, '/upload-data/input', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(42, '0', '1', '업로드 목록', 'DATA', 3, 3, 2, 2, 12, '/upload-data/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(43, '0', '1', '업로드 수정', 'DATA', 3, 3, 2, 2, 13, '/upload-data/modify', '/upload-data/list', null, 'glyph-monitor', 'N', 'Y', 'N'),
	(44, '0', '1', '데이터 변환 결과', 'DATA', 3, 3, 2, 2, 14, '/converter/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(45, '0', '1', '데이터 변환 상세 목록', 'DATA', 3, 3, 2, 2, 15, '/converter/converter-job-file-list', null , null ,'glyph-monitor', 'Y', 'Y', 'Y'),
	(46, '0', '1', '데이터 변경 이력', 'DATA', 3, 3, 2, 2, 16, '/data-log/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(47, '0', '1', '데이터 위치 변경 요청 이력', 'DATA', 3, 3, 2, 2, 17, '/data-adjust-log/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),

    (5, '0', '1', '레이어', 'LAYER', 5, 0, 1, 2, 5, '/layer-group/list', null, null, 'glyph-stack', 'Y', 'Y', 'Y'),
	(51, '0', '1', '2D 레이어 그룹', 'LAYER', 5, 5, 2, 1, 1, '/layer-group/list', null, null, 'glyph-stack', 'Y', 'Y', 'Y'),
	(52, '0', '1', '2D 레이어 그룹 등록', 'LAYER', 5, 5, 2, 2, 2, '/layer-group/input', '/layer-group/list', null, 'glyph-stack', 'Y', 'Y', 'Y'),
	(53, '0', '1', '2D 레이어 그룹 수정', 'LAYER', 5, 5, 2, 2, 3, '/layer-group/modify', '/layer-group/list', null, 'glyph-stack', 'N', 'Y', 'N'),
	(54, '0', '1', '2D 레이어 목록', 'LAYER', 5, 5, 2, 2, 4, '/layer/list', null, null, 'glyph-stack', 'Y', 'Y', 'Y'),
	(55, '0', '1', '2D 레이어 등록', 'LAYER', 5, 5, 2, 2, 5, '/layer/input', '/layer/list', null, 'glyph-stack', 'N', 'Y', 'N'),
	(56, '0', '1', '2D 레이어 수정', 'LAYER', 5, 5, 2, 2, 6, '/layer/modify', '/layer/list', null, 'glyph-stack', 'N', 'Y', 'N'),

    (401, '0', '1', '환경설정', 'CONFIGURATION', 401, 0, 1, 2, 10, '/policy/modify', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(411, '0', '1', '일반 운영정책', 'CONFIGURATION', 401, 401, 2, 1, 1, '/policy/modify', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(412, '0', '1', '공간정보 운영정책', 'CONFIGURATION', 401, 401, 2, 2, 2, '/geopolicy/modify', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(413, '0', '1', '관리자 메뉴', 'ADMIN MENU', 401, 401, 2, 2, 3, '/menu/admin-menu', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(414, '0', '1', '사용자 메뉴', 'USER MENU', 401, 401, 2, 2, 4, '/menu/user-menu', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(415, '0', '1', '위젯', 'WIDGET', 401, 401, 2, 2, 5, '/widget/modify', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(416, '0', '1', '권한', 'ROLE', 401, 401, 2, 2, 6, '/role/list', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(417, '0', '1', '권한 등록', 'ROLE', 401, 401, 2, 2, 7, '/role/input', '/role/list', null, 'glyph-settings', 'N', 'Y', 'N'),
	(418, '0', '1', '권한 수정', 'ROLE', 401, 401, 2, 2, 8, '/role/modify', '/role/list', null, 'glyph-settings', 'N', 'Y', 'N'),
    (420, '0', '1', '지형 목록', 'TERRAIN', 401, 401, 2, 2, 9, '/terrain/list', null, null, 'glyph-desktop', 'Y', 'Y', 'Y'),
    (421, '0', '1', '지형 등록', 'TERRAIN', 401, 401, 2, 2, 10, '/terrain/input', '/terrain/list', null, 'glyph-desktop', 'N', 'Y', 'N'),
    (422, '0', '1', '지형 수정', 'TERRAIN', 401, 401, 2, 2, 11, '/terrain/modify', '/terrain/list', null, 'glyph-desktop', 'N', 'Y', 'N');


-- 사용자 메뉴
insert into menu(menu_id, menu_type, menu_target, name, name_en, ancestor, parent, depth, previous_depth, view_order, url, url_alias, html_id, html_content_id,
    css_class, default_yn, use_yn, display_yn)
values
    (1001, '1', '0', '검색', 'SEARCH', 1001, 0, 1, 1, 1, '/search', null, 'searchMenu', 'searchContent', 'search', 'Y', 'Y', 'Y'),
    (1002, '1', '0', '데이터', 'DATA', 1002, 0, 1, 1, 2, '/data/map', null, 'dataMenu', 'dataContent', 'data', 'Y', 'Y', 'Y'),
    (1003, '1', '0', '변환', 'CONVERTER', 1003, 0, 1, 1, 3, '/upload-data/list', null, 'converterMenu', 'converterContent', 'converter', 'Y', 'Y', 'Y'),
    --(1004, '1', '0', '공간분석', 'SPATIAL', 1004, 0, 1, 4, '/spatial', null, 'spatialMenu', 'spatialContent', 'spatial', 'Y', 'Y', 'Y'),
    --(1005, '1', '0', '시뮬레이션', 'SIMULATION', 1005, 0, 1, 5, '/simulation', null, 'simulationMenu', 'simulationContent', 'simulation', 'Y', 'Y', 'Y'),
    (1007, '1', '0', '레이어', 'LAYER', 1007, 0, 1, 1, 7, '/layer/list', null, 'layerMenu', 'layerContent', 'layer', 'Y', 'Y', 'Y'),
    (1008, '1', '0', '환경설정', 'USER POLICY', 1008, 0, 1, 1, 8, '/user-policy/modify', null, 'userPolicyMenu', 'userPolicyContent', 'userPolicy', 'Y', 'Y', 'Y');


-- 사용자 그룹별 메뉴
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id, previous_depth, all_yn)
values
	(1, 1, 1, 0, 'Y'),
	(2, 1, 2, 0, 'Y'),
	(21, 1, 21, 1, 'Y'),
	(22, 1, 22, 2, 'Y'),
	(23, 1, 23, 2, 'Y'),
	(24, 1, 24, 2, 'Y'),
	(25, 1, 25, 2, 'Y'),
	(26, 1, 26, 2, 'Y'),
	(27, 1, 27, 2, 'Y'),
	(28, 1, 28, 2, 'Y'),
	(29, 1, 29, 2, 'Y'),
	(3, 1, 3, 2, 'Y'),
	(31, 1, 31, 1, 'Y'),
	(32, 1, 32, 2, 'Y'),
	(33, 1, 33, 2, 'Y'),
	(34, 1, 34, 2, 'Y'),
	(35, 1, 35, 2, 'Y'),
	(36, 1, 36, 2, 'Y'),
	(37, 1, 37, 2, 'Y'),
	(38, 1, 38, 2, 'Y'),
	(39, 1, 39, 2, 'Y'),
	(40, 1, 40, 2, 'Y'),
	(41, 1, 41, 2, 'Y'),
	(42, 1, 42, 2, 'Y'),
	(43, 1, 43, 2, 'Y'),
	(44, 1, 44, 2, 'Y'),
	(45, 1, 45, 2, 'Y'),
	(46, 1, 46, 2, 'Y'),
	(47, 1, 47, 2, 'Y'),
	(5, 1, 5, 2, 'Y'),
	(51, 1, 51, 1, 'Y'),
	(52, 1, 52, 2, 'Y'),
	(53, 1, 53, 2, 'Y'),
	(54, 1, 54, 2, 'Y'),
	(55, 1, 55, 2, 'Y'),
	(56, 1, 56, 2, 'Y'),

	(401, 1, 401, 2, 'Y'),
	(411, 1, 411, 1, 'Y'),
	(412, 1, 412, 2, 'Y'),
	(413, 1, 413, 2, 'Y'),
	(414, 1, 414, 2, 'Y'),
	(415, 1, 415, 2, 'Y'),
	(416, 1, 416, 2, 'Y'),
    (417, 1, 417, 2, 'Y'),
    (418, 1, 418, 2, 'Y'),
    (420, 1, 420, 2, 'Y'),
    (421, 1, 421, 2, 'Y'),
    (422, 1, 422, 2, 'Y'),
    
	(NEXTVAL('user_group_menu_seq'), 1, 1001, 1, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 1, 1002, 1, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 1, 1003, 1, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 1, 1004, 1, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 1, 1005, 1, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 1, 1007, 1, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 1, 1008, 1, 'Y'),

	(NEXTVAL('user_group_menu_seq'), 2, 1001, 1, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 2, 1002, 1, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 2, 1003, 1, 'Y'),
	--(NEXTVAL('user_group_menu_seq'), 2, 1004, 'Y'),
	--(NEXTVAL('user_group_menu_seq'), 2, 1005, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 2, 1007, 1, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 2, 1008, 1, 'Y');

insert into user_group_role(user_group_role_id, user_group_id, role_id)
values
	(NEXTVAL('user_group_role_seq'), 1, 1),
	(NEXTVAL('user_group_role_seq'), 1, 2),
	(NEXTVAL('user_group_role_seq'), 1, 3),
	(NEXTVAL('user_group_role_seq'), 1, 1001),
	(NEXTVAL('user_group_role_seq'), 1, 1002),
	(NEXTVAL('user_group_role_seq'), 1, 1003),
	(NEXTVAL('user_group_role_seq'), 2, 1001),
	(NEXTVAL('user_group_role_seq'), 2, 1002),
    (NEXTVAL('user_group_role_seq'), 2, 1003);


-- 메인 화면 위젯
insert into widget(widget_id, widget_name, widget_key, view_order, user_id)
values
	(NEXTVAL('widget_seq'), '사용자 현황', 'userWidget', 1, 'admin' ),
	(NEXTVAL('widget_seq'), '데이터 타입별 현황', 'dataTypeWidget', 2, 'admin' ),
	(NEXTVAL('widget_seq'), '데이터 변환 현황', 'converterWidget', 3, 'admin' ),
	(NEXTVAL('widget_seq'), '최근 이슈', 'issueWidget', 4, 'admin' ),
	(NEXTVAL('widget_seq'), '데이터 위치 정보 변경 요청', 'dataAdjustLogWidget', 5, 'admin' ),
	(NEXTVAL('widget_seq'), '리소스 현황', 'systemResourceWidget', 6, 'admin' ),
	(NEXTVAL('widget_seq'), '스케줄 실행 결과', 'scheduleWidget', 7, 'admin' ),
	(NEXTVAL('widget_seq'), 'API 요청', 'apiLogWidget', 8, 'admin' );


-- 운영 정책
insert into policy(	policy_id, password_exception_char)
			values( 1, '<>&''"');

-- 2D, 3D 운영 정책
insert into geopolicy(	geopolicy_id)
			values( 1 );

-- Role
insert into role(role_id, role_name, role_key, role_target, role_type, use_yn, default_yn)
values
    (1, '[관리자 전용] 관리자 페이지 SIGN IN 권한', 'ADMIN_SIGNIN', '1', '0', 'Y', 'Y'),
    (2, '[관리자 전용] 관리자 페이지 사용자 관리 권한', 'ADMIN_USER_MANAGE', '1', '0', 'Y', 'Y'),
    (3, '[관리자 전용] 관리자 페이지 Layer 관리 권한', 'ADMIN_LAYER_MANAGE', '1', '0', 'Y', 'Y'),

	(1001, '[사용자 전용] 사용자 페이지 SIGN IN 권한', 'USER_SIGNIN', '0', '0', 'Y', 'Y'),
	(1002, '[사용자 전용] 사용자 페이지 DATA 등록 권한', 'USER_DATA_CREATE', '0', '0', 'Y', 'Y'),
	(1003, '[사용자 전용] 사용자 페이지 DATA 조회 권한', 'USER_DATA_READ', '0', '0', 'Y', 'Y');


INSERT INTO data_group (
    data_group_id, data_group_key, data_group_name, data_group_path, data_group_target, sharing, user_id,
    ancestor, parent, depth, view_order, children, basic, available, tiling, data_count, metainfo)
values
(1, 'basic', '기본', 'infra/data/basic/', 'admin', 'common', 'admin', 1, 0, 1, 1, 0, true, true, false, 0,  TO_JSON('{"isPhysical": false}'::json))

;
