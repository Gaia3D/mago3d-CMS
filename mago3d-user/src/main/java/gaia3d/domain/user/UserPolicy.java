package gaia3d.domain.user;

import java.io.Serializable;
import java.time.LocalDateTime;

import javax.validation.constraints.Digits;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserPolicy implements Serializable {

	private static final long serialVersionUID = -6548874769672071277L;

	// 고유 번호
	private Integer userPolicyId;
	// 사용자 아이디
	private String userId;
	// 사용자 설정 레이어 
	private String baseLayers;
	// 초기 카메라 이동 위도
	private String initLatitude;
	// 초기 카메라 이동 경도
	private String initLongitude;
	// 초기 카메라 이동 높이
	private String initAltitude;
	// 초기 카메라 이동 시간. 초 단위
	@Digits(integer = 2, fraction = 0)
	private Integer initDuration;
	// field of view. 기본값 0(1.8 적용) 
	private Float initDefaultFov;
	private String lod0;
	private String lod1;
	private String lod2;
	private String lod3;
	private String lod4;
	private String lod5;
	// 그림자 반경 
	private Float ssaoRadius;
	
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime updateDate;

	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime insertDate;

}
