-- 사용자 그룹 테이블 기본값 입력
insert into user_group(
	user_group_id, group_key, group_name, parent, depth, view_order, default_yn, use_yn, description
) values(
	1, 'SUPER_ADMIN', '슈퍼 관리자', 0, 1, 1, 'Y', 'Y', '기본값'
);

-- 슈퍼 관리자 등록
insert into user_info(
	user_id, user_group_id, user_name, password, salt, user_role_check_yn, last_login_date
) values (
	'admin', 1, '슈퍼관리자', '17ea3ab706538b13ca825dae505c1c9a1bb32030a50a2ce675d7b5d73f6c70eb566df9b07561fd688e9fb7c44e6a3e9bf9de567f853c3c62db8d1e3ac5b479ec', 
	'$2a$10$CMK4Fnjhg/CPE71xYSW9Se', 'N', now()
);

-- 메뉴
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(1, '홈', 'HOME', 0 , 1, 1, '/main/index.do', 'glyph-home', 'N', 'N');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(2, '사용자', 'USER', 0 , 1, 2, '/user/list-user.do', 'glyph-users', 'Y', 'Y');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(21, '사용자 그룹', 'USER', 2 , 2, 1, '/user/list-user-group.do', 'glyph-users', 'N', 'Y');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(22, '사용자 목록', 'USER', 2 , 2, 2, '/user/list-user.do', 'glyph-users', 'N', 'Y');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(23, '사용자 등록', 'USER', 2 , 2, 3, '/user/input-user.do', 'glyph-users', 'N', 'Y');

insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(3, '데이터', 'DATA', 0 , 1, 3, '/data/list-data.do', 'glyph-monitor', 'Y', 'Y');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(31, '데이터 그룹', 'DATA', 3 , 2, 1, '/data/list-data-group.do', 'glyph-monitor', 'N', 'Y');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(32, '데이터 목록', 'DATA', 3 , 2, 2, '/data/list-data.do', 'glyph-monitor', 'N', 'Y');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(33, '데이터 등록', 'DATA', 3 , 2, 3, '/data/input-data.do', 'glyph-monitor', 'N', 'Y');

insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(4, '이슈', 'ISSUE', 0 , 1, 4, '/issue/list-issue.do', 'glyph-dashboard', 'Y', 'Y');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(41, '이슈 일괄', 'ISSUE', 4 , 2, 1, '/issue/all-issue.do', 'glyph-dashboard', 'N', 'Y');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(42, '이슈 목록', 'ISSUE', 4 , 2, 2, '/issue/list-issue.do', 'glyph-dashboard', 'N', 'Y');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(43, '이슈 등록', 'ISSUE', 4 , 2, 3, '/issue/input-issue.do', 'glyph-dashboard', 'N', 'Y');

insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(5, '통계및이력', 'STATISTICS', 0 , 1, 5, '/statistic/index.do', 'glyph-chart', 'N', 'Y');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(51, '통계', 'STATISTICS', 5 , 2, 1, '/statistic/index.do', 'glyph-chart', 'N', 'Y');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(52, '접근 이력', 'STATISTICS', 5 , 2, 2, '/log/list-access-log.do', 'glyph-chart', 'N', 'Y');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(53, '정기 점검', 'STATISTICS', 5 , 2, 3, '/report/list-report-maintenance.do', 'glyph-chart', 'N', 'Y');

insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(6, '스케줄', 'SCHEDULE', 0 , 1, 6, '/schedule/list-schedule.do', 'glyph-check', 'N', 'Y');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(61, '스케줄 목록', 'STATISTICS', 6 , 2, 1, '/schedule/list-schedule.do', 'glyph-check', 'N', 'Y');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(62, '스케줄 실행 이력', 'STATISTICS', 6 , 2, 2, '/schedule/list-schedule-log.do', 'glyph-check', 'N', 'Y');

insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(8, '환경설정', 'CONFIGURATION', 0 , 1, 8, '/config/modify-policy.do', 'glyph-settings', 'Y', 'Y');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(81, '운영정책', 'CONFIGURATION', 8 , 2, 1, '/config/modify-policy.do', 'glyph-settings', 'Y', 'Y');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(82, '메뉴설정', 'CONFIGURATION', 8 , 2, 2, '/config/list-menu.do', 'glyph-settings', 'Y', 'Y');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(83, '라이선스', 'CONFIGURATION', 8 , 2, 3, '/config/modify-license.do', 'glyph-settings', 'Y', 'Y');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(84, '위젯설정', 'CONFIGURATION', 8 , 2, 4, '/config/modify-widget.do', 'glyph-settings', 'N', 'Y');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(85, '권한설정', 'CONFIGURATION', 8 , 2, 5, '/role/list-role.do', 'glyph-settings', 'N', 'Y');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(86, '공통 코드 설정', 'CONFIGURATION', 8 , 2, 6, '/code/list-code.do', 'glyph-settings', 'N', 'Y');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(10, '공지사항', 'BOARD', 0 , 1, 10, '/board/list-board.do', 'glyph-imark-dot', 'N', 'Y');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(101, '공지 목록', 'BOARD', 10 , 2, 1, '/board/list-board.do', 'glyph-imark-dot', 'N', 'Y');
insert into menu(menu_id, name, name_en, parent, depth, view_order, url, css_class, default_yn, use_yn) values(102, '공지사항 등록', 'BOARD', 10 , 2, 2, '/board/input-board.do', 'glyph-imark-dot', 'N', 'Y');

-- 사용자 그룹별 메뉴
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (1, 1, 1);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (2, 1, 2);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (21, 1, 21);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (22, 1, 22);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (23, 1, 23);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (3, 1, 3);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (31, 1, 31);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (32, 1, 32);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (33, 1, 33);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (4, 1, 4);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (41, 1, 41);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (42, 1, 42);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (43, 1, 43);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (5, 1, 5);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (51, 1, 51);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (52, 1, 52);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (53, 1, 53);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (6, 1, 6);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (61, 1, 61);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (62, 1, 62);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (8, 1, 8);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (81, 1, 81);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (82, 1, 82);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (83, 1, 83);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (84, 1, 84);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (85, 1, 85);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (86, 1, 86);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (10, 1, 10);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (101, 1, 101);
insert into user_group_menu(user_group_menu_id, user_group_id, menu_id) values (102, 1, 102);


-- Data 그룹 테이블 기본값 입력
insert into data_group(
	data_group_id, data_group_key, data_group_name, parent, depth, view_order, default_yn, use_yn, description
) values(
	1, 'SUPER_ADMIN', '슈퍼 관리자', 0, 1, 1, 'Y', 'Y', '기본값'
);


-- 메인 화면 위젯
insert into widget(	widget_id, name, view_order, user_id) values( 1, 'issueWidget', 1, 'admin' );
insert into widget(	widget_id, name, view_order, user_id) values( 2, 'userWidget', 4, 'admin' );
insert into widget(	widget_id, name, view_order, user_id) values( 3, 'scheduleLogListWidget', 7, 'admin' );
insert into widget(	widget_id, name, view_order, user_id) values( 4, 'accessLogWidget', 8, 'admin' );
insert into widget(	widget_id, name, view_order, user_id) values( 5, 'dbcpWidget', 9, 'admin' );
insert into widget(	widget_id, name, view_order, user_id) values( 6, 'dbSessionWidget', 10, 'admin' );

-- 운영 정책
insert into policy(	policy_id, password_exception_char, site_name, site_admin_mobile_phone, site_admin_email) 
			values( 1, '<>&''"', 'Mago3D', '000-0000-0000', 'test@test.com');

-- Role
insert into role(role_id, role_name, role_key, role_type, business_type, use_yn, default_yn) values(1, '관리자 페이지 접근 권한', 'USER_ADMIN_LOGIN', '0', '0', 'Y', 'N');



-- 공통 코드
insert into common_code (
  code_key, code_name, code_name_en, code_type, code_value, use_yn
) values (
  'USER_REGISTER', '관리자 등록', 'USER_INSERT_TYPE', 'user', 'SELF', 'Y'
);
insert into common_code (
  code_key, code_name, code_name_en, code_type, code_value, use_yn, view_order
) values (
  'USER_REGISTER_EMAIL', '이메일', 'EMAIL', 'user', 'gmail.com', 'Y', 2
);

insert into common_code (
  code_key, code_name, code_name_en, code_type, code_value, use_yn, view_order
) values (
  'ISSUE_PRIORITY', '우선순위', 'PRIORITY', 'ISSUE', '매우중요', 'Y', 1
);
insert into common_code (
  code_key, code_name, code_name_en, code_type, code_value, use_yn, view_order
) values (
  'ISSUE_PRIORITY', '우선순위', 'PRIORITY', 'ISSUE', '중요', 'Y', 2
);
insert into common_code (
  code_key, code_name, code_name_en, code_type, code_value, use_yn, view_order
) values (
  'ISSUE_PRIORITY', '우선순위', 'PRIORITY', 'ISSUE', '보통', 'Y', 3
);
insert into common_code (
  code_key, code_name, code_name_en, code_type, code_value, use_yn, view_order
) values (
  'ISSUE_PRIORITY', '우선순위', 'PRIORITY', 'ISSUE', '낮음', 'Y', 4
);

insert into common_code (
  code_key, code_name, code_name_en, code_type, code_value, use_yn, view_order
) values (
  'ISSUE_TYPE', '유형', 'TYPE', 'ISSUE', '버그', 'Y', 1
);
insert into common_code (
  code_key, code_name, code_name_en, code_type, code_value, use_yn, view_order
) values (
  'ISSUE_TYPE', '유형', 'TYPE', 'ISSUE', '기능개선', 'Y', 2
);
insert into common_code (
  code_key, code_name, code_name_en, code_type, code_value, use_yn, view_order
) values (
  'ISSUE_TYPE', '유형', 'TYPE', 'ISSUE', '수정', 'Y', 3
);
insert into common_code (
  code_key, code_name, code_name_en, code_type, code_value, use_yn, view_order
) values (
  'ISSUE_TYPE', '유형', 'TYPE', 'ISSUE', '기타', 'Y', 4
);


insert into common_code (
  code_key, code_name, code_name_en, code_type, code_value, use_yn, view_order
) values (
  'ISSUE_STATUS', '상태', 'STATUS', 'ISSUE', '등록', 'Y', 1
);
insert into common_code (
  code_key, code_name, code_name_en, code_type, code_value, use_yn, view_order
) values (
  'ISSUE_STATUS', '상태', 'STATUS', 'ISSUE', '진행중', 'Y', 2
);
insert into common_code (
  code_key, code_name, code_name_en, code_type, code_value, use_yn, view_order
) values (
  'ISSUE_STATUS', '상태', 'STATUS', 'ISSUE', '완료', 'Y', 3
);
insert into common_code (
  code_key, code_name, code_name_en, code_type, code_value, use_yn, view_order
) values (
  'ISSUE_STATUS', '상태', 'STATUS', 'ISSUE', '폐기', 'Y', 4
);

