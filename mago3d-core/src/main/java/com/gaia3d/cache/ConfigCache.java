package com.gaia3d.cache;

import com.gaia3d.domain.Policy;

/**
 * TODO 귀찮고, 전부 select 성 데이터고 관리자가 혼자라서 getInstance를 사용하지 않았음. 바람직 하지는 않음
 * 환경 설정 관련 모든 요소를 캐시 처리
 * 
 * @author jeongdae
 *
 */
public class ConfigCache {

	private volatile static ConfigCache configCache = new ConfigCache();;
	
	private ConfigCache() {
	}
	
	// 회사명
	private String companyName;
	// 회사별 설정 파일 정합성 체크
	private boolean companyConfigValidation;
	// 서버 실제 IP
	private String serverIp;
	// 서버명
	private String serverName;
	// 호스트명
	private String hostname;
	// 라이선스 유효성
	private boolean licenseAvailable = false;
	// 라이선스 파일 OTP 사용자 수
	private Integer otpUserCount = 0;
	// OS TYPE
	private String osType = null;
	// SSL Key 경로
	private String sslKeyPath = null;
	// SSL Key 비밀번호
	private String sslKeyPassword = null;
	// StandBy Server 상태( ON, OFF, BUSY )
	private String standByServerStatus = null;
	
	// 운영 정책
	private Policy policy = null;
	
//	/**
//	 * 객체 리턴
//	 * @return
//	 */
//	public static ConfigCache getInstance() {
//		if(configCache == null) {
//			synchronized (ConfigCache.class) {
//				if(configCache == null) {
//					configCache = new ConfigCache();
//				}
//			}
//		}
//		return configCache;
//	}
	
	/**
	 * 회사명
	 * @return
	 */
	public static String getCompanyName() {
		return configCache.companyName;
	}

	public static void setCompanyName(String companyName) {
		configCache.companyName = companyName;
	}
	
	/**
	 * 회사별 설정 파일 정합성 체크
	 * @return
	 */
	public static boolean isCompanyConfigValidation() {
		return configCache.companyConfigValidation;
	}

	public static void setCompanyConfigValidation(boolean companyConfigValidation) {
		configCache.companyConfigValidation = companyConfigValidation;
	}

	/** 
	 * 서버 IP
	 * @return
	 */
	public static String getServerIp() {
		return configCache.serverIp;
	}

	public static void setServerIp(String serverIp) {
		configCache.serverIp = serverIp;
	}
	
	/**
	 * 서버명
	 * @return
	 */
	public static String getServerName() {
		return configCache.serverName;
	}

	public static void setServerName(String serverName) {
		configCache.serverName = serverName;
	}
	
	/**
	 * hostname
	 * @return
	 */
	public static String getHostname() {
		return configCache.hostname;
	}

	public static void setHostname(String hostname) {
		configCache.hostname = hostname;
	}
	
	/**
	 * 라이선스 유효성 확인
	 * @return
	 */
	public static boolean isLicenseAvailable() {
		return configCache.licenseAvailable;
	}

	public static void setLicenseAvailable(boolean licenseAvailable) {
		configCache.licenseAvailable = licenseAvailable;
	}
	
	/**
	 * 라이선스 파일에 있는 OTP 사용자 수
	 * @return
	 */
	public static Integer getOtpUserCount() {
		return configCache.otpUserCount;
	}

	public static void setOtpUserCount(Integer otpUserCount) {
		configCache.otpUserCount = otpUserCount;
	}

	/**
	 * OS Type
	 * @return
	 */
	public static String getOsType() {
		return configCache.osType;
	}

	public static void setOsType(String osType) {
		configCache.osType = osType;
	}

	/**
	 * SSL Key 경로
	 * @return
	 */
	public static String getSslKeyPath() {
		return configCache.sslKeyPath;
	}

	public static void setSslKeyPath(String sslKeyPath) {
		configCache.sslKeyPath = sslKeyPath;
	}

	/**
	 * SSL Key 비밀번호
	 * @return
	 */
	public static String getSslKeyPassword() {
		return configCache.sslKeyPassword;
	}

	public static void setSslKeyPassword(String sslKeyPassword) {
		configCache.sslKeyPassword = sslKeyPassword;
	}
	
	/**
	 * StandBy Server 상태( ON, OFF, BUSY )
	 * @return
	 */
	public static String getStandByServerStatus() {
		return configCache.standByServerStatus;
	}

	public static void setStandByServerStatus(String standByServerStatus) {
		configCache.standByServerStatus = standByServerStatus;
	}
	
	/**
	 * 운영 정책
	 * @return
	 */
	public static Policy getPolicy() {
		return configCache.policy;
	}
	
	public static void setPolicy(Policy policy) {
		configCache.policy = policy;
	}
}
