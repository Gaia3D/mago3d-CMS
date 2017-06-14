var JS_MESSAGE = new Object();

JS_MESSAGE["create"] = "생성 되었습니다.";
JS_MESSAGE["insert"] = "등록 되었습니다.";
JS_MESSAGE["update"] = "수정 되었습니다.";
JS_MESSAGE["delete"] = "삭제 되었습니다.";
JS_MESSAGE["success"] = "성공 하였습니다.";
JS_MESSAGE["apply"] = "적용되었습니다.";
JS_MESSAGE["upload"] = "업로딩 중입니다.";
JS_MESSAGE["move.confirm"] = "이동 하시겠습니까?";
JS_MESSAGE["delete.confirm"] = "삭제 하시겠습니까?";
JS_MESSAGE["check.value.required"] = "선택된 항목이 없습니다.";

// 공통
JS_MESSAGE["user.session.empty"] = "로그인 후 사용 가능한 서비스 입니다.";
JS_MESSAGE["db.exception"] = "데이터 베이스 장애가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.";
JS_MESSAGE["ajax.error.message"] = "잠시 후 이용해 주시기 바랍니다. 장시간 같은 현상이 반복될 경우 관리자에게 문의하여 주십시오.";
JS_MESSAGE["button.dobule.click"] = "진행 중입니다.";
JS_MESSAGE["cache.reloaded"] = "캐시를 갱신 하였습니다.";
JS_MESSAGE["usersession.grant.invalid"] = "사용 권한이 유효하지 않습니다.";
JS_MESSAGE["search.option.warning"] = "포함 옵션을 사용하실 경우 1분 이상이 소요될 수 있습니다. 계속 진행 하시겠습니까?";
JS_MESSAGE["search.date.warning"] = "시작일이 종료일보다 클수 없습니다.";

JS_MESSAGE["input.invalid"] = "필수 입력값이 유효하지 않습니다.";
JS_MESSAGE["number.required"] = "숫자(4~8자리)만 입력 가능 합니다.";
JS_MESSAGE["config.cache.invalid"] = "필수 입력값이 유효하지 않습니다.";
JS_MESSAGE["boardcomment.invalid"] = "필수 입력값이 유효하지 않습니다.";
JS_MESSAGE["widget.invalid"] = "필수 입력값이 유효하지 않습니다.";
JS_MESSAGE["policy.user.invalid"] = "필수 입력값이 유효하지 않습니다.";
JS_MESSAGE["policy.password.invalid"] = "필수 입력값이 유효하지 않습니다.";
JS_MESSAGE["policy.password.role.invalid"] = "패스워드 생성 규칙이 유효하지 않습니다. 영문 대/소문자, 숫자, 특수기호등을 한가지 이상 사용하여 주십시오.";
JS_MESSAGE["policy.system.invalid"] = "필수 입력값이 유효하지 않습니다.";
JS_MESSAGE["policy.account.invalid"] = "필수 입력값이 유효하지 않습니다.";
JS_MESSAGE["policy.approval.invalid"] = "필수 입력값이 유효하지 않습니다.";
JS_MESSAGE["policy.notice.invalid"] = "필수 입력값이 유효하지 않습니다.";
JS_MESSAGE["policy.security.invalid"] = "필수 입력값이 유효하지 않습니다.";
JS_MESSAGE["policy.content.invalid"] = "필수 입력값이 유효하지 않습니다.";
JS_MESSAGE["policy.site.invalid"] = "필수 입력값이 유효하지 않습니다.";
JS_MESSAGE["policy.backoffice.invalid"] = "필수 입력값이 유효하지 않습니다.";
JS_MESSAGE["policy.os.invalid"] = "필수 입력값이 유효하지 않습니다.";
JS_MESSAGE["policy.os.server_ip.invalid"] = "서버 IP가 유효하지 않습니다.";
JS_MESSAGE["policy.solution.invalid"] = "필수 입력값이 유효하지 않습니다.";
JS_MESSAGE["monitoring.invalid"] = "필수 입력값이 유효하지 않습니다.";
JS_MESSAGE["loadbalancing.vrrpinfo.invalid"] = "입력값이 유효하지 않습니다.";
JS_MESSAGE["usergroup.server.invalid"] = "서버 정보가 유효하지 않습니다.";

// 메뉴
JS_MESSAGE["menu.invalid"] = "필수 입력값이 유효하지 않습니다.";

// 사용자
JS_MESSAGE["user.id.empty"] = "아이디를 입력하여 주십시오.";
JS_MESSAGE["user.id.min_length.invalid"] = "사용자 아이디 최소 길이가 올바르지 않습니다.";
JS_MESSAGE["password.empty"] = "비밀번호를 입력하여 주십시오.";
JS_MESSAGE["password.correct.empty"] = "비밀번호 확인을 입력하여 주십시오.";
JS_MESSAGE["user.name.empty"] = "이름을 입력하여 주십시오.";
JS_MESSAGE["otp.number.empty"] = "OTP 인증번호를 입력하여 주십시오.";
JS_MESSAGE["user.input.invalid"] = "필수 입력값이 유효하지 않습니다.";
JS_MESSAGE["user.id.duplication"] = "사용중인 아이디 입니다. 다른 아이디를 선택해 주십시오.";
JS_MESSAGE["user.password.invalid"] = "입력한 패스워드가 설정된 패스워드 정책에 부적합 합니다.";
JS_MESSAGE["user.password.digit.invalid"] = "입력한 패스워드가 설정된 패스워드 정책에(숫자 개수) 부적합 합니다.";
JS_MESSAGE["user.password.upper.invalid"] = "입력한 패스워드가 설정된 패스워드 정책에(영문 대문자 개수) 부적합 합니다.";
JS_MESSAGE["user.password.lower.invalid"] = "입력한 패스워드가 설정된 패스워드 정책에(영문 소문자 개수) 부적합 합니다.";
JS_MESSAGE["user.password.special.invalid"] = "입력한 패스워드가 설정된 패스워드 정책에(특수 문자 개수) 부적합 합니다.";
JS_MESSAGE["user.password.continuous.char.invalid"] = "연속 문자 제한 개수가 패스워드 정책에 부적합 합니다.";
JS_MESSAGE["user.password.exception.char.message1"] = "관리자가 설정한 특수문자 ";
JS_MESSAGE["user.password.exception.char.message2"] = " 는 비밀번호로 사용 하실 수 없습니다.";
JS_MESSAGE["user.password.exception"] = "패스워드 등록 과정 중 오류가 발생하였습니다.";
JS_MESSAGE["user.session.notexist"] = "세션 정보가 존재하지 않습니다.";
JS_MESSAGE["user.session.closed"] = "세션 종료 처리 하였습니다.";
JS_MESSAGE["user.session.close"] = "선택하신 사용자의 세션을 종료 하시겠습니까?";
JS_MESSAGE["user.id.enable"] = "사용 가능한 아이디 입니다.";
JS_MESSAGE["user.insert"] = "사용자를 등록 하였습니다.";
JS_MESSAGE["user.info.update"] = "사용자 정보를 수정 하였습니다.";
JS_MESSAGE["user.user_otp.update.warning"] = "{update_count} 건 수정되었습니다. {user_ids} 의 경우 OTP 정보가 존재하지 않아 수정 할 수 없습니다.";
JS_MESSAGE["user.id.notexist"] = "아이디가 존재하지 않습니다.";
JS_MESSAGE["user.status.invalid"] = "OTP 사용자 아이디가 사용중지 상태 입니다. 관리자에게 문의하여 주십시오.";
JS_MESSAGE["external.user.system.update"] = "외부사용자 시스템연동 정보를 수정 하였습니다.";

// 사용자 그룹
JS_MESSAGE["user.group.id.required"] = "그룹 아이디가 없습니다.";
JS_MESSAGE["user.group.id.empty"] = "사용자 그룹을 입력해 주십시오.";
JS_MESSAGE["user.group.key.empty"] = "그룹 Key를 입력하여 주십시오.";
JS_MESSAGE["user.group.name.empty"] = "그룹명을 입력하여 주십시오.";
JS_MESSAGE["user.group.level.empty"] = "레벨을 입력하여 주십시오.";
JS_MESSAGE["user.group.id.select"] = "그룹을 선택해 주세요.";
JS_MESSAGE["user.group.server.invalid"] = "최상위 그룹에는 서버를 등록할 수 없습니다.";

// 사용자 등록
JS_MESSAGE["user.file.name"] = "파일을 선택해 주십시오";
JS_MESSAGE["user.file.excel"] = "일괄 등록은 Excel 파일만 가능합니다.";

// OTP
JS_MESSAGE["userotp.user_id.invalid"] = "사용자 아이디를 입력하여 주십시오.";
JS_MESSAGE["userotp.mobile_app_key.invalid"] = "앱 OTP Key를 입력하여 주십시오.";
JS_MESSAGE["userotp.mobile_phone.invalid"] = "사용자 기본 정보의 핸드폰 번호가 존재하지 않습니다.";
JS_MESSAGE["userotp.mobile_phone.required"] = "사용자 기본 정보의 핸드폰 번호 등록 후 앱 OTP Key를 등록 하실 수 있습니다.";
JS_MESSAGE["userotp.pin_number.invalid"] = "PIN 번호를 올바르게 입력하여 주십시오.";
JS_MESSAGE["userotp.pin_number.different"] = "PIN 번호가 올바르지 않습니다. 기존 PIN 번호를 다시 입력해 주십시오.";
JS_MESSAGE["userotp.email.invalid"] = "사용자 기본 정보의 이메일을 입력하여 주십시오.";
JS_MESSAGE["userotp.messanger.invalid"] = "사용자 기본 정보의 메신저를 입력하여 주십시오.";
JS_MESSAGE["userotp.radius.invalid"] = "사용자 RADIUS 설정이 올바르지 않습니다.";
JS_MESSAGE["userotp.server_name.invalid"] = "서버 이름을 입력하여 주십시오.";
JS_MESSAGE["userotp.admin.forbid"] = "관리자 운영정책 OTP 설정에서 OTP API 기능을 사용안함으로 설정 하였습니다.";
JS_MESSAGE["userotp.user.forbid"] = "OTP를 사용하지 않는 사용자 입니다.";
JS_MESSAGE["userotp.otptype.invalid"] = "사용자 OTP 정보에서 OTP 타입이 존재하지 않습니다.";
JS_MESSAGE["userotp.otptype.mobileapp"] = "현재 OTP 인증 방식이 모바일(앱)으로 설정 되어 있습니다. OTP 웹페이지에서 OTP 인증 방식을 변경 후 사용 하시기 바랍니다.";
JS_MESSAGE["userotp.otptype.forbid"] = "관리자 운영 정책에서 지원하지 않는 OTP 타입 입니다.";
JS_MESSAGE["userotp.sms.forbid"] = "관리자 운영 정책에서 SMS는 지원하지 않는 OTP 타입 입니다.";
JS_MESSAGE["userotp.email.forbid"] = "관리자 운영 정책에서 EMail은 지원하지 않는 OTP 타입 입니다.";
JS_MESSAGE["userotp.messanger.forbid"] = "관리자 운영 정책에서 메신저는 지원하지 않는 OTP 타입 입니다.";
JS_MESSAGE["userotp.token.forbid"] = "관리자 운영 정책에서 토큰은 지원하지 않는 OTP 타입 입니다.";
JS_MESSAGE["userotp.radius.forbid"] = "관리자 운영 정책에서 RADIUS는 지원하지 않는 OTP 타입 입니다.";
JS_MESSAGE["userotp.timeverify.fail"] = "OTP 번호 검증(시간)에 실패 하였습니다.";
JS_MESSAGE["userotp.dbverify.otp_type.invalid"] = "DB 검증의 경우 모바일 OTP 앱을 사용하실 수 없습니다.";
JS_MESSAGE["userotp.dbverify.fail"] = "OTP 번호 검증(DB)에 실패 하였습니다.";
JS_MESSAGE["userotp.dbdata.notexist"] = "유효하지 않는 OTP 인증번호(DB) 입니다. OTP 인증 방식을 확인하여 주십시오.";
JS_MESSAGE["userotp.number.send"] = "OTP 번호를 전송 하였습니다.";
JS_MESSAGE["userotp.insert"] = "사용자 OTP 정보를 등록 하였습니다.";
JS_MESSAGE["userotp.info.update"] = "OTP 정보를 수정 하였습니다.";
JS_MESSAGE["userotp.number.empty"] = "OTP 번호를 입력하여 주십시오.";
JS_MESSAGE["userotp.otp_use_yn.invalid"] = "OTP 사용 유무를 선택하여 주십시오.";
JS_MESSAGE["userotp.otp_status.invalid"] = "OTP 인증 서비스 이용을 위한 OTP 상태가 사용중지 또는 잠금 입니다. 관리자에게 문의하여 주십시오.";
JS_MESSAGE["userotp.info.invalid"] = "사용자 기본 정보 등록 후 이용 가능 합니다.";
JS_MESSAGE["userotp.createrole.invalid"] = "해당 사용자는 OTP 생성 Role 을 가지고 있는 사용자 그룹에 속해 있지 않습니다. 관리자에게 권한을 요청하십시오.";
JS_MESSAGE["userotp.verifyrole.invalid"] = "해당 사용자는 OTP 검증 Role 을 가지고 있는 사용자 그룹에 속해 있지 않습니다. 관리자에게 권한을 요청하십시오.";
JS_MESSAGE["userotp.count.invalid"] = "해당 사용자는 OTP 발급 이용 횟수를 초과하였습니다.";
JS_MESSAGE["userotp.date.invalid"] = "해당 사용자는 OTP 발급 사용 기간이 아닙니다.";
JS_MESSAGE["userotp.constraint.date.invalid"] = "OTP 사용 접속 제어 기간 설정이 올바르지 않습니다.";
JS_MESSAGE["userotp.constraint.dayofweek.invalid"] = "OTP 사용 접속 제어 [요일] 설정 제한일 입니다.";
JS_MESSAGE["userotp.constraint.end_day.invalid"] = "종료일이 유효하지 않습니다.";
JS_MESSAGE["userotp.constraint.start_time.invalid"] = "시작 시간이 유효하지 않습니다.";
JS_MESSAGE["userotp.constraint.end_time.invalid"] = "종료 시간이 유효하지 않습니다.";
JS_MESSAGE["userotp.constraint.end_date.invalid"] = "시작 기간이 종료 기간보다 같거나 클수 없습니다.";
JS_MESSAGE["otp.correct.number"] = "유효한 OTP 번호 입니다.";
JS_MESSAGE["userotp.api.fail"] = "OTP 인증번호(API) 생성 요청에 실패했습니다.";

// 운영정책
JS_MESSAGE["policy.server.datetime"] = "서버 시간이 재설정되었습니다."
JS_MESSAGE["policy.user.update"] = "사용자 정책을 수정 하였습니다.";
JS_MESSAGE["policy.userotp.update"] = "사용자 OTP 정책을 수정 하였습니다.";
JS_MESSAGE["policy.password.update"] = "패스워드 정책을 수정 하였습니다.";
JS_MESSAGE["policy.system.update"] = "시스템 정책을 수정 하였습니다.";
JS_MESSAGE["policy.account.update"] = "계정 정책을 수정 하였습니다.";
JS_MESSAGE["policy.approval.update"] = "결재 정책을 수정 하였습니다.";
JS_MESSAGE["policy.notice.update"] = "알림 정책을 수정 하였습니다.";
JS_MESSAGE["policy.security.update"] = "보안 정책을 수정 하였습니다.";
JS_MESSAGE["policy.content.update"] = "컨텐트 정책을 수정 하였습니다.";
JS_MESSAGE["policy.site.update"] = "사이트 정보를 수정 하였습니다.";
JS_MESSAGE["policy.os.update"] = "OS 설정 정보를 수정 하였습니다.";
JS_MESSAGE["policy.backoffice.update"] = "Back Office 정보를 수정 하였습니다.";
JS_MESSAGE["policy.solution.update"] = "제품 정보를 수정 하였습니다.";

// 인터페이스
JS_MESSAGE["systemconfig.invalid"] = "GateWay, DNS 1차, DNS 2차 값을 확인하여 주십시오..";

JS_MESSAGE["fileinfo.invalid"] = "파일이 존재하지 않습니다.";
JS_MESSAGE["fileinfo.name.invalid"] = "파일 이름이 유효하지 않습니다.";
JS_MESSAGE["fileinfo.ext.invalid"] = "일괄 등록은 Excel 파일만 가능합니다.";
JS_MESSAGE["fileinfo.size.invalid"] = "업로딩 가능한 파일 최대 사이즈는 10M가 입니다.";
JS_MESSAGE["fileinfo.copy.exception"] = "파일 업로더 중 오류가 발생하였습니다.";
JS_MESSAGE["fileinfo.parse.exception"] = "파일 업로더 처리중(파싱) 오류가 발생하였습니다.";

// API
JS_MESSAGE["api.otp_createrole.invalid"] = "해당 접속 서버는 OTP 생성 Role 을 가지고 있는 서버 그룹에 속해 있지 않습니다. 관리자에게 권한을 요청하십시오.";
JS_MESSAGE["api.otp_verifyrole.invalid"] = "해당 접속 서버는 OTP 검증 Role 을 가지고 있는 서버 그룹에 속해 있지 않습니다. 관리자에게 권한을 요청하십시오.";

// Server
JS_MESSAGE["server.insert"] = "서버를 등록 하였습니다.";
JS_MESSAGE["server.update"] = "서버 정보를 수정 하였습니다.";
JS_MESSAGE["server.server_ip.empty"] = "서버 아이피를 입력하여 주십시오.";
JS_MESSAGE["server.server_ip.duplication"] = "사용중인 아이피 입니다. 다른 아이피를 선택해 주십시오.";
JS_MESSAGE["server.server_ip.enable"] = "사용 가능한 아이피 입니다.";
JS_MESSAGE["server.server_name.invalid"] = "서버명이 유효하지 않습니다.";
JS_MESSAGE["server.server_ip.invalid"] = "아이피가 유효하지 않습니다.";
JS_MESSAGE["server.api_key.invalid"] = "API KEY가 유효하지 않습니다.";

// API
JS_MESSAGE["external_service.service_code.enable"] = "서비스 코드가 유효하지 않습니다.";
JS_MESSAGE["external_service.service_name.invalid"] = "서비스명이 유효하지 않습니다.";
JS_MESSAGE["external_service.server_ip.invalid"] = "서버 IP가 유효하지 않습니다.";

JS_MESSAGE["systemconfig.gateway_ip.invalid"] = "Default G/W IP가 유효하지 않습니다.";
JS_MESSAGE["systemconfig.first_dns_ip.invalid"] = "DNS 1차 IP가 유효하지 않습니다.";
JS_MESSAGE["systemconfig.second_dns_ip.invalid"] = "DNS 2차 IP가 유효하지 않습니다.";

// ICMP
JS_MESSAGE["icmp.ip.empty"] = "목적지 주소를 입력하여 주십시오.";
JS_MESSAGE["icmp.ip.duplication"] = "사용중인 목적지 주소입니다. 다른 목적지 주소를 선택해 주십시오.";
JS_MESSAGE["icmp.ip.enable"] = "사용 가능한 목적지 주소입니다.";

JS_MESSAGE["role.role_id.required"] = "ROLE 고유키를 입력하여 주십시오.";

JS_MESSAGE["common_code.code_key.required"] = "코드키를 입력하여 주십시오.";
JS_MESSAGE["common_code.code_name.required"] = "코드명를 입력하여 주십시오.";
