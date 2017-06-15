package com.gaia3d.domain;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.gaia3d.domain.Policy;

/**
 * TODO 귀찮고, 전부 select 성 데이터고 관리자가 혼자라서 getInstance를 사용하지 않았음. 바람직 하지는 않음
 * 환경 설정 관련 모든 요소를 캐시 처리
 * 
 * @author jeongdae
 *
 */
public class CacheManager {

	private volatile static CacheManager cacheManager = new CacheManager();;
	
	private CacheManager() {
	}
	
	// 회사명
	private String companyName;
	// 서버 실제 IP
	private String serverIp;
	// 서버명
	private String serverName;
	// 호스트명
	private String hostname;
	// 라이선스 유효성
	private boolean licenseAvailable = false;
	
	// 개인정보 마스킹 처리 유무
	private boolean userInfoMasking = false;
	// 공통 코드
	private Map<String, Object> commonCodeMap = null;
	// 대메뉴 정보
	private Map<Long, Menu> menuMap = null;
	// 사용자 그룹별 메뉴
	private Map<Long, List<UserGroupMenu>> userGroupMenuMap = null;
	// 운영 정책
	private Policy policy = null;
	// 고가용성(HA)
	private Map<String, String> haMap = null;
	// StandBy Server 상태( ON, OFF, BUSY )
	private String standByServerStatus = null;
	
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
		return cacheManager.companyName;
	}

	public static void setCompanyName(String companyName) {
		cacheManager.companyName = companyName;
	}
	
	/** 
	 * 서버 IP
	 * @return
	 */
	public static String getServerIp() {
		return cacheManager.serverIp;
	}

	public static void setServerIp(String serverIp) {
		cacheManager.serverIp = serverIp;
	}
	
	/**
	 * 서버명
	 * @return
	 */
	public static String getServerName() {
		return cacheManager.serverName;
	}

	public static void setServerName(String serverName) {
		cacheManager.serverName = serverName;
	}
	
	/**
	 * hostname
	 * @return
	 */
	public static String getHostname() {
		return cacheManager.hostname;
	}

	public static void setHostname(String hostname) {
		cacheManager.hostname = hostname;
	}
	
	/**
	 * 라이선스 유효성 확인
	 * @return
	 */
	public static boolean isLicenseAvailable() {
		return cacheManager.licenseAvailable;
	}

	public static void setLicenseAvailable(boolean licenseAvailable) {
		cacheManager.licenseAvailable = licenseAvailable;
	}
	
	/**
	 * 개인정보 마스킹 처리 유무
	 * @return
	 */
	public static boolean isUserInfoMasking() {
		return cacheManager.userInfoMasking;
	}
	
	/**
	 * 대메뉴(1 Depth) Map, 화면 왼쪽 메뉴 표시용
	 * @param userGroupId
	 * @return
	 */
	public static Map<Long, Menu> getMapMenu() {
		if(cacheManager.menuMap == null) {
			return new HashMap<Long, Menu>();
		}
		return cacheManager.menuMap;
	}
	
	public static void setMenuMap(Map<Long, Menu> menuMap) {
		cacheManager.menuMap = menuMap;
	}
	
	/**
	 * 사용자 그룹별 메뉴 목록을 취득
	 * @param userGroupId
	 * @return
	 */
	public static List<UserGroupMenu> getListUserGroupMenu(Long userGroupId) {
		if(userGroupId == null) {
			return new ArrayList<UserGroupMenu>();
		}
		
		return cacheManager.userGroupMenuMap.get(userGroupId);
	}
	
	public static void setUserGroupMenuMap(Map<Long, List<UserGroupMenu>> userGroupMenuMap) {
		cacheManager.userGroupMenuMap = userGroupMenuMap;
	}
	
	/**
	 * 운영 정책
	 * @return
	 */
	public static Policy getPolicy() {
		return cacheManager.policy;
	}
	
	public static void setPolicy(Policy policy) {
		cacheManager.policy = policy;
		if("Y".equals(policy.getSecurity_masking_yn())) {
			cacheManager.userInfoMasking = true;
		} else {
			cacheManager.userInfoMasking = false;
		}
	}
	
	/**
	 * 공통 코드명
	 * @param 
	 * @return
	 */
	public static Object getCommonCode(String codeKey) {
		return cacheManager.commonCodeMap.get(codeKey);
	}
	
	public static void setCommonCodeMap(Map<String, Object> commonCodeMap) {
		cacheManager.commonCodeMap = commonCodeMap;
	}
	
	public static Map<String, String> getHaMap() {
		return cacheManager.haMap;
	}

	public static void setHaMap(Map<String, String> haMap) {
		cacheManager.haMap = haMap;
	}
	
	/**
	 * StandBy Server 상태( ON, OFF, BUSY )
	 * @return
	 */
	public static String getStandByServerStatus() {
		return cacheManager.standByServerStatus;
	}

	public static void setStandByServerStatus(String standByServerStatus) {
		cacheManager.standByServerStatus = standByServerStatus;
	}
}
