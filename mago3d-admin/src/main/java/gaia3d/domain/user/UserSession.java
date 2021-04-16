package gaia3d.domain.user;

import java.io.Serializable;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 세션에 저장될 사용자 정보
 * @author jeongdae
 *
 */
@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserSession implements Serializable {

    /**
	 * 
	 */
	private static final long serialVersionUID = -7501829694372184669L;

	/******* 세션 하이재킹 체크 *******/
	private String signinIp;

	// 고유번호
	private String userId;
	// 사용자 그룹 고유번호
	private Integer userGroupId;
	// 사용자 그룹명(화면용)
	private String userGroupName;
	// 이름
	private String userName;
	// 비밀번호
	private String password;
	// SALT(spring5부터 사용 안함)
	private String salt;
	
	// 최초 로그인시 사용자 Role 권한 체크 패스 기능
	private String userRoleCheckYn;
	// 사용자 상태. 0:사용중, 1:사용중지(관리자), 2:잠금(비밀번호 실패횟수 초과), 3:휴면(로그인 기간), 4:만료(사용기간 종료), 5:삭제(화면 비표시, policy.user_delete_method=0), 6:임시비밀번호
	private String status;
	
	// 사인인 실패 횟수
	private Integer failSigninCount;
	// 일정 기간 동안 미 접속시 잠금 처리 결과 값
	private Boolean userLastSigninLockOver;
	// 패스워드 변경 주기 값
	private Boolean passwordChangeTermOver;
	
	// 마지막 사인인 날짜
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime lastSigninDate;
}
