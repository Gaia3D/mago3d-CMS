var JS_MESSAGE = new Object();

JS_MESSAGE["create"] = "생성 되었습니다.";
JS_MESSAGE["insert"] = "등록 되었습니다.";
JS_MESSAGE["update"] = "수정 되었습니다.";
JS_MESSAGE["delete"] = "삭제 되었습니다.";
JS_MESSAGE["success"] = "성공 하였습니다.";
JS_MESSAGE["apply"] = "적용되었습니다.";
JS_MESSAGE["upload"] = "업로딩 중입니다.";
JS_MESSAGE["proceed.confirm"] = "진행 하시겠습니까?";
JS_MESSAGE["move.confirm"] = "이동 하시겠습니까?";
JS_MESSAGE["delete.confirm"] = "삭제 하시겠습니까?";
JS_MESSAGE["check.value.required"] = "선택된 항목이 없습니다.";
JS_MESSAGE["commingsoon"] = "준비중입니다";
JS_MESSAGE["check.group.required"] = "그룹이 선택되지 않았습니다.";
JS_MESSAGE["check.id.duplication"] = "아이디 중복확인을 해주십시오.";
JS_MESSAGE["use.id.other.id.select"] = "사용중인 아이디 입니다. 다른 아이디를 선택해 주십시오.";
JS_MESSAGE["total.count"] = "총건수:";
JS_MESSAGE["total.few"] = "건";
JS_MESSAGE["user"] = "사용자";
JS_MESSAGE["server"] = "서버";
JS_MESSAGE["account"] = "계정";
JS_MESSAGE["use"] = "사용";
JS_MESSAGE["not.use"] = "미사용";

JS_MESSAGE["csrf.token.invalid"] = "보안(CSRF) 토큰이 유효하지 않습니다.";

JS_MESSAGE["file.name.empty"] = "파일명을 입력하여 주십시오.";
JS_MESSAGE["file.name.invalid"] = "파일명이 유효하지 않습니다.";
JS_MESSAGE["file.ext.invalid"] = "파일 확장자가 유효하지 않습니다.";
JS_MESSAGE["fileinfo.size.invalid"] = "업로딩 가능한 파일 사이즈를 초과 하였습니다.";

// 공통
JS_MESSAGE["user.session.empty"] = "사인인 후 사용 가능한 서비스 입니다.";
JS_MESSAGE["db.exception"] = "데이터 베이스 오류가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.";
JS_MESSAGE["io.exception"] = "입출력 처리 과정중 오류가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.";
JS_MESSAGE["runtime.exception"] = "프로그램 실행중 오류가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.";
JS_MESSAGE["unknown.exception"] = "서버 장애가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.";
JS_MESSAGE["ajax.error.message"] = "잠시 후 이용해 주시기 바랍니다. 장시간 같은 현상이 반복될 경우 관리자에게 문의하여 주십시오.";
JS_MESSAGE["button.dobule.click"] = "진행 중입니다.";
JS_MESSAGE["cache.reloaded"] = "캐시를 갱신 하였습니다.";
JS_MESSAGE["usersession.grant.invalid"] = "사용 권한이 유효하지 않습니다.";

//사용자
JS_MESSAGE["user.id.empty"] = "아이디를 입력하여 주십시오.";
JS_MESSAGE["user.id.enable"] = "사용 가능한 아이디 입니다.";
JS_MESSAGE["user.id.min_length.invalid"] = "사용자 아이디 최소 길이가 올바르지 않습니다.";
JS_MESSAGE["password.empty"] = "비밀번호를 입력하여 주십시오.";
JS_MESSAGE["password.correct.empty"] = "비밀번호 확인을 입력하여 주십시오.";
JS_MESSAGE["user.name.empty"] = "이름을 입력하여 주십시오.";
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
JS_MESSAGE["user.insert"] = "사용자를 등록 하였습니다.";
JS_MESSAGE["user.info.update"] = "사용자 정보를 수정 하였습니다.";
JS_MESSAGE["user.id.notexist"] = "아이디가 존재하지 않습니다.";

JS_MESSAGE["password.new"] = "새로운 비밀번호를 입력하여 주십시오.";
JS_MESSAGE["password.match.current"] = "현재 비밀번호와 일치합니다.";
JS_MESSAGE["password.not.match.new"] = "새로운 비밀번호와 일치하지 않습니다.";
JS_MESSAGE["password.change.next"] = "다음에 변경 시 로그인 페이지로 돌아가며 서비스를 사용할 수 없습니다. 비밀번호를 다음에 변경하시겠습니까?";


//운영정책
JS_MESSAGE["policy.user.update"] = "사용자 정책을 수정 하였습니다.";
JS_MESSAGE["policy.password.update"] = "패스워드 정책을 수정 하였습니다.";
JS_MESSAGE["policy.geo.update"] = "공간 정보를 수정 하였습니다.";
JS_MESSAGE["policy.geoserver.update"] = "GeoServer를 수정 하였습니다.";
JS_MESSAGE["policy.geocallback.update"] = "CallBack 함수를 수정 하였습니다.";
JS_MESSAGE["policy.notice.update"] = "알림 정책을 수정 하였습니다.";
JS_MESSAGE["policy.security.update"] = "보안 정책을 수정 하였습니다.";
JS_MESSAGE["policy.content.update"] = "컨텐트 정책을 수정 하였습니다.";
JS_MESSAGE["policy.content.invalid"] = "필수 입력값이 유효하지 않습니다.";

JS_MESSAGE["policy.user.id.min.length"] = "사용자 아이디 최소 길이를 입력하여 주십시오.";
JS_MESSAGE["policy.user.id.min.length.rule"] = "사용자 아이디 최소 길이는 4 이상 입니다.";
JS_MESSAGE["policy.user.signin.fail"] = "사인인 실패 횟수를 입력하여 주십시오.";
JS_MESSAGE["policy.user.lockout.period"] = "마지막 사인인으로 부터 잠금 기간을 입력하여 주십시오.";

JS_MESSAGE["policy.password.period"] = "변경 주기를 입력하여 주십시오.";
JS_MESSAGE["policy.password.min.length"] = "최소 길이를 입력하여 주십시오.";
JS_MESSAGE["policy.password.max.length"] = "최대 길이를 입력하여 주십시오.";
JS_MESSAGE["policy.password.uppercase"] = "영문 대문자 개수를 입력하여 주십시오.";
JS_MESSAGE["policy.password.lowercase"] = "영문 소문자 개수를 입력하여 주십시오.";
JS_MESSAGE["policy.password.number"] = "숫자 개수를 입력하여 주십시오.";
JS_MESSAGE["policy.password.special.letters"] = "특수 문자 개수를 입력하여 주십시오.";
JS_MESSAGE["policy.password.serial.limit"] = "패스워드 연속문자 제한 개수를 입력하여 주십시오.";

JS_MESSAGE["policy.contents.main.display"] = "메인 화면 컨텐츠 표시 개수를 입력하여 주십시오.";
JS_MESSAGE["policy.contents.widget.interval"] = "메인 화면 위젯 Refresh 간격을 입력하여 주십시오.";
JS_MESSAGE["policy.statistics_.interval"] = "통계 기본 검색 기간을 선택해 주십시오.";
JS_MESSAGE["policy.contents.menu.group.root"] = "메뉴 그룹 최상위 그룹명을 입력하여 주십시오.";
JS_MESSAGE["policy.contents.user.group.root"] = "사용자 그룹 최상위 그룹명을 입력하여 주십시오.";
JS_MESSAGE["policy.contents.main.display"] = "메인 화면 컨텐츠 표시 개수를 입력하여 주십시오.";
JS_MESSAGE["policy.contents.main.display"] = "메인 화면 컨텐츠 표시 개수를 입력하여 주십시오.";
JS_MESSAGE["policy.contents.main.display"] = "메인 화면 컨텐츠 표시 개수를 입력하여 주십시오.";

JS_MESSAGE["policy.menu.invalid"] = "필수 입력값이 유효하지 않습니다.";

// ticks
JS_MESSAGE["main.status.in.use"] = "사용중";
JS_MESSAGE["main.status.stop.use"] = "사용중지";
JS_MESSAGE["main.status.fail.count"] = "실패횟수";
JS_MESSAGE["main.status.dormancy"] = "휴면";
JS_MESSAGE["main.status.expires"] = "기간만료";
JS_MESSAGE["main.status.temporary.password"] = "임시비밀번호";

//user group
JS_MESSAGE["user.group.select"] = "사용자 그룹을 선택해 주세요.";
JS_MESSAGE["user.group.top.not.insert"] = "최상위 그룹에는 사용자를 등록할 수 없습니다.";
JS_MESSAGE["user.group.role.top.not.insert"] = "최상위 그룹에는 Role을 등록할 수 없습니다.";
JS_MESSAGE["user.group.not.group.id"] = "그룹 아이디가 없습니다.";
JS_MESSAGE["user.group.not.select"] = "선택된 항목이 없습니다.";

//input group
JS_MESSAGE["user.group.id.minlength"] = "사용자 아이디 최소 길이는";
JS_MESSAGE["user.group.id.minlength.2"] = "입니다";
JS_MESSAGE["user.group.password.not.same"] = "비밀번호가 비밀번호 확인 이랑 일치하지 않습니다.";
JS_MESSAGE["user.group.phone.number.type"] = "전화번호 형식에 맞게 입력해 주십시오.";
JS_MESSAGE["user.group.email.type"] = "이메일 형식에 맞게 입력해 주십시오."
JS_MESSAGE["user.group.mobiler.type"] = "휴대폰 번호 형식에맞게 입력해 주십시오."
JS_MESSAGE["user.basic.information.input"] = "사용자 기본 정보 등록 후 이용 가능 합니다.";
JS_MESSAGE["use.device.name.input"] = "사용 기기명을 입력해 주십시오.";
JS_MESSAGE["input.ip"] = "IP 형식에 맞게 입력해 주십시오.";
JS_MESSAGE["user.device.input.max.five"] = "사용자 디바이스 등록은 최대 5개 까지 가능합니다.";
JS_MESSAGE["error.exist.in.processing"] = "처리 과정에서 오류가 발생하였습니다. 확인하여 주십시오.";
JS_MESSAGE["user.group.role.invalid"] = "사용자 그룹 권한이 유효하지 않습니다.";

//role
JS_MESSAGE["role.insert.name"] = "Role명을 입력하여 주십시오.";
JS_MESSAGE["role.insert.key"] = "Role Key를 입력하여 주십시오.";
JS_MESSAGE["role.insert.type"] = "Role 유형을 선택해 주십시오.";

//widget
JS_MESSAGE["config.schedule.widget.does.not.exist"] = "스케줄 실행 이력이 존재하지 않습니다.";
JS_MESSAGE["config.widget.using"] = "사용중";
JS_MESSAGE["config.widget.stop.using"] = "사용중지";
JS_MESSAGE["config.widget.fail.count"] = "실패횟수";
JS_MESSAGE["config.widget.dormancy"] = "휴면";
JS_MESSAGE["config.widget.expires"] = "기간만료";
JS_MESSAGE["config.temporary.password"] = "임시비밀번호";
JS_MESSAGE["config.widget.content.does.not.exist"] = "수정된 컨텐츠가 존재하지 않습니다.";

JS_MESSAGE["data.name.empty"] = "데이터명을 입력하여 주십시오.";
JS_MESSAGE["data.group.id.empty"] = "데이터 그룹명 입력하여 주십시오.";
JS_MESSAGE["data.sharing.empty"] = "공유 유형을 선택하여 주십시오.";
JS_MESSAGE["data.type.empty"] = "데이터 타입을 선택하여 주십시오.";
JS_MESSAGE["data.latitude.empty"] = "위도를 입력하여 주십시오.";
JS_MESSAGE["data.longitude.empty"] = "경도를  입력하여 주십시오.";
JS_MESSAGE["data.altitude.empty"] = "높이를  입력하여 주십시오.";
JS_MESSAGE["data.file.empty"] = "파일을 입력하여 주십시오.";
JS_MESSAGE["data.insert"] = "데이터를 등록 하였습니다.";
JS_MESSAGE["data.update.check"] = "현재 입력된 위치와 회전 정보를 db에 저장하시겠습니까?";

JS_MESSAGE["data.group.key.empty"] = "데이터 그룹 Key 를 입력하여 주십시오.";
JS_MESSAGE["data.group.key.duplication"] = "사용중인 데이터 그룹 Key 입니다. 다른 이름을 사용해 주십시오.";
JS_MESSAGE["data.group.key.enable"] = "사용 가능한 데이터 그룹 Key 입니다.";
JS_MESSAGE["data.group.key.duplication.check"] = "데이터 그룹 Key 중복 확인이 필요 합니다.";

JS_MESSAGE["upload.data.id.empty"] = "업로더 데이터 삭제 정보가 유효하지 않습니다.";
JS_MESSAGE["upload.file.type.invalid"] = "업로드 파일 타입이 유효하지 않습니다.";
JS_MESSAGE["upload.shpfile.requried"] = "enable_yn, version_id 필드가 필요합니다.";
JS_MESSAGE["upload.shpfile.invalid"] = "shp, shx, dbf 파일이 필요합니다.";

JS_MESSAGE["converter.title.empty"] = "제목을 입력하여 주십시오.";
JS_MESSAGE["converter.usf.empty"] = "Unit Scale Factor 를 입력하여 주십시오.";

JS_MESSAGE["search.option.warning"] = "포함 옵션을 사용하실 경우 1분 이상이 소요될 수 있습니다. 계속 진행 하시겠습니까?";
JS_MESSAGE["search.date.warning"] = "시작일이 종료일보다 클수 없습니다.";

JS_MESSAGE["group.key.empty"] = "그룹 Key 를 입력하여 주십시오.";
JS_MESSAGE["group.key.duplication"] = "사용중인 그룹 Key 입니다. 다른 이름을 사용해 주십시오.";
JS_MESSAGE["group.key.enable"] = "사용 가능한 그룹 Key 입니다.";
JS_MESSAGE["group.key.duplication.check"] = "그룹 Key 중복 확인이 필요 합니다.";

JS_MESSAGE["layer.key.duplication"] = "사용중인 layer Key 입니다. 다른 이름을 사용해 주십시오.";

JS_MESSAGE["already.agreed"] = "이미 동의하였습니다.";

JS_MESSAGE["tile.key.empty"] = "타일 Key 를 입력하여 주십시오.";
JS_MESSAGE["tile.key.duplication"] = "사용중인 타일 Key 입니다. 다른 이름을 사용해 주십시오.";
JS_MESSAGE["tile.key.enable"] = "사용 가능한 타일 Key 입니다.";
JS_MESSAGE["tile.key.duplication.check"] = "타일 Key 중복 확인이 필요 합니다.";
