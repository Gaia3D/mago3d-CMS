package gaia3d.domain.user;

import java.io.Serializable;
import java.time.LocalDateTime;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

import gaia3d.domain.common.Search;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserInfo extends Search implements Serializable {

    /**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = -3187805323220573503L;
	
	/******** 화면 오류 표시용 ********/
	private String message;
	private String errorCode;
	// 일정 기간 동안 미 접속시 잠금 처리(예 3개월 90일)
	private String userLastSigninLock;
	// 아이디 중복 확인 hidden 값
	private String duplicationValue;
	// 논리 삭제 
	private String deleteFlag;
	
	/****** validator ********/
	private String methodMode;
	
	/********** Policy ************/
	// 사용자 사인인 실패 잠금 해제 기간
	private String userFailLockRelease;
	
	/********** DB 사용 *************/
	// 고유번호
	@NotBlank
	private String userId;
	// 사용자 그룹 고유번호
	private Integer userGroupId;
	// 사용자 그룹명(화면용)
	private String userGroupName;
	// 이름
	@Size(max = 64)
	private String userName;
	// 비밀번호
	@NotBlank
	private String password;
	// 비밀번호 확인
	private String passwordConfirm;
	// SALT(spring5부터 사용 안함)
	private String salt;
	// 전화번호1
	private String telephone1;
	// 전화번호2
	private String telephone2;
	// 전화번호3
	private String telephone3;
	// 전화번호
	private String telephone;
	// 핸드폰 번호1
	private String mobilePhone1;
	// 핸드폰 번호2
	private String mobilePhone2;
	// 핸드폰 번호3
	private String mobilePhone3;
	// 핸드폰 번호
	private String mobilePhone;
	// 이메일
	private String email;
	// 이메일1
	private String email1;
	// 이메일2
	private String email2;
	// 메신저 아이디
	private String messenger;
	// 우편번호
	private String postalCode;
	// 주소
	private String address;
	// 상세주소
	private String addressEtc;
	// 사인인 횟수
	private Long signinCount;
	// 사인인 실패 횟수
	private Integer failSigninCount;
	// 마지막 사인인 비밀번호 변경 날짜
	private String lastPasswordChangeDate;
	// 마지막 사인인 날짜
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime lastSigninDate;
	// 최초 사인인시 사용자 Role 권한 체크 패스 기능
	private String userRoleCheckYn;
	// 사용자 상태. 0:사용중, 1:사용중지(관리자), 2:잠금(비밀번호 실패횟수 초과), 3:휴면(사인인 기간), 4:만료(사용기간 종료), 5:삭제(화면 비표시, policy.user_delete_method=0), 6:임시비밀번호, 7:승인대기
	private String status;
	// 사용자 상태 집계
	private Long statusCount;
	// 현재 사용자 상태값
	private String dbStatus;
	// 새로운 비밀번호
	private String newPassword;
	// 새로운 비밀번호 확인
	private String newPasswordConfirm;
	// 패스워드 변경 주기
	private String passwordChangeTerm;
	// 패스워드 변경 주기 값
	private Boolean passwordChangeTermOver;
	// 이메일 From
	private String from;
	// 이메일 Subject
	private String subject;
	// 임시 비밀번호
	private String tempPassword;
	// 일정 기간 동안 미 접속시 잠금 처리 결과 값
	private Boolean userLastSigninLockOver;
	
	// 개인정보 수정 날짜
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime updateDate;
	// 등록일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime insertDate;
}
