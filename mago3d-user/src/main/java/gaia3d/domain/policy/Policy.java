package gaia3d.domain.policy;

import java.time.LocalDateTime;

import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 운영 정책
 * TODO 도메인 답게 나누자.
 * @author jeongdae
 *
 */
@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Policy {
    
	// 고유번호
	@NotNull
    private Long policyId;

	// 사용자 아이디 최소 길이. 기본값 5
 	private Integer userIdMinLength;
 	// 사용자 로그인 실패 횟수
 	private Integer userFailSigninCount;
 	// 사용자 로그인 실패 잠금 해제 기간
 	private String userFailLockRelease;
 	// 사용자 마지막 로그인으로 부터 잠금 기간
 	private String userLastSigninLock;
 	// 사용자 중복 로그인 허용 여부. Y : 허용, N : 허용안함(기본값)
 	private String userDuplicationSigninYn;
 	// 사용자 로그인 인증 방법. 0 : 일반(아이디/비밀번호(기본값)), 1 : 기업용(사번추가), 2 : 일반 + OTP, 3 : 일반 + 인증서, 4 : OTP + 인증서, 5 : 일반 + OTP + 인증서
 	private String userSigninType;
 	// 사용자 정보 수정시 확인
 	private String userUpdateCheck;
 	// 사용자 정보 삭제시 확인
 	private String userDeleteCheck;
 	// 사용자 정보 삭제 방법. 0 : 논리적(기본값), 1 : 물리적(DB 삭제)
 	private String userDeleteType;
	// 회원 가입 후 승인 방법. auto : 승인 없이 사용, approval : 승인 후 사용
	private String signupType;
 	
 	// 패스워드 변경 주기 기본 30일
 	private String passwordChangeTerm;
 	// 패스워드 최소 길이 기본 8
 	private Integer passwordMinLength;
 	// 패스워드 최대 길이 기본 32
 	private Integer passwordMaxLength;
 	// 패스워드 영문 대문자 개수 기본 1
 	private Integer passwordEngUpperCount;
 	// 패스워드 영문 소문자 개수 기본 1
 	private Integer passwordEngLowerCount;
 	// 패스워드 숫자 개수 기본 1
 	private Integer passwordNumberCount;
 	// 패스워드 특수 문자 개수 1
 	private Integer passwordSpecialCharCount;
 	// 패스워드 연속문자 제한 개수 3
 	private Integer passwordContinuousCharCount;
 	// 초기 패스워드 생성 방법. 0 : 사용자 아이디 + 초기문자(기본값), 1 : 초기문자
 	private String passwordCreateType;
 	// 초기 패스워드 생성 문자열. 엑셀 업로드 등
 	private String passwordCreateChar;
 	// 패스워드로 사용할수 없는 특수문자(XSS). <,>,&,작은따음표,큰따움표
 	private String passwordExceptionChar;
 	
 	// 알림 서비스 사용 유무. Y : 사용, N : 미사용(기본값)
 	private String noticeServiceYn;
 	// 알림 발송 매체. 0 : SMS(기본값), 1 : 이메일, 2 : 메신저
 	private String noticeServiceSendType;
 	// 알림 결재 요청/대기시. Y : 사용, N 미사용(기본값)
 	private String noticeApprovalRequestYn;
 	// 알림 결재 완료시. Y : 사용, N 미사용(기본값)
 	private String noticeApprovalSignYn;
 	// 알림 관리 계정 패스워드 변경시. Y : 사용, N 미사용(기본값)
 	private String noticePasswordUpdateYn;
 	// 알림 결재 대기시. Y : 사용, N 미사용(기본값)
 	private String noticeApprovalDelayYn;
 	// 알림 장애 발생시. Y : 사용, N 미사용(기본값)
 	private String noticeRiskYn;
 	// 알림 장애 발송 매체. 0 : SMS(기본값), 1 : 이메일, 2 : 메신저
 	private String noticeRiskSendType;
 	// 알림 발송 장애 등급. 1 : 1등급(기본값), 2 : 2등급, 3 : 3등급
 	private String noticeRiskGrade;
 	
 	// 보안 세션 타임아웃. Y : 사용, N 미사용(기본값)
 	private String securitySessionTimeoutYn;
 	// 보안 세션 타임아웃 시간. 30분
 	private String securitySessionTimeout;
 	// 로그인 시 사용자 등록 IP 체크 유무. Y : 사용, N 미사용(기본값)
 	private String securityUserIpCheckYn;
 	// 보안 세션 하이재킹 처리. 0 : 미사용, 1 : 사용(기본값), 2 : OTP 추가 인증
 	private String securitySessionHijacking;
 	// 보안 로그 보존 방법. 1 : DB(기본값), 2 : 파일
 	private String securityLogSaveType;
 	// 보안 로그 보존 기간. 2년 기본값
 	private String securityLogSaveTerm;
 	// 보안 동적 차단. Y : 사용, N 미사용(기본값)
 	private String securityDynamicBlockYn;
 	// API 결과 암호화 사용. Y : 사용, N 사용안함(기본값)
 	private String securityApiResultSecureYn;
 	// 개인정보 마스킹 처리. Y : 사용(기본값), N 사용안함
 	private String securityMaskingYn;
 	
 	// css, js 갱신용 cache version.
 	private Integer contentCacheVersion;
 	// 메인 화면 위젯 표시 갯수. 기본 6개
 	private Integer contentMainWidgetCount;
 	// 메인 화면 위젯 Refresh 간격. 기본 65초(모니터링 간격 60초에 대한 시간 간격 고려)
 	private Integer contentMainWidgetInterval;
 	// 대몬에서 WAS 모니터링 감시 간격(분단위). 기본 1분
 	private Integer contentMonitoringInterval;
 	// 통계 기본 검색 기간. 0 : 1년단위, 1 : 상/하반기, 2 : 분기별, 3 : 월별
 	private String contentStatisticsInterval;
 	// 현재 서버가 Active, Standby 인지 상태를 표시하는 주기
 	private Integer contentLoadBalancingInterval;
 	// 메뉴 그룹 최상위 그룹명
 	private String contentMenuGroupRoot;
 	// 사용자 그룹 최상위 그룹명
 	private String contentUserGroupRoot;
 	// Layer 그룹 최상위 그룹명
 	private String contentLayerGroupRoot;
 	// data 그룹 최상위 그룹명
 	private String contentDataGroupRoot;
 	// 행정구역 사용여부
	private Boolean contentDistrictAvailable;
 	
 	// 업로딩 가능 확장자. 3ds,obj,dae,collada,ifc,las,gml,citygml,indoorgml,jpg,jpeg,gif,png,bmp,zip
 	private String userUploadType;
 	// 변환 가능 확장자. 3ds,obj,dae,collada,ifc,las,gml,citygml,indoorgml
  	private String userConverterType;
 	// 최대 업로딩 사이즈(단위M). 기본값 10000M
 	private Long userUploadMaxFilesize;
 	// 1회, 최대 업로딩 파일 수. 기본값 500개
 	private Integer userUploadMaxCount;	
 	
 	// 등록일
 	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime insertDate;
}
