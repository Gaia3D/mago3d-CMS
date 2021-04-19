package gaia3d.domain;

/**
 * user_data_group 의 location, height 등의 위치를 data_info 등록시 자동으로 가장 최신 데이터로 update 할지, 사용자가 입력하게 한 값으로 할지
 * 사용자가 한번이라도 입력하면 그 이후에는 자동으로 update 하지 않음
 * @author Jeongdae
 *
 */
public enum LocationUdateType {

	// 사용자가 입력하지 않은 경우, data가 등록 될때 가장 최신 데이터의 location, altitude, duration = 3,000 을 입력 
	AUTO,
	// 사용자가 직접 location, altitude, duration 을 입력
	USER
}
