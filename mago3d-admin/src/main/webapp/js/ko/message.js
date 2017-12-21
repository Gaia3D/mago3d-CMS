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

// 공통
JS_MESSAGE["user.session.empty"] = "로그인 후 사용 가능한 서비스 입니다.";
JS_MESSAGE["db.exception"] = "데이터 베이스 장애가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.";
JS_MESSAGE["ajax.error.message"] = "잠시 후 이용해 주시기 바랍니다. 장시간 같은 현상이 반복될 경우 관리자에게 문의하여 주십시오.";
JS_MESSAGE["button.dobule.click"] = "진행 중입니다.";
JS_MESSAGE["cache.reloaded"] = "캐시를 갱신 하였습니다.";
JS_MESSAGE["usersession.grant.invalid"] = "사용 권한이 유효하지 않습니다.";

JS_MESSAGE["login.password.decrypt.exception"] = "로그인 비밀번호 처리 과정에서 오류가 발생하였습니다.";

// Cache
JS_MESSAGE["cache.input.invalid"] = "필수 입력값이 유효하지 않습니다.";

//사용자
JS_MESSAGE["user.id.empty"] = "아이디를 입력하여 주십시오.";
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
JS_MESSAGE["user.id.enable"] = "사용 가능한 아이디 입니다.";
JS_MESSAGE["user.insert"] = "사용자를 등록 하였습니다.";
JS_MESSAGE["user.info.update"] = "사용자 정보를 수정 하였습니다.";
JS_MESSAGE["user.id.notexist"] = "아이디가 존재하지 않습니다.";


//운영정책
JS_MESSAGE["policy.server.datetime"] = "서버 시간이 재설정되었습니다."
JS_MESSAGE["policy.user.update"] = "사용자 정책을 수정 하였습니다.";
JS_MESSAGE["policy.password.update"] = "패스워드 정책을 수정 하였습니다.";
JS_MESSAGE["policy.geo.update"] = "공간 정보를 수정 하였습니다.";
JS_MESSAGE["policy.geoserver.update"] = "GeoServer를 수정 하였습니다.";
JS_MESSAGE["policy.geocallback.update"] = "CallBack 함수를 수정 하였습니다.";
JS_MESSAGE["policy.notice.update"] = "알림 정책을 수정 하였습니다.";
JS_MESSAGE["policy.security.update"] = "보안 정책을 수정 하였습니다.";
JS_MESSAGE["policy.content.update"] = "컨텐트 정책을 수정 하였습니다.";
JS_MESSAGE["policy.site.update"] = "사이트 정보를 수정 하였습니다.";
JS_MESSAGE["policy.os.update"] = "OS 설정 정보를 수정 하였습니다.";
JS_MESSAGE["policy.backoffice.update"] = "Back Office 정보를 수정 하였습니다.";
JS_MESSAGE["policy.solution.update"] = "제품 정보를 수정 하였습니다.";
JS_MESSAGE["policy.content.invalid"] = "필수 입력값이 유효하지 않습니다.";

// 데이터
JS_MESSAGE["data.key.empty"] = "Key를 입력하여 주십시오.";
JS_MESSAGE["data.key.enable"] = "사용 가능한 Key 입니다.";
JS_MESSAGE["data.key.same"] = "동일 Key 입니다.";
JS_MESSAGE["data.key.duplication"] = "사용중인 Key 입니다. 다른 Key를 선택해 주십시오.";
JS_MESSAGE["data.key.duplication_value.check"] = "Key 중복확인을 해주십시오."
JS_MESSAGE["data.key.duplication_value.already"] = "사용중인 Key 입니다. 다른 Key를 선택해 주십시오.";
JS_MESSAGE["data.project.root.duplication"] = "프로젝트 Root가 존재합니다.";
JS_MESSAGE["data.project.id.empty"] = "프로젝트를 선택하여 주십시오.";
JS_MESSAGE["data.parent.empty"] = "상위 노드를 선택하여 주십시오.";
JS_MESSAGE["data.latitude.empty"] = "위도를 입력하여 주십시오.";
JS_MESSAGE["data.longitude.empty"] = "경도를  입력하여 주십시오.";
JS_MESSAGE["data.height.empty"] = "높이를  입력하여 주십시오.";
JS_MESSAGE["data.heading.empty"] = "Heading을  입력하여 주십시오.";
JS_MESSAGE["data.longitude.empty"] = "경도를  입력하여 주십시오.";
JS_MESSAGE["data.pitch.empty"] = "Pitch를 입력하여 주십시오.";
JS_MESSAGE["data.roll.empty"] = "Roll을 입력하여 주십시오.";
JS_MESSAGE["data.insert"] = "데이터를 등록 하였습니다.";
JS_MESSAGE["data.update"] = "데이터 정보를 수정 하였습니다.";

// project
JS_MESSAGE["project.insert"] = "프로젝트를 등록 하였습니다.";
JS_MESSAGE["project.update"] = "프로젝트를 수정 하였습니다.";
JS_MESSAGE["project.project_id.empty"] = "Project Id를 입력하여 주십시오.";
JS_MESSAGE["project.key.empty"] = "Key를 입력하여 주십시오.";
JS_MESSAGE["project.key.enable"] = "사용 가능한 Key 입니다.";
JS_MESSAGE["project.key.same"] = "동일 Key 입니다.";
JS_MESSAGE["project.key.duplication"] = "사용중인 Key 입니다. 다른 Key를 선택해 주십시오.";
JS_MESSAGE["project.key.duplication_value.check"] = "Key 중복확인을 해주십시오."
JS_MESSAGE["project.key.duplication_value.already"] = "사용중인 Key 입니다. 다른 Key를 선택해 주십시오.";
JS_MESSAGE["project.name.empty"] = "프로젝트명을 입력하여 주십시오.";
JS_MESSAGE["project.latitude.empty"] = "위도를 입력하여 주십시오.";
JS_MESSAGE["project.longitude.empty"] = "경도를  입력하여 주십시오.";
JS_MESSAGE["project.height.empty"] = "높이를  입력하여 주십시오.";
JS_MESSAGE["project.height.empty"] = "이동시간을  입력하여 주십시오.";

// 이슈
JS_MESSAGE["issue.datagroup.empty"] = "데이터 그룹을 선택하여 주십시오.";
JS_MESSAGE["issue.issuetype.empty"] = "Issue Type을 선택하여 주십시오.";
JS_MESSAGE["issue.datakey.empty"] = "Data Key를 입력하여 주십시오.";
JS_MESSAGE["issue.title.empty"] = "제목을 입력하여 주십시오.";
JS_MESSAGE["issue.assignee.empty"] = "대리자를 입력하여 주십시오";
JS_MESSAGE["issue.reporter.empty"] = "보고 해야 하는 사람을 입력하여 주십시오.";
JS_MESSAGE["issue.contents.empty"] = "내용을 입력하여 주십시오.";
JS_MESSAGE["issue.start_hour.proper"] = "issue 시작시간을 올바르게 설정하여 주십시오.";
JS_MESSAGE["issue.start_minute.proper"] = "issue 시작시간을 올바르게 설정하여 주십시오.";

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
JS_MESSAGE["user.basic.information.input"] = "사용자 기본 정보 등록 후 이용 가능 합니다.";
JS_MESSAGE["use.device.name.input"] = "사용 기기명을 입력해 주십시오.";
JS_MESSAGE["input.ip"] = "IP 형식에 맞게 입력해 주십시오.";
JS_MESSAGE["user.device.input.max.five"] = "사용자 디바이스 등록은 최대 5개 까지 가능합니다.";
JS_MESSAGE["fail.count.retry.select"] = "실패 건수가 존재합니다. 파일을 다시 선택해주세요.";

//data
JS_MESSAGE["data.group.select"] = "데이터 그룹을 선택해 주세요.";
JS_MESSAGE["data.top.not.insert"] = "최상위 그룹에는 데이터를 등록할 수 없습니다.";
JS_MESSAGE["data.group.not.group.id"] = "그룹 아이디가 없습니다.";
JS_MESSAGE["data.not.select"] = "선택된 항목이 없습니다.";
JS_MESSAGE["data.no.insert.data"] = "등록된 데이터가 없습니다.";
JS_MESSAGE["data.up.group.no.insert"] = "최상위 그룹에는 등록할 수 없습니다.";

//role
JS_MESSAGE["role.insert.name"] = "Role명을 입력하여 주십시오.";
JS_MESSAGE["role.insert.key"] = "Role Key를 입력하여 주십시오.";
JS_MESSAGE["role.insert.type"] = "Role 유형을 선택해 주십시오.";

//code
JS_MESSAGE["code.insert.name"] = "코드명을 입력하여 주십시오.";
JS_MESSAGE["code.insert.result"] = "코드값을 선택해 주십시오.";

//service
JS_MESSAGE["service.insert.name"] = "서비스명을 입력하여 주십시오.";
JS_MESSAGE["service.insert.ip"] = "서버 IP를 입력하여 주십시오.";
JS_MESSAGE["service.insert.api.key"] = "API KEY를 입력하여 주십시오.";

//widget
JS_MESSAGE["config.schedule.widget.does.not.exist"] = "스케줄 실행 이력이 존재하지 않습니다.";
JS_MESSAGE["config.widget.using"] = "사용중";
JS_MESSAGE["config.widget.stop.using"] = "사용중지";
JS_MESSAGE["config.widget.fail.count"] = "실패횟수";
JS_MESSAGE["config.widget.dormancy"] = "휴면";
JS_MESSAGE["config.widget.expires"] = "기간만료";
JS_MESSAGE["config.widget.temporary.password"] = "임시비밀번호";
JS_MESSAGE["config.widget.content.does.not.exit"] = "수정된 컨텐츠가 존재하지 않습니다.";