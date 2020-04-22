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
	('admin', 1, '슈퍼관리자', '비밀번호', 'N', now()),
	('mago3d', 2, '스마트시티', '비밀번호', 'Y', now());

-- 관리자 메뉴
insert into menu(menu_id, menu_type, menu_target, name, name_en, ancestor, parent, depth, view_order, url, url_alias, html_id, css_class, default_yn, use_yn, display_yn)
values
	(1, '0', '1', '홈', 'HOME', 0, 0, 1, 1, '/main/index', null, null, 'glyph-home', 'N', 'N', 'N'),
	(2, '0', '1', '사용자', 'USER', 2, 0, 1, 2, '/user/list', null, null, 'glyph-users', 'Y', 'Y', 'Y'),
	(21, '0', '1', '사용자 그룹', 'USER', 2, 2, 2, 1, '/user-group/list', null, null, 'glyph-users', 'Y', 'Y', 'Y'),
	(22, '0', '1', '사용자 그룹 등록', 'USER', 2, 2, 2, 2, '/user-group/input', null, null, 'glyph-users', 'Y', 'Y', 'Y'),
	(23, '0', '1', '사용자 그룹 수정', 'USER', 2, 2, 2, 3, '/user-group/modify', '/user-group/list', null, 'glyph-users', 'N', 'Y', 'N'),
	(24, '0', '1', '사용자 그룹 메뉴', 'USER', 2, 2, 2, 4, '/user-group/menu', '/user-group/list', null, 'glyph-users', 'N', 'Y', 'N'),
	(25, '0', '1', '사용자 그룹 Role', 'USER', 2, 2, 2, 5, '/user-group/role', '/user-group/list', null, 'glyph-users', 'N', 'Y', 'N'),
	(26, '0', '1', '사용자 목록', 'USER', 2, 2, 2, 6, '/user/list', null, null, 'glyph-users', 'Y', 'Y', 'Y'),
	(27, '0', '1', '사용자 등록', 'USER', 2, 2, 2, 7, '/user/input', null, null, 'glyph-users', 'Y', 'Y', 'Y'),
	(28, '0', '1', '사용자 정보 수정', 'USER', 2, 2, 2, 8, '/user/modify', '/user/list', null, 'glyph-users', 'N', 'Y', 'N'),
	(29, '0', '1', '사용자 상세 정보', 'USER', 2, 2, 2, 9, '/user/detail', '/user/list', null, 'glyph-users', 'N', 'Y', 'N'),
	(3, '0', '1', '데이터', 'DATA', 3, 0, 1, 3, '/data-group/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(31, '0', '1', '데이터 그룹', 'DATA', 3, 3, 2, 1, '/data-group/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(32, '0', '1', '데이터 그룹 등록', 'DATA', 3, 3, 2, 2, '/data-group/input', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(33, '0', '1', '데이터 그룹 수정', 'DATA', 3, 3, 2, 3, '/data-group/modify', '/data-group/list', null, 'glyph-monitor', 'N', 'Y', 'N'),
	(34, '0', '1', '사용자 데이터 그룹', 'DATA', 3, 3, 2, 4, '/data-group/list-user', null, null, 'glyph-monitor', 'Y', 'N', 'Y'),
	(35, '0', '1', '데이터 목록', 'DATA', 3, 3, 2, 5, '/data/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(36, '0', '1', '데이터 상세 정보', 'DATA', 3, 3, 2, 6, '/data/detail', '/data/list', null, 'glyph-monitor', 'N', 'Y', 'N'),
	(37, '0', '1', '데이터 수정', 'DATA', 3, 3, 2, 7, '/data/modify', '/data/list', null, 'glyph-monitor', 'N', 'Y', 'N'),
	(40, '0', '1', '업로드', 'DATA', 3, 3, 2, 8, '/upload-data/input', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(41, '0', '1', '업로드 목록', 'DATA', 3, 3, 2, 9, '/upload-data/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(42, '0', '1', '업로드 수정', 'DATA', 3, 3, 2, 10, '/upload-data/modify', '/upload-data/list', null, 'glyph-monitor', 'N', 'Y', 'N'),
	(43, '0', '1', '데이터 변환 결과', 'DATA', 3, 3, 2, 11, '/converter/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(44, '0', '1', '데이터 위치 변경 요청 이력', 'DATA', 3, 3, 2, 12, '/data-adjust-log/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(45, '0', '1', '데이터 변경 이력', 'DATA', 3, 3, 2, 13, '/data-log/list', null, null, 'glyph-monitor', 'Y', 'Y', 'Y'),
	(5, '0', '1', '레이어', 'LAYER', 5, 0, 1, 5, '/layer-group/list', null, null, 'glyph-check', 'Y', 'Y', 'Y'),
	(51, '0', '1', '2D 레이어 그룹', 'LAYER', 5, 5, 2, 1, '/layer-group/list', null, null, 'glyph-check', 'Y', 'Y', 'Y'),
	(52, '0', '1', '2D 레이어 그룹 등록', 'LAYER', 5, 5, 2, 2, '/layer-group/input', null, null, 'glyph-check', 'Y', 'Y', 'Y'),
	(53, '0', '1', '2D 레이어 그룹 수정', 'LAYER', 5, 5, 2, 3, '/layer-group/modify', '/layer-group/list', null, 'glyph-check', 'N', 'Y', 'N'),
	(54, '0', '1', '2D 레이어 목록', 'LAYER', 5, 5, 2, 4, '/layer/list', null, null, 'glyph-check', 'Y', 'Y', 'Y'),
	(55, '0', '1', '2D 레이어 등록', 'LAYER', 5, 5, 2, 5, '/layer/input', null, null, 'glyph-check', 'Y', 'Y', 'Y'),
	(56, '0', '1', '2D 레이어 수정', 'LAYER', 5, 5, 2, 6, '/layer/modify', '/layer/list', null, 'glyph-check', 'N', 'Y', 'N'),
	(7, '0', '1', '시민참여', 'CIVIL VOICE', 7, 0, 1, 7, '/civil-voice/list', null, null, 'glyph-dashboard', 'Y', 'Y', 'Y'),
	(71, '0', '1', '시민참여 목록', 'CIVIL VOICE', 7, 7, 2, 1, '/civil-voice/list', null, null, 'glyph-dashboard', 'Y', 'Y', 'Y'),
	(72, '0', '1', '시민참여 상세 정보', 'CIVIL VOICE', 7, 7, 2, 2, '/civil-voice/detail', '/civil-voice/list', null, 'glyph-dashboard', 'N', 'Y', 'N'),
	(73, '0', '1', '시민참여 등록', 'CIVIL VOICE', 7, 7, 2, 3, '/civil-voice/input', null, null, 'glyph-dashboard', 'Y', 'Y', 'Y'),
	(74, '0', '1', '시민참여 수정', 'CIVIL VOICE', 7, 7, 2, 4, '/civil-voice/modify', '/civil-voice/list', null, 'glyph-dashboard', 'N', 'Y', 'N'),
	(8, '0', '1', '환경설정', 'CONFIGURATION', 8, 0, 1, 8, '/policy/modify', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(81, '0', '1', '일반 운영정책', 'CONFIGURATION', 8, 8, 2, 1, '/policy/modify', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(82, '0', '1', '공간정보 운영정책', 'CONFIGURATION', 8, 8, 2, 2, '/geopolicy/modify', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(83, '0', '1', '관리자 메뉴', 'ADMIN MENU', 8, 8, 2, 3, '/menu/admin-menu', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(84, '0', '1', '사용자 메뉴', 'USER MENU', 8, 8, 2, 4, '/menu/user-menu', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(85, '0', '1', '위젯', 'WIDGET', 8, 8, 2, 5, '/widget/modify', null, null, 'glyph-settings', 'N', 'N', 'N'),
	(86, '0', '1', '권한', 'ROLE', 8, 8, 2, 6, '/role/list', null, null, 'glyph-settings', 'Y', 'Y', 'Y'),
	(87, '0', '1', '권한 등록', 'ROLE', 8, 8, 2, 7, '/role/input', '/role/list', null, 'glyph-settings', 'N', 'Y', 'N'),
	(88, '0', '1', '권한 수정', 'ROLE', 8, 8, 2, 8, '/role/modify', '/role/list', null, 'glyph-settings', 'N', 'Y', 'N');


-- 사용자 메뉴
insert into menu(menu_id, menu_type, menu_target, name, name_en, ancestor, parent, depth, view_order, url, url_alias, html_id, html_content_id,
    css_class, default_yn, use_yn, display_yn)
values
    (1001, '1', '0', '검색', 'SEARCH', 1001, 0, 1, 1, '/search', null, 'searchMenu', 'searchContent', 'search', 'Y', 'Y', 'Y'),
    (1002, '1', '0', '데이터', 'DATA', 1002, 0, 1, 2, '/data/map', null, 'dataMenu', 'dataContent', 'data', 'Y', 'Y', 'Y'),
    (1003, '1', '0', '변환', 'CONVERTER', 1003, 0, 1, 3, '/upload-data/list', null, 'converterMenu', 'converterContent', 'converter', 'Y', 'Y', 'Y'),
    (1004, '1', '0', '공간분석', 'SPATIAL', 1004, 0, 1, 4, '/spatial', null, 'spatialMenu', 'spatialContent', 'spatial', 'Y', 'Y', 'Y'),
    (1005, '1', '0', '시뮬레이션', 'SIMULATION', 1005, 0, 1, 5, '/simulation', null, 'simulationMenu', 'simulationContent', 'simulation', 'Y', 'Y', 'Y'),
    (1006, '1', '0', '시민참여', 'CIVIL VOICE', 1006, 0, 1, 6, '/civil-voice/list', null, 'civilVoiceMenu', 'civilVoiceContent', 'civilVoice', 'Y', 'Y', 'Y'),
    (1007, '1', '0', '레이어', 'LAYER', 1007, 0, 1, 7, '/layer/list', null, 'layerMenu', 'layerContent', 'layer', 'Y', 'Y', 'Y'),
    (1008, '1', '0', '환경설정', 'USER POLICY', 1008, 0, 1, 8, '/user-policy/modify', null, 'userPolicyMenu', 'userPolicyContent', 'userPolicy', 'Y', 'Y', 'Y');


-- 사용자 그룹별 메뉴
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id, all_yn)
values
	(1, 1, 1, 'Y'),
	(2, 1, 2, 'Y'),
	(21, 1, 21, 'Y'),
	(22, 1, 22, 'Y'),
	(23, 1, 23, 'Y'),
	(24, 1, 24, 'Y'),
	(25, 1, 25, 'Y'),
	(26, 1, 26, 'Y'),
	(27, 1, 27, 'Y'),
	(28, 1, 28, 'Y'),
	(29, 1, 29, 'Y'),
	(3, 1, 3, 'Y'),
	(31, 1, 31, 'Y'),
	(32, 1, 32, 'Y'),
	(33, 1, 33, 'Y'),
	(34, 1, 34, 'Y'),
	(35, 1, 35, 'Y'),
	(36, 1, 36, 'Y'),
	(37, 1, 37, 'Y'),
	(40, 1, 40, 'Y'),
	(41, 1, 41, 'Y'),
	(42, 1, 42, 'Y'),
	(43, 1, 43, 'Y'),
	(44, 1, 44, 'Y'),
	(45, 1, 45, 'Y'),
	(5, 1, 5, 'Y'),
	(51, 1, 51, 'Y'),
	(52, 1, 52, 'Y'),
	(53, 1, 53, 'Y'),
	(54, 1, 54, 'Y'),
	(55, 1, 55, 'Y'),
	(56, 1, 56, 'Y'),
	(7, 1, 7, 'Y'),
	(71, 1, 71, 'Y'),
	(72, 1, 72, 'Y'),
	(73, 1, 73, 'Y'),
	(74, 1, 74, 'Y'),
	(8, 1, 8, 'Y'),
	(81, 1, 81, 'Y'),
	(82, 1, 82, 'Y'),
	(83, 1, 83, 'Y'),
	(84, 1, 84, 'Y'),
	(85, 1, 85, 'Y'),
	(86, 1, 86, 'Y'),
	(87, 1, 87, 'Y'),
	(88, 1, 88, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 1, 1001, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 1, 1002, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 1, 1003, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 1, 1004, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 1, 1005, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 1, 1006, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 1, 1007, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 1, 1008, 'Y'),

	(NEXTVAL('user_group_menu_seq'), 2, 1001, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 2, 1002, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 2, 1003, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 2, 1004, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 2, 1005, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 2, 1006, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 2, 1007, 'Y'),
	(NEXTVAL('user_group_menu_seq'), 2, 1008, 'Y');

insert into user_group_role(user_group_role_id, user_group_id, role_id)
values
	(NEXTVAL('user_group_role_seq'), 1, 1),
	(NEXTVAL('user_group_role_seq'), 1, 2),
	(NEXTVAL('user_group_role_seq'), 1, 3),
	(NEXTVAL('user_group_role_seq'), 1, 4),
	(NEXTVAL('user_group_role_seq'), 1, 5),
	(NEXTVAL('user_group_role_seq'), 1, 6),
	(NEXTVAL('user_group_role_seq'), 1, 7),
	(NEXTVAL('user_group_role_seq'), 2, 4),
	(NEXTVAL('user_group_role_seq'), 2, 5),
	(NEXTVAL('user_group_role_seq'), 2, 6);


-- 메인 화면 위젯
insert into widget(widget_id, name, view_order, user_id)
values
	(NEXTVAL('widget_seq'), 'dataGroupWidget', 1, 'admin' ),
	(NEXTVAL('widget_seq'), 'dataStatusWidget', 2, 'admin' ),
	(NEXTVAL('widget_seq'), 'dataAdjustLogWidget', 3, 'admin' ),
	(NEXTVAL('widget_seq'), 'userStatusWidget', 4, 'admin' ),
	(NEXTVAL('widget_seq'), 'systemUsageWidget', 5, 'admin' ),
	(NEXTVAL('widget_seq'), 'civilVoiceWidget', 6, 'admin' ),
	(NEXTVAL('widget_seq'), 'userAccessLogWidget', 7, 'admin' ),
	(NEXTVAL('widget_seq'), 'dbcpStatusWidget', 8, 'admin' );


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

	(4, '[사용자 전용] 사용자 페이지 SIGN IN 권한', 'USER_SIGNIN', '0', '0', 'Y', 'Y'),
	(5, '[사용자 전용] 사용자 페이지 DATA 등록 권한', 'USER_DATA_CREATE', '0', '0', 'Y', 'Y'),
	(6, '[사용자 전용] 사용자 페이지 DATA 조회 권한', 'USER_DATA_READ', '0', '0', 'Y', 'Y'),
	(7, '[사용자 전용] 사용자 페이지 시민참여 관리 권한', 'USER_CIVIL_VOICE_MANAGE', '0', '0', 'Y', 'Y');


INSERT INTO data_group (
	data_group_id, data_group_key, data_group_name, data_group_path, data_group_target, sharing, user_id,
	ancestor, parent, depth, view_order, children, basic, available, tiling, data_count, metainfo)
values
	(1, 'basic', '기본', 'infra/basic/', 'admin', 'public', 'admin', 1, 0, 1, 1, 0, true, true, false, 0,  TO_JSON('{"isPhysical": false}'::json)),

	(2, 'sejong-general-house', '세종시 일반주택', 'infra/sejong-general-house/', 'admin', 'public', 'admin', 2, 0, 1, 2, 0, false, true, true, 190, TO_JSON('{"isPhysical": false}'::json)),
	(3, 'sejong-apartment', '세종시 공공주택', 'infra/sejong-apartment/', 'admin', 'public', 'admin', 3, 0, 1, 3, 0, false, true, true, 2244, TO_JSON('{"isPhysical": false}'::json)),
	(4, 'sejong-public', '세종시 공공기관', 'infra/sejong-public/', 'admin', 'public', 'admin', 4, 0, 1, 4, 0, false, true, true, 203, TO_JSON('{"isPhysical": false}'::json)),
	(5, 'sejong-industry', '세종시 산업시설', 'infra/sejong-industry/', 'admin', 'public', 'admin', 5, 0, 1, 5, 0, false, true, true, 37, TO_JSON('{"isPhysical": false}'::json)),
	(6, 'sejong-curture', '세종시 문화교육시설', 'infra/sejong-curture/', 'admin', 'public', 'admin', 6, 0, 1, 6, 0, false, true, true, 335, TO_JSON('{"isPhysical": false}'::json)),
	(7, 'sejong-welfare', '세종시 의료복지시설', 'infra/sejong-welfare/', 'admin', 'public', 'admin', 7, 0, 1, 7, 0, false, true, true, 9, TO_JSON('{"isPhysical": false}'::json)),
	(8, 'sejong-service', '세종시 서비스시설', 'infra/sejong-service/', 'admin', 'public', 'admin', 8, 0, 1, 8, 0, false, true, true, 36, TO_JSON('{"isPhysical": false}'::json)),
	(9, 'sejong-etc', '세종시 기타시설물', 'infra/sejong-etc/', 'admin', 'public', 'admin', 9, 0, 1, 9, 0, false, true, true, 11732, TO_JSON('{"isPhysical": false}'::json)),
	(10, 'sejong-special', '세종시 특수시설물', 'infra/sejong-special/', 'admin', 'public', 'admin', 10, 0, 1, 10, 0, false, true, true, 6, TO_JSON('{"isPhysical": false}'::json)),
	(11, 'sejong-street-lamp', '세종시 가로등', 'infra/sejong-street-lamp/', 'admin', 'public', 'admin', 11, 0, 1, 11, 0, false, true, true, 1478, TO_JSON('{"isPhysical": false}'::json)),
	(12, 'sejong-traffic-light', '세종시 교통신호등', 'infra/sejong-traffic-light/', 'admin', 'public', 'admin', 12, 0, 1, 12, 0, false, true, true, 314, TO_JSON('{"isPhysical": false}'::json)),
	(13, 'sejong-road-sign', '세종시 도로표지판', 'infra/sejong-road-sign/', 'admin', 'public', 'admin', 13, 0, 1, 13, 0, false, true, true, 63, TO_JSON('{"isPhysical": false}'::json)),
	(14, 'sejong-bus-sign', '세종시 버스정류장표지판', 'infra/sejong-bus-sign/', 'admin', 'public', 'admin', 14, 0, 1, 14, 0, false, true, true, 47, TO_JSON('{"isPhysical": false}'::json)),
	(15, 'sejong-pedestrian-light', '세종시 보행자신호등', 'infra/sejong-pedestrian-light/', 'admin', 'public', 'admin', 15, 0, 1, 15, 0, false, true, true, 316, TO_JSON('{"isPhysical": false}'::json)),
	(16, 'sejong-safe-sign', '세종시 안전표시판', 'infra/sejong-safe-sign/', 'admin', 'public', 'admin', 16, 0, 1, 16, 0, false, true, true, 1097, TO_JSON('{"isPhysical": false}'::json)),
	(17, 'sejong-jeonju', '세종시 전신주', 'infra/sejong-jeonju/', 'admin', 'public', 'admin', 17, 0, 1, 17, 0, false, true, true, 19, TO_JSON('{"isPhysical": false}'::json)),
	(18, 'sejong-taxi-sign', '세종시 택시정류장표시판', 'infra/sejong-taxi-sign/', 'admin', 'public', 'admin', 18, 0, 1, 18, 0, false, true, true, 1, TO_JSON('{"isPhysical": false}'::json)),
	(19, 'sejong-tree', '세종시 식생(나무)', 'infra/sejong-tree/', 'admin', 'public', 'admin', 19, 0, 1, 19, 0, false, true, true, 3930, TO_JSON('{"isPhysical": false}'::json)),
	(20, 'busan-mj', '부산 명지1동 건물', 'infra/busan-mj/', 'admin', 'public', 'admin', 20, 0, 1, 20, 0, false, true, true, 4795, TO_JSON('{"isPhysical": false}'::json)),
	(21, 'busan-edc', '부산 EDC', 'infra/busan-edc/', 'admin', 'public', 'admin', 21, 0, 1, 21, 0, false, true, true, 691, TO_JSON('{"isPhysical": false}'::json)),
	(22, 'busan-sv', '부산 스마트빌리지', 'infra/busan-sv/','admin', 'public', 'admin', 22, 0, 1, 22, 0, false, true, true, 56, TO_JSON('{"isPhysical": false}'::json)),
	(23, 'busan-general-house', '부산시 일반주택', 'infra/busan-general-house/', 'admin', 'public', 'admin', 23, 0, 1, 23, 0, false, true, true, 16134, TO_JSON('{"isPhysical": false}'::json)),
	(24, 'busan-apartment', '부산시 공동주택', 'infra/busan-apartment/', 'admin', 'public', 'admin', 24, 0, 1, 24, 0, false, true, true, 977, TO_JSON('{"isPhysical": false}'::json)),
	(25, 'busan-public', '부산시 공공기관', 'infra/busan-public/', 'admin', 'public', 'admin', 25, 0, 1, 25, 0, false, true, true, 3, TO_JSON('{"isPhysical": false}'::json)),
	(26, 'busan-industry', '부산시 산업시설', 'infra/busan-industry/', 'admin', 'public', 'admin', 26, 0, 1, 26, 0, false, true, true, 14542, TO_JSON('{"isPhysical": false}'::json)),
	(27, 'busan-curture', '부산시 문화교육시설', 'infra/busan-curture/', 'admin', 'public', 'admin', 27, 0, 1, 27, 0, false, true, true, 674, TO_JSON('{"isPhysical": false}'::json)),
	(28, 'busan-welfare', '부산시 의료복지시설', 'infra/busan-welfare/', 'admin', 'public', 'admin', 28, 0, 1, 28, 0, false, true, true, 104, TO_JSON('{"isPhysical": false}'::json)),
	(29, 'busan-service', '부산시 서비스시설', 'infra/busan-service/', 'admin', 'public', 'admin', 29, 0, 1, 29, 0, false, true, true, 408, TO_JSON('{"isPhysical": false}'::json)),
	(30, 'busan-etc', '부산시 기타시설', 'infra/busan-etc/', 'admin', 'public', 'admin', 30, 0, 1, 30, 0, false, true, true, 41172, TO_JSON('{"isPhysical": false}'::json)),
	(100, 'busan-sample', '부산시 샘플', 'infra/busan-sample/', 'admin', 'public', 'admin', 100, 0, 1, 31, 0, false, true, false, 16, TO_JSON('{"isPhysical": false}'::json))
	;

commit;
